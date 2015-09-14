/* globals React, jQuery */

var Submission = React.createClass({
    getInitialState: function () {
        return {
            link: this.props.submission.link,
            notes: this.props.submission.notes
        };
    },
    render: function () {
        return (
            <dl>
              <dt>Submission</dt>
              <dd>{this.submissionLink()}</dd>
              <dt>Student Notes</dt>
              <dd>{this.submissionNotes()}</dd>
            </dl>
        );
    },
    submissionLink: function () {
        if (this.props.editing) {
            return (<div className='form-inputs'>
                <Input ref='link' value={this.props.submission.link} />
            </div>);
        } else {
            return (<a href={this.props.submission.link}>{this.props.submission.link}</a>);
        }
    },
    submissionNotes: function () {
        if (this.props.editing) {
            return (<div className='form-inputs'>
                <Input ref='notes' value={this.props.submission.notes} />
            </div>);
        } else {
            return (<Markdown text={this.props.submission.notes} />);
        }
    }
});
