import QtQuick 2.6
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

Column {
    width: parent.width

    SectionHeader {
        text: "Flick keyboard"
    }

    TextSwitch {
        automaticCheck: false
        checked: flickAssistConfig.value
        text: "Assist labels"
        onClicked: flickAssistConfig.value = !flickAssistConfig.value
    }


    TextSwitch {
        automaticCheck: false
        checked: flickPopperConfig.value
        text: "Flick popper"
        onClicked: flickPopperConfig.value = !flickPopperConfig.value
    }

    ConfigurationValue {
        id: flickAssistConfig

        key: "/sailfish/text_input/flick_assist_label_enabled"
        defaultValue: false
    }

    ConfigurationValue {
        id: flickPopperConfig

        key: "/sailfish/text_input/flick_popper_enabled"
        defaultValue: false
    }
}
