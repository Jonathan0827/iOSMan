//
//  ProjSelectionView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/09.
//

import SwiftUI

struct ProjSelectionView: View {
    let projectName: String
    let projectType: Int
    let projectPath: URL
    let projectFilePath: URL
    var body: some View {
        VStack {
            Text(projectName)
                .fontWeight(.semibold)
                .font(.title2)
            
        }
    }
}
