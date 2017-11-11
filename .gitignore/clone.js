let clone = (obj) => {
  let _clone = {};
  
  Object.keys(obj).map(key => {
    if(typeof obj[key] === 'object') {
      _clone[key] = clone(obj[key])
    }
    else {
      _clone[key] = obj[key];
    }
  })
  
  return _clone
}
