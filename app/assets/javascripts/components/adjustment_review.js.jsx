/* globals React, jQuery, moment */
var AdjustmentReview = React.createClass({
        getInitialState: function () {
                return { adjustment: {}, checkin: {}, student: {}, day: {} };
        },
        componentDidMount: function() {
                jQuery.ajax({
                        url: "/adjustments/"+this.props.id,
                        dataType: 'json',
                        success: function(response) {
                                if(this.isMounted()){
                                        this.parse(response);
                                }
                        }.bind(this),
                        error: function(xhr, status, err) {
                                console.error(this.props.url, status, err.toString());
                        }.bind(this)
                });
        },
        render: function () {
                return (
                        <tr>
                                <td className={this.align()}>{this.startTime()}</td>
                                <td className={this.align()}>{this.state.checkin.status}</td>
                                <td className={this.align()}>{this.state.student.pretty_name}</td>
                                <td className='actions'>
                                        {this.actions()}
                                </td>
                        </tr>
                );
        },

        startTime: function(time) {
                let momentTime = moment(this.state.day.start)
                return momentTime.format('ll')
        },

        parse: function(response) {
                this.setState({adjustment: response.data.attributes})
                if(response.included) {
                        let checkin = response.included[0].attributes;
                        this.setState({checkin})
                        if(response.included[1]) {
                                let student = response.included[1].attributes;
                                this.setState({student})
                        }
                        if(response.included[2]) {
                                let day = response.included[2].attributes
                                this.setState({day})
                        }
                }
        },

        align: function () {
                if (this.state.adjustment.state === 'OPENED') {
                        return 'align-middle';
                }
        },

        actions: function () {
                if (this.state.adjustment.state === 'OPENED') {
                        return (<span>
                                <a className='btn waves-effect waves-light green' onClick={this.handleClick.bind(this, 'adjust')}><i className="material-icons">done</i></a>
                                <a className='btn waves-effect waves-light red' onClick={this.handleClick.bind(this, 'close')}><i className="material-icons">not_interested</i></a>
                        </span>);
                } else {
                        return (<span/>);
                }
        },

        handleClick: function (action) {
                jQuery.ajax({
                        method: 'PUT',
                        url: '/adjustments/' + this.props.id + '/' + action
                }).success(function (response) {
                        this.parse(response);
                }.bind(this));
        }
});
