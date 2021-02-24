import Foundation

/// Protocol that defines Redux State.
public protocol ReduxStateProtocol {
  /// Reduce pure function that generates new State of self with the input `action`.
  /// i.e. (oldState, action) => newState
  ///
  /// - Note:
  /// Recommendation is to define conformer as `struct` and return deep copy of self,  i.e. let newSelf = self,
  /// so avoid duplicate mutations on the same instance if `self` is reference type.
  /// If you have to use reference type, workaround is to return deep copy of `self`.
  ///
  /// For example, if FeedList/FeedDetails shares the same `Feed` class reference, LikeFeed action
  /// in FeedDetails will possibly mutate `Feed` instance twice trigged by `reduce(action:)` function
  /// in both FeedList/FeedDetails.
  ///
  /// - Parameter action: The action to be reduced.
  /// - Returns: The new State of self after reducing `action`.
  @discardableResult
  func reduce(action: ReduxActionProtocol) -> Self
}
