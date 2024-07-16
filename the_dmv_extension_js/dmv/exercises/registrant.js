module.exports = {
  createRegistrant,
  earnPermit,
  takeLicenseExam
}

function createRegistrant(name, age, permit = false) {
  return {name, age, permit, licenseData: {written: false, license: false, renewed: false}}
}

function earnPermit(registrant) {
  if (!registrant.permit && registrant.age >= 16) {
    registrant.permit = true
    return 'You have successfully earned a permit!'
  }
  else {
    return 'Sorry, you are not able to earn a permit right now.'
  }
}

function takeLicenseExam(registrant) {
  if (registrant.permit) {
    registrant.licenseData.written = true
    return 'Great job! You can take your test.'
  }
  else {
    return 'Sorry, you need to earn a permit first.'
  }
}
