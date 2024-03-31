//
//  ProjSelectionView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/09.
//

import SwiftUI

struct ProjSelectionView: View {
    let name: String
    let type: Bool?
    let path: String?
    let isNotManaged: Bool
    var body: some View {
        if !isNotManaged {
            NavigationLink(destination: ProjSelectedView(projectName: name, projectType: type!, projectPath: path!), label: {
                VStack(alignment: .leading) {
                    Text(name)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    if type! {
                        Text("Xcode Project")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .font(.title3)
                    } else {
                        Text("Xcode Workspace")
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                }
            })
            .padding(5)
        } else {
            HStack() {
//                Text(name)
//                    .fontWeight(.bold)
//                    .font(.largeTitle)
//                
                if name == "Home" {
                    Image(systemName: "house")
                } else if name == "New" {
                    Button(action: {
                        let projInfo = manNewProj()
                        if projInfo.canceled{
                            print("Canceled")
                        } else {
        //                    MARK: Manage New Project
                        }
                    }, label: {Text("New")})
                    Image(systemName: "plus.rectangle.on.folder")
                }
            }
        }
    }
}

struct ProjSelectedView: View {
    let projectName: String
    let projectType: Bool
    let projectPath: String
    @State var smallFont = false
    @State var showTitle: Bool = false
    @State var showFT: Bool = false
    @State var showOpt: Bool = false
    @State var fontSize = 100.0
    
    var body: some View {
        VStack{
            if showTitle{
                GeometryReader { g in
                    Text(projectName)
                        .fontWeight(.bold)
                        .font(.system(size: g.size.height/10))
                        .position(x: g.size.width / 2, y: g.size.height / 2)
                    if showFT{
                        if projectType == true {
                            Text("Xcode Project File")
                                .font(.system(size: g.size.height/30))
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .position(x: g.size.width / 2, y: g.size.height / 1.73)
                            
                        } else {
                            Text("Xcode Workspace File")
                                .font(.system(size: g.size.height/30))
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .position(x: g.size.width / 2, y: g.size.height / 1.73)
                            
                        }
                    }
                }
            }
            if showOpt {
                GeometryReader { g in
                    
                    ZStack{
                        //                    Spacer()
                        Rectangle()
                            .fill(.opacity(0.1))
                            .blur(radius: 150)
                        VStack{
                            Text("Options")
                                .font(.system(size: g.size.height/15))
                                .fontWeight(.bold)
                            Section("Build"){
                                HStack {
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Build .ipa")
                                            .font(.system(size: g.size.height/40))
                                            .fontWeight(.bold)
                                    })
                                    .buttonStyle(GrowingButtonBlue())
                                    .padding(.trailing, 10)
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Build .app")
                                            .foregroundColor(.white)
                                            .font(.system(size: g.size.height/40))
                                            .fontWeight(.bold)
                                    })
                                    .buttonStyle(GrowingButton())
                                }
                            }
                            Spacer()
                        }
                        .position(x: g.size.width / 2, y: g.size.height / 3)
                    }
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                withAnimation{
                    showTitle = true
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+1.2, execute: {
                withAnimation{
                    showFT = true
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+2.9, execute: {
                withAnimation{
                    showOpt = true
                }
            })
        }
    }
}
