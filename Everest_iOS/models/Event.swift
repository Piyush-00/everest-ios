//
//  Event.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-10-23.
//  Copyright © 2016 Everest. All rights reserved.
//

//SKU 
/*
 Event(name: "Tesla Solar Roof, Powerpack", description: "Tesla CEO Elon Musk led a fantastic, futuristic presentation this evening at sunset. To be unveiled: solar roof, power wall 2.0", location: "Universal Studio in Los Angeles, California ", date: "Saturday, October 30 2016", startTime: "4:00pm", endTime: "8:00pm", headerImage: "https://electrek.files.wordpress.com/2016/10/tesla-28-oct-event-e1477694135248.jpg?quality=82&strip=all&strip=all&w=1024&h=0")
 */
import Foundation
import RealmSwift

class RealmEvent: Object {
  dynamic var name = ""
  dynamic var about: String? = nil
  dynamic var location: String? = nil
  dynamic var date: Date? = nil
  dynamic var startTime: String? = nil
  dynamic var endTime: String? = nil
  dynamic var headerImage: UIImage? = nil
  dynamic var attendeeCharacteristics: String? = nil
}

class Event {
  private var name: String = ""
  private var description: String = ""
  private var location: String = ""
  private var date: String = ""
  private var startTime: String = ""
  private var endTime: String = ""
  private var headerImageUrl: String = ""
  private var headerImage: UIImage?
  private var attendeeCharacteristics: [String] = []
  
  //SKO - will be used by RealmEvent as separator between attendeeCharacteristics when concatenated
  static let attendeeCharacteristicsSeparator = "%^&"

  init(name:String = "", description:String = "", location:String = "", date:String = "", startTime:String = "", endTime:String = "", headerImageUrl:String = "", attendeeCharacteristics:[String] = []){
    self.name = name
    self.description = description
    self.location = location
    self.date = date
    self.startTime = startTime
    self.endTime = endTime
    self.headerImageUrl = headerImageUrl
    self.attendeeCharacteristics = attendeeCharacteristics
  }
  
  //SKU - Getters and setters for all properties of the class
  public func setName(name:String){
    self.name = name
  }
  
  public func setDescription(description:String){
    self.description = description
  }
  
  public func setLocation(location:String){
    self.location = location
  }
  
  public func setDate(date:String){
    self.date = date
  }
  
  public func setStartTime(startTime:String){
    self.startTime = startTime
  }
  
  public func setEndTime(endTime:String){
    self.endTime = endTime
  }
  
  public func setHeaderImageUrl(headerImageUrl:String){
    self.headerImageUrl = headerImageUrl
  }
  
  public func setAttendeeCharacteristics(attendeeCharacteristics: [String]) {
    self.attendeeCharacteristics = attendeeCharacteristics
  }
  
  public func getName() -> String{
    return self.name
  }
  
  public func getDescription() -> String {
    return self.description
  }
  
  public func getLocation() -> String{
    return self.location
  }
  
  public func getDate() -> String{
    return self.date
  }
  
  public func getStartTime() -> String{
    return self.startTime
  }
  
  public func getEndTime() -> String{
    return self.endTime
  }
  
  public func getHeaderImageUrl() -> String{
    return self.headerImageUrl
  }
  
  public func getAttendeeCharacteristics() -> [String] {
    return self.attendeeCharacteristics
  }
  
  public func getHeaderImage() -> UIImage? {
    return self.headerImage
  }
  
  public func setHeaderImage(image: UIImage?) {
    self.headerImage = image
  }
  
  public func isUserSignedIn() -> String? {
    return User.getKeyChainUserID()
  }
  
  public func createEvent(completionHandler: @escaping (Bool) -> ()){
    
    let params = ["EventName": name, "Description": description, "StartTime": Date(), "EndTime" :  Date(), "EventQuestions" : attendeeCharacteristics, "UserId" : isUserSignedIn() , "Location" : location ] as [String : Any]
    
    Http.multipartRequest(requestURL: t(Routes.Api.CreateNewEvent), image: self.headerImage, parameters: params) {
      response in
      switch response.result {
      case .success :
        
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
              completionHandler(true)
            
          default:
            print("default case")
            completionHandler(false)
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  public func QRScanEvent(eventURL: String, completionHandler: @escaping (Bool) -> ()){
    Http.getRequest(requestURL: t(eventURL)){
      response in
      switch response.result {
      case .success (let JSON):
        if let httpStatusCode = response.response?.statusCode {
          switch (httpStatusCode) {
          case 200:
            if let json = JSON as? Dictionary<String,Any> {
              
              self.setName(name: json["EventName"] as! String)
              self.setDescription(description: json["Description"] as! String)
              self.setLocation(location: json["Location"] as! String)
              self.setDate(date:"Thursday")
              self.setStartTime(startTime: AppUtil.formatDateString(json["StartTime"] as! String))
              self.setEndTime(endTime: AppUtil.formatDateString(json["EndTime"] as! String))
              self.setHeaderImageUrl(headerImageUrl: t(json["EventImageURL"] as! String?))
              completionHandler(true)
            }
          default:
            print("default case")
            completionHandler(false)
          }
        }
      case .failure(let error):
        print(error)
       completionHandler(false)
      }
    }
  }
}
