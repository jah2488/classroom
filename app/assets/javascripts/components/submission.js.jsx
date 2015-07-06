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
            <div>
              <p className='muted'>Submission</p>
              <section>
                  <p>{this.submissionLink()}</p>
              </section>

              <p className='muted'>Student Notes</p>
              <section>
                  {this.submissionNotes()}
              </section>
            </div>
        );
    },
    submissionLink: function () {
        if (this.props.editing) {
            return (<div className='form-inputs'>
                <label className='string required control-label'>Link</label>
                <Input ref='link' value={this.props.submission.link} />
            </div>);
        } else {
            return (<a href={this.props.submission.link}>{this.props.submission.link}</a>);
        }
    },
    submissionNotes: function () {
        if (this.props.editing) {
            return (<div className='form-inputs'>
                <label className='string required control-label'>Notes</label>
                <Input ref='notes' value={this.props.submission.notes} />
            </div>);
        } else {
            return (<Markdown text={this.props.submission.notes} />);
        }
    }
});
