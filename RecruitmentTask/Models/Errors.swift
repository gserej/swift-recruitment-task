//
//  Errors.swift
//  RecruitmentTask
//
//  Created by gese on 05/09/2021.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case wrongUrlError
    case serverError(String)
    case missingData
    case decodingError(String)
}
