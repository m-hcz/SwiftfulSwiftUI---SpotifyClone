//
//  SwiftfulSwiftUIApp.swift
//  SwiftfulSwiftUI
//
//  Created by mhcz on 01.04.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftfulSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
			RouterView { _ in
				ContentView()
			}
        }
    }
}
