var LoginButton = React.createClass({
  render: function() {
    return(
      <button className="btn btn-default login-button" onClick={this.props.onClick}>
        Login
      </button>
    )
  }
});
var LoginRow = React.createClass({
  getInitialState: function() {
    client.login().then(function(d) {
      this.setState(d);
    }.bind(this));
    return {token: ''};
  },
  handleClick: function(e) {
    e.preventDefault();
    toastr.info('Processing...', 'login');
    var token = this.state.token;
    var afterLogin = this.props.afterLogin || function() {};
    client.login(token).then(function(d) {
      toastr.success('logged in', 'login');
      afterLogin();
    });
  },
  handleChange: function(e) {
    e.preventDefault();
    this.setState({
      data: e.target.value
    });
  },
  render: function() {
    return(
      <div>
        <label htmlFor="token">Slack API Token: </label>
        <input placeholder="slack api token" ref="token" type="password"
          value={this.state.data} name="token" className="form-control"
          onChange={this.handleChange} />
        <LoginButton onClick={this.handleClick} />
      </div>
    )
  }
});
var ChannelButton = React.createClass({
  handleClick: function(e) {
    this.props.afterSelectChannel({
      channelName: this.props.channelName
    });
  },
  render: function() {
    return(
      <li className="list-unstyled channel-button" onClick={this.handleClick} >
        <i className="fa fa-television" />
        <span>
          {this.props.channelName}
        </span>
      </li>
    )
  }
});
var ChannelRow = React.createClass({
  render: function() {
    var afterSelectChannel = this.props.afterSelectChannel;
    var channelButtons = this.props.channels.map(function(e) {
      return(
        <ChannelButton channelName={e} afterSelectChannel={afterSelectChannel} />
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
    client.channels().then(function(d) {
      this.setState(d);
    }.bind(this));
  },
  getInitialState: function() {
    return {data: []};
  },
  render: function() {
    return(
      <div className="col-md-3 column menu-column">
        <LoginRow afterLogin={this.getChannels}/>
        <ChannelRow channels={this.state.data} afterSelectChannel={this.props.afterSelectChannel}/>
      </div>
    );
  }
});
var MessageIcon = React.createClass({
  render: function() {
    return (
      <div className="col-md-2 message-icon">
        <img className="img-rounded" src={this.props.src} />
      </div>
    )
  }
});
var MessageHeader = React.createClass({
  render: function() {
    return(
      <div className="message-header row">
        <div className="message-username col-md-4">{this.props.name}</div>
        <div className="message-timestamp col-md-8">{this.props.ts}</div>
      </div>
    )
  }
})
var Message = React.createClass({
  render: function() {
    return (
      <div className="message" data-md="">
        <MessageIcon src="https://avatars.slack-edge.com/2015-07-20/7916335493_befb8f27e45d5ccade4b_48.jpg" />
        <div className="col-md-6">
          <MessageHeader name="name001" ts="70/01/01 00:00:00"/>
          <div className="row message-text">
            <pre className="col-md-12">Hello, world</pre>
          </div>
        </div>
      </div>
    );
  }
});
var Messages = React.createClass({
  getMessagesByChannelName: function(channelName) {
    client.messages(channelName).done(function (d){
      this.setState(d);
    })
  },
  render: function() {
    var arr = [0, 1, 2];
    var messages = arr.map(function(e){
      return (
        <Message />
      )
    });
    return(
      <div className="messages">
        {messages}
      </div>
    )
  }
});
var ViewerColumn = React.createClass({
  render: function () {
    return(
      <div className="col-md-9 column viewer-column">
        <h2>
          {this.props.channelName}
        </h2>
        <Messages />
      </div>
    )
  }
})
var KomonjoScreen = React.createClass({
  getInitialState: function() {
    return {
      channelName: ''
    };
  },
  afterSelectChannel: function(d) {
    this.setState(d);
  },
  render: function() {
    return(
      <div className="row komonjo-screen">
        <MenuColumn afterSelectChannel={this.afterSelectChannel} />
        <ViewerColumn channelName={this.state.channelName} />
      </div>
    )
  }
})

React.render(
  <KomonjoScreen />,
  document.getElementById('react')
)
