var surl = "http://www.meadidea.com/";

function mdBridge(url) {
    var bridge;
    bridge = document.createElement("iframe");
    bridge.setAttribute("src", url);
    bridge.setAttribute("style", "display:none;");
    bridge.setAttribute("height", "0px");
    bridge.setAttribute("width", "0px");
    bridge.setAttribute("frameborder", "0");
    document.body.appendChild(bridge);
    bridge.parentNode.removeChild(bridge);
    bridge = null;
}

function invokeAction(method,args) {
    mdBridge("MEADPROTOCAL:"+method+"?"+JSON.stringify(args));
}

function Request() {
    this.parameters = {};
    var match,
    pl     = /\+/g,  // Regex for replacing addition symbol with a space
    search = /([^?&=]+)=?([^?&]*)/g,
    decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
    query  = window.location.search;
    while (match = search.exec(query)) {
        this.parameters[decode(match[1])] = decode(match[2]);
    }
}

//辅助获取参数.
var request = new Request();

