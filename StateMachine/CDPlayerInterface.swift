//
//  CDPlayerInterface.swift
//  StateMachine
//
//  Created by Mike on 1/26/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import Foundation
import AVFoundation

// MARK: CDPlayerInterface delegate protocol
//
@objc protocol CDPInterfaceDelegate {
    optional func CDPInterfaceDidChangeTrack(interface: CDPInterface, trackIndex: Int)
    optional func CDPInterfaceDidUpdateTime(interface: CDPInterface, time: NSTimeInterval)
}


class CDPInterface: NSObject, AVAudioPlayerDelegate {
    
    // MARK: Constants and variables
    //
    var audioPlayer: AVAudioPlayer?
    var trackIndex: Int = 0
    let noTrackSelectedIndex: Int = -1
    let trackNames: [String] = ["cold", "sail", "69", "5seconds"]
    let prevTrackThreshold: NSTimeInterval = 3
    var playbackTimer: NSTimer?
    var delegate: CDPInterfaceDelegate?


    // MARK: Initializer
    //
    override init() {
        super.init()

        loadNextTrack()
    }


    // MARK: Audio player interface
    //

    // Loads the next track on disk.
    //
    func loadNextTrack() {
        let nextTrackName = trackNames[trackIndex]
        let filePath = NSBundle.mainBundle().pathForResource(nextTrackName, ofType: "mp3")

        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath!))
            audioPlayer?.delegate = self
        } catch {
            print("Error initializing audio player.")
        }
    }

    // Prepares the audio player and tells it to play.
    //
    func play() {
        if trackIndex == noTrackSelectedIndex {
            trackIndex = 0
        }

        delegate?.CDPInterfaceDidChangeTrack!(self, trackIndex: trackIndex)

        audioPlayer?.prepareToPlay()
        audioPlayer?.play()

        playbackTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }

    // Stops the audio player and resets the timer back to the beginning.
    //
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0

        trackIndex = noTrackSelectedIndex
        delegate?.CDPInterfaceDidChangeTrack!(self, trackIndex: trackIndex)

        playbackTimer?.invalidate()
        delegate?.CDPInterfaceDidUpdateTime!(self, time: 0)
    }

    // Pauses the audio player.
    func pause() {
        playbackTimer?.invalidate()

        audioPlayer?.pause()
    }

    // Skips to the next track, which starts back at the beginning if at the end.
    //
    func nextTrack() {
        if trackIndex == trackNames.count - 1 {
            trackIndex = 0
        } else {
            trackIndex++
        }

        loadNextTrack()

        delegate?.CDPInterfaceDidChangeTrack!(self, trackIndex: trackIndex)
    }

    // Goes to the previous track if we're prior to the threshold, otherwise starts the
    // current track over.
    //
    func prevTrack() {
        if audioPlayer?.currentTime < prevTrackThreshold {
            if trackIndex == 0 {
                trackIndex = trackNames.count - 1
            } else {
                --trackIndex
            }
        }
        
        loadNextTrack()

        delegate?.CDPInterfaceDidChangeTrack!(self, trackIndex: trackIndex)
    }


    // MARK: AVAudioPlayerDelegate
    //
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        nextTrack()
        play()
    }

    func updateTime() {
        let elapsedTime: NSTimeInterval = (audioPlayer?.currentTime)!

        delegate?.CDPInterfaceDidUpdateTime?(self, time: elapsedTime)
    }
}
