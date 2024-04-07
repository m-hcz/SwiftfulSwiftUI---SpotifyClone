//
//  SpotifyHomeView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {

	@State private var currentUser: User?
	@State private var selectedCategory: SpotifyCategory?
	@State private var products: [Product] = []
	@State private var productRows: [ProductRow] = []

    var body: some View {
		ZStack {
			Color.spotifyBlack.ignoresSafeArea()

			ScrollView(.vertical) {
				LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]) {
					Section {
						VStack(spacing: 16) {
							recentsSection

							if let product = products.first {
								newReleaseSection(product: product)
							}
						}
						.padding(.horizontal, 16)

						listRows
					} header: {
						header
					}
				}
				.padding(.top, 8)
			}
			.scrollIndicators(.hidden)
			.clipped()
		}
		.task {
			await getData()
		}
		.toolbar(.hidden, for: .navigationBar)
    }

	private func getData() async {
		do {
			currentUser = try await DatabaseHelper().getUsers().first
			products = try await Array(DatabaseHelper().getProducts().prefix(8))

			var rows: [ProductRow] = []

			let allBrands = Set(products.map { $0.brand })
			for brand in allBrands {
//				let products = self.products.filter { $0.brand == brand}
				rows.append(ProductRow(title: brand, products: products.shuffled()))
			}
			productRows = rows

		} catch {
		}
	}

	private var header: some View {
		HStack(spacing: 0) {
			ZStack {
				if let currentUser {
					ImageLoaderView(urlString: currentUser.image)
						.background(.spotifyWhite)
						.clipShape(Circle())
						.onTapGesture {

						}
				}
			}
			.frame(width: 35, height: 35)

			ScrollView(.horizontal) {
				HStack(spacing: 8) {
					ForEach(SpotifyCategory.allCases, id: \.self) { category in
						SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
							.onTapGesture {
								selectedCategory = category
							}
					}
				}
				.padding(.horizontal, 16)
			}
			.scrollIndicators(.hidden)
		}
		.padding(.vertical, 24)
		.padding(.leading, 8)
		.background(.spotifyBlack)
	}

	private var recentsSection: some View {
		NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
			if let product {
				SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
					.asButton(.press) {

					}
			}
		}
	}

	private func newReleaseSection(product: Product) -> some View {
		SpotifyNewReleaseCell(
			imageName: product.firstImage,
			headline: product.brand,
			subheadline: product.category,
			title: product.title,
			subtitle: product.description) {

			} onPlayPressed: {

			}
	}

	private var listRows: some View {
		ForEach(productRows) { row in
			VStack {
				Text(row.title)
					.font(.title2)
					.fontWeight(.semibold)
					.foregroundStyle(.spotifyWhite)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.horizontal, 16)

				ScrollView(.horizontal) {
					HStack(alignment: .top ,spacing: 16) {
						ForEach(row.products) { product in
							SpotifyImageTitleRowCell(
								imageSize: 100,
								imageName: product.firstImage,
								title: product.title
							)
							.asButton(.press) {

							}
						}
					}
					.padding(.horizontal, 16)
				}
				.scrollIndicators(.hidden)
			}
		}
	}
}

#Preview {
    SpotifyHomeView()
}
