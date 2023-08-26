//  CoverView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct CoverView: View {
	let imageUrl: URL?
	let size: CGSize

    var body: some View {
		AsyncImage(
			url: imageUrl,
			content: { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
					.background(Color.white)
					.frame(width: size.width, height: size.height)
			},
			placeholder: {
				ProgressView()
					.tint(Colors.light)
					.padding()
			}
		).clipped()
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView(
			imageUrl: URL(string: "https://image.tmdb.org/t/p/original//ptpr0kGAckfQkJeJIt8st5dglvd.jpg"),
			size: CGSize(width: 500, height: 750)
		)
		.previewLayout(.sizeThatFits)
    }
}
