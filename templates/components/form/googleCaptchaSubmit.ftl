[#assign backButtonText=content.backButtonText!]
[#assign cancelButtonText=content.cancelButtonText!]
[#assign recaptchaSiteKey=content.recaptchaSiteKey!]

<div class="button-wrapper">

    [#if cancelButtonText?has_content]
        <script type="text/javascript">
            function mgnlFormReset(el) {
                var myForm = el.form;
                myForm.reset();
                var firstElem = null;
                var elements = myForm.elements;
                for (var i = 0; i < elements.length; i++) {
                    var elem = elements[i];
                    var fieldType = elements[i].type.toLowerCase();
                    switch (fieldType) {
                        case "text":
                        case "password":
                        case "textarea":
                            elements[i].value = "";
                            firstElem = firstElem == null ? elements[i] : firstElem;
                            break;
                        case "radio":
                        case "checkbox":
                            if (elements[i].checked) {
                                elements[i].checked = false;
                            }
                            break;
                        case "select-one":
                        case "select-multi":
                            elements[i].selectedIndex = -1;
                            break;
                        default:
                            break;
                    }
                    removeClass(elem, "user-error");
                    removeClass(elem, "form-ui-invalid");
                    if (elem.parentNode.nodeName.toLowerCase() == 'div') {
                        removeClass(elem.parentNode, "error");
                    }
                }
                // remove the "formErrors"-div
                var errorBox = document.getElementById("formErrorsDisplay");
                if(errorBox != null) {
                  errorBox.parentNode.removeChild(errorBox);
                }
                el.focus();
                return false;
            }
            function removeClass(e, c) {
                e.className = e.className.replace(new RegExp('(?:^|\\s)' + c + '(?!\\S)'), '');
            }
        </script>
        <input type="submit" onclick="return mgnlFormReset(this)" value="${cancelButtonText}"/>
    [/#if]

    [#if backButtonText?has_content]
      <script type="text/javascript">
        function mgnlFormHandleBackButton(el) {
          var back = document.createElement('input')
          back.setAttribute('type','hidden')
          back.setAttribute('name', 'mgnlFormBackButtonPressed')
          //get the enclosing form. This is widely supported, even by IE4!
          el.form.appendChild(back)
          //and disable html5 form validation
          el.form.setAttribute('novalidate', 'novalidate')
          el.form.submit()
        }
      </script>
      <input type="submit" onclick="return mgnlFormHandleBackButton(this)" value="${backButtonText}" />
    [/#if]
    [#if recaptchaSiteKey?has_content]
      <script src="https://www.google.com/recaptcha/api.js"></script>
      <input type='submit' class="g-recaptcha"
          data-sitekey ='${content.recaptchaSiteKey}'
          name="${content.controlName!}"
          id="${content.controlName!}"
          value="${content.buttonText!i18n['form.submit.default']?html}"
          onclick="return this.form.submit()" />
    [#else]
      <input type="submit" value="${content.buttonText!i18n['form.submit.default']?html}" />
    [/#if]

    [@cms.area name="conditionList"/]
</div><!-- end navigation-button-wrapper -->
