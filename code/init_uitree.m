% function uitreetest()
% surf(peaks)
%           f = figure(666);
%         
%         init_uitree(f);
% end

function mtree = init_uitree(handles)
% Create the data
% Fruits
fruits = uitreenode('v0', 'Fruits',   [], false);
fruits.add(uitreenode('v0', 'Apple',    [], true));
fruits.add(uitreenode('v0', 'Pear',     [], true));
fruits.add(uitreenode('v0', 'Banana',   [], true));
fruits.add(uitreenode('v0', 'Orange',   [], true));
 
% Vegetables
veggies = uitreenode('v0', 'Veggies',   [], false);
veggies.add(uitreenode('v0', 'Potato',  [], true));
veggies.add(uitreenode('v0', 'Tomato',   [], true));
veggies.add(uitreenode('v0', 'Carrot',  [], true));
 
% Root node
root = uitreenode('v0', 'Food',  [], false);
root.add(veggies);
root.add(fruits);
 
% Tree

mtree = uitree(handles.figure1, 'Root', root);

end

