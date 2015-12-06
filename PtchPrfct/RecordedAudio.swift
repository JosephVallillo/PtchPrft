//
//  RecordedAudio.swift
//  PtchPrfct
//
//  Created by Joseph Vallillo on 11/28/15.
//  Copyright © 2015 Joseph Vallillo. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    //MARK: - Properties
    var filePathURL: NSURL!
    var title: String!
    
    //MARK: - Init
    init(url: NSURL, title: String) {
        self.filePathURL = url
        self.title = title
    }
}