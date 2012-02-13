// This file was automatically generated from templates.soy.
// Please don't edit this file by hand.

if (typeof tmpl == 'undefined') { var tmpl = {}; }


tmpl.user = function(opt_data, opt_sb) {
  var output = opt_sb || new soy.StringBuilder();
  output.append('<tr><td>', soy.$$escapeHtml(opt_data.user.name), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.rank), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.lrank), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.id), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.username), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.ac), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.nos), '</td><td>', soy.$$escapeHtml(opt_data.user.uva.tried), '</td>', (opt_data.user.euler.id) ? '<td>' + soy.$$escapeHtml(opt_data.user.euler.lrank) + '</td><td>' + soy.$$escapeHtml(opt_data.user.euler.id) + '</td><td>' + soy.$$escapeHtml(opt_data.user.euler.solved) + '</td>' : '<td></td><td></td><td></td>', '</tr>');
  return opt_sb ? '' : output.toString();
};
