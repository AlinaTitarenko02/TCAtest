//
//  TableViewStore.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

extension TableViewController {
    
    struct ViewState: Equatable {
        
        let rows: [Row]
    }
    
    enum ViewAction: Equatable {
        
        case didLoad
        case didSelect(Int)
        case childDismissed
    }
    
    struct Row: Equatable {
        
        let id: Int
        let title: String
    }
}

extension Table.Action {

    static func view(_ localAction: TableViewController.ViewAction) -> Self {
        switch localAction {
        case .didLoad:
            return .didLoad
        case .didSelect(let id):
            return .select(id)
        case .childDismissed:
            return .resetNavigation
        }
    }
}
