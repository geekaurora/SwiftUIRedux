import CZUtils

/// Middleware that transforms DispatchFunction.
///
/// - Note:
///   When implement Middleware, should call `dispatchFunction`, otherwise the actual `dispatchFunction` won't be executed.
public typealias Middleware = (_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction

/// Dispatch function that dispatchs Action.
public typealias DispatchFunction = (ReduxActionProtocol) -> Void
