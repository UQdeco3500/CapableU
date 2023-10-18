//
//  RecipeCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 3/10/2023.
//

import SwiftUI

struct RecipeCardView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	@State var recipe: Recipe
	var model: BoardModel
	private var alergenConflicts: [Profile]? {
		model.hasAlergenConflict(recipe)
	}
	@State private var attachedProfiles: [Profile] = []
	@State private var isDetailed: Bool = false
	@State private var isAboutToBeDeleted = false
	
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
		VStack{
			ZStack(alignment: .bottomLeading) {
				BlurryBottomedImage(image: Image(recipe.coverPhotoString))
					.cornerRadius(10)
					.onTapGesture(count: 2) {
						isAboutToBeDeleted.toggle()
					}
					.onTapGesture(count: 1) {
						withAnimation {
							isDetailed.toggle()
						}
					}
					.alert("Delete \(recipe.title) card?", isPresented: $isAboutToBeDeleted) {
						Button("Delete", role: .destructive) {
							model.recipes.remove(at: model.recipes.firstIndex(of: recipe)!)
						}
						Button("Cancel", role: .cancel) { }
					}
				
				VStack(alignment: .leading) {
					Text(recipe.title)
						.font(isDetailed ? .largeTitle : .title)
						.fontWeight(.bold)
						.fontDesign(.serif)
						.foregroundColor(.white)
						.shadow(radius: 10)
						.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
					if !isDetailed {
						HStack {
							Text(recipe.description)
								.font(.body)
								.foregroundColor(.white)
								.shadow(radius: 4)
								.padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
							
							
						}
					}
					
					
				}
				if let owner = recipe.owner {
					Image(owner.profilePhotoString)
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 50, height: 50)
						.cornerRadius(15)
						.padding()
						.offset(x: -50, y: 30)
				}
				VStack{
					HStack {
						if  alergenConflicts != nil {
							Image(systemName: "person.crop.circle.badge.exclamationmark")
								.symbolRenderingMode(.multicolor)
								.resizable()
								.scaledToFit()
								.frame(width: 40, height: 40)
								.foregroundStyle(.red)
								.offset(x: -30, y: -30)
						}
						Spacer()
						ContextMenuButton(model: model) {
							model.recipes.remove(at: model.recipes.firstIndex(of: recipe)!)
						}
						.buttonStyle(.plain)
						.foregroundColor(.white)
					}
					Spacer()
				}.padding(10)
			}
			RecipeCardDetailView(isVisible: $isDetailed, recipe: recipe, alergenConflicts: alergenConflicts)
				.offset(y: -20)
				.zIndex(-1)
		}
		.shadow(radius: 5)
		.frame(width: 300, height: 200)
		.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
		.position(x: location.x, y: isDetailed ? UIScreen.main.bounds.height/2 : location.y)
		.gesture(simpleDrag)
		.dropDestination(for: Profile.self) { items, location in
			if recipe.owner == nil {
				recipe.setOwner(as: items.first!)
			}
			
			attachedProfiles.append(items.first!)
			return true
		}
	}
}

struct BlurryBottomedImage: View {
	var image: Image
	
	var body: some View {
		ZStack(alignment: .bottomLeading) {
			image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.clipped()
			
			VStack{}
				.frame(width: 300, height: 200)
				.background(
					VisualEffectView(effect: UIBlurEffect(style: .regular)))
			
			image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 300, height: 200)
				.mask(LinearGradient(stops: [.init(color: .white, location: 0),
											 .init(color: .white, location: 0.4),
											 .init(color: .clear, location: 0.80),], startPoint: .top, endPoint: .bottom))
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
		RecipeCardView(recipe: BoardModel().recipes.first!, model: BoardModel())
		.frame(width: 300, height: 400)
	}
}

struct RecipeCardDetailView: View {
	
	@Binding var isVisible: Bool
	var recipe: Recipe
	var alergenConflicts: [Profile]?
	
	var body: some View {
		if isVisible {
			VStack(alignment: .leading, spacing: 8) {
				Text(recipe.description)
					.font(.body)
					.shadow(radius: 4)
					.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 16))
				if !recipe.alergens.isEmpty {
					HStack {
						Text("\(Image(systemName: "allergens")) Contains: ")
						
						ForEach(recipe.alergens, id: \.self) { alergen in
							VStack {
								Text("\(Image(systemName: alergen.rawValue))")
								Text("\(alergen.rawValue == "brain" ? "nuts" : alergen.rawValue)")
									.font(.caption2)
							}
						}
						Spacer()
					}
					.symbolRenderingMode(.multicolor)
				}
				if let conflictingProfiles = alergenConflicts {
					HStack {
						Text("\(Image(systemName: "person.crop.circle.badge.exclamationmark")) Not suitable for: ")
							.symbolRenderingMode(.multicolor)
							.lineLimit(1)
						Spacer()
						ForEach(conflictingProfiles) { profile in
							ZStack{
								Image(profile.profilePhotoString)
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(width: 40, height: 40)
									.cornerRadius(15)
								Text("\(Image(systemName: Set(profile.alergens).intersection(recipe.alergens).first!.rawValue))")
									.offset(x:20, y:-20)
							}.padding(4)
						}
					}
				}
				ScrollView {
					Text("Ingredients")
						.fontDesign(.serif)
						.font(.title3)
					VStack(alignment: .leading){
						ForEach(recipe.ingredients, id: \.self) { ingredient in
							Text(ingredient)
						}
					}
					Text("Method")
						.fontDesign(.serif)
						.font(.title3)
					VStack(alignment: .leading){
						ForEach(recipe.method, id: \.self) { step in
							Text(step)
						}
					}
				}
			}
			.foregroundColor(.white)
			.shadow(radius: 5)
			.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
			.frame(width: 300, height: 600)
			.background{
				Image(recipe.coverPhotoString)
					.resizable()
					.scaleEffect(3)
					.blur(radius: 30)
					.saturation(1.5)
			}
			.cornerRadius(10)
		}
	}
}


