//
//  PaginableView.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

/**
 # 저만의 방식으로 시도하다 실패하여 아래 블로그를 참고 후 vc를 view로 바꿔 적용하였습니다.
 # 남은 기능들 구현이후 저만의 방식으로 리펙토링 진행해보겠습니다!
 https://dokit.tistory.com/67
 */

// PageType 프로토콜을 UIView를 반환하도록 변경
public protocol PageType: Hashable {
    var pageView: UIView { get }
}

enum Page: CaseIterable, Identifiable, PageType {
    case coin
    case nft
    case exchange
    
    var krName: String {
        switch self {
        case .coin: return "코인"
        case .nft: return "NFT"
        case .exchange: return "거래소"
        }
    }
    
    var id: String {
        return String(describing: "\(self))")
    }
    
    //vc 대신 View 반환
    var pageView: UIView {
        let view = UIView()
        switch self {
        case .coin:
            view.backgroundColor = .white
        case .nft:
            view.backgroundColor = .red
        case .exchange:
            view.backgroundColor = .blue
        }
        return view
    }
}

final class PaginableView<Page: PageType>: UIView, UIScrollViewDelegate {
    // MARK: Event
    private let _onMove = PublishSubject<Page>()
    var onMove: Observable<Page> {
        return _onMove.asObservable()
    }
    
    var selectedPage: Binder<Page> {
        return Binder(self) { (pageView: PaginableView, page: Page) in
            guard let pageIndex = pageView.pages.firstIndex(of: page) else { return }
            pageView.moveToPage(at: pageIndex, animated: true)
        }
    }
    
    private let _scrollOffset = PublishSubject<CGFloat>()
    var scrollOffset: Observable<CGFloat> {
        return _scrollOffset.asObservable()
    }
    
    // MARK: Private property
    private var pages: [Page] = []
    private let firstPage: Page
    private let gestureDisabled: Bool
    private var pageViewsDict: [Page: UIView] = [:]
    private var pageIndexDict: [Page: Int] = [:]
    private var currentPage: Page?
    
    // MARK: UI component
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init(
        pages: [Page],
        firstPage: Page,
        gestureDisabled: Bool = true
    ) {
        self.firstPage = firstPage
        self.gestureDisabled = gestureDisabled
        
        super.init(frame: .zero)
        
        if pages.isEmpty {
            fatalError("You must provide at least one page.")
        }
        
        if !pages.contains(firstPage) {
            fatalError("The first page must be included in the page list.")
        }
        
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        setupPages(pages)
        setupScrollView()
        setupContentView()
        setupFirstPage()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPageLayout()
        setupFirstPage()
    }
    
    // MARK: Public method
    func updatePages(_ pages: [Page]) {
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        
        setupPages(pages)
        updatePageLayout()
    }
    
    // MARK: Setup
    private func setupPages(_ pages: [Page]) {
        self.pages = pages
        pageViewsDict.removeAll()
        pages.enumerated().forEach { index, page in
            pageViewsDict[page] = page.pageView
            pageIndexDict[page] = index
        }
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.alwaysBounceHorizontal = false
        if gestureDisabled {
            scrollView.panGestureRecognizer.isEnabled = false
        }
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
                .multipliedBy(CGFloat(pages.count))
        }
    }
    
    private func setupPageLayout() {
        for (index, page) in pages.enumerated() {
            if let pageView = pageViewsDict[page] {
                contentView.addSubview(pageView)
                
                pageView.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.snp.width)
                    make.leading.equalTo(scrollView.snp.leading)
                        .offset(scrollView.bounds.width * CGFloat(index))
                }
            }
        }
    }
    
    private func setupFirstPage() {
        guard let firstPageIndex = pageIndexDict[firstPage]
        else { return }
        
        currentPage = firstPage
        scrollView.contentOffset = CGPoint(
            x: scrollView.bounds.width * CGFloat(firstPageIndex),
            y: 0
        )
    }
    
    // MARK: Update
    private func updatePageLayout() {
        let existingViews = Set(contentView.subviews)
        var newViews: Set<UIView> = []
        
        // Iterate over pages array and configure the view for each page
        for (index, page) in pages.enumerated() {
            if let pageView = pageViewsDict[page] {
                newViews.insert(pageView)
                
                // If the view is not already in the existingViews, add it to contentView
                if !existingViews.contains(pageView) {
                    contentView.addSubview(pageView)
                }
                
                pageView.snp.remakeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.snp.width)
                    make.leading.equalTo(scrollView.snp.leading)
                        .offset(scrollView.bounds.width * CGFloat(index))
                }
            }
        }
        
        // Remove views that are no longer needed
        for view in existingViews.subtracting(newViews) {
            view.removeFromSuperview()
        }
        
        // Remake constraints for contentView to fit all pages
        contentView.snp.remakeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
                .multipliedBy(CGFloat(pages.count))
        }
        
        // Ensure the scroll view is positioned correctly for the current page
        guard let currentPage = currentPage,
                let currentPageIndex = pageIndexDict[currentPage]
        else { return }
        
        scrollView.contentOffset = CGPoint(
            x: scrollView.bounds.width * CGFloat(currentPageIndex),
            y: 0
        )
    }
    
    private func moveToPage(at index: Int, animated: Bool) {
        scrollView.setContentOffset(
            CGPoint(
                x: scrollView.bounds.width * CGFloat(index),
                y: 0
            ),
            animated: animated
        )
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        _scrollOffset.onNext(offsetX)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = pages[pageIndex]
        _onMove.onNext(pages[pageIndex])
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = pages[pageIndex]
        _onMove.onNext(pages[pageIndex])
    }
    
    //특정 page 뷰 가져오기
    func getPageView(page: Page) -> UIView? {
        return pageViewsDict[page]
    }
    
}

