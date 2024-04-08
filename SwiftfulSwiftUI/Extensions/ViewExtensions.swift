//
//  ViewExtensions.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 07.04.2024.
//

import Foundation
import SwiftUI

extension View {
	func themeColors(isSelected: Bool = false) -> some View {
		self
			.background(isSelected ? .spotifyGreen : .spotifyDarkGray)
			.foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
	}
}

//extension UINavigationController: UIGestureRecognizerDelegate {
//	override open func viewDidLoad() {
//		super.viewDidLoad()
//		interactivePopGestureRecognizer?.delegate = self
//	}
//
//	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//		return viewControllers.count > 1
//	}
//}
