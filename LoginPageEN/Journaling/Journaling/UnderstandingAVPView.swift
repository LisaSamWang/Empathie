//
//  UnderstandingAVPView.swift
//  Journaling
//
//  Created by Lisa Sam Wang on 10/24/21.
//

import UIKit
import AVKit
import AVFoundation

class UnderstandingAVPView: AVPlayerViewController {
    override func viewDidAppear(_ animated: Bool) {
        let videoURL = URL(string: "https://www.youtube.com/watch?v=xO2cztF_sZc")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
