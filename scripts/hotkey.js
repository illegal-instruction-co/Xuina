var gui = require('nw.gui');
var win = gui.Window.get();

// Shortcuts
var option1 = {
  key : "Ctrl+X",
  active : function() {
    win.show()
  },
  failed : function(msg) {
  }
};

// Create a shortcut with |option|.
var shortcut = new nw.Shortcut(option1);

// Register global desktop shortcut, which can work without focus.
gui.App.registerGlobalHotKey(shortcut);


// Shortcuts
var option2 = {
  key : "Ctrl+H",
  active : function() {
    win.show()
  },
  failed : function(msg) {
  }
};

// Create a shortcut with |option|.
var shortcut2 = new nw.Shortcut(option2);

// Register global desktop shortcut, which can work without focus.
gui.App.registerGlobalHotKey(shortcut2);
