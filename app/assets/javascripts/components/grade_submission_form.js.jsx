/* global React, jQuery */

var Link = React.createClass({
  classes: function () {
    var defaults = 'btn btn-default btn-large';
    if (this.props.url) {
        return defaults;
    } else {
        return defaults + ' disabled';
    }
  },
  render: function () {
      return ( <a className={this.classes()} href={this.props.url}>{this.props.text}</a>);
  }
});

var GradeSubmissionForm = React.createClass({
    getInitialState: function () {
        return {
            submissionID: this.props.submissionID,
            ratingNotes: '',
            sent: false
        };
    },
    handleClick: function(action) {
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
                <div className='actions'>
                    <div className="alert alert-success alert-dismissible" role="alert">
                        <button type="button" className="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong>Success!</strong> Feedback Sent.
                    </div>
                    <Link url='/instructor/dashboard' text="Return to Dashboard"/>
                    <Link url={this.props.nextForStudent} text="Next Submission For Student"/>
                    <Link url={this.props.nextForAssignment} text="Next Submission For Assignment"/>
                </div>
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
