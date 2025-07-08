//
//  AppStateVM.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import Foundation

/// ViewModel that manages the global state of the app,
/// including authentication flow, login status, and loading state.
@Observable
final class AppStateVM {
    
    // MARK: - Published Properties
    
    /// Current status of the app (none, loading, loaded, error, etc.)
    var status = Status.none
    
    /// JWT token for authenticated user sessions
    var tokenJWT: String = ""
    
    /// Flag indicating whether a loading process is active
    var isLoading = false
    
    /// Error message related to login attempts, if any
    var loginError: String?
    
    // MARK: - Ignored Observations
    
    /// Flag that indicates if the user is currently logged in
    @ObservationIgnored
    var isLogged: Bool = false
    
    // MARK: - Dependencies
    
    /// Use case responsible for handling login and token validation logic
    @ObservationIgnored
    private var loginUseCase: UserAuthServiceUsecaseProtocol
    
    // MARK: - Initializer
    
    /// Initializes the ViewModel with a LoginUseCase dependency
    init(loginUC: UserAuthServiceUsecaseProtocol = UserAuthServiceUseCase()) {
        self.loginUseCase = loginUC
        
        // Validate user session on initialization
        Task {
            await validateControlLogin()
        }
    }
    
    // MARK: - Authentication
    
    /// Tries to log in the user with provided credentials
    /// - Parameters:
    ///   - user: User's email
    ///   - pass: User's password
   
    
    /// Logs the user out and returns the app to the login state
    @MainActor
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.status = .login
        }
    }
    
    /// Validates if a user session already exists based on stored token
    @MainActor
    func validateControlLogin() {
        Task {
            if await loginUseCase.validateToken() == true {
                self.status = .inicio
                NSLog("Login OK")
            } else {
                self.startSplashToLoginView()
            }
        }
    }
    
    // MARK: - Navigation Helpers
    
    /// Navigates from splash screen to login view after a short delay
    func startSplashToLoginView() {
        self.status = .none
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            Task { @MainActor in
                self.status = .login
            }
        }
    }
    
   
}
