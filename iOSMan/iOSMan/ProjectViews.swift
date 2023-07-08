//
//  ProjSelectionView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/09.
//

import SwiftUI

struct ProjSelectionView: View {
    let projectName: String
    let projectType: Bool
    let projectPath: URL
    let projectFilePath: URL
    var body: some View {
        NavigationLink(destination: ProjSelectedView(projectName: projectName, projectType: projectType, projectPath: projectPath, projectFilePath: projectFilePath), label: {
            
            VStack(alignment: .leading) {
                Text(projectName)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                if projectType {
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
            .padding(5)
        })
    }
}

struct ProjSelectedView: View {
    let projectName: String
    let projectType: Bool
    let projectPath: URL
    let projectFilePath: URL
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
