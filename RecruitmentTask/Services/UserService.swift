//
//  UserService.swift
//  RecruitmentTask
//
//  Created by gese on 04/09/2021.
//

import Foundation

protocol UserService {
    func queryUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class RealUserService: UserService {
    let getUsersUrl = "https://reqres.in/api/users?page=1"

    private var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func queryUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: getUsersUrl) else {
            completion(.failure(NetworkError.wrongUrlError))
            return
        }

        let task = session.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(NetworkError.serverError("Network request failed")))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.missingData))
                return
            }

            var result: UserQueryResponse?

            do {
                result = try JSONDecoder().decode(UserQueryResponse.self, from: data)
                completion(.success(result?.data ?? []))
            } catch {
                completion(.failure(NetworkError.decodingError("Could not decode data")))
            }
        }

        task.resume()
    }
}
