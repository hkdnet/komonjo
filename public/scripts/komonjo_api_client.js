var Client = function() {
  var base = function(url, method, data) {
    data = data || {};
    method = method || '';
    method.toUpperCase();
    var dfd;
    switch (method) {
      case 'GET':
        dfd = $.get(url, data, 'JSON');
        break;
      case 'POST':
        dfd = $.post(url, data, 'JSON');
        break;
      default:
        throw new Error('unknown method');
    }
    return dfd.fail(function() {
      toastr.error('Sorry, something went wrong...')
    }).then(function(d) {
      if(d.ok) {
        return d;
      }
      toastr.error(d.message);
      throw new Error('bad request');
    });
  };
  this.login = function(api_token) {
    if(api_token) {
      return base('/api/login', 'POST', {api_token: api_token});
    } else {
      return base('/api/login', 'GET');
    }
  };
  this.channels = function() {
    return base('/api/channels', 'GET');
  };
};

var client = new Client();
