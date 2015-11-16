class Markdown extends React.Component {
        componentWillMount() {
                marked.setOptions({
                        highlight: function (code) {
                                return hljs.highlightAuto(code).value;
                        }
                });
        }
        render() {
                return (<span dangerouslySetInnerHTML={{__html: marked(this.props.text)}}/>)
        }
}
