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
    

    var canFetchFavorites: Bool {
        isLogged // o validación extra si quieres
    }

    
    /// Current status of the app (none, loading, loaded, error, etc.)
    var status = Status.splash
    
    /// Flag indicating whether a loading process is active
    var isLoading = false
    
    /// Error message related to login attempts, if any
    var loginError: String?
    
    // MARK: - Ignored Observations
    
    /// Flag that indicates if the user is currently logged in
   
    var isLogged: Bool = false
    
    // MARK: - Dependencies
    
    /// Use case responsible for handling login and token validation logic
    @ObservationIgnored
    var loginUseCase: UserAuthServiceUsecaseProtocol
    private var userProfileUsecase = UserProfileServiceUseCase()
    @ObservationIgnored
    private var heoresViewModel = HeroesViewModel()
    
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
    func closeSessionUser() async {
        heoresViewModel.resetFavorites()
        await loginUseCase.logout()
        // Cambiar temporalmente para forzar transición
        self.status = .loading
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 segundos
        self.status = .inicio
//        isLogged = false
        
    }
    
    
    @MainActor
    func deleteAccount() async throws {
        try await userProfileUsecase.deleteUser()
        KeyChainHR().deleteHR(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        // Cambiar temporalmente para forzar transición
        self.status = .loading
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 segundos
        self.status = .inicio
    }
    
    /// Validates if a user session already exists based on stored token
    @MainActor
    func validateControlLogin() async {
        Task {
            if await loginUseCase.validateToken() == true {
                self.startSplashToLoginView()
//                isLogged = true
                //self.status = .login
                NSLog("Login OK")
            } else {
                self.startSplashToTabBarView()
                NSLog("Login ERROR")
            }
        }
    }
    
    // MARK: - Navigation Helpers
    
    /// Navigates from splash screen to login view after a short delay
    func startSplashToLoginView() {
        self.status = .splash
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            Task { @MainActor in
                self.status = .inicio
            }
        }
    }
    func startSplashToTabBarView() {
        self.status = .splash
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            Task { @MainActor in
                self.status = .inicio
            }
        }
    }
    
}
