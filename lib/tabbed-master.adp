<master src="/packages/openacs-bootstrap-theme/lib/plain-master">
<if @doc@ defined><property name="&doc">doc</property></if>
<if @body@ defined><property name="&body">body</property></if>
<if @head@ not nil><property name="head">@head;noquote@</property></if>
<if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
<if @context@ not nil><property name="context">@context;noquote@</property></if>
<property name="&navigation">navigation</property>

<slave>
