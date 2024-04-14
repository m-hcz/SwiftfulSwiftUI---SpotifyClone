//
//  BumbleInterestPillView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 10.04.2024.
//

import SwiftUI

struct BumbleInterestPillView: View {

	var iconName: String?
	var emoji: String?
	var text: String

    var body: some View {
		HStack(spacing: 4) {
			if let iconName {
				Image(systemName: iconName)
			} else if let emoji {
				Text(emoji)
			}

			Text(text)
		}
		.font(.callout)
		.fontWeight(.medium)
		.padding(.vertical, 6)
		.padding(.horizontal, 12)
		.foregroundStyle(.bumbleBlack)
		.background(.bumbleLightYellow)
		.cornerRadius(32)
    }
}

#Preview {
	VStack {
		BumbleInterestPillView(iconName: "heart.fill", text: "Graduate Degree")
		BumbleInterestPillView(emoji: "☢️", text: "Graduate Degree")
	}
}
