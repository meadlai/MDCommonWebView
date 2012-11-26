function mdBridge(url) {
    var bridge;
    bridge = document.createElement("iframe");
    bridge.setAttribute("src", url);
    bridge.setAttribute("style", "display:none;");
    bridge.setAttribute("height", "0px");
    bridge.setAttribute("width", "0px");
    bridge.setAttribute("frameborder", "0");
    bridge.body.appendChild(iFrame);
    bridge.parentNode.removeChild(bridge);
    bridge = null;
}
