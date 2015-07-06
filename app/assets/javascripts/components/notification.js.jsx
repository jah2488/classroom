/* global React, jQuery, marked */

var Notification = React.createClass({
    getInitialState: function () {
        return { visible: true };
    },
    getDefaultProps: function () {
        return { type: 'success' };
    },
    render: function () {
        var classNames = "alert alert-dismissible";
        classNames += " alert-" + this.props.type;
        if (this.state.visible) {
            return (
                <div className={classNames} role="alert">
                    <button onClick={this.handleClick} type="button" className="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    {this.props.message}
                </div>
            );
        } else {
            return (<div/>);
        }
    },

    handleClick: function (e) {
        e.preventDefault();
        this.setState({ visible: false });
        if (this.props.parentCallback) {
            this.props.parentCallback();
        }
    }
});
