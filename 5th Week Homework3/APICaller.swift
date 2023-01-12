//
//  APICaller.swift
//  5th Week Homework3
//
//  Created by Murat Ceyhun Korpeoglu on 11.01.2023.
//

import Foundation

//MARK: - Here is the url that fetching all data.
//https://newsapi.org/v2/top-headlines?country=tr&apiKey=20ae9fc404a44ba48b546fe0888c55d6

final class APICaller {
    static let shared = APICaller()
    private struct Constants {
        static let apiKey = "20ae9fc404a44ba48b546fe0888c55d6"
        static let baseURL = "https://newsapi.org/v2/top-headlines?"
        static let country = "country=us"
    }
    
    private init() {}
    
    public func getNews(completion: @escaping (Result<[Article],Error>) -> Void) {
        guard let url = URL(string: Constants.baseURL + Constants.country + "&apiKey=" + Constants.apiKey) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("********* \(result.articles.count)")
                    completion(.success(result.articles))
                }
                
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}


//Models


struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: Source
}

struct Source: Codable {
    let name: String?
}
