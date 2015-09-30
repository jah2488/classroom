var UserLookup = React.createClass({
        getInitialState: function() {
                return {query: '', users: [], user: null};
        },

        render: function() {
                if(this.state.user) {
                  return (
                                  <div>
                                          <p>User selected: {this.state.user.email}</p>
                                          <button onClick={this.clearUser}>Clear</button>
                                  </div>
                         )
                } else {
                return (
                                <div>
                                <div className='form'>
                                <label htmlFor='query'>Query</label>
                                <input type='text' name='query' onChange={this.onChange} />
                                </div>
                                <ul>
                                {this.state.users.map(function(user, i) {
                                                                                return <li key={user.id}><User onClick={this.selectUser.bind(this, i)} data={user} /></li>;
                                                                        }, this)}
                                </ul>
                                </div>
                       );
                }
        },

        selectUser: function(i) {
          this.setState({user: this.state.users[i]});
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
                console.log("looking for user");
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
