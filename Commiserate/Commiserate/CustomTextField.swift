//
//  CustomTextField.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import Foundation
import SwiftUI

public enum TextFieldType {
    case phone
    case password
    case plain
    case email
    
    var errorMessage: String {
        switch self {
        case .phone:
            "Lütfen geçerli bir telefon numarası giriniz."
        case .password:
            "Şifreniz en az 8 karakter olmalı ve büyük harf, küçük harf, rakam, özel bir karakter içermelidir."
        case .plain:
            "Eksik yada yanlış giriş yaptınız."
        case .email:
            "Lütfen geçerli bir email adresi giriniz."
        }
    }
}

public struct BorderedTextField: View {
    var hint: String = ""
    var image: String?
    var imageTint: Color?
    var trailingItem: String?
    var type: TextFieldType = .plain
    @Binding var showPassword: Bool
    @Binding var isValid: Bool
    var keyboardType: UIKeyboardType
    @Binding var text: String
    @Binding var showWarning: Bool
    @FocusState private var isFocused: Bool
    
    public init(
        hint: String,
        image: String? = nil,
        imageTint: Color? = .black,
        text: Binding<String>,
        trailingItem: String? = nil,
        type: TextFieldType = .plain,
        showPassword: Binding<Bool> = .constant(false),
        isValid: Binding<Bool> = .constant(true),
        showWarning: Binding<Bool> = .constant(false),
        keyboardType: UIKeyboardType = .alphabet
    ) {
        self.hint = hint
        self.image = image
        self.imageTint = imageTint
        self._text = text
        self.trailingItem = trailingItem
        self.type = type
        self._showPassword = showPassword
        self._isValid = isValid
        self._showWarning = showWarning
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                if let image = image, let tint = imageTint {
                    Image(image)
                        .foregroundStyle(isValid ? tint : .white)
                        .padding(.top, 15)
                }
                
                switch type {
                case .phone:
                    TextField(text.isEmpty && !isFocused ? "" : "(5xx) xxx xx xx", text: $text)
                        .borderedTextFieldHintStyle(showPlaceHolder: text.isEmpty && !isFocused, hint: hint, hintTextColor: isValid ? .gray:.red, isValid: isValid)
                        .accentColor(.black)
                        .autocorrectionDisabled(true)
                        .keyboardType(.numberPad)
                        .focused($isFocused, equals: true)
                        .onSubmit {
                            isFocused = false
                        }
                case .password:
                    HStack {
                        Group {
                            if showPassword {
                                TextField("", text: $text)
                            } else {
                                SecureField("", text: $text)
                            }
                        }
                        .borderedTextFieldHintStyle(showPlaceHolder: text.isEmpty && !isFocused, hint: hint, hintTextColor: isValid ? .gray : .red, isValid: isValid)
                        .accentColor(.black)
                        .autocorrectionDisabled(true)
                        .keyboardType(.numberPad)
                        .focused($isFocused, equals: true)
                        .onSubmit {
                            isFocused = false
                        }
                        
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            Image(showPassword ? "openEye" : "closedEye")
                                .foregroundStyle(Color.gray)
                        }
                    }
                        
                default:
                    TextField("", text: $text)
                        .borderedTextFieldHintStyle(showPlaceHolder: text.isEmpty && !isFocused, hint: hint, hintTextColor: isValid ? .gray : .red, isValid: isValid)
                        .accentColor(.black)
                        .autocorrectionDisabled(true)
                        .keyboardType(keyboardType)
                        .focused($isFocused, equals: true)
                        .onSubmit {
                            isFocused = false
                        }
                }
                
                if let trailingItem = trailingItem {
                    Text(trailingItem)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.black)
                        .padding(.top)
                }
            }
            .padding(.horizontal, 8)
            .frame(height: 48)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(isValid ? (text.isNotEmptyString() ? Color.black: Color.gray) : .red)
            }
            
            if showWarning, !isValid {
                Label(
                    title: { Text(type.errorMessage) },
                    icon: { Image(systemName: "exclamationmark.circle") }
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.red)
                .padding(.top, 5)
                .padding(.leading, 5)
            }
        }
        .onTapGesture {
            withAnimation {
                isFocused.toggle()
                isValid = true
            }
        }
        .onChange(of: text) { newNumber in
            guard type == .phone  else { return }
            if text.count == 1, text != "5" {
                text = ""
                return
            } else if text.count > 10 {
                text = String(text.prefix(10))
                return
            }
            let plainText = newNumber.removeWhitespace().replace(string: "(", replacement: "").replace(string: ")", replacement: "")
            guard plainText.count != text.count else { return }
            text = plainText
        }
    }
}

public struct BorderedTextFieldHintModifier: ViewModifier {
    public var showPlaceHolder: Bool
    public var hint: String
    public var hintTextColor: Color
    public var textColor: Color
    public var isValid: Bool

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            Text(hint)
                .foregroundStyle(isValid ? hintTextColor : .red)
                .padding(.horizontal, hint.isEmpty ? 0 : 2)
                .background(showPlaceHolder ? Color.clear : Color.white)
                .offset(y: showPlaceHolder ? 0 : -30)
                .scaleEffect(showPlaceHolder ? 1 : 0.8, anchor: .leading)
            content
                .foregroundStyle(textColor)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .animation(.default, value: showPlaceHolder)
    }
}

extension View {
    public func borderedTextFieldHintStyle(showPlaceHolder: Bool, hint: String, hintTextColor: Color = .gray, textColor: Color = .black, isValid: Bool = true) -> some View {
        modifier(BorderedTextFieldHintModifier(showPlaceHolder: showPlaceHolder, hint: hint, hintTextColor: hintTextColor, textColor: textColor, isValid: isValid))
    }
}

extension String {
    public func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    public func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    public func isNotEmptyString() -> Bool {
        return !self.isEmpty
    }
}
