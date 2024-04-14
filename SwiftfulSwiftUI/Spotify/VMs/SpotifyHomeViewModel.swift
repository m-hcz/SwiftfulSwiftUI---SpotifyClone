//
//  SpotifyModel.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 08.04.2024.
//

import Foundation
import SwiftfulRouting

@Observable
final class SpotifyHomeViewModel {
	let router: AnyRouter

	var currentUser: User? = nil
	var selectedCategory: SpotifyCategory? = nil
	var products: [Product] = []
	var productRows: [ProductRow] = []

	init(router: AnyRouter) {
		self.router = router
	}

	func getData() async {
		guard products.isEmpty else { return }

		do {
			self.currentUser = try await DatabaseHelper().getUsers().first
			self.products = try await Array(DatabaseHelper().getProducts().prefix(8))

			var rows: [ProductRow] = []

			let allBrands = Set(self.products.map { $0.brand })
			for brand in allBrands {
				//				let products = self.products.filter { $0.brand == brand}
				rows.append(ProductRow(title: brand, products: self.products.shuffled()))
			}
			self.productRows = rows

		} catch {
		}
	}

	func goToPlaylistView(product: Product) {
		guard let currentUser = currentUser else { return }

		router.showScreen(.push) { router in
			SpotifyPlaylistView(vm: SpotifyPlaylistViewModel(router: router, currentUser: currentUser, product: product))
		}
	}
}
