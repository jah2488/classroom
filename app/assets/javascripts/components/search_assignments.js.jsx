/* global React, jQuery */
var SearchAssignments = React.createClass({
    getInitialState: function () {
        return {
            loading: false,
            query: '',
            records: [],
            active: 0
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
        var searchQuery = event.target.value.trim();
        var UP = 38;
        var DOWN = 40;
        var ENTER = 13;

        if (event.keyCode === UP) { this.decrementActive(); }
        if (event.keyCode === DOWN) { this.incrementActive(); }
        if (event.keyCode === ENTER) {
            window.location.href = '/assignments/' + this.state.records[this.state.active].id;
        }

        if (searchQuery.length > 1) {

            var URL = '/assignments/search/' + searchQuery;

            this.setState({ loading: true, query: searchQuery });

            jQuery.getJSON(URL, function (data) {

                this.setState({ loading: false, records: data });

            }.bind(this));

        } else {
            this.setState({ records: [] });
        }
    },

    incrementActive: function () {
        if (this.state.active >= this.state.records.length - 1) {
            this.setState({ active: 0 });
        } else {
            this.setState({ active: this.state.active + 1 });
        }
    },

    decrementActive: function () {
        if (this.state.active <= 0) {
            this.setState({ active: this.state.records.length - 1 });
        } else {
            this.setState({ active: this.state.active - 1 });
        }
    },

    results: function () {
        var records = this.state.records;
        var query = this.state.query;
        return (
            <div>
                {records.map(function (row, index) {
                    return <Result key={index} id={row.id} active={this.isActive(index)} query={query} title={row.title} />;
                }.bind(this))}
            </div>
        );
    },

    isActive: function (index) {
        if (index === this.state.active) {
            return 'active';
        }
    }
});

var Result = React.createClass({
    render: function () {
        return (
            <a className={this.props.active + ' autocomplete'} href={'/assignments/' + this.props.id}>
                <p>{this.text()}</p>
            </a>);
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

