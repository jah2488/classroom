var Adjustments = React.createClass({
        render: function() {
                if(this.props.adjustments.empty) {
                        return (<p>No adjustments have been submitted</p>);
                } else {
                        return (
                                <table>
                                        <thead>
                                                <tr>
                                                        <th>Day</th>
                                                        <th>Checkin</th>
                                                        <th>Student</th>
                                                        <th>Actions</th>
                                                </tr>
                                        </thead>
                                        <tbody>
                                                {this.props.adjustments.filter(a => a.state != "ADJUSTED").sort((a, b) => Date.parse(a.created_at) - Date.parse(b.created_at)).map(function(adjustment) {
                                                        return <AdjustmentReview key={adjustment.id} id={adjustment.id}/>;
                                                })}
                                        </tbody>
                                </table>
                        );
                }
        }
});
