//
//  TLBlockchainAPI.swift
//  ArcBit
//
//  Created by Timothy Lee on 3/14/15.
//  Copyright (c) 2015 Timothy Lee <stequald01@gmail.com>
//
//   This library is free software; you can redistribute it and/or
//   modify it under the terms of the GNU Lesser General Public
//   License as published by the Free Software Foundation; either
//   version 2.1 of the License, or (at your option) any later version.
//
//   This library is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//   Lesser General Public License for more details.
//
//   You should have received a copy of the GNU Lesser General Public
//   License along with this library; if not, write to the Free Software
//   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301  USA

import Foundation
class TLBlockchainAPI {
    
    struct STATIC_MEMBERS {
        static let BLOCKCHAIN_ENDPOINT_ADDRESS = "address/"
        static let BLOCKCHAIN_ENDPOINT_TX = "tx/"
        static let BC_REQ_FORMAT  = "format"
        static let BC_REQ_ACTIVE  = "active"
    }
    
    var networking:TLNetworking
    var baseURL:String
    
    init(baseURL: String) {
        self.networking = TLNetworking()
        self.baseURL = baseURL
    }
    
    func getBlockHeight(success: TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> (){
        let endPoint = "q/getblockcount"
        let parameters = [:]
        let url = NSURL(string: endPoint, relativeToURL:NSURL(string:self.baseURL))
        
        self.networking.httpGET(url!, parameters:parameters,
            success: {(jsonData:AnyObject!) in
                success(jsonData!)
            }, failure:{(code:NSInteger, status:String!) in
                if (code == 200) {
                    success(status)
                } else {
                    failure(code, status)
                }
        })
    }
    
    func getAddressData(address:String, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = String(format:"%@%@", STATIC_MEMBERS.BLOCKCHAIN_ENDPOINT_ADDRESS, address)
        let parameters = [
            STATIC_MEMBERS.BC_REQ_FORMAT: "json"
        ]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func getAddressDataSynchronous(address:String) -> NSDictionary {
        let endPoint = String(format:"%@%@", STATIC_MEMBERS.BLOCKCHAIN_ENDPOINT_ADDRESS, address)
        let parameters = [
            STATIC_MEMBERS.BC_REQ_FORMAT: "json"
        ]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        return self.networking.httpGETSynchronous(url!, parameters:parameters) as! NSDictionary
    }
    
    func getTx(txHash:String, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = String(format:"%@%@", STATIC_MEMBERS.BLOCKCHAIN_ENDPOINT_TX, txHash)
        let parameters = [
            STATIC_MEMBERS.BC_REQ_FORMAT: "json"
        ]
        
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func getTxBackground(txHash:String, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = String(format:"%@%@", STATIC_MEMBERS.BLOCKCHAIN_ENDPOINT_TX, txHash)
        let parameters = [
            STATIC_MEMBERS.BC_REQ_FORMAT: "json"
        ]
        
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpGETBackground(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func pushTx(txHex:String, txHash:String, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = "pushtx"
        let parameters = [
            STATIC_MEMBERS.BC_REQ_FORMAT: "plain",
            "tx":txHex
        ]
        
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpPOST(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func getUnspentOutputsSynchronous(addressArray:NSArray) -> NSDictionary {
        let endPoint = "unspent"
        let parameters = [
            STATIC_MEMBERS.BC_REQ_ACTIVE:addressArray.componentsJoinedByString("|")
        ]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        return self.networking.httpGETSynchronous(url!, parameters:parameters) as! NSDictionary
    }
    
    func getUnspentOutputs(addressArray:Array<String>, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = "unspent"
        let parameters = [
            STATIC_MEMBERS.BC_REQ_ACTIVE:addressArray.joinWithSeparator("|")
        ]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func getAddressesInfoSynchronous(addressArray:Array<String>) -> NSDictionary{
        let endPoint = "multiaddr"
        let parameters = [
            STATIC_MEMBERS.BC_REQ_ACTIVE:addressArray.joinWithSeparator("|"),
            "no_buttons":"true"]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        return self.networking.httpGETSynchronous(url!, parameters:parameters) as! NSDictionary
    }
    
    func getAddressesInfo(addressArray:Array<String>, success:TLNetworking.SuccessHandler, failure:TLNetworking.FailureHandler) -> () {
        let endPoint = "multiaddr"
        let parameters = [
            STATIC_MEMBERS.BC_REQ_ACTIVE:addressArray.joinWithSeparator("|"),
            "no_buttons":"true"]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
}
