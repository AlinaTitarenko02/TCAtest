//
//  ListAPIClientMocks.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//

extension ListAPIClient {

    static let failing = Self(
        requestFetchPost: {  .failing("ListAPIClient.requestFetchPost") }
    )
}
