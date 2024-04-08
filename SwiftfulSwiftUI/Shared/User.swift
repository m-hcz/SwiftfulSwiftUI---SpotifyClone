//
//  User.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 01.04.2024.
//

import Foundation

struct UserArray: Codable {
	let users: [User]
	let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
	let id: Int
	let firstName, lastName: String
	let age: Int
	let email, phone, username, password: String
	let image: String
	let height: Int
	let weight: Double

	static var mock: User {
		.init(
			id: 123,
			firstName: "Michal",
			lastName: "MM",
			age: 20,
			email: "michal@michal",
			phone: "",
			username: "Michal",
			password: "",
			image: Constants.randomImage,
			height: 180,
			weight: 200
		)
	}
}
