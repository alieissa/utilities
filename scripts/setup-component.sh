#!/bin/sh


# This script creates  new directory with name of new component and necessary files.
# Files are saved in new directory. For example the following will be created for 
# button component
#   button/button.js, button/button.test.js, and button/button.css


# Name of component. Capitalize inut name
name="$(tr '[:lower:]' '[:upper:]' <<< ${1:0:1})${1:1}"

# Component has its own directr=ory
mkdir $1

jsfile=$1/$1.js
cssfile=$1/$1.css
testfile=$1/$1.test.js

cat<<EOF > $jsfile
import React from 'react'
import PropTypes from 'prop-types'

export class $name extends React.Component {
    render() {
        return (
            <div></div>
        )
    }
}
EOF

cat<<EOF > $testfile
import React from 'react'
import { shallow } from 'enzyme'

import { $name } from './$1'

describe('<$name />', () => {

})
EOF

cat<<EOF > $cssfile
.$1 {

}
EOF

