/* global React, jQuery */

var MarkdownField = React.createClass({
    getInitialState: function () {
        return {
            text: ''
        };
    },

    componentDidMount: function () {
      jQuery('#markdown-area').trigger('autoresize')
    },

    handleChange: function (event) {
        this.setState({ text: event.target.value });
    },
    render: function () {
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
});
