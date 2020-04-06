import Foundation
import CZUtils

public class Feed: Codable, CustomStringConvertible
//, Identifiable
{
  static let mocks = (0..<1).map { Feed(title: "Feed\($0)") }
  
  public var id = UUID()
  public let title: String
  public var isLiked: Bool
  
  public init(title: String, isLiked: Bool = false) {
    self.title = title
    self.isLiked = isLiked
  }
}
