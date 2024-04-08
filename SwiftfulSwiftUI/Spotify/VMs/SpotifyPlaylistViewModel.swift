//
//  SpotifyPlaylistViewModel.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 08.04.2024.
//

import Foundation
import SwiftfulRouting

@Observable
final class SpotifyPlaylistViewModel {
	let router: AnyRouter

	var currentUser: User
	var product: Product
	var products: [Product] = []
	var showHeader: Bool = false

	init(router: AnyRouter, currentUser: User, product: Product) {
		self.router = router
		self.currentUser = currentUser
		self.product = product
	}

	func getData() async {
		do {
			products = try await DatabaseHelper().getProducts()
		} catch {
			print(error)
		}
	}

	func goToPlaylistView(product: Product) {
		router.showScreen(.push) { router in
			SpotifyPlaylistView(vm: SpotifyPlaylistViewModel(router: router, currentUser: self.currentUser, product: product))
		}
	}
}
