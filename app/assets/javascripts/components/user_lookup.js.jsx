var UserLookup = React.createClass({
        getInitialState: function() {
                return {query: '', users: [], user: null};
        },

        render: function() {
                if(this.state.user) {
                        return (
                                        <div className="row">
                                        {this.state.user.email}
                                        <button className="btn-flat right" onClick={this.clearUser}>Clear
                                          <i className="material-icons right">close</i>
                                        </button>
                                        </div>
                               )
                } else {
                        return (
                                        <div>
                                        <div className='input-field'>
                                        <input type='text' name='query' onChange={this.onChange} />
                                        <label htmlFor='query'>User</label>
                                        </div>
                                        <div className="collection">
                                        {this.state.users.map(function(user, i) {
                                                                                        return <a key={user.id} className="collection-item"><User onClick={this.selectUser.bind(this, i)} data={user} /></a>;
                                                                                }, this)}
                                        </div>
                                        </div>
                               );
                }
        },

        selectUser: function(i) {
                let user = this.state.users[i];
                this.setState({user: user});
                if(this.props.onSelect) {
                        this.props.onSelect(user);
                }
        },

        clearUser: function() {
                this.setState({user: null});
        },

        onChange: function(e) {
                this.setState({query: e.target.value});
                if(e.target.value.length > 2) {
                        this.performLookup();
                }
        },

        performLookup: function() {
                $.ajax({
                        method: 'GET',
                        url: '/users',
                        data: {q: this.state.query}
                }).done(function (response) {
                        if (this.isMounted()) {
                                this.setState({
                                        users: response
                                });
                        }
                }.bind(this));
        }
});
