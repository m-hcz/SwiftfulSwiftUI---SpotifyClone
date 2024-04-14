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

	var work: String { "My work" }
	var education: String { "Graduate Degree" }
	var aboutMe: String { "A sentence about me." }

	var basics: [UserInterest] { [UserInterest(iconName: "ruler", text: "\(height)"),
								  UserInterest(iconName: "gradiationcap", text: education),
								  UserInterest(iconName: "wineglass", text: "Socially"),
								  UserInterest(iconName: "heart.fill", text: "text 1"),
								  UserInterest(iconName: "heart.fill", text: "text 1"),
								  UserInterest(iconName: "moon.stars.fill", text: "Virgo"),
	]}

	var interests: [UserInterest] { [UserInterest(emoji: "☢️", text: "Running"),
								  UserInterest(emoji: "😀", text: "Gym"),
								  UserInterest(emoji: "😀", text: "Music"),
								  UserInterest(emoji: "😀", text: "Cooking")
	]}
	var images: [String] {
		["https://picsum.photos/600/601", "https://picsum.photos/600/602", "https://picsum.photos/600/603"]
	}

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
