//  HomeViewModel.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Foundation

final class HomeViewModel: ObservableObject {
	private let dataService: DataServiceProtocol

	init(dataService: DataServiceProtocol) {
		self.dataService = dataService
	}
}
