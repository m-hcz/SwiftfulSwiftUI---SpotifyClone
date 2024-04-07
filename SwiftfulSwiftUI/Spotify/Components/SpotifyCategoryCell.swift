//
//  SpotifyCategoryCell.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {

	var title: String = "All"
	var isSelected: Bool = false
	
    var body: some View {
        Text(title)
			.font(.callout)
			.frame(minWidth: 35)
			.padding(.vertical, 8)
			.padding(.horizontal, 10)
			.themeColors(isSelected: isSelected)
			.cornerRadius(16)
    }
}



#Preview {
	ZStack {
		Color.spotifyBlack.ignoresSafeArea()

		VStack(spacing: 40) {
			SpotifyCategoryCell(title: "Title text")
			SpotifyCategoryCell(title: "Title text", isSelected: true)
			SpotifyCategoryCell(isSelected: true)
		}
	}
}
