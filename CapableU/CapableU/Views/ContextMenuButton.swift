//
//  ContextMenuButton.swift
//  CapableU
//
//  Created by Lachlan Corrie on 16/10/2023.
//

import SwiftUI

struct ContextMenuButton<OwnableType: Ownable>: View {
	@State private var triggered = false
	
	var model: BoardModel
	
	@Binding var ownableObject: OwnableType
	
	var deleteAction: () -> Void
	
    var body: some View {
		Menu{
			Button(role: .destructive, action: deleteAction) {
				Label("Delete", systemImage: "trash")
			}
			
			Button{
				model.notes.append(Note(content: "",
										x: 300,
										y: 300))
			} label: {
				Label("Add comment", systemImage: "text.bubble")
			}
			
			Menu() {
				ForEach (model.profiles) { profile in
					Button(profile.name,
						   image: ImageResource(name: profile.profilePhotoString, bundle: .main)) {
						ownableObject.owner = profile
					}
				}
			} label: {
				Label("Set Author", systemImage: "person.badge.plus")
			}
			if var photo = ownableObject as? Photo {
				Divider()
				Button{
					photo.title = ""
					photo.hasTitle = true
					ownableObject = photo as! OwnableType
				} label: {
					Label("Add title", systemImage: "character.cursor.ibeam")
				}
				Button{
					photo.description = ""
					photo.hasDescription = true
					ownableObject = photo as! OwnableType
				} label: {
					Label("Add description", systemImage: "text.below.photo")
				}
			}
			
		} label: {
			Image(systemName: "ellipsis.circle")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 30, height: 30)
				.offset(x:4, y:3)
		}
    }
}
