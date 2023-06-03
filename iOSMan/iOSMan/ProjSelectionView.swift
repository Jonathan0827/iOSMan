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
        NavigationLink(destination: Text("hi"), label: {
            
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
