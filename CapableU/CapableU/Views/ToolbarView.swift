//
//  ToolbarView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 21/9/2023.
//

import SwiftUI

struct ToolbarView: View {
	
	var model: BoardModel
	
    var body: some View {
		HStack {
			Button{
				model.recipes.append(Recipe(
					title: "Poke Bowl",
					coverPhoto: "poke-bowl",
					description: "These delicious Poke Bowls are healthy and delicious!"))
			} label: {
				Image(systemName: "fork.knife.circle")
					.resizable()
					.scaledToFit()
			}
			Button{
				model.notes.append(Note("Heres another note."))
			} label: {
				Image(systemName: "square.and.pencil.circle")
					.resizable()
					.scaledToFit()
			}
			Button{
				
			} label: {
				Image(systemName: "photo.circle")
					.resizable()
					.scaledToFit()
			}
			
		}
		.buttonBorderShape(.roundedRectangle(radius: 15))
		.buttonStyle(.bordered)
	}
}

#Preview {
	ToolbarView(model: BoardModel()).frame(height: 50)
}
