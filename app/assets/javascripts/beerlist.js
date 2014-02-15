var BEERS = {};

BEERS.show = function() {
    var table = $('#beers_table');

    $('#beers_table tr:gt(0)').remove();

    $.each(BEERS.list, function(i, beer) {
	table.append('<tr>'
		     + '<td>' + beer['name'] + '</td>'
		     + '<td>' + beer['style'] + '</td>'
		     + '<td>' + beer['brewery']['name'] + '</td>'
		     + '</tr>');
    });
};

BEERS.sort_by_name = function(){
    BEERS.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BEERS.sort_by_style = function(){
    BEERS.list.sort( function(a,b){
        return a.style.toUpperCase().localeCompare(b.style.toUpperCase());
    });
};

BEERS.sort_by_brewery = function(){
    BEERS.list.sort( function(a,b){
        return a.brewery.name.toUpperCase().localeCompare(b.brewery.name.toUpperCase());
    });
};

$(document).ready(function() {
    $('#name_head').click(function(e) {
	BEERS.sort_by_name();
	BEERS.show();
	e.preventDefault();
    });

    $('#style_head').click(function(e) {
	BEERS.sort_by_style();
	BEERS.show();
	e.preventDefault();
    });

    $('#brewery_head').click(function(e) {
	BEERS.sort_by_brewery();
	BEERS.show();
	e.preventDefault();
    });

    if($('#beers_table').length > 0) {
	$.getJSON('beers.json', function(beers) {
	    BEERS.list = beers;
	    BEERS.sort_by_name();
	    BEERS.show();
	});	
    }
});
