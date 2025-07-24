
//
//  RootView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct RootView: View {
    @Environment(AppStateVM.self) var appState
   
    var body: some View {
        switch appState.status {
        case .none:
            withAnimation {
                SplashView()
            }
        case .loading:
            withAnimation {
                LoadingView()
            }
            
        case .login:
            withAnimation {
                TabBarView()
            }
        case .register:
            withAnimation {
                RegisterUserView(appState: appState)
            }
        case .inicio:
            withAnimation {
                TabBarView()
            }
        case .error(error: let errorString):
            withAnimation {
                Text("Error \(errorString)")
            }
        case .userProfile:
            withAnimation {
                UserProfileView()
            }
        case .defaultProfile:
            withAnimation {
                DefaultProfileView()
            }
        }
            
    }
    
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
