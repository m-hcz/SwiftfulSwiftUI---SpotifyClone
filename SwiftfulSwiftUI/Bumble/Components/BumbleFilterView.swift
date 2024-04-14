//
//  BumbleFilterView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 09.04.2024.
//

import SwiftUI

struct BumbleFilterView: View {

	var options: [String] = []
	@Binding var selection: String
	@Namespace private var namespace

    var body: some View {
		HStack(alignment: .top, spacing: 32) {
			ForEach(options, id: \.self) { option in
				VStack(spacing: 8) {
					Text(option)
						.frame(maxWidth: .infinity)
						.font(.subheadline)
						.fontWeight(.medium)

					if selection == option {
						RoundedRectangle(cornerRadius: 2)
							.frame(height: 1.5)
							.matchedGeometryEffect(id: "selection", in: namespace)
					}
				}
				.padding(.top, 8)
				.background(.black.opacity(0.001))
				.foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
				.onTapGesture {
					selection = option
				}
			}
		}
		.animation(.smooth, value: selection)
		.background(Divider().offset(y: -0.5), alignment: .bottom)

    }
}


fileprivate struct BumbleFilterViewPreview: View {
	var options: [String] = ["Everyone", "Tranding"]
	@State var selection: String = "Everyone"

	var body: some View {
		BumbleFilterView(options: options, selection: $selection)
	}
}

#Preview {
	BumbleFilterViewPreview()
}
