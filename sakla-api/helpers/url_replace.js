module.exports = (url,str="/uploads") => {
  let _url="";

  try {
    _url = url.replace(str,"")
  }catch (e) {

  }

  return _url;
};
