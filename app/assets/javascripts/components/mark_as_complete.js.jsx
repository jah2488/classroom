/* global React, jQuery */
var MarkAsComplete = React.createClass({
    getInitialState: function () {
        return {
            sent: false
        };
    },
    handleClick: function () {
        jQuery.ajax({
            method: 'PATCH',
            url: '/submissions/' + this.props.submissionID + '/' + 'complete'
        }).done(function (response) {
            this.setState({ sent: true });
        }.bind(this));
    },
    render: function () {
        if (this.state.sent) {
            return (
                <div>
                    <div className="alert alert-success alert-dismissible" role="alert">
                        <button type="button" className="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        Complete
                    </div>
                </div>
            );
        } else {
            return (
                <button onClick={this.handleClick} type="button" className="btn btn-xs btn-success" aria-label="Correct">
                  <span className="glyphicon glyphicon-ok" aria-hidden="true"></span>
                </button>
            );
        }
    }
});
