<style>
    .board-items {
        margin-left: 50px;
        padding: 10px;
    }
</style>

<h1>Community structure navigation</h1>
<div>
    <i id="hamburger-icon" class="fa fa-bars"> iTalent Community</i>

    <#assign categories = liqladmin("SELECT id,title,view_href FROM nodes WHERE depth = 1 LIMIT 1000") />
    <div id="menu-items" style="display: none;">
        <#list categories.data.items as item>
            <div class="menu-elements">
                
                <input type='checkbox' value='${item.title}' id='check_${item.id}' onclick="boardItems('${item.id}')"/>
                <a href='${item.view_href}'><label for="check_${item.id}">${item.title}</label></a>
                <div id='board-items_${item.id}' class='board-items' style='display:none'></div>
                
            </div>
        </#list>
    </div>
</div>

<@liaAddScript>
    document.getElementById('hamburger-icon').addEventListener('click', function () {
        const hubMenu = document.getElementById('menu-items');
        hubMenu.style.display = hubMenu.style.display === 'none' ? 'block' : 'none';
    });

    const boardItems = async (id) => {
        const submenuResponse = await fetch("/api/2.0/search?q=SELECT * FROM nodes WHERE parent.id='" + id + "'");
        const submenuJson = await submenuResponse.json();

        const boardItemMenu = document.getElementById('board-items_' + id);
        console.log('puneet',boardItemMenu);
        

        if (!document.getElementById('check_' + id).checked) {
        boardItemMenu.innerHTML = '';
        boardItemMenu.style.display = 'none';
        return;
    }

        boardItemMenu.innerHTML = ''; 

        submenuJson.data.items.map(eachItem => {
            const checkbox = document.createElement('input');
            checkbox.type = "checkbox";
            checkbox.value = eachItem.title;
            checkbox.id = eachItem.id;
            checkbox.onclick = function () {
                boardItems(eachItem.id); 
            };

            const label = document.createElement('label');
            label.htmlFor = eachItem.id;
           
            const link = document.createElement('a');
            link.href = eachItem.view_href;
            label.textContent = eachItem.title;
            
            label.appendChild(link);

            const div = document.createElement('div');
            div.appendChild(checkbox);
            div.appendChild(label);

            boardItemMenu.appendChild(div);
            boardItems(eachItem.id);
        });

       
           boardItemMenu.style.display = 'block';
       
    };
</@liaAddScript>
