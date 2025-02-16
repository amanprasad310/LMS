////
////  AddUserIDsView.swift
////  LMS
////
////  Created by Vanshika Choudhary on 16/2/25.
////


import SwiftUI

struct AddUserIDsView: View {
    @Binding var ids: [String]
    @Binding var toggledStates: [String: Bool]
    
    @State private var startingID = ""
    @State private var endingID = ""
    @State private var addInBulk = false
    @State private var errorMessage: String? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // Input Fields
            VStack(spacing: 12) {
                CustomTextField(placeholder: "Starting ID", text: $startingID, keyboardType: .numberPad)
                
                if addInBulk {
                    CustomTextField(placeholder: "Ending ID", text: $endingID, keyboardType: .numberPad)
                }
                
                Toggle("Add in Bulk", isOn: $addInBulk)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            // Error Message Display
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.horizontal)
            }
            
            // Add Button
            Button(action: addIDs) {
                Text("Add IDs")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Add User IDs")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
    
    private func addIDs() {
        guard let start = Int(startingID), !startingID.isEmpty else {
            errorMessage = "Please enter a valid starting ID."
            return
        }

        if addInBulk {
            guard let end = Int(endingID), end > start else {
                errorMessage = "Please enter a valid ending ID greater than the starting ID."
                return
            }
            
            let newIDs = (start...end).map { String($0) }.filter { !ids.contains($0) }
            if newIDs.isEmpty {
                errorMessage = "All IDs in this range already exist."
                return
            }
            
            ids.append(contentsOf: newIDs)
            newIDs.forEach { toggledStates[$0] = true }
        } else {
            let idString = String(start)
            if ids.contains(idString) {
                errorMessage = "ID \(idString) already exists!"
                return
            }
            ids.append(idString)
            toggledStates[idString] = true
        }
        
        errorMessage = nil  // Clear any error message
        presentationMode.wrappedValue.dismiss() // Go back
    }
}
