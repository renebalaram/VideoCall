//
//  VideoStreamer.swift
//  VideoCall
//
//  Created by Admin on 7/19/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import UIKit
import AVFoundation
import VideoToolbox
import HaishinKit
import Logboard

class VideoStreamer{
    let sampleRate:Double = 44_100
    let rtmpConnection:RTMPConnection
    let rtmpStream: RTMPStream
    
    
    init(){
        rtmpConnection = RTMPConnection()
        rtmpStream = RTMPStream(connection: rtmpConnection)
    }
    
    func setupCamera(for player: HKView) {
        
        
        let frontCamera = DeviceUtil.device(withPosition: .front)
        
        //lllll
        rtmpStream.captureSettings = [
            "fps": 30, // FPS
            "sessionPreset": AVCaptureSession.Preset.high.rawValue, // input video width/height
            "continuousAutofocus": true, // use camera autofocus mode
            "continuousExposure": false, //  use camera exposure mode
        ]
        rtmpStream.audioSettings = [
            "muted": false, // mute audio
            "bitrate": 32 * 1024,
            "sampleRate": sampleRate,
        ]
        rtmpStream.videoSettings = [
            "width": 720, // video output width
            "height": 480, // video output height
            "bitrate": 320 * 1024, // video output bitrate
            // "dataRateLimits": [160 * 1024 / 8, 1], optional kVTCompressionPropertyKey_DataRateLimits property
            "profileLevel": kVTProfileLevel_H264_Baseline_3_1, // H264 Profile require "import VideoToolbox"
            "maxKeyFrameIntervalDuration": 2, // key frame / sec
        ]
        
        rtmpStream.attachAudio(AVCaptureDevice.default(for: AVMediaType.audio)) { error in
            print(error)
        }
        rtmpStream.attachCamera(frontCamera) { error in
            print(error)
        }
        
        
        //rtmpStream.attachScreen(ScreenCaptureSession(shared: UIApplication.shared))
        
        
        player.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.attachStream(rtmpStream)
        
        // add ViewController#view
        
        // if you want to record a stream.
        // rtmpStream.publish("streamName", type: .localRecor
    }
    
    func startStreaming(sesion: String){
        rtmpConnection.connect("rtmp://bald.esy.es/show")
        rtmpStream.publish(sesion)
        
    }
    func stopStreaming(){
        rtmpStream.close()
        rtmpConnection.close()
    }
}
