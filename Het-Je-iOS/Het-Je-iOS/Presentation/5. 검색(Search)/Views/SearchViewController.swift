//
//  SearchViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SearchViewController: BaseViewController {

    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    private let navBackBtn = UIButton()
    private let navTextField = UITextField()
    private let segmentControl = CustomSegmentControl()
    private let paginableView = PaginableView<Page>(pages: Page.allCases, firstPage: Page.coin)
    private let searchResultTableView = UITableView()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
        
        setNav(text: viewModel.navTitle)
    }
    
    deinit {
        print("SearchViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindRelatedPagerView()
        bind()
    }
    
    override func setHierarchy() {
        view.addSubviews(segmentControl, paginableView)
    }
    
    override func setLayout() {
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(46)
        }
        
        paginableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        searchResultTableView.do {
            $0.separatorStyle = .none
            $0.rowHeight = 60
            $0.showsVerticalScrollIndicator = false
            $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.id)
        }
        
        segmentControl.do {
            $0.setupButtons()
            $0.selectedOption.accept(.coin)
        }
        
        //setLayout 이후 실행돼야함
        //-> 그래야 setupNotiView 속 equalToSuperView가 터지지않음
        setupNotiView()
    }
    
    private func setupNotiView() {
        //PaginableView에서 노티 페이지의 뷰 가져와서 테이블 뷰 넣기
        if let notiView = paginableView.getPageView(page: .coin) {
            
            //테이블뷰 노티 뷰에 추가 및 레이아웃 설정
            notiView.addSubview(searchResultTableView)
            searchResultTableView.snp.makeConstraints {
                $0.verticalEdges.equalToSuperview()
                $0.horizontalEdges.equalTo(notiView.safeAreaLayoutGuide).inset(20)
            }
            
            //notiView 변화 생겼으니 레이아웃 수정 호출
            notiView.layoutIfNeeded()
        }
    }
    
}

private extension SearchViewController {
    
    func bindRelatedPagerView() {
        paginableView.onMove
            .bind(to: self.segmentControl.selectedOption)
            .disposed(by: disposeBag)
        
        segmentControl.onChange
            .bind(to: self.paginableView.selectedPage)
            .disposed(by: disposeBag)
    }
    
    func bind() {
        let input = SearchViewModel.Input(
            in_TapNavBackButton: navBackBtn.rx.tap,
            in_TapNavTextFieldReturnKey: navTextField.rx.controlEvent(.editingDidEndOnExit),
            in_NavTextFieldText: navTextField.rx.text.orEmpty, in_SearchResultCellTapped: searchResultTableView.rx.modelSelected(DTO.Response.Search.Coin.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.out_loadingViewLoading
            .drive(with: self) { owner, isLoading in
                owner.isLoading(isLoading: isLoading)
            }.disposed(by: disposeBag)
        
        output.out_TapNavBackButton
            .drive(with: self, onNext: { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        output.out_SearchResultList
            .drive(searchResultTableView.rx.items(
                    cellIdentifier: SearchResultTableViewCell.id,
                    cellType: SearchResultTableViewCell.self))
            { item, element, cell in
                cell.selectionStyle = .none
                cell.fetcHSearchResultCell(model: element)
                cell.favoriteBtn.onChange = { [weak self] (resultMessage) in
                    guard let self else { return }
                    self.showToast(message: resultMessage)
                }
            }.disposed(by: disposeBag)
        
        output.out_IsScrollToTop
            .bind(with: self) { owner, isScroll in
                if isScroll {
                    owner.setScrollToTop()
                }
            }.disposed(by: disposeBag)
        
        output.in_SearchResultCellTapped
            .bind(with: self) { owner, coinData in
                let vc = owner.prepareForNextScreen(data: coinData)
                owner.viewTransition(viewController: vc, transitionStyle: .push)
            }.disposed(by: disposeBag)
    }
    
    func setNav(text: String) {
        navBackBtn.do {
            $0.setImage(AppIconType.left.image, for: .normal)
            $0.tintColor = .primary
        }
        
        navTextField.snp.makeConstraints {
            //textField 길이 제한이 없어 200으로 설정하였습니다.
            $0.width.equalTo(200)
        }
        
        navTextField.do {
            $0.text = text
            $0.font = .hetJeFont(.body_regular_12)
            $0.textColor = .primary
            $0.textAlignment = .left
        }
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: navBackBtn), UIBarButtonItem.init(customView: navTextField)]
    }
    
    func setScrollToTop() {
        print(#function)
        let indexPath = NSIndexPath(row: NSNotFound, section: 0)
        searchResultTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    func prepareForNextScreen(data: DTO.Response.Search.Coin) -> UIViewController {
        let coinData = CoinInfo(coinId: data.id,
                                name: data.name,
                                symbol: data.symbol,
                                marketCapRank: data.marketCapRank,
                                thumb: data.thumb,
                                large: data.large)
        
        let vm = CoinDetailViewModel(coinData: coinData)
        let vc = CoinDetailViewController(viewModel: vm)
        
        return vc
    }
    
}
