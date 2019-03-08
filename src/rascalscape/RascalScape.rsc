module rascalscape::RascalScape
import Prelude;
import util::Math;
import util::HtmlDisplay;

alias Position = tuple[int x, int y];

data Ele = n(str id, NodeShape nodeShape = defaultNodeShape())
         | e(str id, str source, str target, EdgeShape edgeShape = defaultEdgeShape())
         ;
         
data Style = style(
              NodeShape nodeShape =  ellipse(),
              EdgeShape edgeShape = straight(),
              Label label =  label(""),
              Label sourceLabel = sourceLabel(""),
              Label targetLabel = targetLabel("")
              );
         
data Cytoscape = cytoscape(
  str container = "",
  list[Ele] elements = [],
  list[tuple[str selector, Style style]] styles = [],
  Layout \layout = circle(),
  num zoom = 1.0,
  Position pan =  <0, 0>,
  bool zoomingEnabled = true,
  bool userZoomingEnable = true,
  bool panningEnabled = true,
  bool userPanningEnabled = true,
  bool boxSelectionEnabled =false,
  str selectionType = "single",
  int touchTapThreshold = 8,
  int desktopTapThreshold = 4,
  bool autolock = false,
  bool autoungrabify = false,
  bool autounselectify = false,

  // rendering options:
  bool headless = false,
  bool styleEnabled = true,
  bool hideEdgesOnViewport = false,
  bool hideLabelsOnViewport = false,
  bool textureOnViewport = false,
  bool motionBlur = false,
  num motionBlurOpacity = 0.2,
  int wheelSensitivity = 1,
  str pixelRatio = "auto"
  );  
         
data NodeShape(str backgroundColor="", num backgroundOpacity=1.0,
               str borderColor= "", int borderWidth=-1,
               str padding=-1, int width=-1, str height = -1)
    =ellipse()
    |triangle()
    |rectangle()
    |roundRectangle()
    |bottomRoundRectangle()
    |cutRectangle()
    |barrel()
    |rhomboid()
    |diamond()
    |pentagon()
    |hexagon()
    |concaveHexagon()
    |heptagon ()
    |octagon()
    |star()
    |\tag()
    |vee()
    |defaultNodeShape()
    ;
    
 data EdgeShape(
    str lineColor="",
    str lineFill= "",
    str lineCap="",
    int width = -1,
    ArrowShape arrow = defaultArrowShape())
    = haystack()
    | straight()
    | bezier()
    | segments()
    | taxi()
    | defaultEdgeShape()
    ;
     
 data Pos
    = source()
    | midSource()
    | target()
    | midTarget()
    ;
    
 data ArrowShape(bool arrowFill = true, Pos pos= target(), num arrowScale=1.0,
     str arrowColor = "")
    = triangle()
    | triangleTee()
    | triangleCross()
    | triangleBackcurve()
    | vee()
    | tee()
    | square()
    | circle()
    | diamond()
    | chevron()
    | none()
    | defaultArrowShape()
    ;
    
data Label(str labelColor="", str outlineColor="", str backgroundColor="", 
      int marginX=0, int marginY = 0)
    = label(str \value, str hAlign = "center", str vAlign="center")
    | sourceLabel(str \value, int offset = 0)
    | targetLabel(str \value, int offset = 0)
    ;
    
    
