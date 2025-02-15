//
//  AdminSignIn.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import SwiftUI

struct AdminSignIn: View {
    @State private var selectedSegment = "Admin Sign Up"
    let segments = ["Admin Sign Up", "Member Sign Up"]
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var navigateToSuperAdminHome = false
    @State private var navigateToMemberSignIn = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image applied to the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Get Started Now")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.5)) // Light divider
                        .padding(.horizontal)
                    
                    Picker("Sign Up Type", selection: $selectedSegment) {
                        ForEach(segments, id: \.self) { segment in
                            Text(segment)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("Enter Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)

                        SecureField("Enter Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: SuperAdminDashboard(), isActive: $navigateToSuperAdminHome) { EmptyView() }
                        NavigationLink(destination: MemberSignIn(), isActive: $navigateToMemberSignIn) { EmptyView() }

                        Button(action: {
//                            handleSignIn()
                        }) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    if isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
        }
    }
    
    
//    func handleSignIn() {
//        // Set loading state
//        isLoading = true
//        errorMessage = ""
//        
//        // Determine the role based on the password length
//        var role = ""
//        
//        if password.count == 4, let _ = Int(password) {
//            role = "super-admin"
//        } else if password.count == 5, let _ = Int(password) {
//            role = "admin"
//        } else if password.count == 6, let _ = Int(password) {
//            role = "librarian"
//        } else {
//            errorMessage = "Password must be 4, 5, or 6 digits long based on your role."
//            isLoading = false
//            return
//        }
//    }
}

#Preview {
    AdminSignIn()
}
