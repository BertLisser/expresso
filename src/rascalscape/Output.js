var cy = cytoscape({
container: document.getElementById('cy'), 
style: [{selector:'edge', style: {
        'line-color':'blue','midSource-arrow-fill':'true','midSource-arrow-color':'red','arrow-scale':'3','midSource-arrow-shape':'chevron',
                }
             }
            ,{selector:'node', style: {
        'background-color':'antiquewhite','border-color':'darkgrey','border-width':'2','label':'data(id)','text-valign':'center','margin-x':'0','margin-y':'0',
                }
             }
            ,{selector:'node#0', style: {
        'shape':'ellipse',
                }
             }
            ,{selector:'node#1', style: {
        'shape':'triangle',
                }
             }
            ,{selector:'node#2', style: {
        'shape':'rectangle',
                }
             }
            ,{selector:'node#3', style: {
        'shape':'round-rectangle',
                }
             }
            ,{selector:'node#4', style: {
        'shape':'bottom-round-rectangle',
                }
             }
            ,{selector:'node#5', style: {
        'shape':'cut-rectangle',
                }
             }
            ,{selector:'node#6', style: {
        'shape':'barrel',
                }
             }
            ,{selector:'node#7', style: {
        'shape':'rhomboid',
                }
             }
            ,{selector:'node#8', style: {
        'shape':'diamond',
                }
             }
            ,{selector:'node#9', style: {
        'shape':'pentagon',
                }
             }
            ,{selector:'node#10', style: {
        'shape':'hexagon',
                }
             }
            ,{selector:'node#11', style: {
        'shape':'concaveHexagon',
                }
             }
            ,{selector:'node#12', style: {
        'shape':'heptagon',
                }
             }
            ,{selector:'node#13', style: {
        'shape':'octagon',
                }
             }
            ,{selector:'node#14', style: {
        'shape':'star',
                }
             }
            ,{selector:'node#15', style: {
        'shape':'tag',
                }
             }
            ,{selector:'node#16', style: {
        'shape':'vee',
                }
             }
            ],
elements: [{ group:'nodes',
           data: {
             id: '0'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '1'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '2'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '3'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '4'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '5'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '6'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '7'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '8'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '9'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '10'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '11'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '12'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '13'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '14'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '15'
           }
           }
           ,{ group:'nodes',
           data: {
             id: '16'
           }
           }
           ,{ group:'edges',
           data: {
             id: '0_2',
             source:'0',
             target:'2',
           }
           }
           ,{ group:'edges',
           data: {
             id: '1_3',
             source:'1',
             target:'3',
           }
           }
           ,{ group:'edges',
           data: {
             id: '2_4',
             source:'2',
             target:'4',
           }
           }
           ,{ group:'edges',
           data: {
             id: '3_5',
             source:'3',
             target:'5',
           }
           }
           ,{ group:'edges',
           data: {
             id: '4_6',
             source:'4',
             target:'6',
           }
           }
           ,{ group:'edges',
           data: {
             id: '5_7',
             source:'5',
             target:'7',
           }
           }
           ,{ group:'edges',
           data: {
             id: '6_8',
             source:'6',
             target:'8',
           }
           }
           ,{ group:'edges',
           data: {
             id: '7_9',
             source:'7',
             target:'9',
           }
           }
           ,{ group:'edges',
           data: {
             id: '8_10',
             source:'8',
             target:'10',
           }
           }
           ,{ group:'edges',
           data: {
             id: '9_11',
             source:'9',
             target:'11',
           }
           }
           ,{ group:'edges',
           data: {
             id: '10_12',
             source:'10',
             target:'12',
           }
           }
           ,{ group:'edges',
           data: {
             id: '11_13',
             source:'11',
             target:'13',
           }
           }
           ,{ group:'edges',
           data: {
             id: '12_14',
             source:'12',
             target:'14',
           }
           }
           ,{ group:'edges',
           data: {
             id: '13_15',
             source:'13',
             target:'15',
           }
           }
           ,{ group:'edges',
           data: {
             id: '14_16',
             source:'14',
             target:'16',
           }
           }
           ,{ group:'edges',
           data: {
             id: '15_0',
             source:'15',
             target:'0',
           }
           }
           ,{ group:'edges',
           data: {
             id: '16_1',
             source:'16',
             target:'1',
           }
           }
]

});
  var options = {name:'circle'};
      var layout = cy.layout(options);
      layout.run();
  