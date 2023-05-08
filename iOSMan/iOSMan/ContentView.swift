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
            NavigationView{
                VStack {                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                .padding()
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
