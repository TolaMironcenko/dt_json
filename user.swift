import Foundation

struct User: Codable {
	var name: String
	var username: String
	var hashed_password: String
	var id: String = UUID().uuidString
}

func hash_password(password: String) -> String {
	return password
}

func getUserByUsername(username: String) -> User? {
	let userString: String = readFromFile(fileName: getDataDirectory() + "data/users")
	if (userString == "") {
		return nil
	}
	let userData: User = try! JSONDecoder().decode(User.self, from: userString.data(using: .utf8)!)
	return userData
}

func validate_password(password1: String, password2: String) -> Bool {
	if (password1 != password2) {
		return false
	}
	return true
}

func createUser(name: String, username: String, password: String) -> User {
	let newUser = User(name: name, username: username, hashed_password: password)
	let newUserData = try! JSONEncoder().encode(newUser)
	let newUserDataString: String = String(data: newUserData, encoding: .utf8)!
	writeInFile(fileName: getDataDirectory() + "data/users", str: newUserDataString)
	return newUser
}

func register(name: String, username: String, password1: String, password2: String) -> User? {
	if (!validate_password(password1: hash_password(password: password1), password2: hash_password(password: password2))) {
		return nil
	}
	let newUser = createUser(name: name, username: username, password: hash_password(password: password1))
	return newUser
}

func login(username: String, password: String) -> User? {
	let loginUser: User? = getUserByUsername(username: username)
	if (loginUser == nil) {
		return nil
	}
	if (!validate_password(password1: loginUser!.hashed_password, password2: hash_password(password: password))) {
		return nil
	}
	return loginUser
}
