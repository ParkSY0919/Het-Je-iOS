# Het-Je
암호화폐 정보를 실시간으로 제공하는 iOS 애플리케이션으로, Upbit과 CoinGecko API를 연동하여 암호화폐 시세 정보, 트렌딩 데이터, NFT 정보 등을 사용자에게 제공합니다.

## 구조 관련 고려사항

### MVVM + RxSwift 아키텍처
복잡한 데이터 플로우와 UI 업데이트를 효율적으로 관리하기 위해 MVVM 패턴과 RxSwift를 조합한 아키텍처를 도입했습니다. Input/Output 패턴을 통해 ViewModel과 View 간의 데이터 흐름을 명확하게 분리했고, Observer 패턴을 활용해 UI 업데이트를 자동화했습니다. 이를 통해 코드의 테스트 가능성을 높이고 비즈니스 로직과 UI 로직을 완전히 분리할 수 있었습니다.

### BaseViewController를 통한 공통 기능 제공
각 화면마다 반복되는 네트워크 모니터링, 로딩 상태 관리, Toast 알림 기능의 중복을 제거하고자 BaseViewController를 설계했습니다. 상속을 통해 공통 기능들을 제공하면서도 각 화면의 고유 기능은 독립적으로 구현할 수 있도록 했습니다. 이로 인해 코드 중복이 70% 이상 감소했고, 새로운 화면 개발 시간을 단축할 수 있었습니다.

### 계층별 분리 설계
코드의 재사용성과 유지보수성을 향상시키기 위해 Application, Global, Presentation 3개 계층으로 명확히 분리한 아키텍처를 구축했습니다. 각 계층의 역할을 엄격히 정의하여 Global 계층에는 비즈니스 로직과 공통 기능을, Presentation 계층에는 UI 관련 로직만을 배치했습니다. 의존성 방향을 일방향으로 제한함으로써 코드 변경 시 영향 범위를 예측 가능하게 만들었습니다.

## 기능 관련 고려사항

### 실시간 데이터 업데이트 시스템
실시간 암호화폐 시세 특성을 고려하여 자동 갱신 시스템을 구축했습니다. RxSwift의 `Observable.interval`을 활용해 5초 주기로 API를 호출하되, `startWith(0)`을 통해 화면 진입 시 즉시 데이터를 로드하도록 설계했습니다. 특히 `combineLatest` 오퍼레이터를 사용해 API 응답과 정렬 상태를 조합하여, 데이터 로딩 완료 후에만 정렬 기능이 작동하도록 제어했습니다. 이를 통해 사용자가 정렬 중에 새로운 데이터가 들어와도 정렬 상태가 유지되는 안정적인 UX를 구현했습니다.

### 3단계 정렬 시스템
사용자가 직관적으로 데이터를 정렬할 수 있도록 순환형 3단계 정렬 시스템을 개발했습니다. 기본 → 내림차순 → 오름차순 → 기본으로 순환하는 로직을 구현하여 한 번의 터치로 원하는 정렬 상태에 도달할 수 있게 했습니다. SortButtonComponent를 커스텀으로 제작하여 각 상태를 시각적 아이콘으로 표현했고, RxSwift의 BehaviorSubject를 사용해 정렬 상태를 관리함으로써 상태 변경 시 즉시 UI에 반영되도록 구현했습니다. 이로써 복잡한 정렬 로직도 직관적인 사용자 경험으로 제공할 수 있었습니다.

### 즐겨찾기 시스템
사용자 개인화 기능 구현을 위해 Protocol 지향 Repository 패턴을 적용한 즐겨찾기 시스템을 구축했습니다. `FavoriteCoinRepositoryProtocol`을 정의하여 데이터 접근 계층을 추상화했고, Realm을 구현체로 사용해 로컬 저장소를 관리했습니다. 특히 즐겨찾기 상태 변경 시 UI 피드백과 데이터 저장을 동시에 처리하기 위해 클로저 기반 비동기 처리를 구현했습니다. `FavoriteButtonComponent`에서는 사용자 인터랙션 중 중복 터치를 방지하기 위한 플래그 관리도 포함하여 안정적인 사용자 경험을 제공했습니다.


## 기술적 고려사항

