import Foundation

class Job: Decodable {
    let id: Int
    let name: String
    var applied = false

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
