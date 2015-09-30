var StudentEnroll = React.createClass({

        render: function() {
                return (
                                <UserLookup/>
                       );
        },

        handleSubmit: function (e) {
                e.preventDefault();
                jQuery.ajax({
                        method: 'POST',
                        url: '/students',
                        data: { student: { user_id: this.state.user_id, cohort_id: this.state.cohort_id } }
                }).done(function (response) {
                        this.refs.email.state.value = '';
                        if (this.props.callback) {
                                this.props.callback(response);
                        }
                }.bind(this));
        }
});
