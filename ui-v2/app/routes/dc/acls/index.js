import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import { hash } from 'rsvp';
import { get } from '@ember/object';

import WithAclActions from 'consul-ui/mixins/acl/with-actions';

export default Route.extend(WithAclActions, {
  repo: service('acls'),
  model: function(params) {
    return hash({
      items: get(this, 'repo').findAllByDatacenter(this.modelFor('dc').dc.Name),
    });
  },
  setupController: function(controller, model) {
    controller.setProperties(model);
  },
});