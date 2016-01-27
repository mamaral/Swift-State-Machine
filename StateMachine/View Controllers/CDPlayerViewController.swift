//
//  CDPlayerViewController.swift
//  StateMachine
//
//  Created by Mike on 1/25/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import UIKit
import Neon

class CDPlayerViewController: UIViewController, CDPInterfaceDelegate {
    let currentTrackLabel: UILabel = UILabel()
    let timeLabel: UILabel = UILabel()
    let playButton: UIButton = UIButton()
    let pauseButton: UIButton = UIButton()
    let stopButton: UIButton = UIButton()
    let nextButton: UIButton = UIButton()
    let prevButton: UIButton = UIButton()
    let playerStateMachine: CDPStateMachine = CDPStateMachine()

    override func viewDidLoad() {
        super.viewDidLoad()

        playerStateMachine.interface.delegate = self

        currentTrackLabel.text = "Track -"
        currentTrackLabel.font = UIFont(name: "Menlo-Regular", size: 30.0)
        currentTrackLabel.textAlignment = .Center
        view.addSubview(currentTrackLabel)

        timeLabel.text = "0:0"
        timeLabel.font = UIFont(name: "Menlo-Regular", size: 30.0)
        timeLabel.textAlignment = .Center
        view.addSubview(timeLabel)

        playButton.setImage(UIImage(named: "play"), forState: .Normal)
        playButton.addTarget(self, action: "play", forControlEvents: .TouchUpInside)
        view.addSubview(playButton)

        pauseButton.setImage(UIImage(named: "pause"), forState: .Normal)
        pauseButton.addTarget(self, action: "pause", forControlEvents: .TouchUpInside)
        view.addSubview(pauseButton)

        stopButton.setImage(UIImage(named: "stop"), forState: .Normal)
        stopButton.addTarget(self, action: "stop", forControlEvents: .TouchUpInside)
        view.addSubview(stopButton)

        nextButton.setImage(UIImage(named: "next"), forState: .Normal)
        nextButton.addTarget(self, action: "next", forControlEvents: .TouchUpInside)
        view.addSubview(nextButton)

        prevButton.setImage(UIImage(named: "prev"), forState: .Normal)
        prevButton.addTarget(self, action: "prev", forControlEvents: .TouchUpInside)
        view.addSubview(prevButton)
    }

    override func viewDidLayoutSubviews() {
        currentTrackLabel.anchorToEdge(.Top, padding: 50, width: view.width, height: 32)
        timeLabel.alignAndFillWidth(align: .UnderCentered, relativeTo: currentTrackLabel, padding: 20, height: 32)
        view.groupInCenter(group: .Horizontal, views: [playButton, pauseButton, stopButton], padding: 20, width: 100, height: 100)
        view.groupAndAlign(group: .Horizontal, andAlign: .UnderCentered, views: [prevButton, nextButton], relativeTo: pauseButton, padding: 10, width: 100, height: 100)
    }


    // Each of these methods - which are tied to the various UI elements - simply tell
    // the state machine's current state to handle the appropriate action.
    //
    func play() {
        if let currentState = playerStateMachine.currentState as? CDPState {
            currentState.play()
        }
    }

    func pause() {
        if let currentState = playerStateMachine.currentState as? CDPState {
            currentState.pause()
        }
    }

    func stop() {
        if let currentState = playerStateMachine.currentState as? CDPState {
            currentState.stop()
        }
    }

    func next() {
        if let currentState = playerStateMachine.currentState as? CDPState {
            currentState.nextTrack()
        }
    }

    func prev() {
        if let currentState = playerStateMachine.currentState as? CDPState {
            currentState.prevTrack()
        }
    }


    // MARK: CDPInterfaceDelgate protocol implementation
    //

    // Update the track
    //
    func CDPInterfaceDidChangeTrack(interface: CDPInterface, trackIndex: Int) {
        currentTrackLabel.text = trackIndex == interface.noTrackSelectedIndex ? "Track -" : "Track \(trackIndex + 1)"
    }

    // Update the track timer.
    //
    func CDPInterfaceDidUpdateTime(interface: CDPInterface, time: NSTimeInterval) {
        timeLabel.text = String(format: "%00.1f", time)
    }
}
