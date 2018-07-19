//
//  VideoChatViewController.swift
//  VideoCall
//
//  Created by Admin on 7/18/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit

class VideoChatViewController: UIViewController{
    var videoCallID: String!
    let streamer = VideoStreamer()
    @IBOutlet weak var toggleView: UIView!
    
    @IBAction func toggle(_ sender: Any) {
        if let backGroudColor = toggleView.backgroundColor {
            if backGroudColor == UIColor.blue {
                toggleView.backgroundColor = UIColor.red
            } else {
                toggleView.backgroundColor = UIColor.blue
            }
        }else{
            toggleView.backgroundColor = UIColor.red
        }
    }
    @IBOutlet weak var bigVideoPlayer: UIView!
    @IBOutlet weak var smallVideoPlayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        videoCallID = "testing123"
        streamer.setupCamera(for: smallVideoPlayer)
        streamer.startStreaming(sesion: "stream")
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


