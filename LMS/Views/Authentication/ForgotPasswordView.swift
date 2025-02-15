//
//  ForgotPasswordView.swift
//  LMS
//
//  Created by Oggy Paji on 15/02/25.
//
import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showAlert = false
    @State private var navigateToOTPView = false

    @FocusState private var focusedField: Int? // FIXED: Added missing @FocusState
    
    // Email validation
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Check if all fields are filled and valid
    private var areFieldsFilled: Bool {
        return !email.isEmpty && !newPassword.isEmpty && !confirmPassword.isEmpty && isEmailValid && newPassword == confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image applied to the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Forgot Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255))
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.horizontal)
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 15) {
                        TextField("Enter Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .onChange(of: email) { newValue in
                                email = newValue.lowercased() // Force lowercase
                            }
                            .submitLabel(.next)
                            .focused($focusedField, equals: 0) // FIXED: Focus State

                        if !email.isEmpty && !isEmailValid {
                            Text("Please enter a valid email address")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20)
                    
                    // New Password Field
                    VStack(alignment: .leading, spacing: 15) {
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("Enter New Password", text: $newPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
                                    .submitLabel(.next)
                                    .focused($focusedField, equals: 1) // FIXED: Focus State
                            } else {
                                SecureField("Enter New Password", text: $newPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
                                    .submitLabel(.next)
                                    .focused($focusedField, equals: 1) // FIXED: Focus State
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 25)
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 15) {
                        ZStack(alignment: .trailing) {
                            if showConfirmPassword {
                                TextField("Re-enter New Password", text: $confirmPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
                                    .submitLabel(.done)
                                    .focused($focusedField, equals: 2) // FIXED: Focus State
                            } else {
                                SecureField("Re-enter New Password", text: $confirmPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
                                    .submitLabel(.done)
                                    .focused($focusedField, equals: 2) // FIXED: Focus State
                            }
                            
                            Button(action: {
                                showConfirmPassword.toggle()
                            }) {
                                Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 25)
                            }
                        }
                        
                        if !newPassword.isEmpty && !confirmPassword.isEmpty && newPassword != confirmPassword {
                            Text("Passwords do not match")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10)
                    
                    // Submit Button
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(areFieldsFilled ? Color(red: 171/255, green: 136/255, blue: 109/255) : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!areFieldsFilled)
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Check Your Mail"),
                    message: Text("Please check your email for further instructions."),
                    dismissButton: .default(Text("OK")) {
                        navigateToOTPView = true
                    }
                )
            }
            .navigationDestination(isPresented: $navigateToOTPView) {
                OTPView(role: "MemberHomeView") // FIXED: Correct OTPView Call
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
