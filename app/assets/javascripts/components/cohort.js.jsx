var Cohort = React.createClass({
  render: function() {
    return (
      <div onClick={this.props.onClick}>
        <div>{this.props.data.name}</div>
      </div>
    );
  }
});
