//
//  ProfileStickerView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 12/10/2023.
//

import SwiftUI

struct ProfileStickerView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
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
	
	var profile: Profile
	
    var body: some View {
		Image(profile.profilePhotoString)
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: 50, height: 50)
			.cornerRadius(15)
			.shadow(radius: 5)
			.padding()
			.position(location)
			.gesture(simpleDrag)
    }
}

#Preview {
	ProfileStickerView(profile: Profile(name: "Jane Doe",
										initials: "JD",
										profilePhotoString: "jane-doe",
										alergens: [.seafood]))
}
