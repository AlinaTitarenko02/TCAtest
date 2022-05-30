//
//  TableView.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Combine

final class TableViewController: UIViewController {
    
    // MARK: - Store properties
    
    private let store: Store<Table.State, Table.Action>
    private let viewStore: ViewStore<ViewState, ViewAction>
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: [Row] = []
    private let tableView = UITableView()
    
    // MARK: - Init
    
    public init(store: Store<Table.State, Table.Action>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: \.view, action: Table.Action.view))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBody()
        configureObservation(on: store)
        configureStateObservation(on: viewStore)
        viewStore.send(.didLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isMovingToParent {
            viewStore.send(.childDismissed)
        }
    }
}

// MARK: - Configure body

private extension TableViewController {
    
    func configureBody() {
        view.backgroundColor = .white
        tableView.register(TableCell.self)
        tableView.sectionHeaderHeight = 8
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        tableView.scrollIndicatorInsets = .init(top: 18, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.add(into: view)
            .top()
            .leading(16)
            .trailing(16)
            .bottom()
            .done()
    }
    
    private func configureObservation(on store: Store<Table.State, Table.Action>) {
        store
            .scope(state: \.postDetails, action: Table.Action.postDetails)
            .ifLet(
                then: { [weak self] store in
                    let viewController = DetailPostViewController(store: store)
                    viewController.hidesBottomBarWhenPushed = true
                    self?.navigationController?.pushViewController(viewController, animated: true)
                },
                else: { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.navigationController?.popToViewController(TableViewController(store: store), animated: true)
                }
            )
            .store(in: &self.cancellables)
    }
    
    func configureStateObservation(on viewStore: ViewStore<ViewState, ViewAction>) {
        viewStore.publisher.rows.sink { [weak self] rows in
            guard let self = self else {
                return
            }
            self.dataSource = rows
            self.tableView.reloadData()
        }
        .store(in: &self.cancellables)
    }
}

// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableCell.self, for: indexPath)
        cell.viewState = TableCell.ViewState(row: dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        .init()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = dataSource[indexPath.row]
        viewStore.send(.didSelect(row.id))
    }
}
