
import Foundation

extension String {
    var latinCharactersOnly: Bool {
        return self.range(of: "\\P{Latin}", options: .regularExpression) == nil
    }
}
