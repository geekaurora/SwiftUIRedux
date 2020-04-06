import SwiftUI

public class Feed: Identifiable {
  public let id = UUID()
  public let title: String
  public var isLiked: Bool
  
  public init(title: String, isLiked: Bool = false) {
    self.title = title
    self.isLiked = isLiked
  }
}

struct FeedCell: View {
  var body: some View {
    Text("Hello, World!")
  }
}

struct FeedListView: View {
  var body: some View {
    
    List {
      ForEach(0..<20) { id in
        FeedCell()
      }
    }
  }
}

struct FeedListView_Previews: PreviewProvider {
  static var previews: some View {
    FeedListView()
  }
}
