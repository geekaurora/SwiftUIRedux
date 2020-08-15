import CZUtils

/// Middleware that transforms DispatchFunction.
///
/// - Note:
///   When implement Middleware, should call `dispatchFunction`, otherwise the actual `dispatchFunction` won't be executed.
public typealias Middleware = (_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction

/// Dispatch function that be used to dispatch Action.
public typealias DispatchFunction = (ReduxActionProtocol) -> Void
