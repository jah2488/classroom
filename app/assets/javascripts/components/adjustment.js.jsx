/* globals React, jQuery */
var Adjustment = React.createClass({
    getInitialState: function () {
        return { adjustment: this.props.adjustment };
    },
    render: function () {
        return (
            <tr>
                <td>{this.adjustmentAction()}</td>
                <td>{this.props.checkin_status}</td>
            </tr>
        );
    },

    adjustmentAction: function () {
        if (this.state.adjustment) {
            return (<a className='btn btn-xs btn-default'>{this.state.adjustment.state}</a>);
        } else {
            return (<a className='btn btn-xs btn-primary' onClick={this.handleClick}>Submit for Review</a>);
        }
    },

    handleClick: function () {
        jQuery.ajax({
            method: 'POST',
            url: '/adjustments/',
            data: { adjustment: { checkin_id: this.props.checkin.id } }
        }).done(function (response) {
            this.setState({ adjustment: response });
        }.bind(this));
    }
});
