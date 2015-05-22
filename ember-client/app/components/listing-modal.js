import Ember from 'ember';

export default Ember.Component.extend({
  modalIsOpen: false,

  actions: {
    openModal() {
      this.set('modalIsOpen', true);
    },
    closeModal() {
      this.set('modalIsOpen', false);
    },
    save() {
      this.sendAction('action', this.get('url'), this.get('comment'));
      this.setProperties({
        modalIsOpen: false,
        comment:     null,
        url:         null
      });
    }
  }
});
