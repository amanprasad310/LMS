//
//  ManageUserIDsView.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//

import SwiftUI

struct ManageUserIDsView: View {
    @State private var searchText = ""
    @State private var ids: [String] = []
    @State private var toggledStates: [String: Bool] = [:]

    var filteredIDs: [String] {
        searchText.isEmpty ? ids : ids.filter { $0.contains(searchText) }
    }
    
    var body: some View {
            VStack(spacing: 15) {
                searchBar
                
                NavigationLink(destination: AddUserIDsView(ids: $ids, toggledStates: $toggledStates)) {
                    CustomListRow(title: "Add new ID", icon: "plus.circle.fill")
                }

                Text("Manage your IDs")
                    .font(.headline)
                    .foregroundColor(.black)
                
                if ids.isEmpty {
                    EmptyStateView(message: "No ID has been created yet")
                } else if filteredIDs.isEmpty {
                    EmptyStateView(message: "No matching ID found")
                } else {
                    idListView
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("Manage User IDs")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UI Components
extension ManageUserIDsView {
    private var searchBar: some View {
        HStack {
            TextField("Search ID", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private var idListView: some View {
        List {
            ForEach(filteredIDs, id: \.self) { id in
                HStack {
                    Text(id)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { self.toggledStates[id, default: false] },
                        set: { self.toggledStates[id] = $0 }
                    ))
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Reusable Components
struct CustomListRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
            Spacer()
            Image(systemName: icon)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    ManageUserIDsView()
}
