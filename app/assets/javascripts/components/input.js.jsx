/* globals React */
var Input = React.createClass({
        getInitialState: function () {
                return { value: this.props.value };
        },

        getDefaultProps: function () {
                return { type: 'text', name: "" };
        },

        render: function () {
                return (
                        <input name={this.props.name} type={this.props.type} className={this.props.className} onChange={this.handleChange} value={this.state.value} />
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
