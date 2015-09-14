/* @flow */
/* globals React, jQuery */
var EditSubmission = React.createClass({
    getInitialState: function () {
        return { showNotitication: false, editing: false, submission: this.props.submission };
    },

    render: function () {
        return (
            <div>
                <Submission ref='submission' submission={this.state.submission} editing={this.state.editing} />
                <div className='row'>
                    <div className='actions col-md-12'>
                        {this.action()}
                    </div>
                </div>
            </div>
        );
    },

    action: function () {
        if (this.state.editing) {
            return (<span>
                <a onClick={this.handleClick} className='btn btn-sm btn-danger'>Cancel</a>
                <a onClick={this.handleSubmit} className='btn btn-sm btn-primary'>Submit</a>
                    </span>);
        } else {
          if (this.state.showNotitication) {
            return (<span> <Notification parentCallback={this.onDismiss} message="Submission Updated!" /> <div onClick={this.handleClick} className='btn btn-sm btn-primary'>Edit Your Submission</div></span>);
          } else {
            return ( <div onClick={this.handleClick} className='btn btn-sm btn-primary'>Edit Your Submission</div>);
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
