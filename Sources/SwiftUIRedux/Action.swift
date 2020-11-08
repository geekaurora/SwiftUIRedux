import Foundation

// MARK: - ReduxAction

/// Protocol that defines Redux Action.
public protocol ReduxActionProtocol {
  /// The wrapper of context be used to differentiate the source of the action.
  /// If multiple States share the same RootStore, you can pass`context` to the corresponding State,
  /// so action can be handled within the domain.
  /// If action isn't bound to specific domain, return nil as contextWrapper.
  var contextWrapper: ReduxActionContextWrapper? { get }
}

/// Wrapper that holds the weak reference of `ReduxActionContext`.
public class ReduxActionContextWrapper {
  public private(set) weak var context: ReduxActionContext?
  public init(_ context: ReduxActionContext?) {
    self.context = context
  }
}

// MARK: - ReduxAsyncActionProtocol

/// Protocol that defines async Redux Action.
public protocol ReduxAsyncActionProtocol: ReduxActionProtocol {}

/// Async Redux Action that can be excuted automatically by Thunk Middleware.
public struct ReduxAsyncBlockAction: ReduxAsyncActionProtocol {
  public let type: String
  public let executionBlock: () -> Void
  public let contextWrapper: ReduxActionContextWrapper?
  public init(type: String,  executionBlock: @escaping () -> Void, contextWrapper: ReduxActionContextWrapper? = nil) {
    self.type = type
    self.executionBlock = executionBlock
    self.contextWrapper = contextWrapper
  }
}

// MARK: - ReduxActionContext

/// The context be used to differentiate the source of the action.
public protocol ReduxActionContext: class {}
