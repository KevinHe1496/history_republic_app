//
//  EndPoints.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

/// Server Side Endpoints 
enum EndPoints: String {
    case login = "/api/auth/login"

    case register = "/api/auth/register "
    case fetchMe = "/api/users/me"
    case heroes = "/api/heroes"
    
    case addFavorite = "/api/favorites"

}
