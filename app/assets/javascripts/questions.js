$(document).ready(function() {
	new Morris.Bar({
	  // ID of the element in which to draw the chart.
	  element: 'responses_chart',
	  // Chart data records -- each entry in this array corresponds to a point on
	  // the chart.
	  data: $('#responses_chart').data('responses'),
	  xkey: 'choice_content',
	  ykeys: ['pip_sum'],
	  labels: ['B']
	});
});

// $(document).on('page:load', ready)