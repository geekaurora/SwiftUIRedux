import SwiftUI

/**
 https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
 
 ### Usage
 
 struct ContentView: View {

     var body: some View {
         // LoadingView(isShowing: $feedListState.isLoading) {
         LoadingView(isShowing: .constant(true)) {
             NavigationView {
                 List(["1", "2", "3", "4", "5"], id: \.self) { row in
                     Text(row)
                 }.navigationBarTitle(Text("A List"), displayMode: .large)
             }
         }
     }
 }
 */
public struct ActivityIndicator: UIViewRepresentable {
  @Binding public var isAnimating: Bool
  public let style: UIActivityIndicatorView.Style
  
  public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: style)
  }
  
  public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}

public struct LoadingView<Content>: View where Content: View {  
  public typealias ContentBlock = () -> Content
  
  @Binding
  public var isShowing: Bool
  public var content: ContentBlock
  
//  public init(isShowing: Bool, content: @escaping () -> Content) {
//    self.content = content
//    self.isShowing = isShowing
//  }
    
  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center) {
        
        self.content()
          .disabled(self.isShowing)
          .blur(radius: self.isShowing ? 3 : 0)
        
        VStack {
          Text("Loading...")
          ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
        .frame(width: geometry.size.width / 2,
               height: geometry.size.height / 5)
          .background(Color.secondary.colorInvert())
          .foregroundColor(Color.secondary)
          .cornerRadius(15)
          .opacity(self.isShowing ? 1 : 0)
        
      }
    }
  }
  
}
