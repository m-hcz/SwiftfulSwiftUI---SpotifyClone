//
//  BumbleHomeView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 09.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {

	var user: User = .mock
	@State var filters: [String] = ["Everyone", "Tranding"]
	@AppStorage("bumble_home_filter") private var selectedFilter: String = "Everyone"
	@State private var allUsers: [User] = []
	@State private var selectedIndex: Int = 0
	@State private var cardOffset: [Int:Bool] = [:] // userId:rigth=true
	@State private var currentSwipeOffset: CGFloat = 0

    var body: some View {
		ZStack {
			Color.bumbleWhite.ignoresSafeArea()

			VStack(spacing: 12) {
				header

				BumbleFilterView(options: filters, selection: $selectedFilter)

				ZStack {
					if !allUsers.isEmpty {
						ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
							let isPrevious = (selectedIndex - 1) == index
							let isCurrent = selectedIndex == index
							let isNext = (selectedIndex + 1) == index

							if isPrevious || isCurrent || isNext {
								let offserValue = cardOffset[user.id]

								userProfileCell(user: user, index: index)
									.zIndex(Double(allUsers.count - index))
									.offset(x: offserValue == nil ? 0 : offserValue == true ? 900 : -900)
							}
						}

					} else {
						ProgressView()
					}

					overlaySwipingIndicators
						.zIndex(999999)
				}
				.frame(maxHeight: .infinity)
				.animation(.smooth, value: cardOffset)
			}
			.padding(8)
		}
		.task {
			await getData()
		}
		.toolbar(.hidden, for: .navigationBar)
    }

	private func userDidSelect(index: Int, isLike: Bool) {
		let user = allUsers[index]
		cardOffset[user.id] = isLike

		selectedIndex += 1
	}
	func getData() async {
		guard allUsers.isEmpty else { return }

		do {
			allUsers = try await DatabaseHelper().getUsers()
		} catch {
			print(error)
		}
	}

	private var header: some View {
		HStack(spacing: 0) {
			HStack(spacing: 0) {
				Image(systemName: "line.horizontal.3")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {

					}


				Image(systemName: "arrow.uturn.left")
					.padding(8)
					.background(.black.opacity(0.001))
					.onTapGesture {

					}


			}
			.frame(maxWidth: .infinity, alignment: .leading)

			Text("bumble")
				.font(.title)
				.foregroundStyle(.bumbleYellow)

			Image(systemName: "slider.horizontal.3")
				.padding(8)
				.background(.black.opacity(0.001))
				.onTapGesture {

				}
				.frame(maxWidth: .infinity, alignment: .trailing)


		}
		.font(.title2)
		.fontWeight(.medium)
		.foregroundStyle(.bumbleBlack)
	}

	private func userProfileCell(user: User, index: Int) -> some View {
		BumbleCardView(
			user: user,
			onSuperlikePresses: nil,
			onXmarkPresses: {
				userDidSelect(index: index, isLike: false)
			},
			onCheckmarkPresses: {
				userDidSelect(index: index, isLike: true)
			},
			onSendAComplimentPresses: {

			},
			onHideAndReportPresses: {

			}
		)
			.withDragGesture(
				.horizontal,
				minimumDistance: 20,
				resets: true,
				rotationMultiplier: 1.05,
				scaleMultiplier: 0.3,
				onChanged: { dragOffset in
					currentSwipeOffset = dragOffset.width
				},
				onEnded: { dragOffset in
					if dragOffset.width < -50 {
						userDidSelect(index: index, isLike: false)
					} else if dragOffset.width > 50 {
						userDidSelect(index: index, isLike: true)
					}
				}
			)
	}

	private var overlaySwipingIndicators: some View {
		ZStack {
			Circle()
				.fill(.bumbleGray.opacity(0.4))
				.overlay(
					Image(systemName: "xmark")
						.font(.title)
						.fontWeight(.semibold)
				)
				.frame(width: 60, height: 60)
				.scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
				.offset(x: min(-currentSwipeOffset, 150) - 100)
				.frame(maxWidth: .infinity, alignment: .leading)

			Circle()
				.fill(.bumbleGray.opacity(0.4))
				.overlay(
					Image(systemName: "checkmark")
						.font(.title)
						.fontWeight(.semibold)
				)
				.frame(width: 60, height: 60)
				.scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
				.offset(x: max(-currentSwipeOffset, -150) + 100)
				.frame(maxWidth: .infinity, alignment: .trailing)
		}
		.animation(.smooth, value: currentSwipeOffset)
	}
}

#Preview {
	BumbleHomeView(user: .mock)
}
