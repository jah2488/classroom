class MarkdownField extends React.Component {
        constructor(props) {
                super(props)
                this.state = {
                        text: ""
                }
                this.handleChange = this.handleChange.bind(this)
        }

        componentDidMount() {
                jQuery(".materialize-textarea").trigger("autoresize")
        }

        handleChange(event) {
                this.setState({ text: event.target.value });
        }

        render() {
                return (
                        <div className='row'>
                                <div className='col s12 l6'>
                                        <textarea name="markdown" onKeyUp={this.handleChange} onKeyDown={this.handleChange} className="text required form-control materialize-textarea" />
                                        <label htmlFor="markdown">{this.props.title}</label>
                                </div>
                                <div className='col s12 l6'>
                                        <p className='muted'>Preview</p>
                                        <Markdown text={this.state.text}/>
                                </div>
                        </div>
                );
        }
}
