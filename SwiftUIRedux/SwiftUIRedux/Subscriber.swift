import SwiftUIKit

/// Protocol of Subscriber.
public protocol SubscriberProtocol: NSObjectProtocol {
  /// Reacts to the `action`. Note that subscribers can filter action and choose whether to respond.
  @discardableResult
  func reduce(action: ReduxActionProtocol) -> Self
}

/// Base Subscriber that subscribes to the root store automatically when init, and unsubscribes  automatically when deinit.
open class Subscriber: NSObject, SubscriberProtocol {
  
  public override init() {
    super.init()
    
    // Subscribes to the root store, and it will unsubscribe itself automatically when deinit.
    RootStore.shared.subscribe(self)
  }
  
  @discardableResult
  open func reduce(action: ReduxActionProtocol)  -> Self {
    assertionFailure("`\(#function)` should be overriden in subclass - `\(type(of: self))`.")
    return self
  }
  
}
