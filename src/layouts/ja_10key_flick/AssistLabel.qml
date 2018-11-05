import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

Text {
    property int keyIndex
    
    visible: portraitMode
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    font.family: Theme.fontFamily
    font.pixelSize: !portraitMode && attributes.isShifted
        ? Theme.fontSizeSmall
        : Theme.fontSizeExtraSmall
    color: pressed ? Theme.highlightColor : Theme.secondaryColor
    text: portraitMode && !attributes.inSymView && flickerIndex == 0
        ? attributes.isShifted
            ? (textCaptState && captionShifted !== " "
                ? captionShifted2.charAt(keyIndex)
                : (captionShifted !== " "
                    ? captionShifted.charAt(keyIndex)
                    : ""))
            : flickerText.charAt(keyIndex)
        : ""
}