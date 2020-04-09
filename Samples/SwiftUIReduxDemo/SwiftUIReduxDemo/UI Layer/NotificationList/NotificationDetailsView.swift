import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct NotificationDetailsView: View {
  @ObservedObject var state: NotificationDetailsState
  
  init(notification: Notification) {
    self.state = NotificationDetailsState(notification: notification)
  }
  
  var body: some View {
    print(state.notification.feed)    
    return NotificationCell(notification: state.notification)
  }
}
