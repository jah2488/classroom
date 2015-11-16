function Cohort(props) {
        return <div onClick={props.onClick}>
                <div>{props.data.attributes.name}</div>
        </div>
}
