//
//  NetworkService.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 02.04.2022.
//

import Foundation
protocol Networking {
    func request(completion: @escaping ([GetModel]) -> Void)
}

class NetworkService: Networking {
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(completion: @escaping ([GetModel]) -> Void) {
        guard let token = authService.token else { return }
        let params = ["owner_id" : "-128666765", "album_id" : "266276915"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = url(params: allParams)
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                if let currentModel = self.parsJson(withData: data){
                    completion(currentModel)
                }
            }
        }
        task.resume()
    }
    
    func parsJson(withData data: Data) -> [GetModel]? {
        let decoder = JSONDecoder()
        do {
            let currentData = try decoder.decode(Models.self, from: data)
            var arrayInfoData = [GetModel]()
            for i in currentData.response.items {
                arrayInfoData.append(GetModel(info: i))
            }
            return arrayInfoData
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func url(params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photosGet
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
