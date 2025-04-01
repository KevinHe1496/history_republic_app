//
//  SplashView.swift
//  History Republic
//
//  Created by Kevin Heredia on 31/3/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.greenSecondaryColor
                .ignoresSafeArea()
            
            Image(.logo)
        }

    }
}

#Preview {
    SplashView()
}
