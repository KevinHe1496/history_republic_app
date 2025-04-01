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
        case .loaded:
            withAnimation {
                LoginView()
            }
        case .error(error: let errorString):
            withAnimation {
                Text("Error")
            }
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
