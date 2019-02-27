function transform(f, x, shift, amplitude, frequency) {
	return amplitude*f(frequency*(x+shift));
}

var n  = 512;

function updatePath(name, shift, amplitude, frequency) {
  var f = {sin:Math.sin, cos:Math.cos};
  var delta = 2*Math.PI/n;
  var s = "M  0"+" "+
		        transform(f[name], 0, shift, amplitude, frequency);
  for (var d=delta;d<2*Math.PI+delta; d+=delta) s+=
	  (",L "+ d +" "+
			  transform(f[name], d, shift, amplitude, frequency));
  return s;
  }

function updateView(name) {
	// alert(JSON.stringify(param));
	var id = param[name+"_id"];
    var s = updatePath(name, param[name+"_shift"], param[name+"_amplitude"], param[name+"_frequency"]);
    document.getElementById(id).setAttribute("d", s);
}
// alert(param["sin_shift"]);
// document.getElementById(param["sin_id"]).setAttribute("fill", "yellow");
updateView("sin");
updateView("cos");

// var s = updatePath("sinId", 1, 2, 1, 3, 5, 10, 10);
// console.log(s);