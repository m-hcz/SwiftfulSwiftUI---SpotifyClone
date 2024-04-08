//
//  ContentView.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 01.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
	@Environment(\.router) var router

    var body: some View {
		List {
			Button("Open spotify") {
				router.showScreen(.fullScreenCover) { router in
					SpotifyHomeView(vm: SpotifyHomeViewModel(router: router))
				}
			}
		}
        .padding()
    }
}

#Preview {
	RouterView { _ in
		ContentView()
	}
}
