$(document).ready(function() {


/*==================================
Feature : Load all companies with operations
Page : http://localhost/
Element :  Autoload the campanies via ajax .
====================================*/
    function loadCompanies() {

        $(document).on('ready', function() {

        	current_page = $("#current_page").val();

            $.ajax({
                url: '/companies',
                method: 'GET',
                data: {page: current_page},
                success: function(response) {
                  $("#companies_list").html(response);
                },
                error: function(response) {
                    console.log(response);
                }
            });
        })
    }

/*==================================
Feature : Load all companies with operations
Page : http://localhost/
Element :  Autoload the campanies via ajax .
====================================*/
    function loadCompanyInfo() {

        $("#companies_list").on('click', ".company_info_show", function() {
        	
        	company_id = $(this).attr("data-company-id");

            $.ajax({
                url: '/companies/' + company_id,
                method: 'GET',
                success: function(response) {
                  $('.modal-body').html(response);
                  $('#detail_modal').click();
                },
                error: function(response) {
                    console.log(response);
                }
            });          		
      		

        })
    }



/*==================================
Feature : Initializing all Javascript under this controller.
Page : http://localhost
Element : Program start here.
====================================*/

    loadCompanies();
    loadCompanyInfo();

});