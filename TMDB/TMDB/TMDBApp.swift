//  TMDBApp.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

@main
struct TMDBApp: App {
	let dataService: DataServiceProtocol = DataService()

    var body: some Scene {
        WindowGroup {
			let viewModel = HomeViewModel(dataService: dataService)
            HomeView(viewModel: viewModel)
				.preferredColorScheme(.dark)
        }
    }
}
