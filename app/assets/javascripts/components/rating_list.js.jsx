var RatingList = React.createClass({
        render: function() {
                return (<ul className="collapsible popout" data-collapsible="accordion">
                                {this.props.ratings.map(function (rating) {
                                                                                  return (
                                                                                                  <li>
                                                                                                  <div className="collapsible-header grey lighten-5">Feedback from <TimeField time={rating.created_at}/></div>
                                                                                                  <div className="collapsible-body"><Markdown text={rating.notes} /></div></li>
                                                                                         );
                                                                          }.bind(this))}
                                </ul>)
        }
});
