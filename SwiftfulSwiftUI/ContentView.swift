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
			Button("Open Spotify") {
				router.showScreen(.fullScreenCover) { router in
					SpotifyHomeView(vm: SpotifyHomeViewModel(router: router))
				}
			}
			Button("Open Bubmle") {
				router.showScreen(.fullScreenCover) { router in
					BumbleHomeView()
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
