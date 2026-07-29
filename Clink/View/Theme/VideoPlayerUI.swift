//
//  VideoPlayerUIView.swift
//  Clink
//
//  Created by Julio Sampaio on 28/07/26.
//
//
//  SplashVideoView.swift
//  Clink
//

import SwiftUI
import AVFoundation

class VideoPlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    
    init(videoName: String) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else { return }
        
        let player = AVPlayer(url: url)
        player.isMuted = true
        
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        player.play()
        
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não implementado")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct SplashVideoView: UIViewRepresentable {
    var videoName: String
    
    func makeUIView(context: Context) -> UIView {
        return VideoPlayerUIView(videoName: videoName)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
