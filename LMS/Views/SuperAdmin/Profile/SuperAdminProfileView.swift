//
//  AdminProfileView.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import SwiftUI

struct SuperAdminProfileView: View {
    let admin: Admin
    @Environment(\.presentationMode) var presentationMode
    @State private var showLogoutAlert = false

    var body: some View {
        VStack(spacing: 20) {
            // Admin Details
            VStack(spacing: 10) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)

                Text(admin.name)
                    .font(.title)
                    .bold()

                Text(admin.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()

            Spacer()

            // Logout Button
            Button(action: {
                showLogoutAlert = true
            }) {
                Text("Log Out")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Do you really want to log out?"),
                    primaryButton: .destructive(Text("Log Out")) {
                        logOut()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }

    private func logOut() {
        // Navigate to AdminSignInView
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: AdminSignIn())
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    SuperAdminProfileView(admin: Admin(name: "aman", email: "aman@gmail.com"))
}
