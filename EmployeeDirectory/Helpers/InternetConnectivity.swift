//
//  InternetConnectivity.swift
//  EmployeeDirectory
//
//  Created by Pranav Bhandari on 1/25/21.
//

import Network

class InternetConnectivity {
  static let shared = InternetConnectivity()
  
  func online(completion: @escaping (Bool) -> Void) {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    monitor.start(queue: queue)
    monitor.pathUpdateHandler = { path in
      var offline = true
      defer {
        completion(offline)
        monitor.cancel()
      }
      offline = path.status == .satisfied ? false : true
    }
  }
}
