//
//  MainView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/09.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFirstLaunching") var isFirstLaunching = true
    @State var managedProjects = ["test"]
    @State var selectKeeper = Set<String>()

    @State var selectedProj: String = ""
    let hour = Calendar.current.component(.hour, from: Date())
    var body: some View {
        NavigationSplitView{
            
//            ProjSelectionView(projectName: "Test Xcodeproj", projectType: 2, projectPath: URL(string: "file://users/jonathanlim/desktop/coding/wonsinheungmid/")!, projectFilePath: URL(string: "file://users/jonathanlim/desktop/coding/wonsinheungmid/wonsinheungmid/wonsinheungmid.xcworkspace")!)
//            List(selection: $selectKeeper) {
//            Section {
//                NavigationLink(destination: DTView(), label: {
//                    Text("Home")
//                })
//            }
            
                List(managedProjects, id: \.self, selection: $selectKeeper){ name in
                    ProjSelectionView(projectName: "WonsinheungMid", projectType: false, projectPath: URL(string: "file://Users/jonathanlim/desktop/coding/WonsinheungMid")!, projectFilePath: URL(string: "file://Users/jonathanlim/desktop/coding/WonsinheungMid/WonsinheungMid/WonsinheungMid.xcworkspace")!)
                    
                }
//            }
            .navigationSplitViewColumnWidth(300)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Text(gday())
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                ToolbarItem(placement: .secondaryAction) {
                    Text(selectedProj)
                }
            }
            
        } detail: {
            DTView()
//                .navigationTitle(gday())
        }
    }
    func gday() -> String{
        var timeDesc = ""
        if hour >= 5 && hour < 12 {
            timeDesc = "Good Morning! 🌄"
        } else if hour >= 12 && hour < 17 {
            timeDesc = "Good Afternoon! 🌇"
        } else if hour >= 17 && hour < 19{
            timeDesc = "Good Evening! 🌆"
        } else if hour >= 19{
            timeDesc = "Good Night! 🌃"
        } else {
            timeDesc = "How's it going?"
        }
        return "\(timeDesc)"
    }
}
struct DTView: View {
    @AppStorage("isFirstLaunching") var isFirstLaunching = true

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button(action: {
                isFirstLaunching = true
            }, label: {
                Text("reset")
            })
            Button(action: {
                print(executeSh("brew"))
            }, label: {
                Text("gh")
            })
        }
    }
}
