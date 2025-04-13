//
//  StatusModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import Foundation

/// Estados de la aplicacion
enum Status {
    case none, loading, login, register, loaded, error(error: String)
}
