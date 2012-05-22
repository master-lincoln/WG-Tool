// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require highcharts
//= require jquery.tokeninput
//= require_tree .

function roundTwo(value) {
	return Math.round(100*value)/100
}

$(function(){

	// drop down mail settings box
	$('#mail-box:first').toggle();
	$('#mail-btn').click(function() {
		$('#mail-box:first').slideToggle();
	});
	// draw standings chart
	var chart = new Highcharts.Chart({
		chart: {
			renderTo: 'chart',
			defaultSeriesType: 'column'
		},
		title: {
			text: 'Schuldenverteilung'
		},
		xAxis: {
			categories: ['Schulden',]
		},
		yAxis: {
			 title: {
				text: 'Guthaben in €'
			 }
		},
		tooltip: {
			formatter: function() {
				return ''+
					 this.series.name +': '+ roundTwo(this.y)+'€';
			}
		},
		plotOptions: {
			column: {
				dataLabels: {
				   enabled: true,
					color: '#334477',
				   style: {
					  fontWeight: 'bold'
				   },
				   formatter: function() {
					  return roundTwo(this.y) +' €';
				   }
				}
			}
		},    
		credits: {
			enabled: false
		},
		series: standings,
		exporting : {
			enabled: false
		}
	});
});

