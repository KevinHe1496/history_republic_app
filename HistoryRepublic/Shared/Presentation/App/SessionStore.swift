import SwiftUI
import Combine


        // iOS 18 / Swift 5.9
@Observable
final class SessionStore {
     var hasToken: Bool = !KeyChainHR()
        .loadHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        .isEmpty
    
    // Guarda el token y notifica
    @MainActor
    func save(token: String) {
        KeyChainHR().saveHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN,
                            value: token)
        hasToken = true
    }
    
    // Borra el token y notifica
    @MainActor
    func logout() {
        KeyChainHR().deleteHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        hasToken = false
    }
}