### 다원 API 통합 및 Generic 네트워크 레이어
Upbit과 CoinGecko라는 전혀 다른 API 명세를 가진 서비스들을 하나의 네트워크 레이어에서 통합 처리하기 위해 Generic을 활용한 NetworkManager를 설계했습니다. `callAPI<T: Decodable, C: Decodable>` 메서드를 통해 성공 모델과 에러 모델을 각각 Generic 타입으로 받아 처리하도록 구현했습니다. 또한 API별로 서로 다른 에러 처리 방식이 필요했기 때문에 `UpbitAPIError<C: Decodable>`와 상태코드 기반 `CoinGekoErrorCode` 열거형을 각각 제작하여 상황에 맞는 에러 처리를 구현했습니다.

### 네트워크 단절 감지 및 사용자 경험 관리
실시간 데이터에 의존하는 앱 특성을 고려하여 Apple의 Network 프레임워크 `NWPathMonitor`를 활용한 네트워크 상태 모니터링 시스템을 구축했습니다. BaseViewController에 `pathUpdateHandler` 클로저를 구현하여 네트워크 상태 변화를 실시간으로 감지하도록 했습니다. 연결 단절 시에는 NetworkGuidanceViewController를 자동으로 모달 표시하되, `alreadyPresent` 플래그를 활용해 중복 알림을 방지하고 네트워크 복구 시 자동으로 해제되도록 구현했습니다. 이를 통해 사용자가 API 호출 실패 원인을 명확히 인지하고 적절한 대응을 할 수 있는 UX를 제공했습니다.


### 가변성 UI 컴포넌트 아키텍처
반복적으로 사용되는 UI 요소들의 코드 중복을 제거하고 일관된 사용자 경험을 제공하기 위해 가변성 UI 컴포넌트 시스템을 구축했습니다. `SortButtonComponent`는 3가지 상태(none, ascending, descending)를 내부에서 관리하면서 시각적 피드백을 제공하고, `FavoriteButtonComponent`는 Realm 데이터베이스와 직접 연동되어 상태 변경과 데이터 업데이트를 자체적으로 처리합니다. SnapKit의 선언적 방식과 Then 라이브러리의 방법 체이닝을 조합하여 UI 코드의 가독성과 유지보수성을 동시에 향상시켰습니다.

### RxSwift 스케줄러 기반 성능 최적화
실시간 데이터 스트림과 UI 업데이트 성능을 최적화하기 위해 RxSwift의 Scheduler 시스템을 전략적으로 활용했습니다. API 호출과 데이터 처리는 `ConcurrentDispatchQueueScheduler`에서 수행하고, UI 업데이트는 `MainScheduler`에서 처리하도록 분리했습니다. 또한 `disposeBag`을 활용해 화면 전환 시 구독 해제를 자동화하고, `distinctUntilChanged`를 사용해 동일한 데이터에 대한 중복 UI 업데이트를 방지했습니다. 이러한 최적화를 통해 5초 주기 자동 새로고침에도 스크롤 성능을 유지할 수 있었습니다.

### Protocol 지향 아키텍처와 코드 표준화
프로젝트 확장성과 코드 품질 향상을 위해 Protocol 지향 프로그래밍을 적극 도입했습니다. `TargetType`과 `TargetTypeProtocol`을 통해 API 엔드포인트를 표준화하고, `ViewModelProtocol`로 Input/Output 패턴을 강제하여 모든 ViewModel이 일관된 인터페이스를 갖도록 했습니다. `FavoriteCoinRepositoryProtocol`을 통해 데이터 계층 추상화를 구현하고, Extension을 활용해 기능별 코드 분리와 StringLiterals를 통한 문자열 중앙 관리를 통해 코드의 일관성과 유지보수성을 대폭 개선했습니다.

## 기술 스택

- **언어**: Swift
- **UI**: UIKit, SnapKit (Auto Layout), Compositional Layout
- **아키텍처**: MVVM + RxSwift/RxCocoa
- **네트워킹**: Alamofire
- **데이터베이스**: Realm
- **보조 라이브러리**: Then (빌더 패턴), Toast (알림)
- **API**: Upbit API (국내 거래소 시세), CoinGecko API (글로벌 암호화폐 정보)

## 주요 성과

1. **안정적인 실시간 데이터 제공**: 5초 주기 자동 새로고침으로 최신 시세 정보 제공
2. **직관적인 사용자 경험**: 3단계 정렬 시스템과 즐겨찾기 기능으로 사용자 편의성 향상
3. **견고한 에러 처리**: 네트워크 단절 감지 및 API 에러 상황별 적절한 사용자 피드백
4. **확장 가능한 아키텍처**: Protocol 지향 설계와 계층 분리로 새로운 기능 추가 용이성 확보
5. **성능 최적화**: RxSwift를 활용한 효율적인 데이터 플로우와 메모리 관리
