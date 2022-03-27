//
//  APIError.swift
//  DailyNewsApp
//
//  Created by Serkan on 24.03.2022.
//

import Foundation


enum NError: String, Error{
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidResponse = "iInvalid response from the server. Please try again."
    case invalidComplete = "Unable to complete your request. Please check your internet connection"
}
