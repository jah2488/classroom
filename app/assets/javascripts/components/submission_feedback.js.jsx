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
                        <a className="modal-trigger waves-effect waves-light btn-flat" onClick={this.openModal}>
                          <i className="material-icons right">assignment</i>Grade
                        </a>
                </div>
            );
            } else {
              return ( <Ratings ratings={this.state.ratings}/> )
            }
    }
});
