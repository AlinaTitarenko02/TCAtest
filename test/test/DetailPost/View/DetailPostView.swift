//
//  DetailPostView.swift
//  test
//
//  Created by Alina Tytarenko on 12.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Combine
import AutoLayoutDSL

final class DetailPostViewController: UIViewController {
    
    // MARK: - Store properties
    
    private let store: Store<DetailPost.State, DetailPost.Action>
    private var viewStore: ViewStore<ViewState, ViewAction>
    private var cancellables: Set<AnyCancellable> = []
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init

    public init(store: Store<DetailPost.State, DetailPost.Action>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: \.view, action: DetailPost.Action.view))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBody()
        configureObservers()
        viewStore.send(.didLoad)
    }
}

// MARK: - Configure body

private extension DetailPostViewController {
    
    func configureBody() {
        view.backgroundColor = .white
        let textTitleLabel = UILabel()
        textTitleLabel.text = "Title"
        let textDescriptionLabel = UILabel()
        textDescriptionLabel.text = "Description"
        let rootStackView = UIStackView.vertical([
            textTitleLabel,
            titleLabel,
            textDescriptionLabel,
            descriptionLabel
        ])
        rootStackView.spacing = 30
        rootStackView.distribution = .fillProportionally
        
        rootStackView.add(into: view)
            .top(100)
            .leading(10)
            .trailing(10)
            .bottom(20)
            .done()
    }
    
    func configureObservers() {
        viewStore.publisher.detailPost.sink { [weak self] row in
            guard let self = self else {
                return
            }
            self.render(detailPost: row)
        }
        .store(in: &self.cancellables)
    }
    
    private func render(detailPost: Post) {
        titleLabel.text = detailPost.title
        descriptionLabel.text = detailPost.body
    }
}

// MARK: - Previews

struct DetailPostView_Previews: PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            DetailPostViewController(store: .init(initialState: .init(detailPost: Post(userId: 1, id: 1, title: "hjnk", body: " hjkn")), reducer: DetailPost.reducer, environment: .init()))
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
        .environment(\.colorScheme, .dark)
    }
}

