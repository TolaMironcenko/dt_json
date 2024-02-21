import Foundation

struct User: Codable {
	var name: String
	var username: String
	var hashed_password: String
	var id: String = UUID().uuidString
}

// func hash_password(password: String) -> String {

// }

// func validate_password(password1: String, password2: String) -> Bool {

// }

// func register(name: String, username: String, password1: String, password2: String) -> User {

// }

// func login(username: String, password: String) -> User {

// }
