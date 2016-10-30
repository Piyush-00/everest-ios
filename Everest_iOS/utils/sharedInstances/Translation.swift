//
//  Translation.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

class Translation{
  
  static let sharedInstance = Translation()
  
  //Invalid Modal Pop up
  let modalInvalid_HeaderText:String = "Oops!"
  let modalInvalid_SubHeaderText:String = "There is no event\nassociated with this code"
  let modalInvalid_ButtonText:String = "Scan Again"
  let modalInvalid_errorMessageText:String = "Our servers did not recognize this QR code! Please make sure you are scanning a\nvalid QR code."
  let modalInvalid_tipMessageText:String = "Tip: Make sure there is enough lighting when scanning!"
}
