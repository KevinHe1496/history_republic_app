//
//  DefaultProfileView.swift
//  History Republic
//
//  Created by Kevin Heredia on 10/4/25.
//

import SwiftUI

struct DefaultProfileView: View {
    @Environment(AppStateVM.self) private var appState

    // 1️⃣  Enum que identifica los sheets
    private enum ActiveSheet: Identifiable {
        case login, register
        var id: Self { self }          // requisito de Identifiable
    }

    // 2️⃣  Estado local para saber qué sheet mostrar
    @State private var activeSheet: ActiveSheet?

    var body: some View {
        ZStack {
            // Fondo que cubre toda la pantalla
            Color(.greenSecondary)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "person.crop.circle.badge.questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.greendarkandlightmode)

                Text("¿Aún no tienes una cuenta?")
                    .font(.appTitle)

                Text("Inicia sesión si ya tienes una cuenta o regístrate como jugador o dueño para guardar tus canchas o administrarlas.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 16) {

                    CustomButton(title: "Iniciar sesión", color: .greendarkandlightmode) {
                        // 3️⃣  Abrir sheet de login
                        activeSheet = .login
                    }

                    CustomButton(title: "Registrarme", color: .greendarkandlightmode) {
                        // 3️⃣  Abrir sheet de registro
                        activeSheet = .register
                    }
                }
            }
            .padding(.horizontal)
        }
        // 4️⃣  Presentación del sheet según el valor de activeSheet
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .login:
                LoginView(appState: appState)       // Reemplaza por tu vista real
            case .register:
                RegisterUserView(appState: appState)    // Reemplaza por tu vista real
            }
        }
        
    }
}

#Preview {
    DefaultProfileView()
        .environment(AppStateVM())     // Asegúrate de inyectar AppStateVM en tu app real
}
