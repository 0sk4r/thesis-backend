import React from "react"
import PropTypes from "prop-types"
class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        <h3>Post: {this.props.post.title}</h3>
        {this.props.post.content}
      </React.Fragment>
    );
  }
}

Post.propTypes = {
  post: PropTypes.object
};
export default Post
