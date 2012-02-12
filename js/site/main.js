"use strict";
// Error handling
$.ajaxSetup({
  error: function(jqXHR, status, error) {
    $('#generic-ajax-error').show().delay(2000).fade();
  }
});

var updateProgress = function(x) {
  var percent = Math.round(x*100);
  $('#progress-text').html(percent + '%');
  $('#progress-bar').css('width', percent + '%');
  if (percent === 100) {
    $('#progress-text').css('left', '40%');
  } else {
    $('#progress-text').css('left', '45%');
  }
};

/// An Euler/UVa user
var User = {
  /// Creates a User instance
  create: function(attrs) {
    var user = Object.create(User);
    // Copy namespaced attributes
    user.uva = Object.create(User.uva);
    if (typeof(attrs.uva) === 'object') {
      $.extend(user.uva, attrs.uva);
      delete attrs.uva;
    }
    user.euler = Object.create(User.euler);
    if (typeof(attrs.euler) === 'object') {
      $.extend(user.euler, attrs.euler);
      delete attrs.euler;
    }
    // Copy everything else
    $.extend(user, attrs);
    user.loaded = false;
    _.bindAll(user);
    _.bindAll(user.uva);
    _.bindAll(user.euler);
    return user;
  },
  /// UVa related functions and attributes
  uva: {
    /// Fetches UVa statistics
    fetch: function() {
      var self = this;
      if (typeof(self.id) === 'number') {
        // Get problem submissions for last submisson
        return $.when($.get('http://uhunt.felix-halim.net/api/subs/' + self.id).
        done(function(data) {
          data.subs = $.parseJSON(data.subs);
          $.extend(self, data);
          self.subs.sort(function(x,y) { return x[4] - y[4]; });
          self.tried = 0;
          var map = {};
          for (var i = 0; i < self.subs.length; ++i) {
            var probId = self.subs[i][1];
            if (typeof(map[probId]) === 'undefined') {
              map[probId] = true;
              ++self.tried;
            }
          }
        }),
        // Get ranklist for other stats
        $.get('http://uhunt.felix-halim.net/api/ranklist/' +
            self.id + '/0/0').done(function(data) {
            $.extend(self, data[0]);
        }));
      } else {
        return $.Deferred().resolve().promise();
      }
    }
  },
  /// Project Euler related functions and attributes
  euler: {
    /// Fetches Project Euler statistics
    fetch: function() {
      return $.Deferred().resolve();
      var self = this;
      if (typeof(self.id) === 'string') {
        return $.get('http://projecteuler.net/profile/' + self.id + '.txt').
          done(function(data) {
            var frags = data.split(',');
            self.nSolved = +frags[3].split(' ')[1];
          });
      } else {
        return $.Deferred().resolve();
      }
    }
  },
  /// Fetches UVa and Project Euler statistics
  fetch: function() {
    var self = this;
    return $.when(self.uva.fetch(), self.euler.fetch()).done(function() {
      self.loaded=true;
    });
  },
  /// Renders this User
  render: function() {
    var self = this;
    var rendered = $(tmpl.user({
      user: self,
      lastUvaSub: self.uva.subs ? humaneDate(new Date(self.uva.subs[self.uva.subs.length-1][4]*1000)).
        toLowerCase() : ""
    }));
    if (typeof(self.el) !== 'undefined') {
      self.el.replaceWith(rendered);
    }
    self.el = rendered;
    self.el.data('user', this);
    return self.el;
  },
};

// Represents a collection of users
var Users = {
  /// Creates a Users instance
  create: function(attrs) {
    var users = $.extend(Object.create(Users), attrs);
    _.bindAll(users);
    return users;
  },
  /// Fetches statistics for all Users in this collection
  fetch: function() {
    return $.map(this.list, function(x) { return x.fetch(); });
  },
  /// Renders all Users in this collection
  render: function() { 
    var self = this;
    for (var i = 0; i < this.list.length; ++i) {
      var x = this.list[i];
      if (x.loaded) {
        if (typeof(x.el) === 'undefined') {
          self.el.append(x.render());
        } else {
          x.render();
        }
      }
    }
  },
  updateUvaRanks: function() {
    this.list.sort(function(x, y) {
      var xAc = -1;
      if (typeof(x.uva.ac) === 'number') xAc = x.uva.ac;
      var yAc = -1;
      if (typeof(y.uva.ac) === 'number') yAc = y.uva.ac;
      return yAc - xAc;
    });
    for (var i = 0; i < this.list.length; ++i) {
      this.list[i].uva.lrank = i+1;
    }
  }
};


