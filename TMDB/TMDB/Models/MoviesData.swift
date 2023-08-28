//  NowPlaying.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Foundation

struct MoviesData: Codable {
	private enum CodingKeys: String, CodingKey {
		case page
		case movies = "results"
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}

	let page: Int
	let movies: [Movie]
	let totalPages: Int
	let totalResults: Int
}

struct Movie: Codable, Identifiable {
	private enum CodingKeys: String, CodingKey {
		case id
		case title
		case description = "overview"
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
		case originalTitle = "original_title"
		case releaseDate = "release_date"
		case voteAverage = "vote_average"
	}

	let id: Int
	let title: String
	let description: String
	private let posterPath: String
	private let backdropPath: String
	let originalTitle: String
	let releaseDate: String
	let voteAverage: Double
}

extension Movie {
	var posterUrl: URL? {
		let urlsString = "https://image.tmdb.org/t/p/w200\(posterPath)"
		return URL(string: urlsString)
	}

	var backdropUrl: URL? {
		let urlsString = "https://image.tmdb.org/t/p/w500\(backdropPath)"
		return URL(string: urlsString)
	}
}
