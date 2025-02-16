//
//  ManageLibrarianView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//

import SwiftUI

struct ManageLibrarianView: View {
    @State private var librarians: [Librarian] = []
    @State private var disabledLibrarians: [Librarian] = []

    var body: some View {
            VStack(spacing: 15) {
                createLibrarianButton
                
                Text("Manage Your Librarians")
                    .font(.headline)
                    .foregroundColor(.black)
                
                if librarians.isEmpty && disabledLibrarians.isEmpty {
                    EmptyStateView(message: "No Librarians added yet")
                } else {
                    librarianListView
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("Manage Librarians")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UI Components
extension ManageLibrarianView {
    private var createLibrarianButton: some View {
        NavigationLink(destination: CreateLibrarianView(librarians: $librarians)) {
            CustomListRow(title: "Create a new Librarian", icon: "plus.circle.fill")
        }
    }

    private var librarianListView: some View {
        List {
            if !librarians.isEmpty {
                Section(header: Text("Active Librarians").bold()) {
                    ForEach(librarians) { librarian in
                        NavigationLink(destination: LibrarianDetailsView(
                            librarian: librarian,
                            librarians: $librarians,
                            disabledLibrarians: $disabledLibrarians
                        )) {
                            LibrarianRow(librarian: librarian)
                        }
                    }
                    .onDelete(perform: deleteLibrarian)
                }
            }

            if !disabledLibrarians.isEmpty {
                Section(header: Text("Disabled Librarians").bold().foregroundColor(.red)) {
                    ForEach(disabledLibrarians) { librarian in
                        LibrarianRow(librarian: librarian, isDisabled: true)
                    }
                    .onDelete(perform: deleteDisabledLibrarian)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Actions
extension ManageLibrarianView {
    private func deleteLibrarian(at offsets: IndexSet) {
        librarians.remove(atOffsets: offsets)
    }

    private func deleteDisabledLibrarian(at offsets: IndexSet) {
        disabledLibrarians.remove(atOffsets: offsets)
    }
}

// MARK: - Reusable Components
struct LibrarianRow: View {
    var librarian: Librarian
    var isDisabled: Bool = false

    var body: some View {
        HStack {
            if let image = librarian.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(isDisabled ? .gray : .blue)
            }

            VStack(alignment: .leading) {
                Text(librarian.name)
                    .font(.headline)
                Text("Age: \(librarian.age)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(librarian.email)
                    .font(.subheadline)
                    .foregroundColor(isDisabled ? .gray : .blue)
            }

            if isDisabled {
                Spacer()
                Text("Disabled")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(6)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    ManageLibrarianView()
}

