//  HomeView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct HomeView: View {
	@StateObject var viewModel: HomeViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(dataService: DataService()))
    }
}
