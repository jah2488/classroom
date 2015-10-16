var RatingList = React.createClass({
        render: function() {
           return (
                <div>
                {this.props.ratings.map(function (rating) {
                  return (
                          <div className="card grey lighten-5" key={rating.id}>
                          <div className="card-content">
                          <span className="card-title black-text">Feedback from <TimeField time={rating.created_at}/></span>
                          <Markdown text={rating.notes} />
                          </div>
                          <div className="card-action">
                          <a href="#">Edit</a>
                          </div>
                          </div>
                 );
                }.bind(this))}
                </div>
            )
        }
});
