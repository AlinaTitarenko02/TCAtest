//
//  Table.Action.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension Table {
    
    public enum Action: Equatable {
        
        case didLoad
        case loadList
        case loadListResponse(Result<[Post], ListAPIClient.Failure>)
        case select(Int)
        case resetNavigation
        case postDetails(DetailPost.Action)
    }
}
 
