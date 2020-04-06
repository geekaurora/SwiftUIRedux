import SwiftUI
import Combine

import CZUtils
import SwiftUIKit

public typealias ElementSubscriberObject = NSObject & ElementSubscriberProtocol

/// Root dispatcher of the app, responsible to notify SubDispatchers - tabs.
///
/// - Note:
/// Dispatcher only holds weak reference to subscribers, no need to explicitly call `removeSubscriber()` when deinit.
public class ElementRootDispatcher {

  public static var shared = ElementRootDispatcher()

  private var subscribers = NSHashTable<AnyObject>.weakObjects()

  public func dispatch(action: ElementDispatcherAction = ElementDispatcherReloadAction()) {
    // Notify all subscribers. Note that subscribers can filter action and choose whether to respond.
    subscribers.allObjects
      .compactMap { ($0 as? ElementSubscriberObject).assertIfNil }
      .forEach { $0.reduce(action: action) }
  }

  public func addSubscriber(_ subscriber: ElementSubscriberObject) {
    guard !containsSubscriber(subscriber) else { return }
    subscribers.add(subscriber)
  }

  public func removeSubscriber(_ subscriber: ElementSubscriberObject) {
    subscribers.remove(subscriber)
  }

  public func containsSubscriber(_ subscriber: ElementSubscriberObject) -> Bool {
    return subscribers.contains(subscriber)
  }

}
