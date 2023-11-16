    <style>
        .board-items {
            margin-left: 50px;
            padding: 10px;
        }
    </style>


<h1>Community structure navigation</h1>
<div>
    <i id="hamburger-icon" class="fa fa-bars"> iTalent Community</i>

    <#assign categories = liqladmin("SELECT id, view_href, title, short_title, node_type, depth, parent.id FROM nodes WHERE depth>=1 AND hidden=false ORDER BY position ASC LIMIT 1000") />
   <#macro addSubcategories categoriesa>
       <#list categoriesa as item>
             <#assign children = []/>
           <#list categories.data.items as subcat>
               <#if subcat.parent.id == item.id>
                  <#assign children = children + [subcat]/>
                </#if>
            </#list>
           <div class="menu-elements">  
                <#if children?size gt 0>
                <input type='checkbox' value='${item.title}' id='check_${item.id}' class='checkBox'/>
               </#if>
                <a href='${item.view_href}'><label for="check_${item.id}">${item.title}</label></a>
                <div id='board-items_${item.id}' class='board-items' style='display:none'>
                   <#if children?size gt 0>
                     <@addSubcategories children/>
                   </#if>
                </div>
                
            </div>
        </#list>
   </#macro>

   <#assign topCategories = []/>
   <#list categories.data.items as topCat>
       <#if topCat.parent.id == "community:italent2" >
         <#assign topCategories = topCategories+[topCat]/>

       </#if>
</#list> 
    <div id="menu-items" style="display: none;">
        <#list topCategories as item>

             <#assign children = []/>
             <#list categories.data.items as subcat>
               <#if subcat.parent.id == item.id>
                  <#assign children = children + [subcat]/>
                </#if>
             </#list>

            <div class="menu-elements">
                
                <#if children?size gt 0>
                    <input type='checkbox' value='${item.title}' id='check_${item.id}' class ="checkBox" />
                  </#if>
                <a href='${item.view_href}'><label for="check_${item.id}">${item.title}</label></a>
                <div id='board-items_${item.id}' class='board-items' style='display:none'>
                  <#if children?size gt 0>
                       <@addSubcategories children/>
                  </#if>
                </div>

                 
                
            </div>
        </#list>
    </div>
</div>

<@liaAddScript>
    document.getElementById('hamburger-icon').addEventListener('click', function () {
        const hubMenu = document.getElementById('menu-items');
        hubMenu.style.display = hubMenu.style.display === 'none' ? 'block' : 'none';
    });
    
     ;(function($){
          $("input[type='checkbox']").change(function() {   
           $(this).next('a').next("div").toggle(this.checked); 
              
          });
     })(LITHIUM.jQuery)
 </@liaAddScript>


