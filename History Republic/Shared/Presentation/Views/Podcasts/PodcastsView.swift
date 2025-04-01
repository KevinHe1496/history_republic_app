//
//  PodcastsView.swift
//  History Republic
//
//  Created by Kevin Heredia on 1/4/25.
//

import SwiftUI

struct PodcastsView: View {
    @Environment(AppStateVM.self) var appState
    var body: some View {
        VStack {
            Text("Podcasts")
            Button("LogOut", action: appState.closeSessionUser)
        }
    }
}

#Preview {
    PodcastsView()
        .environment(AppStateVM())
}
