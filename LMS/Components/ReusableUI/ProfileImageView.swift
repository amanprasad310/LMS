//
//  ProfileImageView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//


import SwiftUI

struct ProfileImageView: View {
    var image: UIImage?
    @Binding var isEditing: Bool
    @Binding var showingImagePicker: Bool
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }

            if isEditing {
                Button(action: { showingImagePicker = true }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
            }
        }
    }
}
