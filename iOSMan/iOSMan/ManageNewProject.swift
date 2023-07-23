//
//  ManageNewProject.swift
//  iOSMan
//
//  Created by 임준협 on 7/10/23.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI
func manNewProj() -> newManager {
    var fileDir = ""
    var fileEx = ""
    guard let xcodeproj = UTType(tag: "xcodeproj", tagClass: .filenameExtension, conformingTo: .compositeContent) else { fatalError() }
    guard let xcworkspace = UTType(tag: "xcworkspace", tagClass: .filenameExtension, conformingTo: .compositeContent) else { fatalError() }
    let panel = NSOpenPanel()
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = false
    panel.canChooseFiles = true
    panel.canCreateDirectories = false
    panel.resolvesAliases = false;
    panel.allowedContentTypes = [xcodeproj, xcworkspace]
//    panel.hidd
    panel.title = "Select your iOS project"
    panel.prompt = "Manage"
    if panel.runModal() == .OK {
        fileDir = panel.url?.absoluteString ?? ""
        fileEx = panel.url!.pathExtension
    }
    let dirCount = fileDir.count
    var isCanceled = false
    if dirCount-7<0{
        isCanceled = true
    } else {
        fileDir = String(fileDir.suffix(dirCount-7))
    }
    print("Path: \(fileDir) Type: \(fileEx)")
    return newManager(name: "", type: fileEx=="xcodeproj", path: fileDir, canceled: isCanceled)
}

struct newManager {
    let name: String
    let type: Bool
    let path: String
    let canceled: Bool
}
