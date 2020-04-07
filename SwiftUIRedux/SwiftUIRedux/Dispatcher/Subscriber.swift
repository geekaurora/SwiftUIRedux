import SwiftUIKit

/// Protocol of Subscriber.
public protocol SubscriberProtocol: NSObjectProtocol {
  /// Reacts to the `action`. Note that subscribers can filter action and choose whether to respond.
  func reduce(action: ReduxActionProtocol)
}

/// Base class of Subscriber that subscribes to the root store automatically when init, and unsubscribes  automatically when deinit.
open class Subscriber: NSObject, SubscriberProtocol {
  
  public override init() {
    super.init()
    // Subscribes to the root store, and it will unsubscribe itself automatically when deinit.
    RootStore.shared.addSubscriber(self)
  }
  
  open func reduce(action: ReduxActionProtocol) {
    assertionFailure("\(#function) should be overriden in subclass.")
  }
  
}
