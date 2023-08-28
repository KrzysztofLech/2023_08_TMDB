//  CarouselTitleStyle.swift
//  Created by Krzysztof Lech on 28/08/2023.

import SwiftUI

struct CarouselTitleStyle: ViewModifier {
	let inset: CGFloat

	func body(content: Content) -> some View {
		content
			.foregroundColor(Colors.light)
			.font(.system(size: 32, weight: .light))
			.padding(.leading, inset)
	}
}

extension View {
	func carouselTitleStyle(withInset inset: CGFloat) -> some View {
		modifier(CarouselTitleStyle(inset: inset))
	}
}
