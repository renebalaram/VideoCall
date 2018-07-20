//
//  VideoChatViewController.swift
//  VideoCall
//
//  Created by Admin on 7/18/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit
import HaishinKit

class VideoChatViewController: UIViewController{
    var videoCallID: String!
    let streamer = VideoStreamer()
    var player : VideoPlayer!
    var currentUser: User!
    
    @IBOutlet weak var bigVideoPlayer: GLHKView!
    @IBOutlet weak var smallVideoPlayer: HKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        streamer.setupCamera(for: smallVideoPlayer)
        streamer.startStreaming(sesion: currentUser.userName)
        player = VideoPlayer(player: bigVideoPlayer,contact: currentUser.talkingTo)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        streamer.stopStreaming()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func finishVideoCall(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


