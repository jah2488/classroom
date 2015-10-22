var RatingList = React.createClass({
        render: function() {
                return (
                        <div>
                                {this.props.ratings.map(function (rating) {
                                        return (<RatingCard key={rating.id} rating={rating} canGrade={this.props.canGrade}/>);
                                }.bind(this))}
                        </div>
                )
        }
});
