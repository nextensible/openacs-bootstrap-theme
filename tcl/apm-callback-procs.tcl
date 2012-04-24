namespace eval openacs_bootstrap_theme {}
namespace eval openacs_bootstrap_theme::install {}

ad_proc openacs_bootstrap_theme::install::after_install {} {
    Package after installation callback proc.  Add our themes, and set the acs-subsite's
    bootstrap master template parameter's bootstrap value to our "plain" theme.
} {

    # Insert this package's themes
    db_transaction {

        subsite::new_subsite_theme \
            -key bootstrap_plain \
            -name #openacs-bootstrap-theme.plain# \
            -template /packages/openacs-bootstrap-theme/lib/plain-master \
            -form_template /packages/openacs-bootstrap-theme/resources/forms/standard \
            -list_template /packages/openacs-bootstrap-theme/resources/lists/table \
            -list_filter_template /packages/openacs-bootstrap-theme/resources/lists/filters 

        subsite::new_subsite_theme \
            -key bootstrap_tabbed \
            -name #openacs-bootstrap-theme.tabbed# \
            -template /packages/openacs-bootstrap-theme/lib/tabbed-master \
            -form_template /packages/openacs-bootstrap-theme/resources/forms/standard \
            -list_template /packages/openacs-bootstrap-theme/resources/lists/table \
            -list_filter_template /packages/openacs-bootstrap-theme/resources/lists/filters 
    }

}
