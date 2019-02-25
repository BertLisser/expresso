function transform(f, x, shift, amplitude, frequency) {
	return amplitude*f(frequency*(x+shift));
}

var n  = 32;

function scX(d, x, width) {return 100*(d-x)/width;}

function scY(d, y, height) {return 100-100*(d-y)/height;}

function updatePath(id, shift, amplitude, frequency, x, y, width, height) {
  var f = {sinId:Math.sin, cosId:Math.cos};
  var s = "M "+scX(0, x, width) +","+scY(
		        transform(f[id], 0, shift, amplitude, frequency), y, height);
  for (var d=2*Math.PI/n;d<=2*Math.PI; d+=2*Math.PI/n) s+=
	  (" L "+scX(d, x, width) +","+
			  scY(transform(f[id], d, shift, amplitude, frequency), y, height));
  return s;
  }

function updateView(id) {
    var s = updatePath(id, param["shift"], param["amplitude"], param["frequency"]
       ,param[x], param["y"], param["width"], param["height"]);
    document.getElementById(id).setAttribute("d", s);
}

var s = updatePath("sinId", 1, 2, 1, 3, 5, 10, 10);
// console.log(s);