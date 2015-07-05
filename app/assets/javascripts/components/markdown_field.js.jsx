/* global React, jQuery */

var MarkdownField = React.createClass({
    getInitialState: function () {
        return {
            text: ''
        };
    },
    handleChange: function (event) {
        this.setState({ text: event.target.value });
    },
    render: function () {
        return (
            <div className='col-sm-12'>
                <div className='col-sm-6'>
                    <p className='muted'>{this.props.title}</p>
                    <section>
                        <textarea onKeyUp={this.handleChange} onKeyDown={this.handleChange} className="text required form-control" />
                        <p className="help-block">I am a markdown field</p>
                    </section>
                </div>
                <div className='col-sm-6'>
                    <p className='muted'>Preview</p>
                    <section className='md-preview' style={{minHeight: '142px'}}>
                      <Markdown text={this.state.text}/>
                    </section>
                </div>
            </div>
        );
    }
});
