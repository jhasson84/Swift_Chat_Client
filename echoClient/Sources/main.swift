import Foundation
import Glibc

var echoClient = EchoClient(port: 5000, server: "127.0.0.1")

do {
	 try echoClient.start()
}catch let error {
    print("Error: \(error)")
}
