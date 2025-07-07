//
//  GAError.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import Foundation

enum HRError: Error, CustomStringConvertible {
    
    case requestWasNil
    case errorFromServer(reason: Error)
    case errorFromApi(statusCode: Int)
    case dataNoReveiced
    case errorParsingData
    case sessionTokenMissing
    case badUrl
    case authenticationFailed
    
    var description: String {
        switch self {
            
        case .requestWasNil:
            return "Error creating request"
        case .errorFromServer(reason: let reason):
            return "Received error from server \((reason as NSError).code)"
        case .errorFromApi(statusCode: let statusCode):
            return "Received error from api status code \(statusCode)"
        case .dataNoReveiced:
            return "Data no received from server"
        case .errorParsingData:
            return "There was un error parsing data"
        case .sessionTokenMissing:
            return "Seesion token is missing"
        case .badUrl:
            return "Bad url"
        case .authenticationFailed:
            return "Authentication Failed"
        }
    }
}


extension HRError: Equatable {
    static func == (lhs: HRError, rhs: HRError) -> Bool {
        switch (lhs, rhs) {
        case (.requestWasNil, .requestWasNil),
            (.dataNoReveiced, .dataNoReveiced),
            (.errorParsingData, .errorParsingData),
            (.sessionTokenMissing, .sessionTokenMissing),
            (.badUrl, .badUrl),
            (.authenticationFailed, .authenticationFailed):
            return true
            
        case let (.errorFromApi(code1), .errorFromApi(code2)):
            return code1 == code2
            
        case let (.errorFromServer(reason1), .errorFromServer(reason2)):
            // Compara por código de NSError (útil en tests)
            return (reason1 as NSError).code == (reason2 as NSError).code
            
        default:
            return false
        }
    }
}
