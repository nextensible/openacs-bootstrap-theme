::xo::library require -package xotcl-core 30-widget-procs

namespace eval ::xo {}
namespace eval ::xo::Table {

    Class create BootstrapDataTableRenderer \
        -superclass TABLE3 \
        -instproc init_renderer {} {
            next
            my set css.table-class list-table
            my set css.tr.even-class "even row-fluid"
            my set css.tr.odd-class "odd row-fluid"
          my set id [::xowiki::Includelet js_name [::xowiki::Includelet html_id [self]]]
        }

    BootstrapDataTableRenderer instproc render-body {} {
        #html::thead {
        #    html::tr -class list-header {
        #        foreach o [[self]::__columns children] {
        #        if {[$o hide]} continue
        #            $o render
        #        }
        #    }
        #}
        set children [my children]
        html::div {
            foreach line [my children] {
              html::div class well {
                html::div -class [expr {[my incr __rowcount]%2 ? [my set css.tr.odd-class] : [my set css.tr.even-class] }] {
                    foreach field [[self]::__columns children] {
                        if {[$field hide]} continue
                        html::div  [concat [list class "ff[$field name]"] [$field html]] {
                            $field render-data $line
                        }
                    }
                }
              }
            }
        }
    }

    BootstrapDataTableRenderer instproc render {} {
        if {![my isobject [self]::__actions]} {my actions {}}
        if {![my isobject [self]::__bulkactions]} {my __bulkactions {}}
        set bulkactions [[self]::__bulkactions children]
        if {[llength $bulkactions]>0} {
          set name [[self]::__bulkactions set __identifier]
        } else {
          set name [::xowiki::Includelet js_name [self]]
        }
        # TODO: maybe use skin everywhere? hen to use style/CSSclass or skin?
        set skin [expr {[my exists skin] ? [my set skin] : ""}]
        html::div -id [my set id]_wrapper -class $skin {
        html::form -name $name -id $name -method POST { 
        html::div -id [my set id]_container {
                    #html::table -id [my set id] -class [my set css.table-class] {
                        # TODO do i need that?
                        my render-actions
                        my render-body
                    #}
                    if {[llength $bulkactions]>0} { my render-bulkactions }
                }
            }
        }
    }


    #Class create BootstrapDataTableRenderer::AnchorField -superclass TABLE::AnchorField

    Class create BootstrapDataTableRenderer::AnchorField \
        -superclass TABLE::Field \
        -ad_doc "
            In addition to the standard TableWidget's AnchorField, we also allow the attributes
            <ul>
                <li>onclick
                <li>target
            </ul>
        " \
        -instproc render-data {line} {
          set __name [my name]
          if {[$line exists $__name.href] &&
              [set href [$line set $__name.href]] ne ""} {
                # use the CSS class rather from the Field than not the line
                my instvar CSSclass
                $line instvar   [list $__name.title title] \
                                [list $__name.target target] \
                                [list $__name.onclick onclick]
                if {[my exists onclick]} {
                  set onclick [my set onclick]
                }
                html::a [my get_local_attributes href title {CSSclass class} target onclick] {
                    return "[next]"
                }
          } elseif {$__name in {"_edit" "_delete" "_view" "_personalize" "_widgetize"}} {
            # TODO: In form-usages, all Fields are AnchorFields, therefore, we
            # have to render them regardless of absent hrefs...
            # However, for the hardcoded buttons, we can safely not render them
            # if they have an empty href.
            return ""
          }
          next
      }

    Class create BootstrapDataTableRenderer::Action -superclass TABLE::Action
    Class create BootstrapDataTableRenderer::Field -superclass TABLE::Field
    Class create BootstrapDataTableRenderer::Field \
        -superclass TABLE::Field \
        -instproc render-data {line} {
          # We can only use inline tags here, as this
          # might be wrapped by a link tag
          set contents [$line set [my name]]
          # FIXME: Hack for review
          if {$contents ne "" && $contents ne "<div class='ff__wookie viewmode'></div>" } {
            html::span -class [my name]_label {
              html::t [my label]
            }
          }
          if {[my name] eq "__nls_language"} {
            set lang [string range [$line set __nls_language] end-4 end-3]
            html::img -class "pull-right" -src "/resources/xowiki/flags/png/${lang}.png"
          } else {
            html::span -class "ffield [my name]" {
              next
            }
          }
      }
    Class create BootstrapDataTableRenderer::HiddenField -superclass TABLE::HiddenField
    Class create BootstrapDataTableRenderer::ImageField -superclass TABLE::ImageField
    Class create BootstrapDataTableRenderer::ImageAnchorField -superclass TABLE::ImageAnchorField
    Class create BootstrapDataTableRenderer::BulkAction -superclass TABLE::BulkAction
}
