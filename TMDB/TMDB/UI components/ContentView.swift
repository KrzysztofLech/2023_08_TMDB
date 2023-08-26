//  ContentView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
		ZStack {
			Colors.background.ignoresSafeArea()

			Text("The Movie Database (TMDB)").foregroundColor(Colors.light)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.environmentObject(HomeViewModel(dataService: DataService()))
    }
}
