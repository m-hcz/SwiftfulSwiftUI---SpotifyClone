//
//  SpotifyPlaylistHeaderCell.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI
import SwiftfulUI

struct SpotifyPlaylistHeaderCell: View {

	var height: CGFloat = 300
	var title: String = "Some Playlist title"
	var subtitle: String = "Subtitle"
	var imageName: String = Constants.randomImage
	var shadowColor: Color = .spotifyBlack.opacity(0.8)

    var body: some View {
        Rectangle()
			.opacity(0)
			.overlay(
				ImageLoaderView(urlString: imageName)
			)
			.overlay(
				VStack(alignment: .leading, spacing: 8) {
					Text(subtitle)
						.font(.headline)
					Text(title)
						.font(.largeTitle)
						.fontWeight(.bold)
				}
				.foregroundStyle(.spotifyWhite)
				.padding(16)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(.linearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom))
				, alignment: .bottomLeading
			)
			.asStretchyHeader(startingHeight: height)
    }
}

#Preview {
	ZStack {
		Color.spotifyBlack.ignoresSafeArea()

		ScrollView {
			SpotifyPlaylistHeaderCell()
		}
		.ignoresSafeArea()
	}
}
