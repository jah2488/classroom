/* globals React, jQuery */
var Adjustment = React.createClass({
        getInitialState: function () {
                return {
                        adjustment: this.props.adjustment,
                        statusMsg: this.checkinStatus()
                };
        },
        render: function () {
                return (
                        <div>
                                {this.state.statusMsg}
                                &nbsp;
                                {this.adjustmentAction()}
                        </div>
                );
        },

        checkinStatus: function() {
                if(this.props.day.start < this.props.checkin.created_at) {
                        return moment(this.props.checkin.created_at).format("llll");
                }
                return null;
        },

        adjustmentAction: function () {
                if (this.state.adjustment) {
                        return <span>{this.state.adjustment.state}</span>;
                } else {
                        return (
                                <a className='waves-effect waves-light green btn' onClick={this.handleClick}>
                                        <i className="material-icons right">replay</i>
                                        Review
                                </a>
                        );
                }
        },

        handleClick: function () {
                console.log("Submitting for adjustment")
                jQuery.ajax({
                        method: "POST",
                        url: "/adjustments/",
                        data: { adjustment: { "checkin_id": this.props.checkin.id } }
                }).then( response => {
                        this.setState({ adjustment: response });
                });
        }
});
