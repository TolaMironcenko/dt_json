import Foundation

struct Transaction: Codable {
	let chet: String
	let category: String
	let sum: Float
	var id: String = UUID().uuidString
}

func getTransactionsForCategoryAndChet(chet: String, category: String) -> [Transaction] {
	let transactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + chet + "/transactions")
	var transactions: [Transaction] = []
	do {
		transactions = try JSONDecoder().decode([Transaction].self, from: transactionsDataString.data(using: .utf8)!)
	} catch {
		transactions = []
	}
	transactions = transactions.filter {$0.category == category}
	return transactions
}

func getTransactionsFotCategory(category: String) -> [Transaction] {
	let transactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/main/transactions")
	var transactions: [Transaction] = []
	do {
		transactions = try JSONDecoder().decode([Transaction].self, from: transactionsDataString.data(using: .utf8)!)
	} catch {
		transactions = []
	}
	transactions = transactions.filter {$0.category == category}
	return transactions
}

func getTransactionsForChet(chet: String) -> [Transaction] {
	let transactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + chet + "/transactions")
	var transactions: [Transaction] = []
	do {
		transactions = try JSONDecoder().decode([Transaction].self, from: transactionsDataString.data(using: .utf8)!)
	} catch {
		transactions = []
	}
	return transactions
}

func createTransaction(chet: String, category: String = "No category", sum: Float = 0) -> Transaction {
	let newTransaction: Transaction = Transaction(chet: chet, category: category, sum: sum)
	let transactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + chet + "/transactions")
	var transactions: [Transaction] = []
	do {
		transactions = try JSONDecoder().decode([Transaction].self, from: transactionsDataString.data(using: .utf8)!)
	} catch {
		transactions = []
	}
	transactions.append(newTransaction)
	let transactionsJson = try! JSONEncoder().encode(transactions)
	let transactionsJsonString: String = String(data: transactionsJson, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/" + chet + "/transactions", str: transactionsJsonString)
	writeInFile(fileName: getDataDirectory() + "data/main/transactions", str: transactionsJsonString)

	let chetDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + chet + "/chet")
	var chetData: Chet = try! JSONDecoder().decode(Chet.self, from: chetDataString.data(using: .utf8)!)
	chetData.balance += sum
	let chetDataJson = try! JSONEncoder().encode(chetData)
	let chetJsonString: String = String(data: chetDataJson, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/" + chet + "/chet", str: chetJsonString)

	let mainChetDataString: String = readFromFile(fileName: getDataDirectory() + "data/main/chet")
	var mainChetData: Chet = try! JSONDecoder().decode(Chet.self, from: mainChetDataString.data(using: .utf8)!)
	mainChetData.balance += sum
	let mainChetDataJson = try! JSONEncoder().encode(mainChetData)
	let mainChetJsonString: String = String(data: mainChetDataJson, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/main/chet", str: mainChetJsonString)

	return newTransaction
}

func deleteTransaction(chet: String, id: String) -> Bool {
	let transactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/" + chet + "/transactions")
	if (transactionsDataString == "") {
		return false
	}
	var transactions: [Transaction] = []
	do {
		transactions = try JSONDecoder().decode([Transaction].self, from: transactionsDataString.data(using: .utf8)!)
	} catch {
		transactions = []
	}
	let deleteTransactionData: [Transaction] = transactions.filter {$0.id == id}
	if (deleteTransactionData.isEmpty) {
		return false
	}
	transactions = transactions.filter {$0.id != id}
	let transactionsJson = try! JSONEncoder().encode(transactions)
	let transactionsJsonString: String = String(data: transactionsJson, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/" + chet + "/transactions", str: transactionsJsonString)

	let mainTransactionsDataString: String = readFromFile(fileName: getDataDirectory() + "data/main/transactions")
	var mainTransactions: [Transaction] = []
	do {
		mainTransactions = try JSONDecoder().decode([Transaction].self, from: mainTransactionsDataString.data(using: .utf8)!)
	} catch {
		mainTransactions = []
	}
	// let deleteTransactionData: [Transaction] = transactions.filter {$0.id == id}
	mainTransactions = mainTransactions.filter {$0.id != id}
	let mainTransactionsJson = try! JSONEncoder().encode(mainTransactions)
	let mainTransactionsJsonString: String = String(data: mainTransactionsJson, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/main/transactions", str: mainTransactionsJsonString)

	return true
}