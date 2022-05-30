//
//  ListAPIClient.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//

import ComposableArchitecture

public struct ListAPIClient {
    
    var requestFetchPost: () -> Effect<[Post], Failure>
    
    public enum Failure: Equatable, Error {
        case couldntFetchList
    }
}

// MARK: - Live

public extension ListAPIClient {
    
    static var live: Self {
        return Self(
            requestFetchPost: {
                .future { callback in
                    let stringURL = "https://jsonplaceholder.typicode.com/posts"
                    guard let serviceUrl = URL(string: stringURL) else {
                        callback(.failure(.couldntFetchList))
                        return
                    }
                    var request = URLRequest(url: serviceUrl)
                    request.httpMethod = "GET"
                    
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            callback(.failure(.couldntFetchList))
                            return
                        }
                        do {
                            let decodedResponse = try JSONDecoder().decode([Post].self, from: data)
                            callback(.success(decodedResponse))
                        } catch {
                            callback(.failure(.couldntFetchList))
                        }
                    }
                    task.resume()
                }
            }
        )
    }
}
