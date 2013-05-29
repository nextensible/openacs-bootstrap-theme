<master src="blank-master">
<if @doc@ defined><property name="&doc">doc</property></if>
<if @body@ defined><property name="&body">body</property></if>
<if @head@ not nil><property name="head">@head;noquote@</property></if>
<if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
<if @body_attributes@ not nil><property name="body_attributes">@body_attributes;noquote@</property></if>
<property name="skip_link">@skip_link;noquote@</property>

<if @widgetize@ false>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <a class="brand"<if @system_url@ not nil> href="@system_url@"</if>>@system_name@ <sup style="font-weight:normal;color:gray;font-size:small">BETA</sup></a>
      <div class="nav-collapse">
        <ul class="nav">
          <comment>
            <li <if @active@ eq "compose">class="active"</if>><a href="/composer/compose">#itec-composer.nav_compose#</a></li>
            <li <if @active@ eq "manage">class="active"</if>><a href="/composer/manage">#itec-composer.nav_manage#</a></li>
          </comment>


                      <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">#itec-composer.nav_activities_stories# <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="@activities_url@">#itec-composer.nav_activities#</a></li>
                          <li><a href="@learningstories_url@">#itec-composer.nav_learning_stories#</a></li>
                        </ul>
                      </li>
                      <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">#itec-composer.nav_technical_setting# <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="/composer/technicalsettings">#itec-composer.nav_technical_settings#</a></li>
                          <li><a href="/composer/applications">#itec-composer.nav_applications#</a></li>
                          <li><a href="/composer/devices">#itec-composer.nav_devices#</a></li>
                          <li><a href="/composer/contents">#itec-composer.nav_content#</a></li>
                        </ul>
                      </li>




        </ul>
        <comment>
        <form class="navbar-search pull-left" action="">
          <input class="search-query span2" type="text" placeholder="Search...">
        </form>
        </comment>
        <ul class="nav pull-right">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
              <if @untrusted_user_id@ ne 0>#acs-subsite.Welcome_user#</if>
              <else>#acs-subsite.Not_logged_in#</else>
              <i class="icon-cog icon-white"></i>
              <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <if @pvt_home_url@ not nil>
                <li><a href="@pvt_home_url@" title="#acs-subsite.Change_pass_email_por#">@pvt_home_name@</a></li>
              </if>
              <if @login_url@ not nil>
                <li><a href="@login_url@" title="#acs-subsite.Log_in_to_system#">#acs-subsite.Log_In#</a></li>
              </if>
              <if @num_of_locales@ gt 1>
                <li><a href="@change_locale_url@">#acs-subsite.Change_locale_label#</a></li>
              </if>
              <li>#itec-composer.feedback_questionnaire#</li>
              <if @logout_url@ not nil>
                <li><a href="@logout_url@" title="#acs-subsite.Logout_from_system#">#acs-subsite.Logout#</a></li>
              </if>
              <if @user_menu_entries:rowcount@ not nil>
                <multiple name="user_menu_entries">
                  <li><a href="@user_menu_entries.href@">@user_menu_entries.text@</a></li>
                </multiple>
              </if>
              <comment>
              <li><a href="@whos_online_url@" title="#acs-subsite.view_all_online_members#">@num_users_online@ <if @num_users_online@ eq 1>#acs-subsite.Member#</if><else>#acs-subsite.Members#</else> #acs-subsite.Online#</a> |</li>
              </comment>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
</if>

<div id="wrapper" class="container">
    <div id="header">
        <div id="breadcrumbs">
            <if @context_bar@ not nil>
                @context_bar;noquote@
            </if>
            <else>
                <if @context:rowcount@ not nil>
                <ul class="breadcrumb">
                  <multiple name="context">
                  <if @context.url@ not nil>
                    <li><a href="@context.url@">@context.label@</a> <span class="divider">@separator@</span></li>
                  </if>
                  <else>
                    <comment>
                      TODO: Does an empty URL really mean, that we are at the end?
                    </comment>
                    <li class="active">@context.label@</li>
                  </else>
                  </multiple>
                </ul>
                </if>
            </else>
          </div>
  </div> <!-- /header -->
            
  <if @navigation:rowcount@ not nil>
    <list name="navigation_groups">
      <div id="@navigation_groups:item@-navigation">
        <div class="block-marker">Begin @navigation_groups:item@ navigation</div>
        <ul>
          <multiple name="navigation">
          <if @navigation.group@ eq @navigation_groups:item@>
            <li<if @navigation.id@ not nil> id="@navigation.id@"</if>><a href="@navigation.href@"<if @navigation.target@ not nil> target="@navigation.target;noquote@"</if><if @navigation.class@ not nil> class="@navigation.class;noquote@"</if><if @navigation.title@ not nil> title="@navigation.title;noquote@"</if><if @navigation.lang@ not nil> lang="@navigation.lang;noquote@"</if><if @navigation.accesskey@ not nil> accesskey="@navigation.accesskey;noquote@"</if><if @navigation.tabindex@ not nil> tabindex="@navigation.tabindex;noquote@"</if>>@navigation.label@</a></li>
          </if>
          </multiple>
        </ul>
      </div>
    </list>
  </if>

  <div id="content-wrapper">
    <comment>
      <div class="block-marker">Begin main content</div>
    </comment>
    <div id="inner-wrapper">
<comment>
      <if @in_personal_space@>
        <div class="myspace-wrapper">
          <div class="myspace">
            @personal_space_indicator@
          </div>
        </div>
      </if>
</comment>

    <if @user_messages:rowcount@ gt 0>
      <div id="alert-message">
        <multiple name="user_messages">
          <div class="alert">
            <strong>@user_messages.message;noquote@</strong>
          </div>
         </multiple>
       </div>
     </if>

     <if @main_content_p@>
       <div id="main">
         <div id="main-content">
           <div class="main-content-padding">
             <slave />
           </div>
         </div>
       </div>
     </if>
     <else>
       <slave />
     </else>

    </div>
  </div> <!-- /content-wrapper -->

  <if @curriculum_bar_p@ true><include src="/packages/curriculum/lib/bar" /></if>

  <if @num_of_locales@ gt 1 or @locale_admin_url@ not nil>
  <footer>
  <div id="footer">

    <hr>
    <p>
      The <a href="http://itec.eun.org" target="_blank">iTEC Project</a> is co-funded by the European Commission's FP7 programme.
    </p>
    <div id="footer-links">
    </div>
  </div> <!-- /footer -->
  </footer>
  </if>

</div> <!-- /wrapper -->

