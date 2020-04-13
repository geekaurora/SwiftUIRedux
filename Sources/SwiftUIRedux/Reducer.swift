import Foundation

/// Protocol that defines Redux Reducer.
/// It will receive `ReduxAction` dispatched from the root store after subscribe.
///
/// - Note:
/// `ReduxReducerProtocol` conformance is normally RootState of RootView for each feature which is equivalant to FeatureControllerViewModel.
///
/// Convenient implementation is to subclass `ReduxReducer` to be subscribed to the root store automatically.
/// If you class implements`ReduxReducerProtocol` manually, be sure to subscibe itself to the root store when init.
public protocol ReduxReducerProtocol: class {
  /// Reduces the `action`. Note that reducer can filter action and choose how to process.
  func reduce(action: ReduxActionProtocol)
}

/// Base ReduxReducer that subscribes to the root store automatically when init, and unsubscribes automatically
/// when deinit.
open class ReduxReducer: ReduxReducerProtocol {
  
  /// Required initializer of ReduxReducer, make sure to call `super.init()` in subclass.
  public required init() {
    // Subscribes to the root store, will unsubscribe itself automatically when deinit.
    ReduxRootStore.shared.subscribe(self)
  }
  
  /// Reduces the `action`. Note that reducer can filter action and choose how to process.
  open func reduce(action: ReduxActionProtocol) {
    fatalError("`\(#function)` should be overriden in subclass - `\(type(of: self))`.")
  }
}
