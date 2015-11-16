class Badges extends React.Component {
        constructor(props) {
                super(props)
                this.state = { badgeIds: {} }
                this.handleChange = this.handleChange.bind(this)
        }

        handleChange(e) {
                let updatedBadgeIds = this.state.badgeIds;
                updatedBadgeIds[e.target.name] = e.target.checked;
                this.setState({ badgeIds: updatedBadgeIds });
        }

        render() {
                if(this.props.badges) {
                        let badges = this.props.badges.map( (badge, i) => {
                                var key = "badge-" + badge.id;
                                return (
                                        <div key={key} className='col l1 m4 s6'>
                                                <span className='circle'>
                                                        <input ref={key} name={key} id={key} type='checkbox' onChange={this.handleChange} />
                                                        <label htmlFor={key}>
                                                                <img className="shadow-z-1 circle student-badge" tabIndex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" data-title={badge.title} data-content={badge.description} src={badge.icon_image} alt="Icon image" data-original-title="" title="" style={{width: "50px"}} />
                                                        </label>
                                                </span>
                                        </div>
                                );
                        })
                        return (
                                <div className='row'>
                                        <div className='col s12 badges'>
                                                <div className='row'>
                                                        {badges}
                                                </div>
                                        </div>
                                </div>
                        );
                } else {
                        return <div/>;
                }
        }
}