data Layout
    =  concentric(
        // str name = "concentric",
        bool fit= true, // whether to fit the viewport to the graph
        int padding= 30, // the padding on fit
        num startAngle= 3 / 2 * PI(), // where nodes start in radians
        num sweep= 2*PI(), // how many radians should be between the first and last node (defaults to full circle)
        bool clockwise= true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
        bool equidistant= false, // whether levels have an equal radial distance betwen them, may cause bounding box overflow
        int minNodeSpacing= 10, // min spacing between outside of nodes (used for radius adjustment)
        str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
        bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox if not enough space
        bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
        int height= -1, // height of layout area (overrides container height)
        int width = -1, // width of layout area (overrides container width)
        num spacingFactor= -1 //
       )
   | circle(
       // name= 'circle',
      bool fit= true, // whether to fit the viewport to the graph
      int padding= 30, // the padding on fit
      str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
      bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox and radius if not enough space
      bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
      num spacingFactor= -1, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
      int radius= -1, // the radius of the circle
      num startAngle= 3 / 2 * PI(), // where nodes start in radians
      num sweep= 2*PI(), // how many radians should be between the first and last node (defaults to full circle)
      bool clockwise= true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
  // sort= undefined, // a sorting function to order the nodes; e.g. function(a, b){ return a.data('weight') - b.data('weight') }
      bool animate= false, // whether to transition the node positions
      int animationDuration= 500, // duration of animation in ms if enabled
      bool animationEasing= false // easing of animation if enabled
 // animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
 // ready= undefined, // callback on layoutready
 // stop= undefined, // callback on layoutstop
       )
  | preset (
   // name= 'preset',
  map(str, Position) positions= (), // map of (node id) => (position obj); or function(node){ return somPos; }
  num zoom=  1, // the zoom level to set (prob want fit = false if set)
  Position pan= <0, 0>, // the pan level to set (prob want fit = false if set)
  bool fit= true, // whether to fit to viewport
  int padding= 30, // padding on fit
  bool animate= false, // whether to transition the node positions
  bool animationDuration= 500, // duration of animation in ms if enabled
  bool animationEasing= false // easing of animation if enabled
  // animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
  // ready= undefined, // callback on layoutready
  // stop= undefined, // callback on layoutstop
     )
  | dagre (
    // name= 'dagre'
    int nodeSep= -1, // the separation between adjacent nodes in the same rank
  int edgeSep= -1, // the separation between adjacent edges in the same rank
  int rankSep= -1, // the separation between adjacent nodes in the same rank
  str rankDir= "", // 'TB' for top to bottom flow, 'LR' for left to right,
  str ranker= "", // Type of algorithm to assign a rank to each node in the input graph. Possible values= 'network-simplex', 'tight-tree' or 'longest-path'
  // minLen= function( edge ){ return 1; }, // number of ranks to keep between the source and target of the edge
  // edgeWeight= function( edge ){ return 1; }, // higher weight edges are generally made shorter and straighter than lower weight edges
  // general layout options
  bool fit= true, // whether to fit to viewport
  int padding= 30, // fit padding
  num spacingFactor= -1, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
  bool nodeDimensionsIncludeLabels= false, // whether labels should be included in determining the space used by a node
  bool animate= false, // whether to transition the node positions
  //animateFilter= function( node, i ){ return true; }, // whether to animate specific nodes when animation is on; non-animated nodes immediately go to their final positions
  //animationDuration= 500, // duration of animation in ms if enabled
  // animationEasing= undefined, // easing of animation if enabled
  str boundingBox= "" // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
  // transform= function( node, pos ){ return pos; }, // a function that applies a transform to the final node position
  // ready= function(){}, // on layoutready
  // stop= function(){} // on layoutstop
    )
  | breadthfirst(
  //    name= 'breadthfirst',
  bool fit= true, // whether to fit the viewport to the graph
  bool directed= false, // whether the tree is directed downwards (or edges can point in any direction if false)
  int padding= 30, // padding on fit
  bool circle= false, // put depths in concentric circles if true, put depths top down if false
  bool grid= false, // whether to create an even grid into which the DAG is placed (circle=false only)
  num spacingFactor= 1.75, // positive spacing factor, larger => more space between nodes (N.B. n/a if causes overlap)
  str boundingBox= "", // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
  bool avoidOverlap= true, // prevents node overlap, may overflow boundingBox if not enough space
  bool nodeDimensionsIncludeLabels= false, // Excludes the label when calculating node bounding boxes for the layout algorithm
  list[str] roots= [], // the roots of the trees
  bool maximal= false, // whether to shift nodes down their natural BFS depths in order to avoid upwards edges (DAGS only)
  bool animate= false, // whether to transition the node positions
  int animationDuration= 500, // duration of animation in ms if enabled
  bool animationEasing= false // easing of animation if enabled,
  //animateFilter= function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
  //ready= undefined, // callback on layoutready
  // stop= undefined, // callback on layoutstop
    )
  ;
    
public void cytoScape(CytoScape) {
   }