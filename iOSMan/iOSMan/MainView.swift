//
//  MainView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/09.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFirstLaunching") var isFirstLaunching = true
    @AppStorage("supportDir") var supportDir = ""
    @State var managedProjects = ["test"]
    @State var notProjectButList = ["Home", ""]
    @State var selectKeeper = Set<String>()
    @State var selectedProj: String = ""
    let hour = Calendar.current.component(.hour, from: Date())
    var body: some View {
        NavigationSplitView{
//                List()
                List(managedProjects, id: \.self, selection: $selectKeeper){ name in
                    ProjSelectionView(projectName: name, projectType: false, projectPath: URL(string: "file://Users/jonathanlim/desktop/coding/WonsinheungMid")!, projectFilePath: URL(string: "file://Users/jonathanlim/desktop/coding/WonsinheungMid/WonsinheungMid/WonsinheungMid.xcworkspace")!)
                    
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
        ZStack{
            GeometryReader { g in
                Image("icon")
                    .resizable()
                    .cornerRadius(20)
                    .position(x: g.size.width / 2, y: g.size.height / 3.5)
                    .frame(width: g.size.width/4, height: g.size.width/4)
                    
            }
            GeometryReader { g in
                VStack {
                    
                    Text("iOSMan")
                        .fontWeight(.bold)
                        .font(.system(size: g.size.height/10))
                        .position(x: g.size.width / 2, y: g.size.height / 1.8)
                    Button(action: {
                        isFirstLaunching = true
                    }, label: {
                        Text("reset")
                    })
                    .position(x: g.size.width / 2, y: g.size.height / 7)
                    .buttonStyle(GrowingButton())
                }
            }
        }
    }
}
