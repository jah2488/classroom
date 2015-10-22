var RatingCard = React.createClass({
        getInitialState: function () {
                return {
                        rating: this.props.rating,
                        editing: false
                };
        },
        update: function () {
                jQuery.ajax({
                        method: 'PATCH',
                        url: '/ratings/' + this.state.rating.id,
                        data: {
                                rating: {
                                        notes: this.state.rating.notes
                                }
                        }
                }).success(function (response) {
                        this.setState({ rating: response, editing: false });
                }.bind(this));
        },
        handleNotesChange: function(event) {
                let rating = this.state.rating;
                rating.notes = event.target.value;
                this.setState({rating});
        },
        setEditing: function(editing) {
                this.setState({editing});
        },
        render: function() {
                return(
                        <div className="card grey lighten-5">
                                <div className="card-content">
                                        <span className="card-title black-text">Feedback from <TimeField time={this.props.rating.created_at}/></span>
                                        {this.ratingBody()}
                                </div>
                                {this.renderActions()}
                        </div>

                )
        },
        renderActions: function () {
                if (!this.props.canGrade) {
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
        ratingBody: function() {
                if (this.state.editing) {
                        return (<div className='input-field row'>
                                <textarea ref='notes' name="notes" className="materialize-textarea" value={this.state.rating.notes} onChange={this.handleNotesChange} />
                                <label htmlFor="notes">Notes</label>
                        </div>);
                } else {
                        return (<Markdown text={this.state.rating.notes} />)
                }
        }
});
