//
//  AdminDashboard.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import SwiftUI

struct AdminDashboard: View {
    // State to track the selected tab
    @State private var selectedTab: Tab = .home

    // Enum to represent the tabs
    enum Tab {
        case home
        case profile
    }

    var body: some View {
        VStack(spacing: 0) {
            // Show the appropriate view based on the selected tab
            switch selectedTab {
            case .home:
                HomeView()
            case .profile:
                NavigationView {
                    AdminsProfileView(admin: admin1) // Replace `admin1` with your actual data
                        .toolbar {
                            // Center the navigation title
                            ToolbarItem(placement: .principal) {
                                Text("Profile")
                                    .font(.title)
                                    .foregroundColor(.brown)
                                    .fontWeight(.bold)
//                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                        }
                }
            }

            // Bottom Navigation Bar
            bottomNavBar
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Home View
struct HomeView: View {
    var body: some View {
        VStack {
            // Header
            headerView

            // List of Admin Actions
            List {
                adminNavigationItem(
                    title: "Manage Your Librarian",
                    subtitle: "Easily oversee and manage your librarian",
                    icon: "person.2.fill" // Unique icon for "Manage Your Librarian"
                )

                adminNavigationItem(
                    title: "Manage permissible user IDs",
                    subtitle: "Manage user IDs for secure access.",
                    icon: "key.fill"
                    // Unique icon for "Manage Permissible User IDs"
                )
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

// MARK: - UI Components
extension HomeView {
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Welcome admin")
                .font(.title)
                .bold()
                .foregroundColor(.brown)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
    }

    private func adminNavigationItem(title: String, subtitle: String, icon: String) -> some View {
        NavigationLink(destination: destinationView(for: title)) {
            HStack(alignment: .center, spacing: 12) { // Adjusted spacing for better alignment
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown) // Custom icon color
                    .padding(.trailing, 13)

                VStack(alignment: .leading, spacing: 4) { // Adjusted spacing for better alignment
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure text is aligned to the left
            }
            .padding(.vertical, 10) // Add vertical padding for better spacing
            .padding(.horizontal, 8) // Add horizontal padding for better spacing
        }
    }

    private func destinationView(for title: String) -> some View {
        switch title {
        case "Manage Your Librarian":
            return AnyView(ManageLibrarianView())
        case "Manage permissible user IDs":
            return AnyView(ManageUserIDsView())
        default:
            return AnyView(EmptyView())
        }
    }
}

// MARK: - Bottom Navigation Bar
extension AdminDashboard {
    private var bottomNavBar: some View {
        HStack {
            // Home Tab
            Button(action: {
                selectedTab = .home
            }) {
                bottomNavItem(icon: "house.fill", label: "Home", isActive: selectedTab == .home)
            }
            .frame(maxWidth: .infinity) // Distribute space evenly

            // Profile Tab
            Button(action: {
                selectedTab = .profile
            }) {
                bottomNavItem(icon: "person.crop.circle", label: "Profile", isActive: selectedTab == .profile)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 10) // Add vertical padding
        .background(Color.white)
    }

    private func bottomNavItem(icon: String, label: String, isActive: Bool) -> some View {
        VStack(spacing: 4) { // Adjust spacing between icon and text
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
            Text(label)
                .font(.caption)
        }
        .foregroundColor(isActive ? .brown : .gray)
        .padding(.vertical, 8) // Add padding to the entire tab item
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        AdminDashboard()
    }
}
