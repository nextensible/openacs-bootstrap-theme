<multiple name=elements>
    <if @elements.section@ not nil>
        <fieldset id="@elements.form_id@:@elements.section@" @elements.sec_fieldset;noquote@>
        <!-- section fieldset -->
        <legend @elements.sec_legend;noquote@><span>@elements.sec_legendtext@</span></legend>
    </if>

    <group column="section">
        <if @elements.widget@ eq "hidden">
            <noparse><div><formwidget id=@elements.id@></div></noparse>
        </if>

        <else>
            <if @elements.widget@ eq "submit">
                <!-- if form submit button wrap it in the form-button class -->
                <div class="form-button">
                    <group column="widget">
                        <if @elements.id@ eq formbutton:ok>
                            <noparse>
                                <formwidget id="@elements.id@" class="btn primary">
                            </noparse>
                        </if>
                        <else>
                            <noparse>
                                <formwidget id="@elements.id@" class="btn">
                            </noparse>
                        </else>
                    </group>
                </div>
            </if>

        <else>
            <!-- wrap the form item in the form-item-wrapper class -->
            <noparse>
                <formerror id="@elements.id@">
                    <div class="alert-message error">
                        \@formerror.@elements.id@;noquote\@
                    </div> <!-- /form-error -->
                </formerror>
                <if \@formerror.@elements.id@\@ not nil>
                    <div class="clearfix error">
                </if>
                <else>
                    <div class="clearfix">
                </else>
            </noparse>

            <if @elements.widget@ in radio checkbox> 
                <if @elements.legendtext@ defined>
                    <fieldset @elements.fieldset;noquote@>
                        <!-- radio button groups and checkbox groups get their own fieldsets -->
                        <legend @elements.legend;noquote@><span>@elements.legendtext@</span></legend>
                </if>
            </if>

            <if @elements.label@ not nil>
                <noparse>
                    <if @form_properties.mode@ eq display or @elements.widget@ in radio checkbox date inform>
                        <!-- no label tag -->
                    </if>
                    <else>
                        <label for="@elements.id@">
                    </else>

                    <if \@formerror.@elements.id@\@ not nil>
                        <span class="form-label form-label-error">
                    </if>
                    <else>
                        <span class="form-label">
                    </else>
                </noparse>

                @elements.label;noquote@

                <if @form_properties.show_required_p@ true>
                    <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform">
                        <span class="form-required-mark">(#acs-templating.required#)</span>
                    </if>
                </if>
                </span><!-- form-label -->
            </if>
            <else>
                <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform">
                    <span class="form-label form-required-mark">
                        #acs-templating.required#
                    </span>
                </if>
            </else>

            <if @elements.widget@ in radio checkbox>
                <noparse>
                    <span class="form-widget">
                        <formgroup id="@elements.id@">			
                            <label for="@elements.form_id@:elements:@elements.id@:\@formgroup.option@">
                                \@formgroup.widget;noquote@
                                \@formgroup.label;noquote@
                            </label><br>
                        </formgroup>
                    </span>
                </noparse>
            </if>
            <else>
                <if @form_properties.mode@ eq display or @elements.widget@ in radio checkbox date inform>
                    <!-- no label tag -->
                </if>
                <else>
                    <if @elements.label@ not nil></label></if>
                </else>
                <noparse>
                    <div class="form-widget input">
                        <formwidget id="@elements.id@">
                </noparse>
                <if @elements.help_text@ not nil>
                    <span class="help-block">
                        <noparse><formhelp id="@elements.id@"></noparse>
                    </span>
                </if>
                    </div>
            </else>


            <if @elements.widget@ in radio checkbox>
                <if @elements.legendtext@ defined>
                    <!-- radio button groups and checkbox groups get their own fieldsets -->
                </fieldset>
                </if>
            </if>
        </div> <!-- form-item-wrapper -->
    </else>
</else>
  </group>

  <if @elements.section@ not nil>
    </fieldset> <!-- section fieldset -->
  </if>
</multiple>
