/* globals React, jQuery */

var Submission = React.createClass({
        getInitialState: function () {
                return {
                        submission: this.props.submission,
                        editing: false
                };
        },
        handleNotesChange: function(event) {
                let submission = this.state.submission;
                submission.notes = event.target.value;
                this.setState({submission});
        },
        setEditing: function(editing) {
                this.setState({editing});
        },

        update: function () {
                jQuery.ajax({
                        method: 'PATCH',
                        dataType: 'JSON',
                        url: '/submissions/' + this.state.submission.id,
                        data: {
                                submission: {
                                        link: this.state.submission.link,
                                        notes: this.state.submission.notes
                                }
                        }
                }).success(function (response) {
                        this.setState({ submission: response, editing: false });
                }.bind(this));
        },

        render: function () {
                return (
                                <div className="card grey lighten-5">
                                <div className="card-content black-text">
                                <span className="card-title black-text">Submission</span>
                                <p>{this.submissionLink()}</p>
                                {this.submissionNotes()}
                                </div>
                                {this.renderActions()}
                                </div>
                       );
        },

        renderActions: function () {
                if (!this.props.canEdit) {
                        return (<div/>)
                } else if (this.state.editing) {
                        return (
                                <div className="card-action">
                                        <a onClick={this.setEditing.bind(this, false)}>Cancel</a>
                                        <a onClick={this.update}>Save</a>
                                        </div>
                               );
                } else {
                        return (
                                <div className="card-action">
                                        <a onClick={this.setEditing.bind(this, true)}>Edit</a>
                                        </div>);
                }
        },
        submissionLink: function () {
                if (this.state.editing) {
                        return (<div className='input-field row'>
                                        <Input ref='link' name="link" value={this.state.submission.link} />
                                        <label htmlFor="link">Link</label>
                                        </div>);
                } else {
                        return (<a href={this.state.submission.link}>{this.state.submission.link}</a>);
                }
        },
        submissionNotes: function () {
                if (this.state.editing) {
                        return (<div className='input-field row'>
                                        <textarea ref='notes' name="notes" className="materialize-textarea" value={this.state.submission.notes} onChange={this.handleNotesChange} />
                                        <label htmlFor="notes">Notes</label>
                                        </div>);
                } else {
                        return (<Markdown text={this.state.submission.notes} />);
                }
        }
});
