/**
 * 
 */

cy.add([ // list of graph elements to start with
    { // node a
	  group: 'nodes',
      data: { id: 'a' }
    },
    { // node b
      group: 'nodes',
      data: { id: 2 }
    },
    { // edge ab
      group: 'edges',
      data: { id: 'ab', source: 'a', target: 2 }
    }
  ]);
// alert("noot");