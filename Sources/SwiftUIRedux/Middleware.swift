import CZUtils

/// Middleware that transforms DispatchFunction.
///
/// - Note:
///   When implement Middleware, should call `nextDispatchFunction`, otherwise the `nextDispatchFunction` won't be executed.
public typealias Middleware = (_ nextDispatchFunction: @escaping DispatchFunction) -> DispatchFunction

/// Dispatch function that dispatchs Action.
public typealias DispatchFunction = (ReduxActionProtocol) -> Void
