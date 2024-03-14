//
//  NetworkManager.swift
//  weairy
//
//  Created by do hee kim on 2024/03/14.
//

import Combine
import Foundation

import Moya

protocol NetworkManager {
    func request<Provider: TargetType, T: Decodable>(
        target: Provider,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}

final class NetworkManagerImpl: NetworkManager {
    
    struct Providers {
        let weatherProvider: MoyaProvider<WeatherAPI>
    }
    
    private let providers: Providers
    
    init(providers: Providers) {
        self.providers = providers
    }
    
}

extension NetworkManagerImpl {
    
    func request<Provider: TargetType, T: Decodable>(
        target: Provider,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        let provider = getProvider(for: target)
        
        return Future<T, NetworkError> { promise in
            provider.request(target) { [weak self] result in
                guard let `self` else { return }
                
                switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    
                    guard 200...299 ~= statusCode else {
                        guard let error = NetworkError(rawValue: statusCode) else {
                            return promise(.failure(.unexpectedServerError))
                        }
                        
                        return promise(.failure(error))
                    }
                    
                    let decodedData = decode(responseType.self, data: response.data)
                    
                    switch decodedData {
                    case .success(let success):
                        print("디코딩 완", success)
                        return promise(.success(success))
                        
                    case .failure(let failure):
                        print("디코딩 실패", failure)
                        return promise(.failure(.decodingFail))
                    }
                    
                case .failure(let error):
                    print("요청 실패", error)
                    return promise(.failure(.requestFail))
                }
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func getProvider<T: TargetType>(for target: T) -> MoyaProvider<T> {
        switch target {
        case is WeatherAPI:
            guard let provider = providers.weatherProvider as? MoyaProvider<T> else { return MoyaProvider<T>() }
            return provider
        default:
            fatalError("Unsupported type")
        }
    }
    
}

extension NetworkManagerImpl {
    
    private func decode<T: Decodable>(_ type: T.Type, data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(type, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
    
}

class StubNetworkManager {
    static var networkManager: NetworkManager = NetworkManagerImpl(
        providers: NetworkManagerImpl.Providers(
            weatherProvider: MoyaProvider<WeatherAPI>()
        )
    )
}
