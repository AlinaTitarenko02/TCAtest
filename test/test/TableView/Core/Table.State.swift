//
//  Table.State.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import ComposableArchitecture

public struct Table { }

extension Table {
    
    public struct State: Equatable {
        
        var mode = Mode.idle
        var list: [Post] = []
        var postDetails: DetailPost.State?
    }
    
    enum Mode: Equatable {
        
        case idle
        case loading
        case loaded
        case failed(ListAPIClient.Failure)
    }
}

// MARK: - View

extension Table.State {
    
    var view: TableViewController.ViewState {
        .init(rows: buildRows(list: list))
    }
    
    func buildRows(list: [Post]) -> [TableViewController.Row] {
        return list.map { TableViewController.Row(id: $0.id, title: $0.title) }
    }
}
