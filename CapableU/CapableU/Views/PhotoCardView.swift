//
//  RecipeCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 3/10/2023.
//

import SwiftUI

struct PhotoCardView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	@State var photo: Photo
	var model: BoardModel
	
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
				Image(photo.imageString)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 300, height: 225)
					.cornerRadius(10)
				
				VStack(alignment: .leading) {
					if let title = photo.title {
						Text(title)
							.font(.title)
							.fontWeight(.bold)
							.fontDesign(.serif)
							.foregroundColor(.white)
							.shadow(radius: 10)
							.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
							.background(.ultraThinMaterial, in:
								RoundedRectangle(cornerRadius: 10))
							.offset(x: -20, y: -20)
							
					}
					Spacer()
					if let description = photo.description {
						HStack {
							Text(description)
								.font(.body)
								.foregroundColor(.white)
								.shadow(radius: 4)
								.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
								.background(.ultraThinMaterial, in:
												RoundedRectangle(cornerRadius: 10))
								.offset(x: 20, y: 20)
						}
					}
					
				}
				if let owner = photo.owner {
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
						Spacer()
						ContextMenuButton(model: model, ownableObject: $photo) {
							model.photos.remove(at: model.photos.firstIndex(of: photo)!)
						}
						.buttonStyle(.plain)
						.foregroundColor(.white)
					}
					Spacer()
				}.padding(10)
			}
		}
		.shadow(radius: 5)
		.frame(width: 300, height: 200)
		.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
		.position(x: location.x, y: location.y)
		.gesture(simpleDrag)
		.dropDestination(for: Profile.self) { items, location in
			if photo.owner == nil {
				photo.owner = items.first!
			}
			return true
		}
	}
}

struct PhotoCard_Previews: PreviewProvider {
	static var previews: some View {
		PhotoCardView(photo: Photo(owner: Profile(name: "Hannah Pritchet",
												  initials: "HP",
												  profilePhotoString: "hannah-pritchet",
												  alergens: []),
								   imageString: "pasta",
								   title: "Pasta Salad",
								   description: "Leftovers are in the fridge, help yourself!"),
					  model: BoardModel())
	}
}
