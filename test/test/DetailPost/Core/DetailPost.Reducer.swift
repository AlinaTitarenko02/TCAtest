//
//  DetailPost.Reducer.swift
//  test
//
//  Created by Alina Tytarenko on 12.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import ComposableArchitecture

extension DetailPost {
    
    public static let reducer = Reducer<State, Action, Environment>.combine(
        
        Reducer { state, action, environment in
            
            switch action {
            case .didLoad:
                return .none
            }
        }
    )
}
