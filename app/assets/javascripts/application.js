// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require highcharts.js
//= require_tree .



// draw standings chart
$(function(){
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
					 this.series.name +': '+ this.y +'€';
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
					  return this.y +' €';
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

