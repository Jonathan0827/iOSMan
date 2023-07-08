//
//  iOSManApp.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import SwiftUI

@main
struct iOSManApp: App {
    @AppStorage("supportDir") var supportDir = ""
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("Updating scripts...")
                    print(executeSh("cd \(supportDir)/iOSManHelpers/ && git pull"))
                }
//                .frame(minWidth: 700, minHeight: 350)
        }
//        .windowResizability(.contentSize)
    }
}
