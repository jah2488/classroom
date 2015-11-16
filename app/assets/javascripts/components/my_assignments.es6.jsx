class MyAssignments extends React.Component {
        constructor(props) {
                super(props)
                this.state = { assignments: [], query: "" }
                this.queryUpdated = this.queryUpdated.bind(this)
                this.clearQuery = this.clearQuery.bind(this)
        }

        componentDidMount() {
                jQuery.ajax({
                        url: "/assignments",
                        dataType: "json"
                }).then( response => {
                        this.parse(response);
                }).fail( (xhr, status, err) => {
                        console.error(status, err.toString());
                })
        }

        componentDidUpdate() {
                jQuery(this.refs.assignments).collapsible();
        }

        parse(response) {
                let assignments = response.data.sort((a, b) => Date.parse(a.attributes.due_date) - Date.parse(b.attributes.due_date))
                this.setState({assignments});
        }

        render() {
                let assignments = this.state.assignments.filter(a => a.attributes.title.toLowerCase().indexOf(this.state.query) != -1 ).map( assignment => {
                        return <Assignment key={assignment.id} id={assignment.id} assignment={assignment.attributes} />
                })

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
                                        {assignments}
                                </ul>
                        </div>)
        }

        renderKey() {
                return MyAssignments.icons.map( icon => {
                        return (<li key={icon[0]} className="collection-item">
                                <i className="material-icons left">{icon[0]}</i>
                                {icon[1]}
                        </li>);
                })
        }

        queryUpdated() {
                this.setState({query: this.refs.search.value.trim().toLowerCase()})
        }

        clearQuery(event) {
                this.refs.search.value = ""
                this.setState({query: ""})
        }
}

MyAssignments.icons = [["announcement", "Instructor or TA has left feedback on this submission."],
        ["chat_bubble_outline", "No feedback has been left on this assignment."],
        ["done", "This assignment is completed. Good job!"],
        ["code", "This assignment is currently in code review."],
        ["not_interested", "This assignment was marked as incomplete."],
        ["report_problem", "This assignment has no submissions and is now late."],
        ["assignment", "This is an assignment. You probably have several of these."]]
