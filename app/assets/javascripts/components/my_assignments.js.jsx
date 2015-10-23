var MyAssignments = React.createClass({
        getInitialState: function () {
                return { assignments: [], query: "" }
        },
        componentDidMount: function() {
                jQuery.ajax({
                        url: "/assignments",
                        dataType: 'json',
                        success: function(response) {
                                if(this.isMounted()) {
                                        this.parse(response);
                                }
                        }.bind(this),
                        error: function(xhr, status, err) {
                                console.error(status, err.toString());
                        }.bind(this)
                });
        },
        componentDidUpdate: function() {
                jQuery(this.refs.assignments).collapsible();
        },
        parse: function(response) {
                this.setState({assignments: response.data});
        },
        render: function() {
                return (
                        <div>
                                <form>
                                        <div className="input-field">
                                                <input ref="search" className="field" id="search" onKeyUp={this.queryUpdated} type='search' placeholder="Search" required/>
                                                <i className="mdi-navigation-close close" onClick={this.clearQuery}></i>
                                        </div>
                                </form>
                                <ul className="collapsible black-text popout" ref="assignments">
                                        <li className="full-width">
                                                <div className="collapsible-header">
                                                        <i className="material-icons left">language</i>
                                                        Icon Reference
                                                </div>
                                                <div className="collapsible-body white">
                                                        <ul className="collection">
                                                                {this.renderKey()}
                                                        </ul>
                                                </div>
                                        </li>
                                        {this.state.assignments.filter(a => a.attributes.title.toLowerCase().includes(this.state.query) ).map(function(assignment) {
                                                return (
                                                        <Assignment key={assignment.id} id={assignment.id} assignment={assignment.attributes} />
                                                        )
                                        })
                                        }
                                </ul>
                        </div>)
        },
        renderKey: function() {
                let icons = [['announcement', 'Instructor or TA has left feedback on this submission.'],
                        ['chat_bubble_outline', 'No feedback has been left on this assignment.'],
                        ['done', 'This assignment is completed. Good job!'],
                        ['code', 'This assignment is currently in code review.'],
                        ['not_interested', 'This assignment was marked as incomplete.'],
                        ['report_problem', 'This assignment has no submissions and is now late.'],
                        ['assignment', 'This is an assignment. You probably have several of these.']]
                        return icons.map(function(icon) {
                                return (<li key={icon[0]} className="collection-item">
                                        <i className="material-icons left">{icon[0]}</i>
                                        {icon[1]}
                                </li>);
                        })
        },
        queryUpdated: function() {
                this.setState({query: this.refs.search.value.trim().toLowerCase()})
        },
        clearQuery: function(event) {
                this.refs.search.value = ""
                this.setState({query: ""})
        }
});
