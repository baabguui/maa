//
//  MapleAPI.swift
//  maa
//
//  Created by baabguui on 8/17/24.
//

import Foundation

// TODO: - 캐릭터 식별자(ocid) 조회 리퀘 날리고 -> ocid로 새로 리퀘 날려서 정보 받아와야함. -> 그리고 저장 (앱 열때 조회시간 15분 지난 상태면 새로 조회해야 함. 그래서 저장 시간 타임스탬프 필요)

@Observable class MapleAPI {
    var heroInfo: HeroInfo?
    var characterOcid: String?
    
    let baseUrl = "https://open.api.nexon.com/maplestory/"
    let headers = [
        "accept": "application/json",
        "x-nxopen-api-key": "\(Bundle.main.infoDictionary?["API_KEY"] ?? "NO KEY")"
    ]
    
    // MARK: - 캐릭터 이름으로 ocid 가져오기
    func getCharacterOcid(characterName: String, completion: @escaping (HeroInfo) -> Void) {
        guard var url = URL(string: "\(baseUrl)v1/id")
        else { fatalError("Missing URL")}

        let query: [URLQueryItem] = [URLQueryItem(name: "character_name", value: characterName)]
        url.append(queryItems: query)

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest)
        {(data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    do {
                        let decodedInfo = try JSONDecoder().decode([String:String].self, from: data)
                        self.characterOcid = decodedInfo.values.first
                        guard let ocid = self.characterOcid else { return }
                        
                        self.getCharacterInfo(ocid: ocid) { result in
                            completion(result)
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else { return print(response.statusCode) }
        }
        dataTask.resume()
    }
    
    // TODO: - 이런거 원래 같이 두나
    var dateQuery:String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    // MARK: - ocid로 캐릭터 정보 가져오기
    func getCharacterInfo(ocid: String, completion: @escaping (HeroInfo)-> Void) {
        print("2번 함수 도착, \(ocid)")
        guard var url = URL(string: "\(baseUrl)v1/character/basic")
        else { fatalError("Missing URL")}
        
        let query: [URLQueryItem] = [
            URLQueryItem(name: "ocid", value: ocid)
            /*URLQueryItem(name: "date", value: dateQuery)*/]
        url.append(queryItems: query)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest)
        {(data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    do {
                        let decodedInfo = try JSONDecoder().decode(HeroInfo.self, from: data)
                        self.heroInfo = decodedInfo
                        guard let hero = self.heroInfo else { return }
                        
                        completion(hero)
                    } catch let error {
                        print("2 Error decoding: ", error)
                    }
                }
            } else { return print(response.statusCode) }
        }
        dataTask.resume()
    }
}
