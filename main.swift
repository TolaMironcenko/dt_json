createDataDirectory()

print("all chets:    ", getAllChets())
print("get main chet:    ", getChet(name: "main"))
// print(createTransaction(chet: "mom", category: "mac", sum: 100.42))
// createChet(name: "mom", balance: 0)
print("transactions for category mac and chet mom:    ", getTransactionsForCategoryAndChet(chet: "mom", category: "mac"))
if (!deleteTransaction(chet: "mom", id: "9474086E-6291-45A2-ADED-21C17DDE9D9D")) {
	print("error")
}

// register(name: "tola", username: "tola", password1: "2808", password2: "2808")
print(login(username: "tola", password: "2808"))
