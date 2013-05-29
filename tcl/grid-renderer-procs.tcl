::xo::library require -package xotcl-core 30-widget-procs

namespace eval ::xo::Table {

    Class create BootstrapGridRenderer \
        -superclass TABLE3 \
        -instproc init_renderer {} {
            next
            my set css.tr.even-class "even thumbnail"
            my set css.tr.odd-class "odd thumbnail"
          my set id [::xowiki::Includelet js_name [::xowiki::Includelet html_id [self]]]
        }

    BootstrapGridRenderer instproc render-body {} {
        #html::thead {
        #    html::tr -class list-header {
        #        foreach o [[self]::__columns children] {
        #        if {[$o hide]} continue
        #            $o render
        #        }
        #    }
        #}
        set children [my children]
            foreach line [my children] {
              html::li class span3 {
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

    BootstrapGridRenderer instproc render {} {
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
                    html::ul -id [my set id] -class "thumbnails" {
                        # TODO do i need that?
                        my render-actions
                        my render-body
                    }
                    if {[llength $bulkactions]>0} { my render-bulkactions }
                }
            }
        }
    }


    #Class create BootstrapGridRenderer::AnchorField -superclass TABLE::AnchorField

    Class create BootstrapGridRenderer::AnchorField \
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
                html::a [my get_local_attributes href title {CSSclass class} target onclick] {
                    return "[next]"
                }
          }
          next
      }

    Class create BootstrapGridRenderer::Action -superclass TABLE::Action
    Class create BootstrapGridRenderer::Field -superclass TABLE::Field
    Class create BootstrapGridRenderer::Field \
        -superclass TABLE::Field \
        -instproc render-data {line} {
          set contents [$line set [my name]]
          if {$contents ne ""} {
            html::span -class [my name]_label {
              html::t [my label]
            }
          }
          html::span -class "ffield [my name]" {
            next
          }
      }
    Class create BootstrapGridRenderer::HiddenField -superclass TABLE::HiddenField
    Class create BootstrapGridRenderer::ImageField -superclass TABLE::ImageField
    Class create BootstrapGridRenderer::ImageAnchorField -superclass TABLE::ImageAnchorField
    Class create BootstrapGridRenderer::BulkAction -superclass TABLE::BulkAction
}
