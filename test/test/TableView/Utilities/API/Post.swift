//
//  List.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//

import Foundation

public struct Post: Decodable, Identifiable, Equatable {

    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
}
