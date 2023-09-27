//
//  NoteCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import SwiftUI

struct NoteCardView: View {
	@State private var location: CGPoint = CGPoint(x: 50, y: 50)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	var textContent: String
	
	var simpleDrag: some Gesture {
		DragGesture()
			.onChanged { value in
				var newLocation = startLocation ?? location
				newLocation.x += value.translation.width
				newLocation.y += value.translation.height
				self.location = newLocation
			}.updating($startLocation) { (value, startLocation, transaction) in
				startLocation = startLocation ?? location
			}
	}
	
	var body: some View {
		Text(textContent)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
			.padding()
			.frame(width: 100, height: 100)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(.pink))
			.position(location)
			.gesture(simpleDrag)
	}
}

#Preview {
    NoteCardView(textContent: "Example Note")
}
