import SwiftUI

// MARK: - Text

struct HeadlineTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
     .font(.headline)
  }
}

// MARK: - Button

struct NormalButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
     .foregroundColor(.blue)
  }
}

