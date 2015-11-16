var RatingForm = React.createClass({
        handleSubmit: function(action) {
                jQuery.ajax({
                        method: 'PATCH',
                        dataType: 'JSON',
                        url: '/submissions/' + this.props.submission.id + '/' + action,
                        data: {
                                notes: this.refs.textarea.state.text,
                                badge_ids: this.refs.badges.state.badge_ids
                        }
                }).success(function (response) {
                        $('#grade-modal').closeModal();
                        location.reload();
                }.bind(this));
        },

        render: function() {
                return (
                        <div id="grade-modal" className="modal modal-fixed-footer">
                                <div className="modal-content">
                                        <div className='row input-field col s12'>
                                                <MarkdownField ref='textarea' title='Submission Feedback' />
                                        </div>
                                        <Badges ref='badges' badges={this.props.badges} />
                                </div>
                                <div className="modal-footer">
                                        <a className="modal-action modal-close btn-flat" rel="nofollow" onClick={this.handleSubmit.bind(this, 'complete')}><i className="material-icons left">done</i> Complete</a>
                                        <a className="modal-action modal-close btn-flat" rel="nofollow" onClick={this.handleSubmit.bind(this, 'unfinish')}><i className="material-icons left">not_interested</i> Incomplete</a>
                                </div>
                        </div>
                );
        },
});
