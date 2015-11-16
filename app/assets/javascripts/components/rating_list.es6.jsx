RatingList = props => {
        let ratings = props.ratings.map( rating => {
                return (<RatingCard key={rating.id} rating={rating} canGrade={props.canGrade}/>);
        })
        return <div>{ratings}</div>
}