var users = Users.create({
  list: $.map([{
    uva: { id: 19304 },
    name: 'Krzysztof Stencel (Top of UVa)'
  }, {
    uva: { id: 339 },
    name: 'Felix Halim (maker of uHunt)'
  }, {
    uva: { id: 95830 },
    name: 'Kevin Atienza',
    euler: { id: 'kevinsogo' }
  }/*, {
    uva: { id: 23638 },
    name: 'Neil Armin Bande (retired)'
  }, {
    uva: { id: 52978 },
    name: 'Tim Dumol',
    euler: { id: 'timdumol' }
  }, {
    uva: { id: 58112 },
    name: 'Karl Pilario',
    euler: { id: 'kspilario' }
  }, {
    uva: { id: 27698 },
    name: 'Alvin John Burgos',
    euler: { id: 'ajmburgos09' }
  }, {
    uva: { id: 43087 },
    name: 'JE Ayson',
    euler: { id: 'jester_vg086' }
  }, {
    uva: { id: 76660 },
    name: 'Angel Jaurigue, Jr.',
    euler: { id: 'angel.jaurigue.jr' }
  }, {
    uva: { id: 71704 },
    name: 'Jared Guissmo Asuncion',
    retired: true,
    euler: { id: 'guissmo' }
  }, {
    uva: { id: 30424 },
    name: 'Kevin Atienza (Fake account)'
  }, {
    uva: { id: 74680 },
    name: 'Hykinel Bon Guarte',
    euler: { id: 'hykinel' }
  }, {
    uva: { id: 73412 },
    name: 'Payton Yao',
    euler: { id: 'Peetoon' }
  }, {
    uva: { id: 63125 },
    name: 'Thomas James Mendoza'
  }, {
    uva: { id: 58813 },
    name: 'John Ruperto Celis'
  }, {
    uva: { id: 96544 },
    name: 'Neil Irwin Bernardo'
  }, {
    uva: { id: 76871 },
    name: 'Iman Encarnacion'
  }, {
    uva: { id: 96512 },
    name: 'Juancho Coronel'
  }, {
    uva: { id: 57633 },
    name: 'Jeffrey Go',
    euler: { id: 'greedypiggy' }
  }, {
    uva: { id: 96503 },
    name: 'Gabriel Canovas',
    euler: { id: 'gabs' }
  }, {
    uva: { id: 98379 },
    name: 'Bryan Ayson'
  }, {
    uva: { id: 41719 },
    name: 'Alberto de Villa',
    retired: true
  }, {
    uva: { id: 41434 },
    name: 'Julian Villaruz',
    retired: true,
    euler: { id: 'julianvillaruz' }
  }, {
    uva: { id: 41067 },
    name: 'Neil John Ortega',
    retired: true
  }, {
    uva: { id: 95874 },
    name: 'Daryll Panaligan'
  }, {
    uva: { id: 98637 },
    name: 'Jepoy Baduria'
  }, {
    uva: { id: 114410 },
    name: 'Jerome Beltran'
  }, {
    uva: { id: 111001 },
    name: 'Dexter Edep'
  }, {
    uva: { id: 65674 },
    name: 'Adrian Vidal',
    euler: { id: 'adrianvidal' }
  }, {
    uva: { id: 124235 },
    name: 'Iman Encarnacion (2nd Account)'
  }, {
    uva: { id: 81382 },
    name: 'Charles Verdad'
  }, {
    name: 'Luke Wicent Sy',
    euler: { id: 'sy_lukewicent' },
    retired: true,
    uva: { id: 41739 }
  }, {
    name: 'Marte Soliza',
    euler: { id: 'myrtacle' },
    retired: true
  }*/], function(x) { return User.create(x); })
});;

var updateAndRenderAll = function() {
  updateProgress(0);
  $('#refresh-rankings').button('loading');
  var nUpdated = 0;
  $.each(users.fetch(), function(idx, def) {
    def.done(function() {
      ++nUpdated;
      updateProgress(nUpdated/users.list.length);
      if (nUpdated == users.list.length) {
        $('#refresh-rankings').button('reset');
      }
      users.updateUvaRanks();
      users.render();
    });
  });
};

var updateUva = function() {
  
};

var updateEuler = function() {

};

$(function() {
  users.el = $('#users tbody');
  updateAndRenderAll();
  $('#refresh-rankings').click(updateAndRenderAll);
});
