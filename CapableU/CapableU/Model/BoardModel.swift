//
//  CapableUModel.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

@Observable class BoardModel {
	var notes: [Note] = []
	var recipes: [Recipe] = [
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
			   "Divide the rice among serving bowls. Top with the salad mixture, edamame or broad beans, salmon, cucumber, spring onion and ginger. Sprinkle with the sesame seeds from the salad kit and drizzle with remaining dressing."])]
	let profiles: [Profile] = [
		Profile(name: "Jane Doe",
				initials: "JD",
				profilePhotoString: "jane-doe",
				alergens: [.seafood]),
		Profile(name: "John Smith",
				initials: "JS",
				profilePhotoString: "john-smith",
				alergens: [.nuts])]
	
	func hasAlergenConflict(_ recipe: Recipe) -> [Profile]?{
		var conflictingProfiles: [Profile] = []
		
		for alergen in recipe.alergens {
			for profile in profiles {
				if profile.alergens.contains(alergen) {
					conflictingProfiles.append(profile)
				}
			}
		}
		
		return conflictingProfiles.isEmpty ? nil : conflictingProfiles
	}
}

struct Note : Identifiable, Hashable {
	var id: UUID
	
	var content : String
	
	init(_ content: String) {
		id = UUID()
		self.content = content
	}
}

struct Recipe : Identifiable, Hashable {
	var owner: Profile?
	
	var id = UUID()
	
	var title : String
	var coverPhotoString : String
	var description: String
	var alergens: [alergenFlag]
	var ingredients: [String]
	var method: [String]
	
	mutating func setOwner(as profile: Profile) {
		owner = profile
	}
}

struct Profile : Identifiable, Hashable, Codable, Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(for: Profile.self, contentType: .profile)
	}
	
	var id = UUID()
	
	var name: String
	var initials: String
	var profilePhotoString: String
	var alergens: [alergenFlag] = []
}

extension UTType {
	static var profile: UTType { UTType(exportedAs: "com.capableu.profile") }
}

enum alergenFlag: String, Codable {
	case nuts = "brain"
	case seafood = "fish"
	case gluten = "birthday.cake.fill"
	case meat = "pawprint.circle"
}


