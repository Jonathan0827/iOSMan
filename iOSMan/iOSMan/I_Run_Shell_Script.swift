//
//  I_Run_Shell_Script.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import Foundation

func executeSh(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/sh"
    task.standardInput = nil
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    var returnValue = ""
    if output.isEmpty {
        returnValue = "macOS returned nothing"
    } else {
        returnValue = output
    }
    return returnValue
}

func runShFile(_ shName: String) -> String {
    let task = Process()
    let pipe = Pipe()
    let fileManager = FileManager.default
    let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    let manSupportURL = appSupportURL.appendingPathComponent("iOSMan/iOSManHelpers")
    let man = manSupportURL.absoluteString
    let manInd = man.count
    let manSupportDir = String(man.suffix(manInd-7)).replacingOccurrences(of: "%20", with: "\\ ")
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", "sh \(manSupportDir)/\(shName)"]
    task.launchPath = "/bin/bash"
    task.standardInput = nil
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}
