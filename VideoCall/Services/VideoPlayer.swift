import UIKit
import AVFoundation
import VideoToolbox
import HaishinKit
import Logboard

class VideoPlayer{
    var rtmpConnection: RTMPConnection = RTMPConnection()
    var rtmpStream: RTMPStream!
    let contact: String
    init(player: GLHKView, contact:String){
        self.contact = contact
        rtmpStream = RTMPStream(connection: rtmpConnection)
        rtmpConnection.addEventListener(Event.RTMP_STATUS, selector: #selector(rtmpStatusHandler), observer: self)
        rtmpConnection.connect("rtmp://bald.esy.es/show")
        
        
        player.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.attachStream(rtmpStream)
        
    }
    
    
    @objc func rtmpStatusHandler(_ notification: Notification) {
        let e: Event = Event.from(notification)
        
        guard
            let data: ASObject = e.data as? ASObject,
            let code: String = data["code"] as? String else {
                return
        }
        
        switch code {
        case RTMPConnection.Code.connectSuccess.rawValue:
            rtmpStream!.play(contact)
        default:
            break
        }
    }
}
