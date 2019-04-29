import React from "react"
import PropTypes from "prop-types"

class Post extends React.Component {
  render () {
    const date = new Date(this.props.post.created_at);
    
    return (
      <React.Fragment>
        <div className="row">
          <div className="col-lg-8">
            <h2>{this.props.post.title}</h2>
            <p className="lead">by {this.props.user.email}</p>
            <p>Date: {date.toLocaleDateString()}</p>
          </div>
        </div>
        <div className="row">
          <div className="col-lg-8">
            <p>{this.props.post.content}</p>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

Post.propTypes = {
  post: PropTypes.object
};
export default Post
