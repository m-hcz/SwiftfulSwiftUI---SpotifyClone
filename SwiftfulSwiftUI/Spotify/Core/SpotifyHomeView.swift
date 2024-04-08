//
//  SpotifyHomeView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {

	@State var vm: SpotifyHomeViewModel

    var body: some View {
		ZStack {
			Color.spotifyBlack.ignoresSafeArea()

			ScrollView(.vertical) {
				LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]) {
					Section {
						VStack(spacing: 16) {
							recentsSection

							if let product = vm.products.first {
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
			await vm.getData()
		}
		.toolbar(.hidden, for: .navigationBar)
    }



	private var header: some View {
		HStack(spacing: 0) {
			ZStack {
				if let currentUser = vm.currentUser {
					ImageLoaderView(urlString: currentUser.image)
						.background(.spotifyWhite)
						.clipShape(Circle())
						.onTapGesture {
							vm.router.dismissScreen()
						}
				}
			}
			.frame(width: 35, height: 35)

			ScrollView(.horizontal) {
				HStack(spacing: 8) {
					ForEach(SpotifyCategory.allCases, id: \.self) { category in
						SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == vm.selectedCategory)
							.onTapGesture {
								vm.selectedCategory = category
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
		NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: vm.products) { product in
			if let product {
				SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
					.asButton(.press) {
						vm.goToPlaylistView(product: product)
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
			subtitle: product.description,
			onAddToPlaylistPressed: {

			}, 
			onPlayPressed: {
				vm.goToPlaylistView(product: product)
			})
	}

	private var listRows: some View {
		ForEach(vm.productRows) { row in
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
								vm.goToPlaylistView(product: product)
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
	RouterView { router in
		SpotifyHomeView(vm: SpotifyHomeViewModel(router: router))
	}
}
