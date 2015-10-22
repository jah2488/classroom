var User = React.createClass({
        render: function() {
                return (
                        <div onClick={this.props.onClick}>
                                <div>Email: {this.props.data.email}</div>
                                <div>Name: {this.props.data.name}</div>
                        </div>
                );
        }
});
