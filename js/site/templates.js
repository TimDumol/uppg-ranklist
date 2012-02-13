// This file was automatically generated from templates.soy.
// Please don't edit this file by hand.

if (typeof tmpl == 'undefined') { var tmpl = {}; }


tmpl.user = function(opt_data, opt_sb) {
  var output = opt_sb || new soy.StringBuilder();
  output.append('<tr><td>', soy.$$escapeHtml(opt_data.user.name), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.rank), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.lrank), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.id), '</td><td><a href="http://uhunt.felix-halim.net/id/', soy.$$escapeHtml(opt_data.user.uva.id), '">', soy.$$escapeHtml(opt_data.user.uva.username), '</a></td><td>', soy.$$escapeHtml(opt_data.user.uva.ac), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.nos), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.tried), '</td><td><a title="', soy.$$escapeHtml(opt_data.lastUvaSub), '">', soy.$$escapeHtml(opt_data.lastUvaSubHumane), '</a></td>', (opt_data.user.euler.id) ? '<td>' + soy.$$escapeHtml(opt_data.user.euler.lrank) + '</td><td><a href="http://projecteuler.net/profile/' + soy.$$escapeHtml(opt_data.user.euler.id) + '.png">' + soy.$$escapeHtml(opt_data.user.euler.id) + '</a></td><td>' + soy.$$escapeHtml(opt_data.user.euler.solved) + '</td>' : '<td></td><td></td><td></td>', '</tr>');
  return opt_sb ? '' : output.toString();
};
