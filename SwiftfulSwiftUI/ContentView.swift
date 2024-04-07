//
//  ContentView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 01.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
	@State private var users: [User] = []
	@State private var products: [Product] = []

    var body: some View {
        ScrollView {
			HStack(content: {
				VStack(content: {
					ForEach(users) { user in
						Text(user.firstName)
					}
				})
				VStack(content: {
					ForEach(products) { product in
						Text(product.brand)
					}
				})
			})
        }
        .padding()
		.task {
			await getData()
		}
    }

	private func getData() async {
		do {
			users = try await DatabaseHelper().getUsers()
			products = try await DatabaseHelper().getProducts()
		} catch {
		}
	}
}

#Preview {
    ContentView()
}
