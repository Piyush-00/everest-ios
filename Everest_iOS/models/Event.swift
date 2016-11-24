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
  dynamic var title = ""
  dynamic var about: String? = nil
  dynamic var location: String? = nil
  dynamic var date: Date? = nil
  dynamic var pictureUrl: String? = nil
}

class Event {
  
  public var name: String
  public var description: String
  public var location: String
  public var date: String
  public var startTime: String
  public var endTime: String
  public var headerImage: String
  public var attendeeCharacteristics: [String]

  init(name:String = "", description:String = "", location:String = "", date:String = "", startTime:String = "", endTime:String = "", headerImage:String = "", attendeeCharacteristics:[String] = []){
    self.name = name
    self.description = description
    self.location = location
    self.date = date
    self.startTime = startTime
    self.endTime = endTime
    self.headerImage = headerImage
    self.attendeeCharacteristics = attendeeCharacteristics
  }
  
  //SKU - Getters and setters for all properties of the struct
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
  
  public func setHeaderImage(headerImage:String){
    self.headerImage = headerImage
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
  
  public func getHeaderImage() -> String{
    return self.headerImage
  }
  
  public func getAttendeeCharacteristics() -> [String] {
    return self.attendeeCharacteristics
  }
  
}
