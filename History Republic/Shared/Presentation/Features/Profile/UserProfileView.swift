//
//  UserProfileView.swift
//  History Republic
//
//  Created by Kevin Heredia on 10/4/25.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        Text("User profile")
        Button {
            self.appState.closeSessionUser()
        } label: {
            Text("Close Session")
                
        }
        .buttonStyle(.bordered)
        
    }
}

#Preview {
    UserProfileView()
        .environment(AppStateVM())
}
