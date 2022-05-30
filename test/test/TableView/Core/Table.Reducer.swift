//
//  Table.Reducer.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import ComposableArchitecture

extension Table {
    
    public static let reducer = Reducer<State, Action, Environment>.combine(
        
        Reducer { state, action, environment in
            struct RequestID: Hashable {}
            
            switch action {
            case .didLoad:
                return .init(value: .loadList)
            case .select(let id):
                guard let postDetails = state.list.first(where: { $0.id == id }) else { return .none }
                state.postDetails = .init(detailPost: postDetails)
                return .none
            case .loadListResponse(.success(let result)):
                state.mode = .loaded
                state.list = result
                return .none
            case .loadListResponse(.failure(let error)):
                state.mode = .failed(error)
                return .none
            case .loadList:
                state.mode = .loading
                return environment.apiClient.requestFetchPost()
                    .receive(on: DispatchQueue.main)
                    .catchToEffect(Table.Action.loadListResponse)
                    .cancellable(id: RequestID(), cancelInFlight: true)
            case .resetNavigation:
                state.postDetails = nil
                return .none
            case .postDetails:
                return .none
            }
        }
    )
}

