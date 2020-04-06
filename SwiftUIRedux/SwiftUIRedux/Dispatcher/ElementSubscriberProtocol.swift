import SwiftUIKit
import SwiftUI
import Combine

/// Protocol of Subscriber.
public protocol ElementSubscriberProtocol: NSObjectProtocol {

  /// React to the `action`. Note that subscribers can filter action and choose whether to respond.
  func reduce(action: ElementDispatcherAction)
  
}
