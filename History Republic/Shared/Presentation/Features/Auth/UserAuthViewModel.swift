//
//  RegisterViewModel.swift
//  History Republic
//
//  Created by Kevin Heredia on 12/4/25.
//

import Foundation

@Observable
final class UserAuthViewModel {
    
    @ObservationIgnored
    private var useCase: UserAuthServiceUsecaseProtocol
    private var appState: AppStateVM
    var isRegistered: Bool = false
    var showAlert: Bool = false
    var message: String = ""
    
    init(registerUC: UserAuthServiceUsecaseProtocol = UserAuthServiceUseCase(), appState: AppStateVM) {
        self.useCase = registerUC
        self.appState = appState
    }
    
    @MainActor
    func registerUser(name: String, email: String, password: String) async throws  {
        
        if let validationError = validateRegisterFields(name: name, email: email, password: password) {
            message = validationError
            showAlert = true
        
        }
        
        do {
            let result = try await useCase.registerUser(name: name, email: email, password: password)
            if result {
                message = "¡Registro completado! Inicia sesión para comenzar."
                showAlert = true
            }
        } catch {
            message = "Algo salio mal."
            showAlert = true
            appState.status = .error(error: "Iconrrect username or password.")
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func loginApp(email: String, pass: String) async throws -> Bool {
        
        if let validateError = validateLoginFields(email: email, password: pass) {
            message = validateError
            showAlert = true
            return false
        }
        
        do {
            let result = try await useCase.loginApp(user: email, password: pass)
            
            if result {
                self.appState.status = .inicio
                return true
            } else {
                message = "El email o contraseña es inválido."
                showAlert = true
                //self.appState.status = .error(error: "Incorrect username or password")
                return false
            }
            
            
        } catch {
            message = "El email o contraseña es inválido."
            showAlert = true
            return false
        }
    }
    
    
    // MARK: - Validation
    
    /// Checks that all fields are filled and email/password are valid.
    func validateRegisterFields(name: String, email: String, password: String) -> String? {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            message = "Todos los campos son requeridos."
            return message
        }
        if !email.contains("@") || !email.contains(".") {
            message = "Ingresa un correo electrónico válido, por ejemplo: usuario@ejemplo.com"
            return message
        }
        if password.count < 6 {
            message = "La contraseña debe tener al menos 6 caracteres."
            return message
        }
        return nil
    }
    
    
    func validateLoginFields(email: String, password: String) -> String? {
        if email.isEmpty || password.isEmpty {
            message = "Todos los campos son requeridos."
            return message
        }
        if !email.contains("@") || !email.contains(".") {
            message = "Ingresa un correo electrónico válido, por ejemplo: usuario@ejemplo.com"
            return message
        }
        if password.count < 6 {
            message = "La contraseña debe tener al menos 6 caracteres."
            return message
        }
        return nil
    }
    
    
    
}
