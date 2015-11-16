class TimeField extends React.Component {
        constructor(props) {
                super(props)
                this.state = { hover: false }
                this.mouseOver = this.mouseOver.bind(this)
                this.mouseOut = this.mouseOut.bind(this)
        }

        componentDidMount() {
                let fiftySeconds = 50000;
                this.ticker = setInterval(this.update, fiftySeconds);
        }

        componentWillUnmount() {
                if (this.ticker) {
                        clearInterval(this.ticker);
                        this.ticker = null;
                }
        }

        update() {
                this.forceUpdate();
        }

        render() {
                var momentTime = moment(this.props.time);
                return <time onMouseOver={this.mouseOver} onMouseOut={this.mouseOut} dateTime={this.props.time}>{this.timestamp(momentTime)}</time>
        }

        timestamp(time) {
                if (this.state.hover) { return time.format("llll"); }
                if (this.isOverAWeek(time)) { return time.fromNow(); }
                return time.fromNow();
        }

        isOverAWeek(time) {
                return Math.abs(moment().diff(time, "days")) > 7;
        }

        mouseOver() {
                if (this.props.hoverable === true) {
                        this.setState({ hover: true});
                }
        }

        mouseOut() {
                this.setState({ hover: false});
        }
}
