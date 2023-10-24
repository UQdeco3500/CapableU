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
		Photo(imageString: "tacos"),
		Photo(imageString: "curry"),
		Photo(imageString: "garlicPasta"),
		Photo(imageString: "omelette")]
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
				"Divide the rice among serving bowls. Top with the salad mixture, edamame or broad beans, salmon, cucumber, spring onion and ginger. Sprinkle with the sesame seeds from the salad kit and drizzle with remaining dressing."]),
		Recipe(title: "Butter Chicken",
			   coverPhotoString: "curry",
			   description: "A classic and indulgent North Indian dish known for its rich and flavorful tomato-based sauce.",
			   alergens: [.nuts],
			   ingredients: [
				"1 lb (450g) boneless chicken, cut into bite-sized pieces",
				"1/2 cup plain yogurt",
				"1 tablespoon ginger-garlic paste",
				"1 teaspoon red chili powder",
				"1/2 teaspoon turmeric powder",
				"1 teaspoon garam masala",
				"Salt to taste",
				"2 tablespoons butter",
				"2 tablespoons vegetable oil",
				"2 medium onions, finely chopped",
				"1 tablespoon ginger-garlic paste",
				"1 teaspoon ground coriander",
				"1 teaspoon ground cumin",
				"1/2 teaspoon ground cardamom",
				"1/2 teaspoon red chili powder (adjust to your spice preference)",
				"1 cup tomato puree",
				"1/4 cup cashew paste (optional, for extra creaminess)",
				"1 cup heavy cream",
				"1/4 cup water",
				"Fresh cilantro, for garnish"],
			   method:[
				"In a mixing bowl, combine the yogurt, ginger-garlic paste, red chili powder, turmeric, garam masala, and salt. Add the chicken pieces and coat them evenly with the marinade. Cover and refrigerate for at least 30 minutes, or ideally, marinate overnight for the best flavor.",
				"Heat 2 tablespoons of butter and 1 tablespoon of vegetable oil in a large, heavy-bottomed pan over medium-high heat. Add the marinated chicken pieces and cook until they turn golden brown and are cooked through, about 8-10 minutes. Remove the chicken and set it aside.",
				"In the same pan, add the remaining tablespoon of oil and butter. Add finely chopped onions and sauté until they turn translucent and slightly brown. Stir in ginger-garlic paste, ground coriander, ground cumin, ground cardamom, and red chili powder. Cook for 2-3 minutes.",
				"Add the tomato puree and cook for about 5-7 minutes until the oil begins to separate from the sauce. If using cashew paste, add it at this stage and stir well.",
				"Return the cooked chicken to the pan and mix it into the sauce. Pour in the heavy cream and water. Stir well. Allow the butter chicken to simmer for 10-15 minutes on low heat, letting the flavors meld together. Season with salt to taste.",
				"Garnish with fresh cilantro leaves. Serve hot with naan, rice, or roti."]),
		Recipe(title: "Creamy Garlic Parmesan Pasta",
			   coverPhotoString: "garlicPasta",
			   description: "A simple yet indulgent meal that's sure to satisfy your cravings.",
			   alergens: [],
			   ingredients: [
				"8 ounces (about 2 cups) of your choice of pasta (such as fettuccine or linguine)",
				"2 tablespoons unsalted butter",
				"4 cloves garlic, minced",
				"1 cup heavy cream",
				"1 cup grated Parmesan cheese",
				"Salt and black pepper, to taste",
				"Fresh parsley, for garnish (optional)"],
			   method:[
				"Bring a large pot of salted water to a boil. Add the pasta and cook according to the package instructions until it reaches your desired level of doneness. Remember to reserve about 1/2 cup of pasta cooking water before draining.",
				"In a large skillet or saucepan, melt the butter over medium heat.",
				"Add the minced garlic and sauté for about 1-2 minutes, or until it becomes fragrant and just begins to turn golden.",
				"Pour in the heavy cream, and bring the mixture to a gentle simmer. Reduce the heat to low.",
				"Stir in the grated Parmesan cheese and continue to cook, stirring constantly, until the cheese is fully melted and the sauce thickens, which should take about 5-7 minutes.",
				"Season the sauce with salt and black pepper to taste. Keep in mind that Parmesan cheese is already salty, so go easy on the salt.",
			   "If the sauce becomes too thick, you can add a small amount of the reserved pasta cooking water to reach your desired consistency.",
			   "Add the cooked and drained pasta to the creamy sauce and toss them together, ensuring the pasta is well coated with the sauce.",
			   "Garnish with fresh parsley for a burst of color and flavor, if desired.",
			   "Serve your Creamy Garlic Parmesan Pasta hot, perhaps with additional Parmesan cheese to sprinkle on top."])]
	
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


