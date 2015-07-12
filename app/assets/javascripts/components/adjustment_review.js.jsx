/* globals React, jQuery */
var AdjustmentReview = React.createClass({
    getInitialState: function () {
        return { adjustment: this.props.adjustment };
    },
    render: function () {
        return (
            <tr>
                <td className={this.align()}>{this.state.adjustment.state}</td>
                <td className={this.align()}>{this.props.checkin_status}</td>
                <td className={this.align()}>{this.props.student_name}</td>
                <td className='actions'>
                    {this.actions()}
                </td>
            </tr>
        );
    },

    align: function () {
        if (this.state.adjustment.state === 'OPENED') {
            return 'align-middle';
        }
    },

    actions: function () {
        if (this.state.adjustment.state === 'OPENED') {
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
