//
//  CustomTabBarAppearance.swift
//  History Republic
//
//  Created by Kevin Heredia on 10/4/25.
//


import SwiftUI

struct CustomTabBarAppearance: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.greenSecondaryColor)
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.mainBrownColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.mainBrownColor)
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // Aplicamos apariencia SOLO a esta instancia
        viewController.tabBarController?.tabBar.standardAppearance = appearance
        viewController.tabBarController?.tabBar.scrollEdgeAppearance = appearance
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
