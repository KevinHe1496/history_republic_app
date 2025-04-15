//
//  RegisterViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

@Observable
final class RegisterViewModel {

    @ObservationIgnored
    private var registerUseCase: RegisterUsecaseProtocol
    private var appState: AppStateVM
    
    init(registerUC: RegisterUsecaseProtocol = RegisterUseCase(), appState: AppStateVM) {
        self.registerUseCase = registerUC
        self.appState = appState
    }
    
    @MainActor
    func registerUser(name: String, email: String, password: String) {
        
        appState.status = .loading
        
        Task {
            if try await registerUseCase.registerUser(name: name, email: email, password: password) == true {
                appState.status = .login
            } else {
                appState.status = .error(error: "incorrect username or password")
            }
        }
    }
}
