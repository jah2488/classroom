/* globals React, jQuery */
var AdjustmentReview = React.createClass({
    getInitialState: function () {
        return { adjustment: this.props.adjustment };
    },
    render: function () {
        return (
            <tr>
                <td>{this.state.adjustment.state}</td>
                <td>{this.props.checkin_status}</td>
                <td>{this.props.student_name}</td>
                <td className='actions'>
                    {this.actions()}
                </td>
            </tr>
        );
    },

    actions: function () {
        if (this.state.adjustment.state === 'OPEN') {
            return (<span>
                    <a className='btn btn-xs btn-success' onClick={this.handleClick.bind(this, 'adjust')}>Adjust</a>
                    <a className='btn btn-xs btn-danger' onClick={this.handleClick.bind(this, 'close')}>Close</a>
                </span>);
        } else {
            return (<span/>);
        }
    },

    handleClick: function (action) {
        jQuery.ajax({
            method: 'PATCH',
            url: '/adjustments/' + this.state.adjustment.id + '/' + action,
            data: {}
        }).done(function (response) {
            this.setState({ adjustment: response });
        }.bind(this));
    }
});
