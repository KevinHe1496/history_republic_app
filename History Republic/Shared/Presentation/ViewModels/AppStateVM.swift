//
//  AppStateVM.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

@Observable
final class AppStateVM {
    var status = Status.none
    var tokenJWT: String = ""
    
    @ObservationIgnored
    var isLogged: Bool = false
    
    @ObservationIgnored
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUC: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUC
    }
    
    @MainActor
    func loginApp(user: String, pass: String) {
        self.status = .loading
        
        Task {
            if try await loginUseCase.loginApp(user: user, password: pass) == true {
                self.status = .loaded
            } else {
                self.status = .error(error: "Error con el usuario / clave")
            }
        }
    }
    
    @MainActor
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.status = .none
        }
    }
    
    @MainActor
    func validateControlLogin(){
        
        Task {
            if await loginUseCase.validateToken() == true {
                self.status = .loaded
                NSLog("Login OK")
            } else {
                self.status = .none
                NSLog("Login ERROR")
            }
        }
    }
    

    func startSplashToLoginView() {
        
        self.status = .none
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.status = .loaded
            }
        }
    }
}

