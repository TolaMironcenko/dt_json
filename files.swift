//
//  files.swift
//  dt
//
//  Created by Анатолий Миронченко on 29.01.2023.
//

import Foundation

// function for read some string from file
func readFromFile(fileName: String) -> String {
    var line: String
    do {
        line = try String(contentsOfFile: fileName)
    } catch _ as NSError {
        //        print("read file error: \(error.localizedDescription)")
        return ""
    }
    
    return line
}

// function for write some string in file
func writeInFile(fileName: String, str: String) {
    try? str.write(toFile: fileName, atomically: true, encoding: .utf8)
}

// function for appending some string in file
func appendInFile(fileName: String, str: String) {
    var toFile: String = readFromFile(fileName: fileName)
    toFile += str
    writeInFile(fileName: fileName, str: toFile)
}

// function for get document directory
func getDocumentsDirectory() -> String {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    var docDir = documentsDirectory.absoluteString.split(separator: "/")
    docDir.removeFirst()
    return "/" + docDir.joined(separator: "/")
}

// function for get data directory
func getDataDirectory() -> String {
    let dataDirectory: String = getDocumentsDirectory() + "/.dt/"
    return dataDirectory
}

func checkDirectory(dir: String) -> Bool {
    do {
        let dataDirectory: URL = URL(string: dir)!
        let filesInDirectory = try FileManager.default.contentsOfDirectory(at: dataDirectory, includingPropertiesForKeys: nil)
        
        let files = filesInDirectory
        if files.count > 0 {
            return true
        }
    } catch let error as NSError {
        print(error)
    }
    return false
}

func createDataDirectory() {
    do {
        //        print(getDocumentsDirectory())
        if (!checkDirectory(dir: getDocumentsDirectory() + "/.dt/data/main")) {
            try FileManager.default.createDirectory(atPath: getDocumentsDirectory() + "/.dt/data/main", withIntermediateDirectories: true, attributes: nil)
            
            if (readFromFile(fileName: getDataDirectory() + "data/main/" + "/chet") == "" || readFromFile(fileName: getDataDirectory() + "data/main/" + "/transactions") == "") {
                writeInFile(fileName: getDataDirectory() + "data/main/" + "/chet", str: "{\"name\":\"main\",\"balance\":0,\"id\":\"0\"}")
                writeInFile(fileName: getDataDirectory() + "data/main/" + "/transactions", str: "")
            }
        }
        //        try FileManager.default.createDirectory(atPath: getDocumentsDirectory() + "/.dt/data", withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print("Error creating directory: \(error.localizedDescription)")
    }
}

// function for create directory
func createDirectory(dirName: String) {
    do {
        try FileManager.default.createDirectory(atPath: getDataDirectory() + "data/" + dirName, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        print("Error creating directory: \(error.localizedDescription)")
    }
}

// function for remove directory
func removeDirectory(dirName: String) {
    try? FileManager.default.removeItem(atPath: getDataDirectory() + "data/" + dirName)
}
