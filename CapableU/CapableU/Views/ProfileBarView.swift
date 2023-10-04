//
//  ProfileBarView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 4/10/2023.
//

import SwiftUI

struct ProfileBarView: View {
	var profiles: [Profile]
	
    var body: some View {
		HStack {
			ForEach(profiles, id: \.profilePhotoString) { profile in
				ProfileButtonView(profile: profile)
			}
		}
	}
}

struct ProfileButtonView: View {
	let profile: Profile
	
	var body: some View {
		Button(action: {
			// Add action for the button here
			// For example, you can navigate to a profile detail view
			// or perform some other action related to the profile.
		}) {
			Image(profile.profilePhotoString) // Use the profilePhotoString as the image name
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 50, height: 50) // Adjust the size as needed
				.cornerRadius(15)
		}
		.buttonStyle(.borderless)
		.draggable(profile)
	}
}

#Preview {
    ProfileBarView(profiles: [Profile(name: "Jane Doe", initials: "JD", profilePhotoString: "poke-bowl")])
}
