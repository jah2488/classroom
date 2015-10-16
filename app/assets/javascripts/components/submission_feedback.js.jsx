/* global React, jQuery, marked */

var SubmissionFeedback = React.createClass({
    getInitialState: function() {
      return {
        ratings: this.props.ratings
      }
    },

    openModal: function() {
       $('#grade-modal').openModal();
    },

    render: function () {
            if(this.props.canGrade) {
            return (
                <div>
                        <RatingList ratings={this.state.ratings} />
                        <RatingForm badges={this.props.badges} submission={this.props.submission} />
                        <div className="fixed-action-btn" htmlStyle="bottom: 45px; right: 24px;">
                                <a className="btn-floating btn-large blue" onClick={this.openModal}>
                                  <i className="material-icons large">feedback</i>
                                </a>
                        </div>
                </div>
            );
            } else {
              return ( <Ratings ratings={this.state.ratings}/> )
            }
    }
});
