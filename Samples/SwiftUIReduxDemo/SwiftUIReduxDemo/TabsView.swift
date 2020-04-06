import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct TabsView: View {
  
  var body: some View {
    TabView {
      FeedListView()
        .tabItem {
          Image(systemName: "house")
          Text("Feeds")
      }
      
      NotificationListView()
        .tabItem {
          Image(systemName: "message")
          Text("Notifications")
      }
    }
    .font(.headline)
  }
}
