//
//  RegisterMember.swift
//  LMS
//
//  Created by Oggy Paji on 15/02/25.
//

/*
import SwiftUI

struct RegisterMember: View {
    @State private var libraryCode = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var memberID = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showDatePicker = false
    @State private var navigateToOTPVerification = false
    @State private var showPasswordMismatchAlert = false
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    // Email validation
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Check if all mandatory fields are filled
    private var areFieldsFilled: Bool {
        if libraryCode == "111111" {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !memberID.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        } else {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        }
    }
    
    // Check if the library is private (library code is 111111)
    private var isPrivateLibrary: Bool {
        return libraryCode == "111111"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image covering the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Register User")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5)
                            .padding(.top, 90)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.5)) // Light divider
                            .padding(.horizontal)

                        // Library Code
                        VStack(alignment: .leading) {
                            Text("Library Code")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Library Code", text: $libraryCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .onChange(of: libraryCode) { _ in
                                    // Trigger visibility check when library code changes
                                }
                        }
                        
                        // First Name and Last Name
                        HStack {
                            VStack(alignment: .leading) {
                                Text("First Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                                    .onChange(of: firstName) { _ in
                                        // Trigger visibility check when first name changes
                                    }
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                                    .onChange(of: lastName) { _ in
                                        // Trigger visibility check when last name changes
                                    }
                            }
                        }
                        
                        // Email
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .onChange(of: email) { newValue in
                                    email = newValue.lowercased()
                                }
                            
                            if !email.isEmpty && !isEmailValid {
                                Text("Please enter a valid email address")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Date of Birth
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
                        
                        // Member ID (visible only for private library)
                        if isPrivateLibrary {
                            VStack(alignment: .leading) {
                                Text("Member ID")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter Member ID", text: $memberID)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        // Set Password
                        VStack(alignment: .leading) {
                            Text("Set Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        
                        // Confirm Password
                        VStack(alignment: .leading) {
                            Text("Confirm Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showConfirmPassword {
                                    TextField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showConfirmPassword.toggle()
                                }) {
                                    Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Register Member Button
                    Button(action: {
                        if password == confirmPassword {
                            handleRegister()
                        } else {
                            showPasswordMismatchAlert = true
                        }
                    }) {
                        Text("Register Member")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(areFieldsFilled ? Color(red: 171/255, green: 136/255, blue: 109/255) : Color.gray) // #AB886D
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!areFieldsFilled)
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
            .alert(isPresented: $showPasswordMismatchAlert) {
                Alert(
                    title: Text("Password Mismatch"),
                    message: Text("The passwords you entered do not match. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func handleRegister() {
        // Perform registration logic here
        navigateToOTPVerification = true
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    RegisterMember()
}
*/

import SwiftUI

struct RegisterMember: View {
    @State private var libraryCode = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var memberID = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showDatePicker = false
    @State private var navigateToOTPVerification = false
    @State private var navigateToAdminSignIn = false
    @State private var showPasswordMismatchAlert = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    // Email validation
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Check if all mandatory fields are filled
    private var areFieldsFilled: Bool {
        if isPrivateLibrary {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !memberID.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        } else {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        }
    }
    
