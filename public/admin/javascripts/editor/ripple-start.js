$(document).ready(function(){
	var View = ripple('#template')
	  .use(ripple.events)
	  .use(ripple.markdown);

	View.prototype.change = function(event) {
	  this.set('text', event.target.value);  
	};

	var view = new View({
	  data: { 
	    text: $('#getTextFromHere').val()
	  }   
	});

	view.appendTo('#append-editor');
})