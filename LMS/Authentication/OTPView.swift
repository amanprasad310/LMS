//
//  OTPView.swift
//  LMS
//
//  Created by Rounak Azad on 15/02/25.
//

import SwiftUI

struct OTPView: View {
    @State private var otp = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?

    var body: some View {
        ZStack {
            Image("Image1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Verify OTP")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("#AB886D"))
                    .padding(.bottom, 5)
                
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
                    }
                    
                    Button(action: {
                        resendOTP()
                    }) {
                        Text("Resend OTP")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color(hex: "#AB886D")) // Same as Verify button color
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#AB886D"), lineWidth: 1) // Thin border
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .padding()
            .onAppear {
                focusedField = 0
            }
        }
    }
    
    func verifyOTP() {
        print("OTP Verified: \(otp.joined())")
    }
    
    func resendOTP() {
        print("OTP Resent")
    }
}


#Preview {
    OTPView()
}
