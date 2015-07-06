/* globals React */
var Input = React.createClass({
    getInitialState: function () {
        return { value: this.props.value };
    },

    getDefaultProps: function () {
        return { type: 'text' };
    },

    render: function () {
        return (
            <input type={this.props.type} className='required form-control' onChange={this.handleChange} value={this.state.value} />
        );
    },

    handleChange: function (e) {
        if (e) {
            this.setState({
                value: e.target.value
            });
        }
    },

    clear: function () {
        this.setState({
            value: this.props.value
        });
    }
});
