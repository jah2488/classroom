var CohortLookup = React.createClass({
        getInitialState: function() {
                return {query: '', cohorts: [], cohort: null};
        },

        render: function() {
                if(this.state.cohort) {
                        return (
                                <div className="row">
                                        {this.state.cohort.attributes.name}
                                        <button className="btn-flat right" onClick={this.clearCohort}>Clear
                                                <i className="material-icons right">close</i>
                                        </button>
                                </div>
                        )
                } else {
                        return (
                                <div>
                                        <div className='input-field'>
                                                <input type='text' name='query' onChange={this.onChange} />
                                                <label htmlFor='query'>Cohort</label>
                                        </div>
                                        <div className="collection">
                                                {this.state.cohorts.map(function(cohort, i) {
                                                        return <a key={cohort.id} className="collection-item"><Cohort onClick={this.selectCohort.bind(this, i)} data={cohort} /></a>;
                                                }, this)}
                                        </div>
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
                                        cohorts: response.data
                                });
                        }
                }.bind(this));
        }
});
