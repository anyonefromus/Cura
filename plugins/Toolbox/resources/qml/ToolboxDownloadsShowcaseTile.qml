// Copyright (c) 2018 Ultimaker B.V.
// Toolbox is released under the terms of the LGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import UM 1.1 as UM

Item
{
    width: UM.Theme.getSize("toolbox_thumbnail_large").width
    height: childrenRect.height
    visible:
    {
        if (toolbox.viewCategory == "material" && model.packages_count)
        {
            return model.packages_count > 0
        }
        else
        {
            return true
        }
    }
    Rectangle
    {
        id: highlight
        anchors.fill: parent
        opacity: 0.0
        color: UM.Theme.getColor("primary")
    }
    Rectangle
    {
        id: thumbnail
        color: "white"
        width: UM.Theme.getSize("toolbox_thumbnail_large").width
        height: UM.Theme.getSize("toolbox_thumbnail_large").height
        border
        {
            width: UM.Theme.getSize("default_lining").width
            color: UM.Theme.getColor("lining")
        }
        anchors
        {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        Image {
            anchors.centerIn: parent
            width: UM.Theme.getSize("toolbox_thumbnail_large").width - 2 * UM.Theme.getSize("default_margin").width
            height: UM.Theme.getSize("toolbox_thumbnail_large").height - 2 * UM.Theme.getSize("default_margin").height
            fillMode: Image.PreserveAspectFit
            source: model.icon_url || "../images/logobot.svg"
        }
    }
    Label
    {
        text: model.name
        anchors
        {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        height: UM.Theme.getSize("toolbox_heading_label").height
        width: parent.width
        wrapMode: Text.WordWrap
        color: UM.Theme.getColor("text")
        font: UM.Theme.getFont("medium_bold")
    }
    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
        {
            thumbnail.border.color = UM.Theme.getColor("primary")
            highlight.opacity = 0.1
        }
        onExited:
        {
            thumbnail.border.color = UM.Theme.getColor("lining")
            highlight.opacity = 0.0
        }
        onClicked:
        {
            base.selection = model
            switch(toolbox.viewCategory)
            {
                case "material":
                    toolbox.viewPage = "author"
                    toolbox.filterModelByProp("packages", "author_name", model.name)
                    break
                default:
                    toolbox.viewPage = "detail"
                    toolbox.filterModelByProp("packages", "id", model.id)
                    break
            }
        }
    }
}
