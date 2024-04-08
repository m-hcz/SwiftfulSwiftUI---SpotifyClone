//
//  SpotifyPlaylistView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {

	@State var vm: SpotifyPlaylistViewModel

    var body: some View {
		ZStack {
			Color.spotifyBlack.ignoresSafeArea()
			
			ScrollView(.vertical) {
				LazyVStack(spacing: 12) {
					SpotifyPlaylistHeaderCell(
						height: 250,
						title: vm.product.title,
						subtitle: vm.product.brand,
						imageName: vm.product.thumbnail
					)
					.readingFrame { frame in
						vm.showHeader = frame.maxY < 150
					}

					SpotifyPlaylistDescriptionCell(
						descriptionText: vm.product.description,
						userName: vm.currentUser.username,
						subheadline: vm.product.category,
						onAddToPlaylistPressed: nil,
						onDownloadPressed: nil,
						onSharePressed: nil,
						onEllipsePressed: nil,
						onShufflePressed: nil,
						onPlayPressed: nil
					)
					.padding(.horizontal, 16)

					ForEach(vm.products) { product in
						SpotifySongRowCell(
							imageSize: 80,
							imageName: product.firstImage,
							title: product.title,
							subtitle: product.brand, 
							onCellPressed: {
								vm.goToPlaylistView(product: product)
							},
							onEllipsisPressed: {

							})

					}
					.padding(.leading, 16)
				}
			}
			.scrollIndicators(.hidden)

			ZStack {
				Text(vm.product.title)
					.font(.headline)
					.padding(.vertical, 20)
					.frame(maxWidth: .infinity)
					.background(.spotifyBlack)
					.offset(y: vm.showHeader ? 0 : -200)
					.opacity(vm.showHeader ? 1 : 0)

				Image(systemName: "chevron.left")
					.font(.title3)
					.padding(10)
					.background(vm.showHeader ? Color.spotifyGray.opacity(0.001) : Color.spotifyGray.opacity(0.7))
					.clipShape(Circle())
					.onTapGesture {
						vm.router.dismissScreen()
					}
					.padding(.leading, 16)
					.frame(maxWidth: .infinity, alignment: .leading)
			}
			.foregroundStyle(.spotifyWhite)
			.frame(maxWidth: .infinity)
			.animation(.smooth(duration: 0.4), value: vm.showHeader)
				.frame(maxHeight: .infinity, alignment: .top)
		}
		.task {
			await vm.getData()
		}
		.toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
	RouterView { router in
		SpotifyPlaylistView(vm: SpotifyPlaylistViewModel(router: router, currentUser: .mock, product: .mock))
	}
}
