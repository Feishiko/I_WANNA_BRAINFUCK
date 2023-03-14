var initX = argument0;
var initY = argument1;
var text = argument2;
//var dir = argument3;

var ins = instance_create(initX, initY, oDialog);
ins.text = text;
ins.currentDir = fa_left;
