import Foundation

struct Chet: Codable {
	let name: String
	var balance: Float
	var id: String
}

func getChet(name: String) -> Chet {
	let chetDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + name + "/chet")
	let chetData: Chet = try! JSONDecoder().decode(Chet.self, from: chetDataString.data(using: .utf8)!)
	return chetData
}

func getAllChets() -> [Chet] {
	var allChetsUrl: [URL]

	let dataDirectory: URL = URL(string: getDataDirectory() + "data/")!

	allChetsUrl = try! FileManager.default.contentsOfDirectory(
		at: dataDirectory,
		includingPropertiesForKeys: nil
	)

	allChetsUrl = allChetsUrl.filter { $0.absoluteString.split(separator: "/")[$0.absoluteString.split(separator: "/").count-1] != ".DS_Store" }

	var allChets: [Chet] = []

	for chet: URL in allChetsUrl {
		var chetarr: [String.SubSequence] = chet.absoluteString.split(separator: "/")
		chetarr.removeFirst()
		if (String(chetarr[chetarr.count - 1]) != "main") {
			let chetDataString: String = readFromFile(fileName: "/" + chetarr.joined(separator: "/") + "/chet")
			let chetData: Chet = try! JSONDecoder().decode(Chet.self, from: chetDataString.data(using: .utf8)!)
			allChets.append(chetData)
		}
	}
	return allChets
}

func createChet(name: String, balance: Float = 0) -> Any {
	createDirectory(dirName: name)
	if (readFromFile(fileName: getDataDirectory() + "data/" + name + "/chet") == "" && readFromFile(fileName: getDataDirectory() + "data/" + name + "/transactions") == "") {
		let newChet: Chet = Chet(name: name, balance: balance, id: UUID().uuidString)
		let newChetJson = try! JSONEncoder().encode(newChet)
		let newChetString: String = String(data: newChetJson, encoding: .utf8)!
		writeInFile(fileName: getDataDirectory() + "data/" + name + "/chet", str: newChetString)
		writeInFile(fileName: getDataDirectory() + "data/" + name + "/transactions", str: "")
		return newChet
	} else {
		print("Chet already exists")
		return false
	}
}

func deleteChet(name: String) -> Bool {
	if (name == "main" || name == "MAIN") {
		print("You can't delete main chet!")
		return false
	} else {
		removeDirectory(dirName: name)
	}
	return true
}