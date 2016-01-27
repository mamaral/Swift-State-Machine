//
//  CDPPaused.swift
//  StateMachine
//
//  Created by Mike on 1/25/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import Foundation

class CDPPaused: CDPState {

    // Paused state implementation of the subclass-specific functions.
    //
    override func enterState() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.pause()
    }

    override func nextTrack() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.nextTrack()
    }

    override func prevTrack() {
        let stateMachine = self.stateMachine as! CDPStateMachine
        stateMachine.interface.prevTrack()
    }
}
