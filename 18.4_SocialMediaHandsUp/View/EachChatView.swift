//
//  EachChatView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI

struct EachChatView: View {
    @State var name = ""
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        HStack(spacing:10){
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 60,height: 60)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding()
                .foregroundColor(.pink)
            VStack{
                Text("\(name)")
                Text("i am message")
                    .font(.footnote)

                    
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .frame(width: screenWidth)
        .frame(height: 80)
        .foregroundColor(Color("darkBlue"))
        
        //MARK: Date
        .overlay(alignment:.topTrailing){
            Text("2/25/2023")
                .font(.footnote)
                .foregroundColor(Color("darkBlue"))
        }
        
        //MARK: Time
        .overlay(alignment:.bottomTrailing){
            Text("2:06 PM")
                .font(.footnote)
                .foregroundColor(Color("darkBlue"))
        }
    }
}

