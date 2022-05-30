//
//  Table.Environment.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import ComposableArchitecture

extension Table {
    
    public struct Environment {

        public let apiClient: ListAPIClient
        
        public init(apiClient: ListAPIClient) {
            self.apiClient = apiClient
        }
    }
}
