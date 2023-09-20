type element;
type ref('value) = {mutable current: 'value};

type componentLike('props, 'return) = 'props => 'return;

type component('props) = componentLike('props, element);
