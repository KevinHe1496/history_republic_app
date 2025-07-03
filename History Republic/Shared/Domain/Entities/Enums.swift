//
//  Enums.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.
//

import Foundation

// MARK: -- ViewState

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case error(String)
}


extension ViewState {
    var data: T? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }
}
