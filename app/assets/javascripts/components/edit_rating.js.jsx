/* @flow */
/* globals React, jQuery */

var EditRating = React.createClass({
    getInitialState: function () {
        return { editing: false, rating: this.props.rating };
    },
    render: function () {
        if (this.state.editing) {
            return (
                <div>
                    <div className='form-inputs'>
                        <label htmlFor='notes' className='string required control-label'>Notes</label>
                        <Input ref='notes' name='notes' value={this.state.rating.notes} />
                    </div>
                    <div className='actions'>
                        <a onClick={this.handleClick} className='btn btn-sm btn-default'>Cancel</a>
                        <a onClick={this.handleSubmit} className='btn btn-sm btn-primary'>Submit</a>
                    </div>
                </div>
            );
        } else {
            return (
                <div>
                    <Markdown text={this.state.rating.notes} />
                    <div className='actions'>
                        <div onClick={this.handleClick} className='btn btn-sm btn-default'>Edit</div>
                    </div>
                </div>
            );
        }
    },

    handleClick: function () {
        var state = this.state.editing ? false : true;
        this.setState({editing: state});
    },

    handleSubmit: function () {
        jQuery.ajax({
            method: 'PATCH',
            url: '/ratings/' + this.props.rating.id,
            data: {
                rating: {
                    notes: this.refs.notes.state.value
                }
            }
        }).done(function (response) {
            this.setState({ rating: response, editing: false });
        }.bind(this));
    }
});
