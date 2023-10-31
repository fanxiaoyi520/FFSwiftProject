//
//  NetworkManager.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SVProgressHUD

class NetworkManager {
    static let shared = NetworkManager()

    private var defaultHeaders: HTTPHeaders {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    private init() {}

    func request<T: HandyJSON>(url: String,
                               method: HTTPMethod,
                               parameters: [String: Any]? = nil,
                               additionalHeaders: HTTPHeaders? = nil,
                               success: ((ResponseModel<T>?) -> Void)? = nil,
                               failure: ((Error) -> Void)? = nil) {
        let inputUrl = "\(BaseUrl)\(url)"
        
        var headers = defaultHeaders
        
        // 合并默认请求头和添加的请求头
        additionalHeaders?.forEach { header in
            headers.add(header)
        }
        
        if (FFUserManager.shared.currentToken != nil) {
            headers.add(HTTPHeader(name: "Authorization", value: FFUserManager.shared.currentToken?.token ?? ""))
        }
        SVProgressHUD.show()
        let completionHandler: (AFDataResponse<Data?>) -> Void = { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let data):
                if let data = data {
                    let jsonString = String(data: data, encoding: .utf8)
                    let json = JSONDeserializer<ResponseModel<T>>.deserializeFrom(json: jsonString)
                    if (json?.status == 401) {FFUserManager.shared.logout()}
                    json?.jsonString = jsonString
                    success?(json)
                } else {
                    success?(nil)
                }
                
            case .failure(let error):
                failure?(error)
            }
        }
    
        var encoding : ParameterEncoding = JSONEncoding.default
        if (method == .get && parameters != nil) {encoding = URLEncoding.default}
        AF.request(inputUrl, method: method, parameters: parameters, encoding: encoding,headers: headers).validate().response(completionHandler: completionHandler)
    }
}
