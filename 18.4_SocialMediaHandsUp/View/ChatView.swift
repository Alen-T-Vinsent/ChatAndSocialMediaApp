//
//  ChatView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI
import Firebase

struct ChatView: View {
    let sampleArray = ["1","2","3","4","5","6","7","8","9"]
    @State var isAnimating = false
    @State var showDMView = false
    @State var displayAddNewFriendView = false
    @State var friendsName = "friends Name"
    @State var usersArrayList:[String] = []
    @AppStorage("userName") var userName = "user1"
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    List {
                        ForEach(Array(usersArrayList.enumerated()),id:\.offset){ index,element in
                            EachChatView(name: element)
                            .onTapGesture {
                                showDMView = true
                                friendsName = element
                            }
                        }
                        
                        .listRowBackground(Color("simpleWhite"))
                        .listRowSeparator(.hidden)
                        HStack{
                            
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .frame(height: 90)
                        .background(Color("simpleWhite"))
                    }
                    .listStyle(.plain)
                    
                    
                }
                .background(Color("simpleWhite"))
            }

            .overlay(alignment:.bottomTrailing){
                Image("chat-icon3")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .foregroundColor(Color("lightBlue"))
                    .offset(x: -25 )
                    .offset(y: isAnimating ? -115 : -100)
                    .onTapGesture {
                        displayAddNewFriendView = true
                    }
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
            DirectMessageView(showDMView: $showDMView, friendsName: $friendsName)
        })
        .fullScreenCover(isPresented: $displayAddNewFriendView, content: {
                AddNewFriendView(displayAddNewFriendView: $displayAddNewFriendView)
                .environmentObject(FirestoreManager())
        })
        .onAppear {
                usersArrayList = fetchAllUsersAndAddToUsersList()
        }
        .accentColor(Color("darkBlue"))
  
        
    }
    
    
    //MARK: need to delete
    func fetchAllUsersAndAddToUsersList() -> [String]{
        let db = Firestore.firestore()
        
        db.collection("Users").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    //MARK: To print String : Dictionary<String, Any>
                    //print("\(document.documentID): \(document.data())")
                    // print( "\(type(of: document.documentID)) : \(type(of: document.data()))")
                    if userName != document.documentID{
                        self.usersArrayList.append(document.documentID)
                    }
                }
                print("fetchAllUsersAndAddToUsersList => \(self.usersArrayList)")
                
            }
            
        }
        print("dfsdf => \(self.usersArrayList)")
        return self.usersArrayList
    }
}



struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
