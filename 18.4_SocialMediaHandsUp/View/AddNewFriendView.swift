//
//  AddNewFriendView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 01/03/23.
//

import SwiftUI
import Firebase

struct AddNewFriendView: View {
    
    //MARK: Properties
    @EnvironmentObject var firestoreManager: FirestoreManager
    @Binding var displayAddNewFriendView:Bool
    @AppStorage("userName") var userName = "user1"
    @State var usersArrayList:[String] = []
    @State var displayDMView:Bool = false
    @State var friendsName:String = ""
    
    
    
    
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea(.all)
            
            HStack{
                Text("< go back to Chat View")
                    .onTapGesture {
                        displayAddNewFriendView = false
                    }
            }
            
            
        }
        .frame(height: 100)
        
        //MARK: List of Users(Collection) in Firebase
        HStack{
            List{
                ForEach(Array(usersArrayList.enumerated()) , id: \.offset){ index,element in
                    HStack{
                        Text(element)
                            .foregroundColor(Color.red)
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height:70)
                    .onTapGesture {
                        print(element)
                        displayDMView = true
                        friendsName = element
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height - 100)
        .background(Color.yellow)
        .onAppear{
            print(fetchAllUsersAndAddToUsersList())
            
        }
        .sheet(isPresented: $displayDMView) {
            DirectMessageView(showDMView: $displayDMView , friendsName:  $friendsName )
        }
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






struct UserModel{
    var name:String
    var email:String
    var phone:Int
}

struct User{
    var user:[String:UserModel]
}

class FirestoreManager: ObservableObject {
    @Published var users: String = ""
    @Published var usersList:[String:[String:Any]] = [:]
    @Published var usersArrayList:[String] = []
    
    
    //To fetch one User
    func fetchOneUser() {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document("user1")
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.users = data["name"] as? String ?? ""
                }
            }
            
        }
    }
    
    func fetchAllUsers() {
        let db = Firestore.firestore()
        
        db.collection("Users").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID): \(document.data())")
                }
            }
        }
    }
    
    
    //its gets all users from firebase and simply appends it to usersArrayList of type Array[String]
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
                    self.usersArrayList.append(document.documentID)
                }
                print("fetchAllUsersAndAddToUsersList => \(self.usersArrayList)")
                
            }
            
        }
        print("dfsdf => \(self.usersArrayList)")
        return self.usersArrayList
    }
}
