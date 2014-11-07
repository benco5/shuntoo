$(document).ready(function() {
	//alert('DOM has loaded.');
	new Morris.Bar({
	  element: 'responses_chart',						// ID of the chart element
	  data: $('#responses_chart').data('responses'),	// Chart data
	  xkey: 'choice_content',							 
	  ykeys: ['pip_sum'],
	  labels: ['Sum']
	});
});

