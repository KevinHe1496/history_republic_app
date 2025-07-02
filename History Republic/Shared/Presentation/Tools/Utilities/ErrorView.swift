//
//  ErroView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct ErrorView: View {
    @Environment(AppStateVM.self) var appState
    var body: some View {
        ZStack {
            Color.greenSecondaryColor
                .ignoresSafeArea()
            
            VStack {
                Text("Something went wrong")
                    .foregroundStyle(.mainBrownColor)
                Text("Please try again")
                    .foregroundStyle(.mainBrownColor)
            }
        }
    }
}

#Preview {
    ErrorView()
        .environment(AppStateVM())
}
