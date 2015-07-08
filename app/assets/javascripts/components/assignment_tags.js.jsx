/* globals React */
var AssignmentTags = React.createClass({
    getInitialState: function () {
        return { tags: this.props.tags, tag_ids: this.props.tag_ids };
    },
    render: function () {
        return (
            <div className="form-group check_boxes optional assignment_tags">
                <label className="check_boxes optional control-label">Tags</label>
                {this.state.tags.map(function (tag, index) {
                      return (
                          <span key={index} className="checkbox">
                            <label htmlFor={"assignment_tag_ids_" + tag.id}>
                                {this.checkbox(tag)}
                                {tag.name}
                            </label>
                        </span>
                    );
                }.bind(this))}
                <NewTag callback={this.newTagCreated} />
            </div>
        );
    },
    checkbox: function (tag) {
        if (this.state.tag_ids.indexOf(tag.id) > -1) {
            return (<input className="check_boxes" type="checkbox" value={tag.id} defaultChecked="checked" name="assignment[tag_ids][]" id={"assignment_tag_ids_" + tag.id} />);
        } else {
            return (<input className="check_boxes" type="checkbox" value={tag.id} name="assignment[tag_ids][]" id={"assignment_tag_ids_" + tag.id} />);
        }
    },
    newTagCreated: function (response) {
        var tags = this.state.tags;
        var tag_ids = this.state.tag_ids;
        tags.push(response);
        tag_ids.push(response.id);
        this.setState({ tags: tags, tag_ids: tag_ids });
    }
});
