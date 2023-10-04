//
//  RecipeCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 3/10/2023.
//

import SwiftUI

struct RecipeCardView: View {
	@State private var location: CGPoint = CGPoint(x: 50, y: 50)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	var recipe: Recipe
	@State private var attachedProfiles: [Profile] = []
	
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
		ZStack(alignment: .bottomLeading) {
			Image(recipe.coverPhotoString)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.clipped()
			
			VStack{}
				.frame(width: 300, height: 200)
				.background(
					VisualEffectView(effect: UIBlurEffect(style: .regular)))
			
			Image(recipe.coverPhotoString)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.mask(LinearGradient(stops: [.init(color: .white, location: 0),
											 .init(color: .white, location: 0.4),
											 .init(color: .clear, location: 0.80),], startPoint: .top, endPoint: .bottom))
			
			VStack(alignment: .leading, spacing: 8) {
				Text(recipe.title)
					.font(.title)
					.fontWeight(.bold)
					.fontDesign(.serif)
					.foregroundColor(.white)
					.shadow(radius: 10)
					.padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
				
				Text(recipe.description)
					.font(.body)
					.foregroundColor(.white)
					.shadow(radius: 4)
					.padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
			}
			HStack{
				Spacer()
				VStack {
					ForEach(attachedProfiles, id: \.self) {
						Image($0.profilePhotoString)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 50, height: 50)
							.cornerRadius(15)
							.padding()
					}
					Spacer()
				}
				
			}
		}
		.cornerRadius(10)
		.shadow(radius: 5)
		.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
		.frame(width: 300, height: 200)
		.position(location)
		.gesture(simpleDrag)
		.dropDestination(for: Profile.self) { items, location in
			attachedProfiles.append(items.first!)
			print("Recieved profiled: \(items.first?.name ?? "Null")")
			return true
		}
	}
}

struct VisualEffectView: UIViewRepresentable {
	var effect: UIVisualEffect?
	
	func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
		return UIVisualEffectView()
	}
	
	func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
		uiView.effect = effect
	}
}

struct RecipeCardView_Previews: PreviewProvider {
	static var previews: some View {
		RecipeCardView(recipe: Recipe(
				title: "Poke Bowl",
				coverPhotoString: "poke-bowl",
				description: "These delicious Poke Bowls are healthy and delicious!"))
		.frame(width: 300, height: 400)
	}
}

struct RecipeCardDetailView: View {
	@State private var location: CGPoint = CGPoint(x: 50, y: 50)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	var recipe: Recipe
	@State private var attachedProfiles: [Profile] = []
	
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
		ZStack(alignment: .bottomLeading) {
			Image(recipe.coverPhotoString)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.clipped()
			
			VStack{}
				.frame(width: 300, height: 200)
				.background(
					VisualEffectView(effect: UIBlurEffect(style: .regular)))
			
			Image(recipe.coverPhotoString)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.mask(LinearGradient(stops: [.init(color: .white, location: 0),
											 .init(color: .white, location: 0.4),
											 .init(color: .clear, location: 0.80),], startPoint: .top, endPoint: .bottom))
			
			VStack(alignment: .leading, spacing: 8) {
				Text(recipe.title)
					.font(.largeTitle)
					.fontWeight(.bold)
					.fontDesign(.serif)
					.foregroundColor(.white)
					.shadow(radius: 10)
					.padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
			}
			HStack{
				Spacer()
				VStack {
					ForEach(attachedProfiles, id: \.self) {
						Image($0.profilePhotoString)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 50, height: 50)
							.cornerRadius(15)
							.padding()
					}
					Spacer()
				}
				
			}
		}
		.cornerRadius(10)
		.shadow(radius: 5)
		.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
		.frame(width: 300, height: 200)
		.position(location)
		.gesture(simpleDrag)
		.dropDestination(for: Profile.self) { items, location in
			attachedProfiles.append(items.first!)
			print("Recieved profiled: \(items.first?.name ?? "Null")")
			return true
		}
	}
}

