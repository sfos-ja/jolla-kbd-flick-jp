/*
 * Copyright (C) Jakub Pavelek <jpavelek@live.com>
 * Copyright (C) 2013 Jolla Ltd.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0

Rectangle {
    id: popper
    
    opacity: 0
    color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
    height: geometry.popperWidth
    width: geometry.popperWidth
    radius: geometry.popperRadius
    visible: popperText === "" ? false : true

    property Item target: null
    property int popperIndex
    property string popperText: target !== null
        ? (target.enableFlicker === true
            ? target.currentText.charAt(popperIndex)
            : "")
        : ""

    onTargetChanged: {
        if (target && target.enableFlicker) {
            setup()
        }
    }
    
    PopperCell {
        width: parent.width
        height: parent.height
        character: popperText
        active: target === null ? false : target.flickerIndex == popperIndex
    }

    states: [
        State {
            name: "active"
            when: target !== null && target.enableFlicker

            PropertyChanges {
                target: popper
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: "active"
            to: ""

            SequentialAnimation {
                PauseAnimation { duration: 20 }
                PropertyAction {
                    target: popper
                    properties: "opacity"
                }
                ScriptAction {
                    script: {
                        popper.opacity = 0
                    }
                }
            }
        }
    ]

    function setup() {
        // set the popper positions depending on the index position
        y = popper.parent.mapFromItem(target, 0, 0).y + (popperIndex == 1 || popperIndex == 3
            ? 0
            : (popperIndex == 2
                ? -popper.height + Theme.paddingSmall
                :  popper.height - Theme.paddingSmall))
        x = popper.parent.mapFromItem(target, 0, 0).x + (popperIndex == 2 || popperIndex == 4
            ? (target.width - popper.width) / 2
            : (popperIndex == 1
                ? -target.width + (target.width - popper.width) + Theme.paddingSmall
                :  target.width - Theme.paddingSmall))
    }
}
