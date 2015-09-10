/* global React, jQuery, marked */

var Link = React.createClass({
  render: function () {
      return ( <a className={this.classes()} href={this.props.url}>{this.props.text}</a>);
  },

  classes: function () {
    var defaults = 'btn btn-default btn-primary btn-large';
    if (this.props.url) { return defaults; }
    return defaults + ' disabled';
  }
});

var Nav = React.createClass({
    render: function () {
        return (
            <div>
                <Link url={this.props.nextForStudent} text="Next Submission For Student"/>
                <Link url={this.props.nextForAssignment} text="Next Submission For Assignment"/>
            </div>
        );
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
            dataType: 'JSON',
            url: '/submissions/' + this.state.submissionID + '/' + action,
            data: {
                notes: this.refs.textarea.state.text,
                badge_ids: this.refs.badges.state.badge_ids
            }
        }).done(function (response) {
            this.refs.textarea.text = '';
            this.setState({ sent: true });
        }.bind(this));
    },

    handleSend: function () {
        jQuery.ajax({
            method: 'POST',
            url: '/ratings/',
            data: { rating: { submission_id: this.props.submissionID, notes: this.refs.textarea.state.text } }
        }).done(function (response) {
            this.refs.textarea.text = '';
            this.setState({ sent: true });
        }.bind(this));
    },

    render: function () {
        if (this.state.sent) {
            return (
                <div className='actions'>
                    <Notification type='success' message='Success! Feedback Sent.' />
                    <Nav nextForStudent={this.props.nextForStudent} nextForAssignment={this.props.nextForAssignment} />
               </div>
            );
        } else {
            return (
                <section>
                    <div className='row'>
                        <MarkdownField ref='textarea' title='Submission Feedback' />
                    </div>
                    <Badges ref='badges' badges={this.props.badges} />
                    <div className='row'>
                        <div className='actions col-sm-12'>
                            <a className="btn btn-success" rel="nofollow" onClick={this.handleClick.bind(this, 'complete')}>Mark as Complete</a>
                            <a className="btn btn-warning" rel="nofollow" onClick={this.handleClick.bind(this, 'unfinish')}>Mark as Unfinished</a>
                            <a className="btn btn-primary" rel="nofollow" onClick={this.handleSend}>Send Feedback</a>
                        </div>
                    </div>
                    <div className='row'>
                        <div className='actions col-sm-12'>
                            <Nav nextForStudent={this.props.nextForStudent} nextForAssignment={this.props.nextForAssignment} />
                        </div>
                    </div>
                </section>
            );
        }
    }
});

var Badges = React.createClass({
    getInitialState: function () { return { badge_ids: {} }; },
    handleChange: function (e) {
        var updated_badge_ids = this.state.badge_ids;
        updated_badge_ids[e.target.name] = e.target.checked;
        this.setState({ badge_ids: updated_badge_ids });
    },
    render: function () {
        return (
            <div className='row'>
              <div className='col-sm-12 badges'>
                  <div className='row'>
                  {this.props.badges.map(function (badge, i) {
                      var key = 'badge-' + badge.id;
                      return (
                          <div key={key} className='col-md-1 col-sm-4 col-xs-6'>
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
    }
});
