//
//  LoadingProgressView.swift
//  History Republic
//
//  Created by Kevin Heredia on 3/7/25.
//

import SwiftUI

struct LoadingProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.3)
    }
}

#Preview {
    LoadingProgressView()
}
