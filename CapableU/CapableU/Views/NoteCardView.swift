//
//  NoteCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import SwiftUI
import Combine

struct NoteCardView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	@State private var keyboardHeight: CGFloat = 0
	@FocusState private var isFocused: Bool
	
	@State var note: Note
	var board: BoardModel
	
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
		ZStack(alignment: .center){
			if isFocused {
				Rectangle()
					.fill(.ultraThinMaterial)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.edgesIgnoringSafeArea(.all)
			}
			
			ZStack{
				HStack{
					TextField("Looks delicious!", text: $note.content, axis: .vertical)
						.multilineTextAlignment(.leading)
						.lineLimit(7, reservesSpace: false)
						.focused($isFocused)
					
					ContextMenuButton(model: board, ownableObject: $note) {
						board.notes.removeAll { otherNote in
							if note.id == otherNote.id {
								return true
							} else {
								return false
							}
						}
					}
					.buttonStyle(.plain)
					.foregroundColor(.white)
					.onChange(of: note.owner) {
						note.color = board.favouriteColors[board.profiles.firstIndex(of: note.owner!)!]
					}
				}
					.padding()
					.frame(maxWidth: 200)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.foregroundColor(note.color))
				if let owner = note.owner {
					Image(owner.profilePhotoString)
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 50, height: 50)
						.cornerRadius(15)
						.offset(x: -115)
				}
			}
				.position(x: isFocused ? UIScreen.current!.bounds.midX : location.x,
						  y: isFocused ? UIScreen.current!.bounds.midY - keyboardHeight / 2 : location.y)
				.gesture(simpleDrag)
		}
			.shadow(radius: 5)
			.onReceive(Publishers.keyboardHeight) {
				self.keyboardHeight = $0
			}
			.dropDestination(for: Profile.self) { items, location in
				note.owner = items.first!
				note.color = board.favouriteColors[board.profiles.firstIndex(of: items.first!)!]
				return true
			}
			.zIndex(isFocused ? .infinity : 0)
	}
}

extension Publishers {
	// 1.
	static var keyboardHeight: AnyPublisher<CGFloat, Never> {
		// 2.
		let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
			.map { $0.keyboardHeight }
		
		let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
			.map { _ in CGFloat(0) }
		
		// 3.
		return MergeMany(willShow, willHide)
			.eraseToAnyPublisher()
	}
}

extension UIWindow {
	static var current: UIWindow? {
		for scene in UIApplication.shared.connectedScenes {
			guard let windowScene = scene as? UIWindowScene else { continue }
			for window in windowScene.windows {
				if window.isKeyWindow { return window }
			}
		}
		return nil
	}
}


extension UIScreen {
	static var current: UIScreen? {
		UIWindow.current?.screen
	}
}

extension Notification {
	var keyboardHeight: CGFloat {
		return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
	}
}

#Preview {
	NoteCardView(note: Note(owner: Profile(name: "Jane Doe",
										   initials: "JD",
										   profilePhotoString: "jane-doe",
										   alergens: [.seafood]),
							content: "Test",
							color: .blue,
							x: 0, y:0), board: BoardModel())
}


