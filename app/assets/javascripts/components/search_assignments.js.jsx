/* global React, jQuery */
var Result = React.createClass({
    render: function () {
        return (<a className={'id-' + this.props.id + ' autocomplete'} href={'/assignments/' + this.props.id}><p>{this.text()}</p></a>);
    },

    text: function () {
        return (<span dangerouslySetInnerHTML={this.highlightQuery()}></span>);
    },

    highlightQuery: function () {
        var title = this.props.title.toLowerCase();
        var query = this.props.query.toLowerCase();
        return { __html: title.replace(query, '<strong>' + query + '</strong>') };
    }
});

var SearchAssignments = React.createClass({
    getInitialState: function () {
        return {
            loading: false,
            query: '',
            records: []
        };
    },

    render: function () {
        return (<span className='autocomplete-form'>
                    <input className='form-control autocomplete-input' onKeyUp={this.handleChange} type='search' placeholder='go to assignment'/>
                    <div className='results'>
                        {this.results()}
                    </div>
                </span>);
    },

    handleChange: function (event) {
        if (event.keyCode === 13) {
            var topResult = this.state.records[0];
            if (topResult) {
                window.location.href = '/assignments/' + topResult.id;
            }
        } else if (event.target.value.trim().length > 0) {
            var searchQuery = event.target.value.trim();
            var URL = '/assignments/search/' + searchQuery;
            this.setState({ loading: true, query: searchQuery });
            jQuery.getJSON(URL, function (data) {
                this.setState({ loading: false, records: data });
            }.bind(this));
        } else {
            this.setState({ records: [] });
        }
    },

    results: function () {
        var records = this.state.records;
        var query = this.state.query;
        var i = 0;
        return (
            <div>
                {records.map(function (row) {
                    i += 1;
                    return <Result key={i} id={row.id} query={query} title={row.title} />;
                })}
            </div>
        );
    }
});
