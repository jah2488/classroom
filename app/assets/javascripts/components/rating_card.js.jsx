var RatingCard = React.createClass({
        render: function() {
                return (
                          <div className="card grey lighten-5">
                          <div className="card-content">
                          <span className="card-title black-text">Feedback from <TimeField time={this.props.rating.created_at}/></span>
                          <Markdown text={this.props.rating.notes} />
                          </div>
                          <div className="card-action">
                          <a href="#">Edit</a>
                          </div>
                          </div>

                )
        }
});
