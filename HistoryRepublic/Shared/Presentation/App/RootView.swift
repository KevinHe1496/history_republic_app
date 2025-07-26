
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
        case .splash:
            withAnimation {
                SplashView()
            }
        case .loading:
            withAnimation {
                LoadingView()
            }
            
        case .inicio:
            withAnimation {
                TabBarView()
            }
        case .error(error: let errorString):
            withAnimation {
                Text("Error \(errorString)")
            }
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
