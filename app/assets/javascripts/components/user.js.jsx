function User(props) {
        return <div onClick={props.onClick}>
                <div>Email: {props.user.attributes.email}</div>
                <div>Name: {props.user.attributes.name}</div>
        </div>
}
