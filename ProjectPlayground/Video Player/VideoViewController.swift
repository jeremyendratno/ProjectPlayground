//
//  VideoViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/8/22.
//

import UIKit
import AVFoundation
import Player
import Foundation

class VideoViewController: UIViewController, PlayerPlaybackDelegate, PlayerDelegate {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let player = Player()
//    let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
    let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        playerSetup()
    }
    
    func avPlayer() {
        let player = AVPlayer(url: url!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func playerSetup() {
        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = self.view.bounds

        self.addChild(player)
        videoView.addSubview(player.view)
        player.didMove(toParent: self)
        player.url = url
        player.playbackLoops = false
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
        let fraction = Float(player.currentTime.value) / Float(player.maximumDuration)
        let progress = fraction / 1000000000
        progressView.progress = Float(progress)
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
    
    func playerPlaybackDidLoop(_ player: Player) {
        
    }
    
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        
    }
}
