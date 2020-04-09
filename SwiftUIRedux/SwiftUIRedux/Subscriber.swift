import SwiftUIKit

public typealias ReduxSubscriberObject = ReduxSubscriberProtocol & NSObject

public protocol ReduxSubscriberProtocol: NSObject {
  func reduce(action: ReduxActionProtocol)
}

/// Base ReduxSubscriber that subscribes to the root store automatically when init, and unsubscribes  automatically when deinit.
///
/// - Note:
/// Redux subscriber is normal RootState of RootView for each feature which is equivalant to FeatureViewController.
open class ReduxSubscriber: NSObject, ReduxSubscriberProtocol {
  
  required public override init() {
    super.init()
    
    // Subscribes to the root store, and it will unsubscribe itself automatically when deinit.
    ReduxRootStore.shared.subscribe(self)
  }
  
  /// Reacts to the `action`. Note that subscribers can filter action and choose whether to respond.
  open func reduce(action: ReduxActionProtocol) {
    fatalError("`\(#function)` should be overriden in subclass - `\(type(of: self))`.")
  }
  
}
