import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

class NotificationDetailsState: ReduxSubscriber, ObservableObject {
  @Published var notification: Notification
  
  override init() { fatalError("init() has not been implemented") }

  init(notification: Notification) {
    self.notification = notification
    super.init()
  }
    
  public override func reduce(action: ReduxActionProtocol) {
    self.notification = notification.codableCopy().reduce(action: action)
  }
}
