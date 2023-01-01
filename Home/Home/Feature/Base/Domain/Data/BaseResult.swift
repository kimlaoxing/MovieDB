import Foundation

struct BaseResult: Equatable, Identifiable {
    let id: Int
    let title: String
    let poster_path: String
    let release_date: String
    let popularity: Int
    let total_pages: Int
    let page: Int
}
