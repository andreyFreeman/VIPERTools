//
//  main.swift
//  ConsoleTest
//
//  Created by ANDREY KLADOV on 08/06/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation

let templatesRelativePath = "/Library/Xcode/Templates/File Templates/VIPER"
let sourceTemplatesFolder = "VIPER"

func placeFiles() {
    let fileManager = FileManager.default
    let templatesPath = bash("xcode-select", ["--print-path"]).appending(templatesRelativePath)
    let sourcePath = currentDirectory().appending("/"+sourceTemplatesFolder)
    
    do {
        if !fileManager.fileExists(atPath: templatesPath) {
            try fileManager.createDirectory(atPath: templatesPath, withIntermediateDirectories: false, attributes: nil)
        }
        let templates = try fileManager.contentsOfDirectory(atPath: sourcePath).filter { $0.hasSuffix(".xctemplate") }
        try templates.forEach {
            terminalPrint("intalling: \($0)")
            let sourceItem      = sourcePath.appending("/"+$0)
            let destinationItem = templatesPath.appending("/"+$0)
            if fileManager.fileExists(atPath: destinationItem) {
                try fileManager.removeItem(atPath: destinationItem)
            }
            try fileManager.copyItem(atPath: sourceItem, toPath: templatesPath.appending("/"+$0))
            terminalPrint("✅  \($0) intalled")
        }
        terminalPrint("🎉  All installed and ready to go! Cheers!! 🍺 🍺 🍺")
    }
    catch {
        terminalPrint("💩 ! Something went wrong here. Make sure 'sudo' is supplied or try manual installation")
    }
}

@discardableResult func shell(_ path: String, _ args: [String]) -> String {
    let task = Process()
    task.launchPath = path
    task.arguments = args
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    if output.characters.count > 0 {
        let lastIndex = output.index(before: output.endIndex)
        return String(output[output.startIndex..<lastIndex])
    }
    return output
}

@discardableResult func bash(_ command: String, _ args: [String]) -> String {
    let path = shell("/bin/bash", ["-l", "-c", "which \(command)"])
    return shell(path, args)
}

func currentDirectory() -> String {
    
    let currentWorkingDirectory = FileManager.default.currentDirectoryPath
    let commandDirectory = CommandLine.arguments[0]
    
    if commandDirectory.hasPrefix("/") {
        return (commandDirectory as NSString).deletingLastPathComponent
    } else {
        let currentWorkingDirectoryUrl = URL(fileURLWithPath: currentWorkingDirectory)
        guard let path = URL(string: commandDirectory, relativeTo: currentWorkingDirectoryUrl)?.path else {
            return currentWorkingDirectory
        }
        return (path as NSString).deletingLastPathComponent
    }
}

func terminalPrint(_ printable: Any) {
    print(printable)
}

placeFiles()
