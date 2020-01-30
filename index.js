const { app, BrowserWindow } = require('electron')
var mainWindow = null;

app.on('ready', function() {
  let win = new BrowserWindow({frame: false, alwaysOnTop: false, fullscreen: false })
  win.on('closed', () => {
    win = null;
  });
  win.loadURL('file://' + __dirname + '/project/ui/index.html');
});
