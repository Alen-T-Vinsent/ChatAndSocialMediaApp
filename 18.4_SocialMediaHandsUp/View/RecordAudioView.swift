//
//  RecordAudioView.swift
//  18.4_SocialMediaHandsUp
//
//  Created by Apple  on 28/02/23.
//

import SwiftUI

struct RecordAudioView: View {
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        HStack{
            HStack{
                
            }
            .frame(height: 100)
            .frame(width: screenWidth - screenWidth/4)
            .background(Color.red)
            Spacer()
        }
        .frame(height: 200)
        .frame(width: screenWidth)
        .background(Color.clear)
        
      
    }
}

struct RecordAudioView_Previews: PreviewProvider {
    static var previews: some View {
        RecordAudioView()
    }
}
