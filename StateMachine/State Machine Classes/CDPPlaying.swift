//
//  CDPlayerPlaying.swift
//  StateMachine
//
//  Created by Mike on 1/25/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import Foundation

class CDPPlaying: CDPState {

    // Playing state implementation of the subclass-specific functions.
    //
    override func enterState() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.play()
    }

    override func nextTrack() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.nextTrack()
        stateMachine.interface.play()
    }

    override func prevTrack() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.prevTrack()
        stateMachine.interface.play()
    }
}
