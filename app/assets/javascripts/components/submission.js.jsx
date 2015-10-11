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
            <div className="card teal darken-1">
              <div className="card-content white-text">
                <span className="card-title white-text">Submission</span>
                <p>{this.submissionLink()}</p>
                {this.submissionNotes()}
              </div>
              {this.props.children}
            </div>
        );
    },
    submissionLink: function () {
        if (this.props.editing) {
            return (<div className='input-field'>
                <Input ref='link' name="link" value={this.props.submission.link} />
                <label htmlFor="link">Link</label>
            </div>);
        } else {
            return (<a href={this.props.submission.link}>{this.props.submission.link}</a>);
        }
    },
    submissionNotes: function () {
        if (this.props.editing) {
            return (<div className='input-field'>
                <Input ref='notes' name="notes" className="materialize-textarea" value={this.props.submission.notes} />
                <label htmlFor="notes">Notes</label>
            </div>);
        } else {
            return (<Markdown text={this.props.submission.notes} />);
        }
    }
});
