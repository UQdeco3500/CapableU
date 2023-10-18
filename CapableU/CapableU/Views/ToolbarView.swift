//
//  ToolbarView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 21/9/2023.
//

import SwiftUI

struct ToolbarView: View {
	
	var model: BoardModel
	
	@State private var showingQR = false
	
	@State private var operation = {}
	
	@State private var expanded = true
	
    var body: some View {
		ZStack {
			Button{
				showingQR.toggle()
				operation = {
					model.recipes.append(
						Recipe(owner: nil,
							   title: "Poke Bowl",
							   coverPhotoString: "poke-bowl",
							   description: "These delicious Poke Bowls are healthy and delicious!",
							   alergens: [.seafood, .nuts],
							   ingredients: [
								"2 Coles Australian Skinless Salmon Portions, cut into 2cm pieces",
								"2 tbsp teriyaki marinade",
								"400g edamame or broad beans",
								"1 tbsp olive oil",
								"450g pkt microwavable brown rice",
								"400g pkt Coles Poke Slaw Kit",
								"1 Lebanese cucumber, thinly sliced crossways",
								"2 spring onions, thinly sliced",
								"Pickled ginger, to serve"],
							   method:[
								"Combine the salmon and marinade in a bowl. Place in the fridge for 15 mins to develop the flavours.",
								"Cook the edamame or broad beans in a large saucepan of boiling water following packet directions. Peel. Place in a bowl.",
								"Heat oil in a large non-stick frying pan over medium heat. Cook salmon, turning, for 4-5 mins or until golden or cooked to your liking.",
								"Meanwhile, heat the rice following packet directions. Place the salad mix from the salad kit in a large bowl. Add half the dressing from the salad kit and toss to combine.",
								"Divide the rice among serving bowls. Top with the salad mixture, edamame or broad beans, salmon, cucumber, spring onion and ginger. Sprinkle with the sesame seeds from the salad kit and drizzle with remaining dressing."],
							   x: 0, y: 200))
				}
			} label: {
				VStack {
					Image(systemName: "fork.knife")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 17, height: 17)
						.padding(3)
						
					Text("Recipe")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(x: expanded ? 80 : 0)
			
			Button{
				model.notes.append(Note(content: "",
										x: 0,
										y: 200))
			} label: {
				VStack(spacing: 0) {
					Image(systemName: "note.text.badge.plus")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 25, height: 25)
						.offset(x:3)
					
					Text("Note")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(x: expanded ? 80 : 0, y: expanded ? 80 : 0)
			
			Button{
				showingQR.toggle()
				operation = {
					model.photos.append(Photo(imageString: "pasta", x: 0, y: 200))
				}
			} label: {
				VStack {
					Image(systemName: "photo")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 25, height: 25)
					
					Text("Photo")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(y: expanded ? 80 : 0)
			
			Button{
				withAnimation{
					expanded.toggle()
				}
			} label: {
				Image(systemName: "plus")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 40, height: 40)
			}
			.rotationEffect(expanded ? .degrees(45) : .zero)
			
		}
		.buttonBorderShape(.circle)
		.buttonStyle(ToolbarButtonStyle())
		.sheet(isPresented: $showingQR, onDismiss: operation) {
			QRSheetView()
		}
	}
}

struct ToolbarButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color(white: 0.9), in: Capsule())
			.foregroundColor(configuration.isPressed ? .blue.opacity(0.5) : .blue)
	}
}

#Preview {
	ToolbarView(model: BoardModel()).frame(height: 75)
}
