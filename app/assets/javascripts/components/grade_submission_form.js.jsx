/* global React, jQuery */

var GradeSubmissionForm = React.createClass({
    getInitialState: function () {
        return {
            submissionID: this.props.submissionID,
            ratingNotes: '',
            sent: false
        };
    },
    handleClick: function(action) {
        console.log(action, ' clicked');
        jQuery.ajax({
            method: 'PATCH',
            url: '/submissions/' + this.state.submissionID + '/' + action,
            data: { notes: this.state.ratingNotes }
        }).done(function (response) {
            this.setState({ ratingNotes: '', sent: true });
        }.bind(this));
    },
    handleChange: function (event) {
        this.setState({ ratingNotes: event.target.value });
    },
    render: function () {
        if (this.state.sent) {
            return (
                <a className='btn btn-default btn-large' href='/instructor/dashboard'>Feedback Sent. Return to Dashboard</a>
            );
        } else {
            return (
                <div>
                    <p className='muted'>Submission Grade Notes</p>
                    <section>
                        <textarea onKeyUp={this.handleChange} className="text required form-control" name="feedback[notes]" id="feedback_notes" />
                        <p className="help-block">Put markdown in me</p>
                        <div className='actions'>
                            <a className="btn btn-primary" rel="nofollow" onClick={this.handleClick.bind(this, 'complete')}>Mark as Complete</a>
                            <a className="btn btn-default" rel="nofollow" onClick={this.handleClick.bind(this, 'unfinished')}>Mark as Unfinished</a>
                        </div>
                    </section>
                </div>
            );
        }
    }
});
