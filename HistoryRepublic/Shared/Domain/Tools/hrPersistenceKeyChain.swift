//
//  hrPersistenceKeyChain.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

@propertyWrapper
class hrPersistenceKeychain {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue : String {
        get {
            return KeyChainHR().loadHR(key: self.key)
        }
        
        set {
            KeyChainHR().saveHR(key: self.key, value: newValue)
        }
    }
}
