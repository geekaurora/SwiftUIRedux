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
          Text("Home")
      }
      
      NotificationListView()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Explore")
      }
    }
    .font(.headline)
  }
}
