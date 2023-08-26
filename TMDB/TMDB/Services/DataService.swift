//  DataService.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Combine
import Foundation

enum DataType {
	case nowPlaying

	var path: String {
		switch self {
		case .nowPlaying:
			return "https://api.themoviedb.org/3/movie/now_playing"
		}
	}
}

enum Language {
	case pl, us

	var code: String {
		switch self {
		case .pl: return "pl-PL"
		case .us: return "en-US"
		}
	}
}

protocol DataServiceProtocol {
	var nowPlayingPublisher: Published<[NowPlayingResult]>.Publisher { get }
	func getData()
}

final class DataService: DataServiceProtocol {
	private var cancellables = Set<AnyCancellable>()

	private let apiKey = "7b9e86f73d32a2cd520b8c757fe87c3b"
	private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjllODZmNzNkMzJhMmNkNTIwYjhjNzU3ZmU4N2MzYiIsInN1YiI6IjY0ZTFhMjUyNGE1MmY4MDEzYmQzZTUzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7-WFMTGY1C2Tq5XKMvMNVAwZF7U-JZkrgkZkM4qRf_A"

	private let session = URLSession.shared

	private func getUrlRequestFor(_ dataType: DataType, andLanguage language: Language) -> URLRequest? {
		let fullUrlString = dataType.path + "?language=\(language.code)&page=1"
		guard let url = URL(string: fullUrlString) else { return nil }

		let headers = [
			"accept": "application/json",
			"Authorization": "Bearer \(token)"
		]

		var urlRequest = URLRequest(
			url: url,
			cachePolicy: .useProtocolCachePolicy,
			timeoutInterval: 10.0
		)
		urlRequest.httpMethod = "GET"
		urlRequest.allHTTPHeaderFields = headers

		return urlRequest
	}

	@Published private var nowPlaying: [NowPlayingResult] = []
	var nowPlayingPublisher: Published<[NowPlayingResult]>.Publisher { $nowPlaying }

	func getData() {
		let language = Language.pl

		getNowPlaying(language: language)
	}

	func getNowPlaying(language: Language) {
		guard let urlRequest = getUrlRequestFor(.nowPlaying, andLanguage: language) else { return }

		session.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.decode(type: NowPlaying.self, decoder: JSONDecoder())
			.sink(
				receiveCompletion: { _ in },
				receiveValue: { decodedData in
					self.nowPlaying = decodedData.results
				}
			)
			.store(in: &cancellables)
	}
}
