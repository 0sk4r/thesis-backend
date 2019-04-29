// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

function Post(props){
  return (
    <div>
      Test
      {/* <h3>{props.post.title}</h3> */}
      {/* <p> {props.post.content} </p> */}
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.body.appendChild(document.createElement('div'));
  const data = JSON.parse(node.getAttribute('data'));
  console.log(data);
  ReactDOM.render(
    <Post name="React" {...data} />, node)
})
