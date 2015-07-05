/* global React, jQuery, marked */
var Markdown = React.createClass({
    toMarkdown: function (text) {
        return { __html: marked(text) };
    },
    render: function () {
        return (<span dangerouslySetInnerHTML={this.toMarkdown(this.props.text)}/>);
    }
});
