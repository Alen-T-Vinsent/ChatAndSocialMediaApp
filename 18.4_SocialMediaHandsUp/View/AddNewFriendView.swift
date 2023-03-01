//
//  AddNewFriendView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 01/03/23.
//

import SwiftUI

struct AddNewFriendView: View {
    @Binding var displayAddNewFriendView:Bool
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea(.all)
            
            HStack{
                Text("go back to Chat View")
                    .onTapGesture {
                        displayAddNewFriendView = false
                    }
            }
        }
    }
}

