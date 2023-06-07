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
    @State var fontSize = 100.0
    var body: some View {
        VStack{
            if showTitle{
                Text(projectName)
                    .fontWeight(.bold)
                    .font(.system(size: fontSize))
                if showFT{
                    if projectType == true {
                        Text("Xcode Project File")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Xcode Workspace File")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
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
                    showTitle = false
                    showFT = false
                }
            })
        }
    }
}
