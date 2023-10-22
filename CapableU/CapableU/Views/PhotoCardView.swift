//
//  RecipeCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 3/10/2023.
//

import SwiftUI
import Combine

struct PhotoCardView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	@State private var keyboardHeight: CGFloat = 0
	
	@State var photo: Photo
	var model: BoardModel
	
	@State private var isfocused = false
	@FocusState private var textEditing: Bool
	
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
		ZStack {
			if isfocused || textEditing {
				Rectangle()
					.fill(.ultraThinMaterial)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.edgesIgnoringSafeArea(.all)
			}
			
			ZStack(alignment: .bottomLeading) {
				Image(photo.imageString)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.cornerRadius(10)
					.onTapGesture {
						withAnimation() {
							isfocused.toggle()
						}
					}
				
				VStack(alignment: .leading) {
					if photo.hasTitle {
						TextField("Title", text: $photo.title, axis: .vertical)
							.font(.title)
							.fontWeight(.bold)
							.fontDesign(.serif)
							.foregroundColor(.white)
							.shadow(radius: 10)
							.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
							.background(.ultraThinMaterial, in:
											RoundedRectangle(cornerRadius: 10))
							.offset(x: -20, y: -20)
							.frame(maxWidth: 300)
							.focused($textEditing)
						
					}
					Spacer()
					if photo.hasDescription {
						TextField("Description", text: $photo.description, axis: .vertical)
							.font(.body)
							.multilineTextAlignment(.leading)
							.foregroundColor(.white)
							.shadow(radius: 4)
							.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
							.background(.ultraThinMaterial, in:
											RoundedRectangle(cornerRadius: 10))
							.offset(x: 20, y: 20)
							.frame(maxWidth: 300)
							.focused($textEditing)
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
							model.photos.remove(at: model.photos.firstIndex(of: photo) ?? 0)
						}
						.buttonStyle(.plain)
						.foregroundColor(.white)
					}
					Spacer()
				}.padding(10)
			}
				.shadow(radius: 5)
				.edgesIgnoringSafeArea(.all)
				.frame(width: isfocused ? 600 : 300,
					   height: isfocused ? 400 : 200)
				.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
				
				.dropDestination(for: Profile.self) { items, location in
					if photo.owner == nil {
						photo.owner = items.first!
					}
					return true
				}
				
				.position(x: isfocused || textEditing ? UIScreen.current!.bounds.midX : location.x,
						  y: isfocused || textEditing ? UIScreen.current!.bounds.midY - keyboardHeight / 2 : location.y)
				.gesture(simpleDrag)
				.onReceive(Publishers.keyboardHeight) {
					self.keyboardHeight = $0
				}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.zIndex(isfocused || textEditing ? .infinity : 0)
	}
}

struct PhotoCard_Previews: PreviewProvider {
	static var previews: some View {
		PhotoCardView(photo: Photo(owner: Profile(name: "Hannah Pritchet",
												  initials: "HP",
												  profilePhotoString: "hannah-pritchet",
												  alergens: []),
								   imageString: "pasta",
								   title: "Monday's Pasta Salad", hasTitle: true,
								   description: "Leftovers are in the fridge, help yourself!", hasDescription: true),
					  model: BoardModel())
	}
}
