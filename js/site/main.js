"use strict";
$(function() {
  // Error handling
  $.ajaxSetup({
      error: function(jqXHR, status, error) {
        $('#generic-ajax-error').show().delay(2000).hide('fast');
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
        // Already in users.json
        return $.Deferred().resolve();
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
            lastUvaSubHumane: self.uva.subs ? humaneDate(new Date(self.uva.subs[self.uva.subs.length-1][4]*1000)).
            toLowerCase() : "",
            lastUvaSub: self.uva.subs ? (new Date(self.uva.subs[self.uva.subs.length-1][4]*1000)).toString() : ""
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
          x.el.detach();
          self.el.append(x.el);
        }
      }
    },
    updateUvaRanks: function() {
      this.list.sort(function(x, y) {
        var xSolved = -1;
        if (typeof(x.euler.solved) === 'number') xSolved = x.euler.solved;
        var ySolved = -1;
        if (typeof(y.euler.solved) === 'number') ySolved = y.euler.solved;
        return ySolved - xSolved;
      });
      for (var i = 0; i < this.list.length; ++i) {
        this.list[i].euler.lrank = i+1;
      }
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

  var users;

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

  $.ajax({
      url: 'js/site/users.json',
      type: 'GET',
      dataType: 'json'
  }).done(function(userJSON) {
    users = Users.create({
        list: $.map(userJSON, function(x) { return User.create(x); })
    });
    users.el = $('#users tbody');
    updateAndRenderAll();
    $('#refresh-rankings').click(updateAndRenderAll);
  });

});
