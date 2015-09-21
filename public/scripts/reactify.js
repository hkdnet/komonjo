var LoginButton = React.createClass({
  render: function() {
    return(
      <button className="login-button" onClick={this.props.onClick}>
        Login
      </button>
    )
  }
});
var LoginRow = React.createClass({
  handleClick: function(e) {
    e.preventDefault();
    toastr.info('Processing...', 'login');
    var token = React.findDOMNode(this.refs.token).value;
    $.post("/api/login", { api_token : token }, "JSON").then(function(d) {
      if(d.ok) {
        toastr.success('logged in', 'login');
      } else {
        toastr.error(d.message, 'login');
      }
    }, function(d) {
      toastr.erro('Sorry, something went wrong...', 'login');
    })
  },
  render: function() {
    return(
      <div>
        <span>Slack API Token: </span>
        <input ref="token" type="password" />
        <LoginButton onClick={this.handleClick} />
      </div>
    )
  }
});

var ChannelButton = React.createClass({
  render: function() {
    return(
      <li className="channel-button">
        <span className="fa fa-television" />
        <span>
          {this.props.channelName}
        </span>
      </li>
    )
  }
});
var ChannelRow = React.createClass({
  render: function() {
    var channelButtons = this.props.channels.map(function(e) {
      return(
        <ChannelButton channelName={e} />
      )
    });
    return(
      <ul className="channel-buttons">
        {channelButtons}
      </ul>
    )
  }
})
var MenuColumn = React.createClass({
  getChannels: function() {
    var channels = ["hoge", "fuga", "piyo"];
    return channels;
  },
  render: function() {
    return(
      <div className="menu-column">
        <LoginRow />
        <ChannelRow channels={this.getChannels()} />
      </div>
    );
  }
});
var ViewerColumn = React.createClass({
  render: function () {
    return(
      <div className="viwer-column">
      </div>
    )
  }
})
var KomonjoScreen = React.createClass({
  render: function() {
    return(
      <div className="komonjo-screen">
        <MenuColumn />
        <ViewerColumn />
      </div>
    )
  }
})

React.render(
  <MenuColumn />,
  document.getElementById('react')
)
