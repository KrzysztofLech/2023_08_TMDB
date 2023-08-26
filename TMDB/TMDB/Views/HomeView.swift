//  HomeView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel: HomeViewModel

    var body: some View {
		ZStack {
			Colors.background.ignoresSafeArea()

			if viewModel.nowPlaying.isEmpty {
//			if viewModel.isLoaderVisible {
				DataLoaderView()
			} else {
				ContentView()
					.environmentObject(viewModel)
			}
		}
		.animation(.easeInOut, value: viewModel.isLoaderVisible)
		.onAppear {
			viewModel.getData()
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(dataService: DataService()))
    }
}
