//
//  OTPView.swift
//  LMS
//
//  Created by Oggy Paji on 15/02/25.
//
import SwiftUI

struct OTPView: View {
    @State private var otp = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    @State private var isOTPVerified = false
    @State private var isOTPIncorrect = false
    @State private var timerActive = true
    @State private var timeRemaining = 30
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToDashboard = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let role: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Image1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Verify OTP")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 171/255, green: 136/255, blue: 109/255)) // #AB886D
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 5)
                        .padding(.top, 70)
                    
                    Text("An OTP is sent to your email/phone.\nVerify your account by entering that code.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { index in
                            TextField("", text: $otp[index])
                                .frame(width: 40, height: 40)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($focusedField, equals: index)
                                .onChange(of: otp[index]) { newValue in
                                    if newValue.count > 1 {
                                        otp[index] = String(newValue.last!)
                                    }
                                    if !newValue.isEmpty && index < 5 {
                                        focusedField = index + 1
                                    }
                                    if index == 5 && newValue.count == 1 {
                                        verifyOTP()
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 15) {
                        // Verify Button
                        Button(action: {
                            verifyOTP()
                        }) {
                            Text("Verify")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#AB886D"))
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isOTPIncorrect ? Color.red : Color.clear, lineWidth: 2)
                                )
                        }
                        .disabled(otp.joined().count != 6)
                        
                        // Resend OTP Button
                        Button(action: {
                            resendOTP()
                        }) {
                            Text(timerActive ? "Resend OTP in \(timeRemaining)s" : "Resend OTP")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(timerActive ? Color.gray : Color(hex: "#AB886D"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(timerActive ? Color.gray : Color(hex: "#AB886D"), lineWidth: 1)
                                )
                        }
                        .disabled(timerActive)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding()
                .onAppear {
                    focusedField = 0
                }
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        timerActive = false
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            if isOTPVerified {
                                navigateToDashboard = true
                            }
                        }
                    )
                }
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                switch role {
                case "SuperAdminDashboard":
                    SuperAdminDashboard()
                case "AdminDashboard":
                    AdminDashboard()
                case "LibrarianDashboard":
                    LibrarianDashboard()
                case "MemberHomeView":
                    MemberHomeView()
                default:
                    EmptyView()
                }
            }
        }
    }
    
    func verifyOTP() {
        let enteredOTP = otp.joined()
        
        // Dummy OTP validation
        if enteredOTP == "654321" && role == "SuperAdminDashboard" ||
           enteredOTP == "543210" && role == "AdminDashboard" ||
           enteredOTP == "765432" && role == "LibrarianDashboard" ||
           enteredOTP == "123456" && role == "MemberHomeView" {
            isOTPVerified = true
            isOTPIncorrect = false
            alertMessage = "OTP Verified! Redirecting to your dashboard..."
        } else {
            isOTPIncorrect = true
            alertMessage = "Incorrect OTP. Please try again."
        }
        showAlert = true
    }
    
    func resendOTP() {
        timeRemaining = 30
        timerActive = true
        alertMessage = "A new OTP has been sent to your email/phone."
        showAlert = true
    }
}

#Preview {
    OTPView(role: "SuperAdminDashboard")
}
