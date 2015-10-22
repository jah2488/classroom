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

var Badges = React.createClass({
        getInitialState: function () {
                return { badge_ids: {} };
        },

        handleChange: function (e) {
                var updated_badge_ids = this.state.badge_ids;
                updated_badge_ids[e.target.name] = e.target.checked;
                this.setState({ badge_ids: updated_badge_ids });
        },
        render: function () {
                if(this.props.badges) {
                        return (
                                <div className='row'>
                                        <div className='col s12 badges'>
                                                <div className='row'>
                                                        {this.props.badges.map(function (badge, i) {
                                                                var key = 'badge-' + badge.id;
                                                                return (
                                                                        <div key={key} className='col l1 m4 s6'>
                                                                                <span className='circle'>
                                                                                        <input ref={key} name={key} id={key} type='checkbox' onChange={this.handleChange} />
                                                                                        <label htmlFor={key}>
                                                                                                <img className="shadow-z-1 circle student-badge" tabIndex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" data-title={badge.title} data-content={badge.description} src={badge.icon_image} alt="Icon image" data-original-title="" title="" style={{width: '50px'}} />
                                                                                        </label>
                                                                                </span>
                                                                        </div>
                                                                        );
                                                        }.bind(this))}
                                                </div>
                                        </div>
                                </div>
                        );
                } else {
                        return (<div/> );
                }
        }
});
