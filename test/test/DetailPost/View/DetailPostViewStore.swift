//
//  DetailPostViewStore.swift
//  test
//
//  Created by Alina Tytarenko on 12.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

extension DetailPostViewController {
    
    struct ViewState: Equatable {
        
        var detailPost: Post
    }
    
    enum ViewAction: Equatable {
        
        case didLoad
    }
}

extension DetailPost.Action {

    static func view(_ localAction: DetailPostViewController.ViewAction) -> Self {
        switch localAction {
        case .didLoad:
            return .didLoad
        }
    }
}
