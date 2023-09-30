//
//  LoginResponseMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 10.08.2023..
//

import Foundation
@testable import GitHubRxApp

class LoginResponseMock {
    // User items
    private var login: String? = "gabbartose"
    private var name: String? = "Gabrijel Bartošek"

    // Dictionary items
    private var accessToken: String? = "ghu_Auf56oTYGf1bJ3iCm0GlDaTszREWLA0Vq82D"
    private var expiresIn: String? = "28800"
    private var refreshTokenExpiresIn: String? = "15897600"
    private var scope: String? = ""
    private var refreshToken: String? = "ghr_85yZFcP59mgK6M8IJAE0Xla06baWtEdaWTk0Fsy2wA6fDgAMikkwBWBlorzrxC6kMaRSdz0SpeuB"
    private var tokenType: String? = "bearer"

    let codeExchangeURL = URL(string: "https://github.com/login/oauth/access_token?client_id=Iv1.03eda0e0b6c3100b&client_secret=370d1b2a85339484e0bb76c26a214ffbac09a388&code=6dc273fefba092a2a1d9")

    let userURL = URL(string: "https://api.github.com/user")

    func getUserResponse() -> User {
        return User(login: login ?? "",
                    name: name ?? "")
    }

    func getUserResponseJsonString() -> String {
          """
          {
            "login": "\(login ?? "")",
            "name": "\(name ?? "")"
          }
          """
    }

    func getSuccessStringResponse() -> String {
          """
          {
            "Success"
          }
          """
    }

    func getReturnedDictionaryResponse() -> String {
        let dictionary =
            """
            {
                [
                    "access_token": "\(accessToken ?? "")",
                    "expires_in": "\(expiresIn ?? "")",
                    "refresh_token_expires_in": "\(refreshTokenExpiresIn ?? "")",
                    "scope": "\(scope ?? "")",
                    "refresh_token": "\(refreshToken ?? "")",
                    "token_type": "\(tokenType ?? "")",
                ]
            }
            """
        return dictionary
    }
}
