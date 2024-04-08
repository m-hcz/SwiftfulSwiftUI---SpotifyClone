//
//  SpotifyPlaylistDescriptionCell.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI

struct SpotifyPlaylistDescriptionCell: View {

	var descriptionText: String = Product.mock.description
	var userName: String = "Michal"
	var subheadline: String = "Some headline"

	var onAddToPlaylistPressed: (() -> Void)?
	var onDownloadPressed: (() -> Void)?
	var onSharePressed: (() -> Void)?
	var onEllipsePressed: (() -> Void)?
	var onShufflePressed: (() -> Void)?
	var onPlayPressed: (() -> Void)?

    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(descriptionText)
				.foregroundStyle(.spotifyLightGray)
				.frame(maxWidth: .infinity, alignment: .leading)

			madeForYou

			Text(subheadline)

			buttonsRow
		}
		.font(.callout)
		.fontWeight(.medium)
		.foregroundStyle(.spotifyLightGray)
    }

	private var madeForYou: some View {
		HStack(spacing: 8) {
			Image(systemName: "applelogo")
				.font(.title3)
				.foregroundStyle(.spotifyGreen)

			Text("Made for ")
			+
			Text(userName)
				.bold()
				.foregroundStyle(.spotifyWhite)
		}
	}

	private var buttonsRow: some View {
		HStack(spacing: 8) {
			HStack(spacing: 0) {
				Image(systemName: "plus.circle")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {
						onAddToPlaylistPressed?()
					}
				Image(systemName: "arrow.down.circle")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {
						onDownloadPressed?()
					}
				Image(systemName: "square.and.arrow.up")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {
						onSharePressed?()
					}
				Image(systemName: "ellipsis")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {
						onEllipsePressed?()
					}
			}
			.offset(x: -8)
			.frame(maxWidth: .infinity, alignment: .leading)

			HStack(spacing: 8) {
				Image(systemName: "shuffle")
					.font(.system(size: 24))
					.background(.black.opacity(0.001))
					.onTapGesture {
						onShufflePressed?()
					}
				Image(systemName: "play.circle.fill")
					.font(.system(size: 46))
					.background(.black.opacity(0.001))
					.onTapGesture {
						onPlayPressed?()
					}
			}
			.foregroundStyle(.spotifyGreen)
		}
		.font(.title2)
	}
}

#Preview {
	ZStack {
		Color.spotifyBlack.ignoresSafeArea()

		SpotifyPlaylistDescriptionCell()
	}
}
