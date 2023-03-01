//
//  PersonView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 27/02/23.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack{
            HStack{
                ZStack{
                        HStack{
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color("skyBlue"))
                        VStack{
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 150,height: 150)
                                .background(Color(.gray))
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .padding()
                                .foregroundColor(.black)
                                
                        }
                        .offset(y:80)
                        

                    
                }
            }
            
            Spacer()
            
            HStack{
                
            }
        }
        
    }
}

struct AccountView_previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
