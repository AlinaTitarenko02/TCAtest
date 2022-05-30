//
//  DetailPost.State.swift
//  test
//
//  Created by Alina Tytarenko on 12.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public struct DetailPost { }

extension DetailPost {
    
    public struct State: Equatable {
            
        var detailPost: Post
    }
}

// MARK: - View

extension DetailPost.State {
    
    var view: DetailPostViewController.ViewState {
        .init(detailPost: detailPost)
    }
}
