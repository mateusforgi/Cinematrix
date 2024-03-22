//
//  NetworkClient.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//


import Foundation

protocol NetworkClient: AnyObject {
	func get<T: Codable>(_ urlRequest: URLRequest) async throws -> T
}
