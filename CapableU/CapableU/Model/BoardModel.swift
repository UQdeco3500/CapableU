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
	var possiblePhotos: [Photo] = [
		Photo(imageString: "pasta"),
		Photo(imageString: "salad"),
		Photo(imageString: "tacos")]
	var possibleRecipes: [Recipe] = [
		Recipe(title: "Cheese and Herb Omelette",
			   coverPhotoString: "omelette",
			   description: "It's quick to prepare and customizable with your favorite herbs and cheese.",
			   alergens: [],
			   ingredients: [
			   "3 large eggs",
			   "1/4 cup grated cheese (cheddar, Swiss, or your favorite)",
			   "1 tablespoon fresh herbs (chives, parsley, or basil), chopped",
			   "Salt and pepper, to taste",
			   "1 tablespoon butter"],
			   method: [
			   "Crack the eggs into a bowl, add a pinch of salt, and whisk them until the yolks and whites are well combined. Stir in the chopped herbs and a generous pinch of black pepper. Set the cheese aside for later.",
			   "Place a non-stick skillet over medium heat and add the butter. Allow it to melt and coat the bottom of the pan evenly. Tilt the pan to ensure the butter covers the surface.",
			   "Once the butter is hot and bubbling, pour the beaten egg mixture into the skillet. Let it cook for a few seconds without stirring. Use a spatula to gently push the cooked edges towards the center, allowing the uncooked eggs to flow to the sides.",
			   "When the omelette is mostly set but still slightly runny on top, sprinkle the grated cheese evenly over one-half of the omelette.",
			   "Carefully fold the other half of the omelette over the cheese-covered half using the spatula. Press it gently to help the cheese melt.",
			   "Continue cooking the omelette for a minute or so, or until it reaches your desired level of doneness. If you like it slightly runny in the middle, it will take less time. If you prefer it fully set, let it cook a bit longer.",
			   "Slide the omelette onto a plate, folding it in half. Garnish with a bit of extra fresh herbs, if desired. Serve hot with toast, a side of fruit, or your favorite breakfast accompaniments."]),
		Recipe(title: "Poke Bowl",
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
	
	var photos: [Photo] = []
	
	var notes: [Note] = []
	
	var recipes: [Recipe] = []
	
	let profiles: [Profile] = [
		Profile(name: "Jane Doe",
				initials: "JD",
				profilePhotoString: "jane-doe",
				alergens: [.seafood]),
		Profile(name: "John Smith",
				initials: "JS",
				profilePhotoString: "john-smith",
				alergens: [.nuts]),
		Profile(name: "Hannah Pritchet",
				initials: "HP",
				profilePhotoString: "hannah-pritchet",
				alergens: []),
		Profile(name: "Andrew Jones",
				initials: "AJ",
				profilePhotoString: "andrew-jones",
				alergens: []),
		Profile(name: "Good Boy",
				initials: "GB",
				profilePhotoString: "good-boy",
				alergens: [])]
	
	let favouriteColors: [Color] = [
		.red,.green,.blue,.indigo,.cyan
	]
	
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

protocol Ownable {
	var owner: Profile? {
		get set
	}
}

struct Note : Identifiable, Hashable, Ownable {
	var id = UUID()
	
	var owner: Profile?
	var content : String
	var color: Color = .yellow
	var x: CGFloat
	var y: CGFloat

	
}

struct Photo: Identifiable, Hashable, Ownable {
	var id = UUID()
	
	var owner: Profile?
	var imageString : String
	var title: String = ""
	var hasTitle: Bool = false
	var description: String = ""
	var hasDescription: Bool = false
	var x: CGFloat = 0
	var y: CGFloat = 0
}

struct Recipe : Identifiable, Hashable, Ownable {
	var owner: Profile?
	
	var id = UUID()
	
	var title : String
	var coverPhotoString : String
	var description: String
	var alergens: [alergenFlag]
	var ingredients: [String]
	var method: [String]
	
	var x: CGFloat = 0
	var y: CGFloat = 0
	
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

struct ProfileSticker: Identifiable, Hashable {

	var id = UUID()
	var profile: Profile
	var x: CGFloat
	var y: CGFloat
}

enum alergenFlag: String, Codable {
	case nuts = "brain"
	case seafood = "fish"
	case gluten = "birthday.cake.fill"
	case meat = "pawprint.circle"
}


