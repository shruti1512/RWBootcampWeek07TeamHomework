//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostView: View {
  
  //MARK: - Properties
  
  @State private var selectedReaction = Reaction.starryEyes
  var post: MediaPost
  var reactionCases = Reaction.allCases

  //MARK: - Content Body

  var body: some View {
    
    VStack(alignment: .center) {
      
      HStack {
        
        //Mascot Image
        
        MascotImage()
        
        //Post Username and Timestamp

        VStack(alignment: .leading) {
          Text(post.userName)
            .font(.custom("ArialRoundedMTBold", size: 20))
          Text(post.timestamp.toString())
            .font(.custom("ArialMT", size: 15))
        }
        
        //Spacer to fill empty space in the HStack
        
        Spacer()
      }
      
      //Post Text Body

      HStack {
        post.textBody != nil ? Text(post.textBody!)
          .lineLimit(nil)
          .font(.custom("ArialMT", size: 18)) : nil
        Spacer()
      }
      
      //Post Image

      post.uiImage != nil ?  PostImage(uiImage: post.uiImage!) : nil

      //SegmentedStyle Picker View for Post Reactions

      HStack(alignment: .bottom) {
        
        Picker("Reaction", selection: $selectedReaction) {
          ForEach(Reaction.allCases, id: \.self) { reaction in
            Text(reaction.rawValue).tag(reaction)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
        
      }

      }
    }
}

struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    
    PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                             userName: "Audrey",
                             timestamp: Date(timeIntervalSinceNow: -9876),
                             uiImage: UIImage(named: "octopus")!))
  }
}

