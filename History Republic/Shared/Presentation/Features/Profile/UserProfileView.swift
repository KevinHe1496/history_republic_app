//
//  UserProfileView.swift
//  History Republic
//
//  Created by Kevin Heredia on 2/7/25.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AppStateVM.self) var appState
    
    @State var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .center) {
                    Text("Profile")
                        .font(.appTitle)
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(16)
                        .background(
                            Circle()
                                .fill(Color.red)
                        )
                    
                    Text(viewModel.userData.name)
                        .font(.appDescription)
                    Text(viewModel.userData.email)
                        .font(.appDescription)
                    
                    Button("Edit Profile") {
                        //Todo
                    }
                    .frame(width: 150, height: 40)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .font(.appButton)
                    .clipShape(.buttonBorder)
                    .padding()
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                
                Section {
                    Button("Logout") {
                        appState.closeSessionUser()
                    }
                    .foregroundStyle(.greenSecondary)
                    .font(.appButton)
                    Button("Delete Account") {
                        Task {
                          try await viewModel.deleteUser()
                        }
                    }
                    .font(.appButton)
                    .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
        .environment(AppStateVM())
}
