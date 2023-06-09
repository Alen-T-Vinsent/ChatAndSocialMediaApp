//
//  ChatView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI

struct ChatView: View {
    let sampleArray = ["1","2","3","4","5","6","7","8","9"]
    @State var isAnimating = false
    @State var showDMView = false
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    List {
                        ForEach(sampleArray,id:\.self){ eachIndex in
                            EachChatView(name: eachIndex)
                            .onTapGesture {
                                showDMView = true
                            }
                        }
                        .listRowBackground(Color("simpleWhite"))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    
                }
            }

            .overlay(alignment:.bottomTrailing){
                Image("chat-icon3")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .foregroundColor(Color("lightBlue"))
    //                .offset(x:-25,y:-120)
                    .offset(x: -25 )
                    .offset(y: isAnimating ? -115 : -100)
                    .onAppear {
                        isAnimating = true
                    }
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever(),
                        value: isAnimating)
                
            }
            
            .navigationTitle("Chats")
            .navigationViewStyle(.stack)
            .toolbarBackground(
                Color("skyBlue"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .fullScreenCover(isPresented: $showDMView, content: {
            DirectMessageView(showDMView: $showDMView)
        })
        .accentColor(Color("darkBlue"))
  
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