    // Check if the library is private (library code is 111111)
    private var isPrivateLibrary: Bool {
        return libraryCode == "111111"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image covering the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Register User")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5)
                            .padding(.top, 90)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.5)) // Light divider
                            .padding(.horizontal)

                        // Library Code
                        VStack(alignment: .leading) {
                            Text("Library Code")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Library Code", text: $libraryCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        // First Name and Last Name
                        HStack {
                            VStack(alignment: .leading) {
                                Text("First Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                            }
                        }
                        
                        // Email
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .onChange(of: email) { newValue in
                                    email = newValue.lowercased()
                                }
                            
                            if !email.isEmpty && !isEmailValid {
                                Text("Please enter a valid email address")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Date of Birth
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
                        
                        // Member ID (visible only for private library)
                        if isPrivateLibrary {
                            VStack(alignment: .leading) {
                                Text("Member ID")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter Member ID", text: $memberID)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        // Set Password
                        VStack(alignment: .leading) {
                            Text("Set Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        
                        // Confirm Password
                        VStack(alignment: .leading) {
                            Text("Confirm Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showConfirmPassword {
                                    TextField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showConfirmPassword.toggle()
                                }) {
                                    Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Register Member Button
                    Button(action: {
                        if password == confirmPassword {
                            handleRegister()
                        } else {
                            showPasswordMismatchAlert = true
                        }
                    }) {
                        Text("Register Member")
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
            .sheet(isPresented: $showDatePicker) {
                DatePicker("Select Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
            .alert("Password Mismatch", isPresented: $showPasswordMismatchAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The passwords you entered do not match. Please try again.")
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK") {
                    if isPrivateLibrary {
                        navigateToOTPVerification = true
                    } else {
                        navigateToAdminSignIn = true
                    }
                }
            }
        }
    }
    
    func handleRegister() {
        alertMessage = isPrivateLibrary ? "Check your mail for OTP." : "Your info has been sent to admin of lib-\(libraryCode) for approval. Please wait."
        showAlert = true
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    RegisterMember()
}


/*
import SwiftUI

struct RegisterMember: View {
    @State private var libraryCode = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var memberID = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showDatePicker = false
    @State private var navigateToOTPVerification = false
    @State private var navigateToAdminSignIn = false
    @State private var showPasswordMismatchAlert = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    
    // Email validation
    private var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Check if all mandatory fields are filled
    private var areFieldsFilled: Bool {
        if isPrivateLibrary {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !memberID.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        } else {
            return !libraryCode.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && isEmailValid
        }
    }
    
    // Check if the library is private (library code is 111111)
    private var isPrivateLibrary: Bool {
        return libraryCode == "111111"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image covering the entire screen
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Register User")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5)
                            .padding(.top, 90)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.white.opacity(0.5)) // Light divider
                            .padding(.horizontal)

                        // Library Code
                        VStack(alignment: .leading) {
                            Text("Library Code")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Library Code", text: $libraryCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .onChange(of: libraryCode) { _ in
                                    // Trigger visibility check when library code changes
                                }
                        }
                        
                        // First Name and Last Name
                        HStack {
                            VStack(alignment: .leading) {
                                Text("First Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                                    .onChange(of: firstName) { _ in
                                        // Trigger visibility check when first name changes
                                    }
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.words)
                                    .onChange(of: lastName) { _ in
                                        // Trigger visibility check when last name changes
                                    }
                            }
                        }
                        
                        // Email
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .onChange(of: email) { newValue in
                                    email = newValue.lowercased()
                                }
                            
                            if !email.isEmpty && !isEmailValid {
                                Text("Please enter a valid email address")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Date of Birth
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
                        
                        // Member ID (visible only for private library)
                        if isPrivateLibrary {
                            VStack(alignment: .leading) {
                                Text("Member ID")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter Member ID", text: $memberID)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        
                        // Set Password
                        VStack(alignment: .leading) {
                            Text("Set Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Enter Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        
                        // Confirm Password
                        VStack(alignment: .leading) {
                            Text("Confirm Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            ZStack(alignment: .trailing) {
                                if showConfirmPassword {
                                    TextField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    SecureField("Re-enter Password", text: $confirmPassword)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                Button(action: {
                                    showConfirmPassword.toggle()
                                }) {
                                    Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Register Member Button
                    Button(action: {
                        if password == confirmPassword {
                            handleRegister()
                        } else {
                            showPasswordMismatchAlert = true
                        }
                    }) {
                        Text("Register Member")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(areFieldsFilled ? Color(red: 171/255, green: 136/255, blue: 109/255) : Color.gray) // #AB886D
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!areFieldsFilled)
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
            .alert(isPresented: $showPasswordMismatchAlert) {
                Alert(
                    title: Text("Password Mismatch"),
                    message: Text("The passwords you entered do not match. Please try again."),
                    dismissButton: .default(Text("OK"))
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if isPrivateLibrary {
                            navigateToOTPVerification = true
                        } else {
                            navigateToAdminSignIn = true
                        }
                    }
            }
            .navigationDestination(isPresented: $navigateToOTPVerification) {
                OTPView(role: "MemberHomeView")
            }
            .navigationDestination(isPresented: $navigateToAdminSignIn) {
                AdminSignIn()
            }
        }
    }
    
    func handleRegister() {
        if isPrivateLibrary {
            alertMessage = "Check your mail for OTP."
        } else {
            alertMessage = "Your info has been sent to admin of lib-\(libraryCode) for approval. Please wait."
        }
        showAlert = true
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    RegisterMember()
}
*/
