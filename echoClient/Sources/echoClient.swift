//working on a client to interact with the server we built
//ok so this works... kind of... it isnt necessarily the best example... 
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif
import Socket
import Foundation

class EchoClient {

    let bufferSize = 4096
    let port: Int
    let server: String
    var listenSocket: Socket? = nil

    init(port: Int, server: String) {
        self.port = port
        self.server = server
    }
    
    deinit {
        listenSocket?.close()
    }

    func start() throws {
      let socket = try Socket.create() 
      listenSocket = socket
      try socket.connect(to: server, port: Int32(port))
      var dataRead = Data(capacity: bufferSize)
      var cont = true
       repeat {
			if let entered = readLine(strippingNewline: false) {
            try socket.write(from: entered)
            if entered.hasPrefix("quit") {
               cont = false
            }
            let bytesRead = try socket.read(into: &dataRead)
            if bytesRead > 0 {
              if let readStr = String(data: dataRead, encoding: .ascii) {
                print("'\(readStr)'")
              }
              dataRead.count = 0
            }
          }
       } while cont
    }
}
