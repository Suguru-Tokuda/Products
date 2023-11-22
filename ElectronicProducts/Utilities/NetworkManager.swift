//
//  NetworkManager.swift
//  PeoplesManagement
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation
import Combine

protocol Networking {
    func getDataFromNetworkLayer<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: Networking {
    func getDataFromNetworkLayer<T>(url: URL, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
