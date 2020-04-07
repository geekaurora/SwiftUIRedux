import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

class NotificationDetailsState: Subscriber, ObservableObject {
  @Published var notification: Notification
  
  init(notification: Notification) {
    self.notification = notification
  }
  
  public override func reduce(action: ReduxActionProtocol) {
    self.notification = notification.codableCopy().reduce(action: action)
    //self.notification = notification.reduce(action: action)
  }
}
