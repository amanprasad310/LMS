//
//  CreateLibrarianView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//
import SwiftUI

struct CreateLibrarianView: View {
    @State private var librarianName: String = ""
    @State private var age: String = ""
    @State private var email: String = ""
    @State private var librarianImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    @Binding var librarians: [Librarian]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            // Image Picker Button
            Button(action: { showImagePicker = true }) {
                if let librarianImage = librarianImage {
                    Image(uiImage: librarianImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .overlay(
                            Text("Add Image")
                                .foregroundColor(.black)
                                .font(.caption)
                        )
                        .shadow(radius: 2)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $librarianImage)
            }

            // Librarian Details Form
            List { // Use List for better scrolling and grouping
                Section {
                    CustomTextField(placeholder: "Librarian Name", text: $librarianName)
                    CustomTextField(placeholder: "Age", text: $age, keyboardType: .numberPad)
                    CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: email) { newValue in
                            email = newValue.lowercased() // Force lowercase
                        }
                }
                .listRowBackground(Color.white) // Set row background to white
            }
            .listStyle(InsetGroupedListStyle()) // Use grouped list style
            .background(Color.white) // Set the entire List background to white

            // Create Button
            Button(action: createLibrarian) {
                Text("Create Librarian")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(!isEmailValid || librarianName.isEmpty || age.isEmpty) // Disable if invalid
            .opacity(!isEmailValid || librarianName.isEmpty || age.isEmpty ? 0.6 : 1) // Fade if invalid
            
            Spacer()
        }
        .navigationTitle("Create Librarian")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemGray6)) // Set the overall background color
    }

    private func createLibrarian() {
        guard let ageInt = Int(age), !librarianName.isEmpty, !email.isEmpty else { return }
        
        let newLibrarian = Librarian(
            name: librarianName,
            age: ageInt,
            email: email,
            image: librarianImage
        )
        librarians.append(newLibrarian)
        presentationMode.wrappedValue.dismiss()
    }

    // Email validation computed property
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}


struct CreateLibrarianView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy binding for the preview
        let dummyLibrarians = Binding<[Librarian]>(
            get: { [] },
            set: { _ in }
        )
        
        NavigationView {
            CreateLibrarianView(librarians: dummyLibrarians)
        }
    }
}
