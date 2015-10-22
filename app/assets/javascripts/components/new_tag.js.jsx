/* globals React, jQuery */
var NewTag = React.createClass({
        render: function () {
                return (
                        <div className='form-inline'>
                                <div className='form-group'>
                                        <label htmlFor='name'>New Tag</label>
                                        <Input ref='name' name='name' value='' className='col-md-1'/>
                                </div>
                                <button onClick={this.handleSubmit} className='btn btn-sm btn-primary'>Create Tag</button>
                        </div>
                );
        },

        handleSubmit: function (e) {
                e.preventDefault();
                jQuery.ajax({
                        method: 'POST',
                        url: '/tags',
                        data: { tag: { name: this.refs.name.state.value } }
                }).done(function (response) {
                        this.refs.name.state.value = '';
                        if (this.props.callback) {
                                this.props.callback(response);
                        }
                }.bind(this));
        }
});
