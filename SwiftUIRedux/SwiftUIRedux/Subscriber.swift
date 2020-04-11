import SwiftUIKit

/// Protocol that defines Redux Subscriber.
public protocol ReduxSubscriberProtocol: class {
  /// Reduces the `action`. Note that subscriber can filter action and choose how to process.
  func reduce(action: ReduxActionProtocol)
}

/// Base ReduxSubscriber that subscribes to the root store automatically when init, and unsubscribes automatically
/// when deinit.
///
/// - Note:
/// `ReduxSubscriber` is normally RootState of RootView for each feature which is equivalant to FeatureControllerViewModel.
open class ReduxSubscriber: ReduxSubscriberProtocol {
  
   public init() {    
    // Subscribes to the root store, will unsubscribe itself automatically when deinit.
    ReduxRootStore.shared.subscribe(self)
  }
  
  /// Reduces the `action`. Note that subscriber can filter action and choose how to process.
  open func reduce(action: ReduxActionProtocol) {
    fatalError("`\(#function)` should be overriden in subclass - `\(type(of: self))`.")
  }
}
