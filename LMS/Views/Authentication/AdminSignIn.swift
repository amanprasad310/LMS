////
////  AdminSignIn.swift
////  LMS
////
////  Created by OggyPaji  on 15/02/25.
////
import SwiftUI

struct AdminSignIn: View {
    @State private var selectedSegment = "Admin Sign Up"
    let segments = ["Admin Sign Up", "Member Sign Up"]
    
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    @State private var navigateToOTPView = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    // Dummy data for roles(password,otp,role)
    private let dummyData = [
        // Super Admin
        "superadmin@example.com": ("123456", "654321", "SuperAdminDashboard"),
        // Admin
        "admin@example.com": ("12345", "543210", "AdminDashboard"),
        // Librarian
        "librarian@example.com": ("1234567", "765432", "LibrarianDashboard"),
        // Member (Private Library)
        "memberprivate@example.com": ("private123", "123456", "MemberHomeView"),
        // Member (Public Library)
        "memberpublic@example.com": ("public123", "123456", "MemberHomeView")
    ]
    
    // Email validation
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Check if both fields are filled
    private var areFieldsFilled: Bool {
        return !email.isEmpty && !password.isEmpty && isEmailValid
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
                    Text("Get Started Now")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.5)) // Light divider
                        .padding(.horizontal)
                    
                    // Segment Control
                    Picker("Sign Up Type", selection: $selectedSegment) {
                        ForEach(segments, id: \.self) { segment in
                            Text(segment)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
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
                            .submitLabel(.go)
                            .onSubmit {
                                if areFieldsFilled {
                                    handleSignIn()
                                }
                            }
                        
                        if !email.isEmpty && !isEmailValid {
                            Text("Please enter a valid email address")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        }
                        
                        // Password Field with Show/Hide Toggle
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("Enter Password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Enter Password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .autocapitalization(.none)
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
                    .padding(.top, 20)
                    
                    // Sign In Button
                    VStack(spacing: 15) {
                        Button(action: {
                            handleSignIn()
                        }) {
                            Text("Sign In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(areFieldsFilled ? Color(red: 171/255, green: 136/255, blue: 109/255) : Color.gray) // #AB886D
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(!areFieldsFilled)
                        
                        // Forgot Password and Sign Up Buttons (only for Member Sign Up)
                        if selectedSegment == "Member Sign Up" {
                            HStack {

                                
                                NavigationLink(destination: ForgotPasswordView()) {
                                    Text("Forgot Password?")
                                        .foregroundColor(Color.blue)
                                }
                                Spacer()
                                
                                NavigationLink(destination: RegisterMember()) {
                                    Text("New Here? Sign Up")
                                        .foregroundColor(Color.blue)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20)

                    // Loading Indicator
                    if isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    
                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToOTPView) {
                if let role = dummyData[email]?.2 {
                    OTPView(role: role)
                }
            }
        }
    }
    
    // Handle Sign In Logic
    func handleSignIn() {
        isLoading = true
        errorMessage = ""
        
        // Simulate a network call or validation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let (storedPassword, _, role) = dummyData[email], password == storedPassword {
                // Role-based check
                if (selectedSegment == "Admin Sign Up" && (role == "SuperAdminDashboard" || role == "AdminDashboard" || role == "LibrarianDashboard")) ||
                    (selectedSegment == "Member Sign Up" && (role == "MemberHomeView")) {
                    navigateToOTPView = true
                } else {
                    errorMessage = "Invalid role for selected segment"
                }
            } else {
                errorMessage = "Invalid email or password"
            }
            isLoading = false
        }
    }
}

#Preview {
    AdminSignIn()
}
