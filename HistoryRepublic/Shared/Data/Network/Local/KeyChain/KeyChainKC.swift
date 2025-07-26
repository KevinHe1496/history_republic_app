//
//  KeyChainKC.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//


import Foundation
import KeychainSwift

public struct KeyChainHR {

    public init(){
    }
    
    // guardar clave
    @discardableResult
    public func saveHR(key: String, value: String) -> Bool{
        if let data = value.data(using: .utf8){
            let keychain = KeychainSwift()
            return keychain.set(data, forKey: key)
        } else {
            return false //Error en desempaquetado
        }
    }
    
    // cargar una clave
    public func loadHR(key: String) -> String{
        let keychain = KeychainSwift()
        if let data = keychain.get(key){
            return data
        } else {
            return ""
        }
    }
    
    //eliminar una clave
    @discardableResult
    public func deleteHR(key: String) -> Bool {
        return KeychainSwift().delete(key)
    }
    
}
