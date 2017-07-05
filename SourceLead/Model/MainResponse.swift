//
//  Response.swift
//  SourceLead
//
//  Created by Ghouse Basha Shaik on 03/07/17.
//  Copyright © 2017 BIS. All rights reserved.

import Gloss

struct MainResponse : Decodable {
    let firstName           :   String?
    let lastName            :   String?
    let profileImageUrl     :   String?
    let locationList        :   LocationList?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.firstName          = "firstName" <~~ json
        self.lastName           = "lastName" <~~ json
        self.profileImageUrl    = "profileImageUrl" <~~ json
        self.locationList       = "orgLocationsList" <~~ json
    }
}

struct LocationList : Decodable {
    let vukPin      :   VUKPin?
    let vuxPin      :   VUXPin?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.vukPin           = "txhlIN" <~~ json
        self.vuxPin           = "czpIV" <~~ json
    }
}

struct VUKPin : Decodable {
    let orgName             :   String?
    let locationCode        :   String?
    let orgCode             :   String?
    let orgImageUrl         :   String?
    let country             :   String?
    let state               :   String?
    let city                :   String?
    let orgLocationAddress  :   String?
    let webSite             :   String?
    let isPrimaryOrg        :   String?
    let userType            :   String?
    let menuList            :   [String]?
    let roleActionsList     :   [String]?
    let menuIconsList       :   [String]?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.orgName            = "orgName" <~~ json
        self.locationCode       = "locationCode" <~~ json
        self.orgCode            = "orgCode" <~~ json
        self.orgImageUrl        = "orgImageUrl" <~~ json
        self.country            = "country" <~~ json
        self.state              = "state" <~~ json
        self.city               = "city" <~~ json
        self.orgLocationAddress = "orgLocationAddress" <~~ json
        self.webSite            = "website" <~~ json
        self.isPrimaryOrg       = "isPrimaryOrg" <~~ json
        self.userType           = "userType" <~~ json
        self.menuList           = "menuList" <~~ json
        self.roleActionsList    = "roleActionsList" <~~ json
        self.menuIconsList      = "menuIconsList" <~~ json
    }
}

struct VUXPin : Decodable{
    let orgName             :   String?
    let locationCode        :   String?
    let orgCode             :   String?
    let orgImageUrl         :   String?
    let country             :   String?
    let state               :   String?
    let city                :   String?
    let orgLocationAddress  :   String?
    let webSite             :   String?
    let isPrimaryOrg        :   String?
    let userType            :   String?
    let menuList            :   [String]?
    let roleActionsList     :   [String]?
    let menuIconsList       :   [String]?
    
    // MARK: - Deserialization
    init?(json: JSON) {
        self.orgName            = "orgName" <~~ json
        self.locationCode       = "locationCode" <~~ json
        self.orgCode            = "orgCode" <~~ json
        self.orgImageUrl        = "orgImageUrl" <~~ json
        self.country            = "country" <~~ json
        self.state              = "state" <~~ json
        self.city               = "city" <~~ json
        self.orgLocationAddress = "orgLocationAddress" <~~ json
        self.webSite            = "website" <~~ json
        self.isPrimaryOrg       = "isPrimaryOrg" <~~ json
        self.userType           = "userType" <~~ json
        self.menuList           = "menuList" <~~ json
        self.roleActionsList    = "roleActionsList" <~~ json
        self.menuIconsList      = "menuIconsList" <~~ json
    }
}
