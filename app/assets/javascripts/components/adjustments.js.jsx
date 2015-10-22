var Adjustments = React.createClass({
  render: function() {
    if(this.props.adjustments.empty) {
      return (<p>No adjustments have been submitted</p>);
    } else {
      return (
        <table>
          <thead>
          <tr>
          <th>State</th>
          <th>Checkin</th>
          <th>Student</th>
          <th>Actions</th>
          </tr>
          </thead>
          <tbody>
            {this.props.adjustments.map(function(adjustment_id) {
              return <AdjustmentReview key={adjustment_id} id={adjustment_id}/>;
            })}
          </tbody>
        </table>
             );
    }
  }
});
