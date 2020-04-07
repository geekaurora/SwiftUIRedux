import SwiftUI

// MARK: - Text

struct HeadlineTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .foregroundColor(Color(white: 0.25))
  }
}

struct ContentTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(Color(white: 0.15))
  }
}

// MARK: - Button

struct NormalButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .buttonStyle(BorderlessButtonStyle())
      //.foregroundColor(.blue)
  }
}

