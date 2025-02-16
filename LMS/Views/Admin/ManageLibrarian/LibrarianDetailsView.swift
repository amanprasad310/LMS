//
//  LibrarianDetailsView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//

import SwiftUI

struct LibrarianDetailsView: View {
    var librarian: Librarian
    @Binding var librarians: [Librarian]
    @Binding var disabledLibrarians: [Librarian]

    @State private var isEditing = false
    @State private var name: String
    @State private var age: String
    @State private var email: String
    @State private var profileImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingDisableAlert = false

    @Environment(\.presentationMode) var presentationMode

    init(librarian: Librarian, librarians: Binding<[Librarian]>, disabledLibrarians: Binding<[Librarian]>) {
        self.librarian = librarian
        self._librarians = librarians
        self._disabledLibrarians = disabledLibrarians
        self._name = State(initialValue: librarian.name)
        self._age = State(initialValue: "\(librarian.age)")
        self._email = State(initialValue: librarian.email)
        self._profileImage = State(initialValue: librarian.image)
    }

    var body: some View {
        VStack {
            ProfileImageView(image: profileImage, isEditing: $isEditing, showingImagePicker: $showingImagePicker)
                .onTapGesture {
                    if isEditing {
                        showingImagePicker = true
                    }
                }

            VStack(spacing: 12) {
                CustomTextField(placeholder: "Name", text: $name, disabled: !isEditing)
                CustomTextField(placeholder: "Age", text: $age, keyboardType: .numberPad, disabled: !isEditing)
                CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress, disabled: !isEditing)
            }
            .padding(.horizontal, 32)

            Spacer()

            if isEditing {
                Button(action: { showingDisableAlert = true }) {
                    Text("Disable Librarian")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                .alert(isPresented: $showingDisableAlert) {
                    Alert(
                        title: Text("Disable Librarian"),
                        message: Text("Are you sure you want to disable \(librarian.name)?"),
                        primaryButton: .destructive(Text("Disable")) { disableLibrarian() },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .background(Color(UIColor.systemGray6))
        .navigationTitle(isEditing ? "Edit Librarian" : librarian.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                if isEditing {
                    saveChanges()
                }
                isEditing.toggle()
            }) {
                Text(isEditing ? "Save" : "Edit")
                    .foregroundColor(.brown)
                    .bold()
            }
        )
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $profileImage)
        }
    }

    private func saveChanges() {
        if let index = librarians.firstIndex(where: { $0.id == librarian.id }) {
            librarians[index] = Librarian(
                id: librarian.id,
                name: name,
                age: Int(age) ?? librarian.age,
                email: email,
                image: profileImage
            )
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func disableLibrarian() {
        if let index = librarians.firstIndex(where: { $0.id == librarian.id }) {
            let disabledLibrarian = librarians.remove(at: index)
            disabledLibrarians.append(disabledLibrarian)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

