//
//  EmptyStateView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//


import SwiftUI

struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.top, 50)
    }
}

#Preview {
    EmptyStateView(message: "No Data Available")
}