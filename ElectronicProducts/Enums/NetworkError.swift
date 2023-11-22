//
//  NetworkError.swift
//  PeoplesManagement
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

enum NetworkError: String, Error {
    case badUrl,
         serverNotFound,
         dataNotFound,
         parsing
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return NSLocalizedString("The url was bad.", comment: self.rawValue)
        case .serverNotFound:
            return NSLocalizedString("Server was not found.", comment: self.rawValue)
        case .dataNotFound:
            return NSLocalizedString("Data was not found.", comment: self.rawValue)
        case .parsing:
            return NSLocalizedString("Could not parse data.", comment: self.rawValue)
        }
    }
}
