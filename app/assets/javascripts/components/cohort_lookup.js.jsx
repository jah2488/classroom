var CohortLookup = React.createClass({
        getInitialState: function() {
                return {query: '', cohorts: [], cohort: null};
        },

        render: function() {
                if(this.state.cohort) {
                  return (
                                  <div>
                                          <p>Cohort selected: {this.state.cohort.name}</p>
                                          <button onClick={this.clearCohort}>Clear</button>
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
                                {this.state.cohorts.map(function(cohort, i) {
                                                                                return <li key={cohort.id}><Cohort onClick={this.selectCohort.bind(this, i)} data={cohort} /></li>;
                                                                        }, this)}
                                </ul>
                                </div>
                       );
                }
        },

        selectCohort: function(i) {
          let cohort = this.state.cohorts[i];
          this.setState({cohort: cohort});
          if(this.props.onSelect){
            this.props.onSelect(cohort);
          }
        },

        clearCohort: function() {
          this.setState({cohort: null});
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
                        url: '/cohorts',
                        data: {q: this.state.query}
                }).done(function (response) {
                        if (this.isMounted()) {
                                this.setState({
                                        cohorts: response
                                });
                        }
                }.bind(this));
        }
});
