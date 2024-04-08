//
//  SpotifySongRowCell.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 08.04.2024.
//

import SwiftUI

struct SpotifySongRowCell: View {

	var imageSize: CGFloat = 60
	var imageName: String = Constants.randomImage
	var title: String = "Some title"
	var subtitle: String = "Some sumtitle"
	var onCellPressed: (()->Void)?
	var onEllipsisPressed: (()->Void)?

    var body: some View {
		HStack {
			ImageLoaderView(urlString: imageName)
				.frame(width: imageSize, height: imageSize)

			VStack(alignment: .leading, spacing: 4) {
				Text(title)
					.font(.body)
					.fontWeight(.medium)
					.foregroundStyle(.spotifyWhite)
				Text(subtitle)
					.font(.callout)
					.foregroundStyle(.spotifyLightGray)
			}
			.lineLimit(2)
			.frame(maxWidth: .infinity, alignment: .leading)

			Image(systemName: "ellipsis")
				.font(.subheadline)
				.foregroundStyle(.spotifyWhite)
				.padding(16)
				.background(Color.black.opacity(0.001))
				.onTapGesture {
					onEllipsisPressed?()
				}

		}
		.onTapGesture {
			onCellPressed?()
		}
    }
}

#Preview {
	ZStack {
		Color.spotifyBlack.ignoresSafeArea()

		VStack {
			SpotifySongRowCell()
			SpotifySongRowCell()
			SpotifySongRowCell()
		}
	}
}
