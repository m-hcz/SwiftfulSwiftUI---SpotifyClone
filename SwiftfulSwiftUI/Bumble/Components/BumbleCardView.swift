//
//  BumbleCardView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 10.04.2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {

	var user: User
	var onSuperlikePresses: (()->Void)?
	var onXmarkPresses: (()->Void)?
	var onCheckmarkPresses: (()->Void)?
	var onSendAComplimentPresses: (()->Void)?
	var onHideAndReportPresses: (()->Void)?

	@State private var cardFrame: CGRect = .zero

    var body: some View {
		ScrollView {
			LazyVStack(spacing: 0) {
				header
					.frame(height: cardFrame.height)

				aboutMeSection
					.padding(24)

				myInterestsSection
					.padding(.horizontal, 24)

				ForEach(user.images, id: \.self) { image in
					ImageLoaderView(urlString: image)
						.frame(height: cardFrame.height)
				}
				.padding(.vertical, 24)

				locationSection
					.padding(.horizontal, 24)

				footerSection
					.padding(.vertical, 60)
					.padding(.horizontal, 32)
			}
		}
		.scrollIndicators(.hidden)
		.background(.bumbleBgYellow)
		.overlay(
			superlikeButton
				.padding(24)
			, alignment: .bottomTrailing
		)
		.cornerRadius(32)
		.readingFrame { frame in
			cardFrame = frame
		}
    }

	private func sectionTitle (title: String) -> some View {
		Text(title)
			.font(.body)
			.foregroundStyle(.bumbleGray)
	}

	private var header: some View {
		ZStack(alignment: .bottomLeading) {
			ImageLoaderView(urlString: user.image)

			VStack(alignment: .leading, spacing: 8) {
				Text("\(user.firstName), \(user.age)")
					.font(.largeTitle)
					.fontWeight(.semibold)

				HStack(spacing: 4) {
					Image(systemName: "suitcase")
					Text(user.work)
				}

				HStack(spacing: 4) {
					Image(systemName: "graduationcap")
					Text(user.education)
				}

				BumbleHeartView()
					.onTapGesture {
						onSendAComplimentPresses?()
					}
			}
			.padding(24)
			.font(.callout)
			.fontWeight(.medium)
			.foregroundStyle(.spotifyWhite)
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(
				LinearGradient(colors: [.bumbleBlack.opacity(0),.bumbleBlack.opacity(0.6),.bumbleBlack.opacity(0.6),], startPoint: .top, endPoint: .bottom)
			)

		}
	}

	private var aboutMeSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			sectionTitle(title: "About Me")

			Text(user.aboutMe)
				.font(.body)
				.fontWeight(.semibold)
				.foregroundStyle(.bumbleBlack)

			HStack(spacing: 0) {
				BumbleHeartView()

				Text("Send a Compliment")
					.font(.caption)
					.fontWeight(.semibold)
			}
			.padding(.horizontal, 8)
			.padding(.trailing, 8)
			.background(.bumbleYellow)
			.cornerRadius(32)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}

	private var myInterestsSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			VStack(alignment: .leading, spacing: 8) {
				sectionTitle(title: "My basics")
				BumbleInterestPillGridView(interests: user.basics)
			}


			VStack(alignment: .leading, spacing: 8) {
				sectionTitle(title: "My Interests")
				BumbleInterestPillGridView(interests: user.interests)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}

	private var locationSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack(spacing: 8){
				Image(systemName: "mappin.and.ellipse.circle.fill")
				Text(user.firstName + "'s Location")
					.foregroundStyle(.bumbleGray)
					.font(.body)
					.fontWeight(.medium)
			}

			Text("10 miles away")
				.font(.headline)
				.foregroundStyle(.bumbleBlack)

			BumbleInterestPillView(iconName: "flag", text: "City")
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}

	private var footerSection : some View {
		VStack(spacing: 24) {
			HStack(spacing: 0) {
				Circle()
					.fill(.bumbleYellow)
					.overlay {
						Image(systemName: "xmark")
							.font(.title)
							.fontWeight(.semibold)
					}
					.frame(width: 60, height: 60)
					.onTapGesture {
						onXmarkPresses?()
					}

				Spacer(minLength: 0)

				Circle()
					.fill(.bumbleYellow)
					.overlay {
						Image(systemName: "checkmark")
							.font(.title)
							.fontWeight(.semibold)
					}
					.frame(width: 60, height: 60)
					.onTapGesture {
						onCheckmarkPresses?()
					}
			}

			Text("Hide and Report")
				.font(.headline)
				.foregroundStyle(.bumbleBlack)
				.padding(8)
				.background(.black.opacity(0.001))
				.onTapGesture {
					onHideAndReportPresses?()
				}

		}
	}

	private var superlikeButton: some View {
		Image(systemName: "hexagon.fill")
			.foregroundStyle(.bumbleYellow)
			.font(.system(size: 60))
			.overlay {
				Image(systemName: "star.fill")
					.foregroundStyle(.bumbleBlack)
					.font(.system(size: 30))
			}
			.onTapGesture {
				onSuperlikePresses?()
			}
	}
}

#Preview {
	BumbleCardView(user: .mock)
		.padding(.vertical, 40)
		.padding(.horizontal, 16)
}
