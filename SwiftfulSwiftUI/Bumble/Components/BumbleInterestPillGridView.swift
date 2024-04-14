//
//  BumbleInterestPillGridView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 10.04.2024.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
	let id = UUID().uuidString
	var iconName: String?
	var emoji: String?
	var text: String
}

struct BumbleInterestPillGridView: View {

	var interests: [UserInterest]

    var body: some View {
		ZStack {
			NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: interests) { interest in
				if let interest {
					BumbleInterestPillView(iconName: interest.iconName, emoji: interest.emoji, text: interest.text)
				} else {
					EmptyView()
				}
			}
		}
    }
}

#Preview {
	VStack(spacing: 40) {
		BumbleInterestPillGridView(interests: User.mock.basics)
		BumbleInterestPillGridView(interests: User.mock.interests)
	}
}
