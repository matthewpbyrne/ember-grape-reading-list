import CustomSession from '../sessions/custom';

export function initialize(container, application) {
  application.register('session:custom', CustomSession);
}

export default {
  name: 'authentication',
  initialize: initialize
};
