/* globals React, moment */
'use strict';
var TimeField = React.createClass({

  getInitialState: function () {
    return { hover: false };
  },

  componentDidMount: function () {
    var fiftySeconds = 50000;
    this.ticker = setInterval(this.update, fiftySeconds);
  },

  componentWillUnmount: function () {
    if (this.ticker) {
      clearInterval(this.ticker);
      this.ticker = null;
    }
  },

  update: function () {
    if (this.isMounted()) {
      this.forceUpdate();
    }
  },

  render: function () {
    var momentTime = moment(this.props.time);
    return (
      <time onMouseOver={this.mouseOver} onMouseOut={this.mouseOut} dateTime={this.props.time}>{this.timestamp(momentTime)}</time>
    );
  },

  timestamp: function(time) {
    if (this.state.hover) { return time.format('llll'); }
    if (this.isOverAWeek(time)) { return time.fromNow(); }
    return time.fromNow();
  },

  isOverAWeek: function (time) {
      return Math.abs(moment().diff(time, 'days')) > 7;
  },

  mouseOver: function () {
      this.setState({ hover: true});
  },

  mouseOut: function() {
      this.setState({ hover: false});
  }
});

