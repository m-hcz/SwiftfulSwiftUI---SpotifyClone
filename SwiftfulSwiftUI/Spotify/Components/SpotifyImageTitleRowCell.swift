//
//  SpotifyImageTitleRowCell.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI

struct SpotifyImageTitleRowCell: View {

	var imageSize: CGFloat = 100
	var imageName: String = Constants.randomImage
	var title: String = "title title title title title title"

    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			ImageLoaderView(urlString: imageName)
				.frame(width: imageSize, height: imageSize)

			Text(title)
				.foregroundStyle(.spotifyLightGray)
				.font(.callout)
				.fontWeight(.semibold)
				.lineLimit(2)
				.padding(4)
		}
		.frame(width: imageSize)
    }
}

#Preview {
	ZStack {
		Color.spotifyBlack.ignoresSafeArea()

		SpotifyImageTitleRowCell()
	}
}
