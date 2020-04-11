import Foundation

public extension NSCopying {
  func deepCopy(with zone: NSZone? = nil) -> Self {
    return copy(with: zone) as! Self
  }
}
