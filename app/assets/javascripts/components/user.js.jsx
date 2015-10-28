var User = React.createClass({
        render: function() {
                return (
                        <div onClick={this.props.onClick}>
                                <div>Email: {this.props.user.attributes.email}</div>
                                <div>Name: {this.props.user.attributes.name}</div>
                        </div>
                );
        }
});
