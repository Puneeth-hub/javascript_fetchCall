    <style>
        .board-items {
            margin-left: 50px;
            padding: 10px;
        }
        .menu-elements span.plus-symbol {
           display: inline-block;
           width: 20px;
           height: 20px;
           background-color: #D3D3D3;
           border-radius: 50%;
           cursor: pointer;
           text-align: center;
           line-height: 20px;
           font-weight: bold; 
           
}

       .menu-elements span.plus-symbol:before {
           content: "+";
}

       .menu-elements span.plus-symbol.active:before {
          content: "-";
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
                <span class="plus-symbol"></span>
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
                    <span class="plus-symbol"></span>
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
    
     (function($) {
  $(".menu-elements span.plus-symbol").click(function() {
    $(this).next("a").next("div").toggle();
    $(this).toggleClass("active");
  });
})(LITHIUM.jQuery)

 </@liaAddScript>


