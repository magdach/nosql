couchapp = require('couchapp');
ddoc = {
				    _id: '_design/app'
										  , views: {}
}
module.exports = ddoc;

ddoc.views.by_titlelong = {
	map: function(doc) {
		if(doc.title_long == null)
			emit("one_title", 1);
		else
			emit("two_titles", 1);
		},
	reduce: "_sum"
}

ddoc.views.by_numbers = {
	map: function(doc) {
			var cyferki = doc.isbn.split("");
			
			for (var i = 0, len = cyferki.length; i < len; i++) {
				var n = cyferki[i];
				if (n != '') {
					emit(n, 1);
				}
			}
			
			
		},
	reduce: "_sum"
}

