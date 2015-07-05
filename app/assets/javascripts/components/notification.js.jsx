/* global React, jQuery, marked */

var Notification = React.createClass({
    render: function () {
        var classNames = "alert alert-dismissible";
        classNames += " alert-" + this.props.type;
        return (
            <div className={classNames} role="alert">
                <button type="button" className="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                {this.props.message}
            </div>
        );
    }
});
