//
//  History_RepublicApp.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import SwiftUI

@main
struct History_RepublicApp: App {
    @State var AppState = AppStateVM()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(AppState)
        }
    }
}
