var StudentEnroll = React.createClass({
        openModal: function() {
                jQuery('#enroll-modal').openModal();
        },

        render: function() {
                return (
                        <div>
                                <a href="#" onClick={this.openModal}>Enroll</a>
                                <a className="clippy" href="#" data-clipboard-text={this.props.enrollURL}>Copy Enrollment URL</a>
                                <div id="enroll-modal" className="modal bottom-sheet">
                                        <div className="modal-content">
                                                <CohortLookup onSelect={this.cohortSelected}/>
                                                <UserLookup onSelect={this.userSelected}/>
                                                <div className="modal-footer">
                                                        <a className='modal-action modal-close waves-effect waves-green btn-flat' onClick={this.enroll}>Enroll</a>
                                                </div>
                                        </div>
                                </div>
                        </div>
                );
        },

        userSelected: function(user) {
                this.setState({user: user});
        },

        cohortSelected: function(cohort) {
                this.setState({cohort: cohort});
        },

        enroll: function (e) {
                $.ajax({
                        method: 'POST',
                        url: '/students',
                        data: { student: { user_id: this.state.user.id, cohort_id: this.state.cohort.id } }
                }).success(function (response) {
                        jQuery("#enroll-modal").closeModal();
                        location.reload();
                }.bind(this));
        }
});
