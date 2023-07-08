//
//  ContentView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstLaunching") var isFirstLaunching = true
    var body: some View {
        if isFirstLaunching {
            OnboardingView()
        } else {
            MainView()
        }
    }
    
    
}
