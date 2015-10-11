/* @flow */
/* globals React, jQuery */
var EditSubmission = React.createClass({
    getInitialState: function () {
        return { showNotitication: false, editing: false, submission: this.props.submission };
    },

    render: function () {
        return (
            <Submission ref='submission' submission={this.state.submission} editing={this.state.editing}>
                <div className='card-action'>
                    {this.action()}
                </div>
            </Submission>
        );
    },

    action: function () {
        if (this.state.editing) {
            return (<span>
                <a onClick={this.handleClick}>Cancel</a>
                <a onClick={this.handleSubmit}>Submit</a>
                    </span>);
        } else {
          if (this.state.showNotitication) {
            return (<span> <Notification parentCallback={this.onDismiss} message="Submission Updated!" /> <a onClick={this.handleClick}>Edit</a></span>);
          } else {
            return ( <a onClick={this.handleClick}>Edit</a>);
          }
        }
    },

    onDismiss: function () { this.setState({showNotitication: false}); },
    handleClick: function () {
        var state = this.state.editing ? false : true;
        this.setState({editing: state});
    },

    handleSubmit: function () {
        jQuery.ajax({
            method: 'PATCH',
            url: '/submissions/' + this.props.submission.id,
            data: {
                submission: {
                    link: this.refs.submission.refs.link.state.value,
                    notes: this.refs.submission.refs.notes.state.value
                }
            }
        }).done(function (response) {
          this.setState({ showNotitication: true, submission: response, editing: false });
        }.bind(this));
    }
});
