//
//  RegisterMember.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import SwiftUI

struct RegisterMember: View {
    @State private var libraryCode = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var memberID = ""
    @State private var password = ""
    @State private var showDatePicker = false
    @State private var navigateToOTPVerification = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image covering the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 15) {
                    Text("Get Started")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("#AB886D")) // Apply #AB886D color
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 5)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.5)) // Light divider
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Library Code")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Library Code", text: $libraryCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("First Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        VStack(alignment: .leading) {
                            Text("Date of Birth")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            HStack {
                                TextField("Select Date of Birth", text: Binding(
                                    get: { formatDate(birthDate) },
                                    set: { _ in }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(true)
                                
                                Button(action: {
                                    showDatePicker.toggle()
                                }) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Member ID")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Member ID", text: $memberID)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Set Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            SecureField("Enter Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // NavigationLink for OTP Verification
                    NavigationLink(destination: OTPView(), isActive: $navigateToOTPVerification) {
                        Button(action: {
                            handleVerify()
                        }) {
                            Text("Verify")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("#AB886D")) // Button color #AB886D
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding()
            }
            .sheet(isPresented: $showDatePicker) {
                DatePicker("Select Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
        }
    }
    
    func handleVerify() {
        navigateToOTPVerification = true
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Extension to use hex color

#Preview {
    RegisterMember()
}
