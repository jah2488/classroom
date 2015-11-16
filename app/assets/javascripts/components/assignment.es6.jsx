class Assignment extends React.Component {
        constructor(props) {
                super(props)
                this.state = {
                        assignment: this.props.assignment,
                        submissions: []
                }
        }

        componentDidMount() {
                jQuery.ajax({
                        url: "/assignments/"+this.props.id,
                        dataType: "json"
                }).then( response => {
                        this.parse(response);
                }).fail( (xhr, status, err) => {
                        console.error(this.props.id, status, err.toString());
                })
        }

        render() {
                let submitPath = "/submissions/new?assignment=" + this.props.id
                let assignmentPath = "/assignments/" + this.props.id
                return (<li className="full-width">
                        <div className="collapsible-header">
                                {this.renderFeedbackIcon()}
                                {this.renderIcon()}
                                <a href={assignmentPath}>{this.state.assignment.title}</a> due <strong><TimeField hoverable time={this.state.assignment.due_date}/></strong>
                        </div>
                        <div className="collapsible-body white">
                                {this.renderSubmissions()}
                                <p>
                                        <a href={submitPath} className="btn">Submit<i className="material-icons right">send</i></a>
                                </p>
                        </div>
                </li>);
        }

        renderSubmissions() {
                if(this.state.submissions) {
                        let submissions = this.state.submissions.map( submission => {
                                let submissionPath = "/submissions/"+submission.id
                                let submissionIcon = submission.attributes.graded ? "announcement" : "chat_bubble_outline"
                                let submissionTime = "Submitted at " + moment(submission.attributes.created_at).format("llll") + " - " + submission.attributes.on_time
                                return (
                                        <li key={submission.id} className="collection-item">
                                                <a href={submissionPath}>
                                                        <i className="material-icons left">{submissionIcon}</i>
                                                </a>
                                                {submissionTime}
                                                <strong>{submission.label}</strong>
                                                <a href={submissionPath}>
                                                        <i className="material-icons right">input</i>
                                                </a>
                                        </li>
                                );
                        })
                        return <ul className="collection">{submissions}</ul>
                } else {
                        return <p>Not submitted yet.</p>
                }
        }

        renderIcon() {
                let icon;
                switch(this.state.assignment.status) {
                        case "completed":
                                icon = "done"
                                break
                        case "pending":
                                icon = "code"
                                break
                        case "incomplete":
                                icon = "not_interested"
                                break
                        case "late":
                                icon = "report_problem"
                                break
                        default:
                                icon = "assignment"
                }
                return <i className="material-icons">{icon}</i>
        }

        renderFeedbackIcon() {
                let icon = "chat_bubble_outline"
                if(this.state.assignment.has_feedback) {
                        icon = "announcement"
                }
                return <i className="material-icons">{icon}</i>
        }

        parse(response) {
                this.setState({assignment: response.data.attributes})
                this.setState({submissions: response.included})
        }
}

Assignment.defaultProps = { assignment: {} }
