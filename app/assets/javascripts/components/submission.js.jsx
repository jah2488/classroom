/* globals React, jQuery */

var Submission = React.createClass({
    render: function () {
        return (
            <div>
              <p className='muted'>Submission</p>
              <section>
                  <p><a href={this.props.submission.link}>{this.props.submission.link}</a></p>
              </section>

              <p className='muted'>Student Notes</p>
              <section>
                  <Markdown text={this.props.submission.notes} />
              </section>
            </div>
        );
    }
});
