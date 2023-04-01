//
//  FriendShareView.swift
//  blink
//
//  Created by Baily Case on 3/19/23.
//

import SwiftUI
import BottomSheet

struct Group: Identifiable {
    let friends: [Friend]
    let id = UUID()
    var name: String
}

struct Friend: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    var image: String?
}

let friends = [
    Friend(firstName: "John", lastName: "Doe"),
    Friend(firstName: "John", lastName: "Doe"),
]

let friendsWithImages = [
    Friend(firstName: "John", lastName: "Doe", image: "https://media.istockphoto.com/id/1270987867/photo/close-up-young-smiling-man-in-casual-clothes-posing-isolated-on-blue-wall-background-studio.jpg?s=612x612&w=0&k=20&c=FXkui3WMnV8YY_aqt8VsSSXYznvm9Y3eMoHMYyW4za4="),
    Friend(firstName: "John", lastName: "Doe", image: "https://media.istockphoto.com/id/539849622/photo/cheerful-young-african-woman-taking-selfie.jpg?s=612x612&w=0&k=20&c=rNKsbjsi8M04e9p6rTH8f2bUVxJFW32foZgctUBZ-M8=")
]

struct FriendImage: View {
    let friend: Friend
    let index: Int
    var body: some View {
        ZStack {
            if index == 1 {
                Circle()
                    .stroke(.ultraThinMaterial, lineWidth: 4)
            }
            if let imageUrl = friend.image {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.clear)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
            } else {
                HStack {
                    Text(initialsFromName: friend.firstName, lastName: friend.lastName)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            }
        }
        .frame(width: 44, height: 44)
        .offset(x: CGFloat(index % 2 == 0 ? -4 : 4), y: CGFloat(index % 2 == 0 ? -6 : 6))
    }
}

struct FriendShareView: View {
    private let groups: [Group] = [
        Group(friends: friendsWithImages, name: "Buddies!"),
        Group(friends: friends, name: "Family"),
        Group(friends: friends, name: "BFFS"),
        Group(friends: friends, name: "BFFS"),
        Group(friends: friends, name: "BFFS"),
        Group(friends: friends, name: "BFFS"),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(groups) { group in
                    VStack {
                        ZStack {
                            // might need to address this for out of bounds
                            ForEach(Array(group.friends.enumerated().prefix(2)), id: \.offset) { index, friend in
                                FriendImage(friend: friend, index: index)
                            }
                        }
                        .frame(width: 65, height: 65)
                        .cornerRadius(.infinity)
                        
                        Text(group.name).font(.caption)
                    }
                }
            }
            .padding(.vertical, 35)
            .padding(.horizontal, 20)
        }
        .frame(alignment: .leading)
    }
}

struct FriendShareView_Previews: PreviewProvider {
    static var previews: some View {
        let shareSheetPosition: BottomSheetPosition = .absolute(175)
        HStack {}
            .bottomSheet(bottomSheetPosition: Binding.constant(shareSheetPosition), switchablePositions: []) {
                FriendShareView()
            }.isResizable(false)
    }
}
