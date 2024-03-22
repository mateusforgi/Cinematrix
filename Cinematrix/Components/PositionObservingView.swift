//
//  PositionObservingView.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct PositionObservingView<Content: View>: View {
	var coordinateSpace: CoordinateSpace
	@Binding var position: ScrollPositionValue
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		content()
			.background(GeometryReader { geometry in
				Color.clear.preference(
					key: PreferenceKey.self,
					value: ScrollPositionValue(size: geometry.size, position: geometry.frame(in: coordinateSpace).origin)
				)
			})
			.onPreferenceChange(PreferenceKey.self) { position in
				self.position = position
			}
	}
}

private extension PositionObservingView {
	struct PreferenceKey: SwiftUI.PreferenceKey {
		static var defaultValue: ScrollPositionValue { .init(size: .zero, position: .zero) }
		
		static func reduce(value: inout ScrollPositionValue, nextValue: () -> ScrollPositionValue) {
			// No-op
		}
	}
}

struct ScrollPositionValue: Equatable {
	let size: CGSize
	let position: CGPoint
}
