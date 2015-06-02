/* global React, jQuery, marked */

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
            data: { notes: this.refs.textarea.state.text}
        }).done(function (response) {
            this.refs.textarea.text = '';
            this.setState({ sent: true });
        }.bind(this));
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
                <section>
                    <div className='row'>
                        <MarkdownField ref='textarea' title='Submission Feedback' />
                    </div>
                    <div className='row'>
                        <div className='actions col-sm-12'>
                            <a className="btn btn-primary" rel="nofollow" onClick={this.handleClick.bind(this, 'complete')}>Mark as Complete</a>
                            <a className="btn btn-default" rel="nofollow" onClick={this.handleClick.bind(this, 'unfinished')}>Mark as Unfinished</a>
                        </div>
                    </div>
                </section>
            );
        }
    }
});
//                    <p className='muted'>Preview</p>
//                    <section dangerouslySetInnerHTML={ this.toMarkdown() }/>
//
//                    <p className='muted'>Submission Grade Notes</p>
//                    <section>
//                        <textarea onKeyDown={this.handleChange} className="text required form-control" name="feedback[notes]" id="feedback_notes" />
//
