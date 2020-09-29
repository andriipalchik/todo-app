Task manager

I'm a person who passionate about my own productivity. I want to manage my tasks and projects more effectively. I need a simple tool that supports me in controlling my task flow.
Functional requirements

★ I want to be able to create/update/delete projects ✔

★ I want to be able to add tasks to my project ✔

★ I want to be able to update/delete tasks ✔

★ I want to be able to prioritize tasks into a project ✔

★ I want to be able to choose deadline for my task ✔

★ I want to be able to mark a task as 'done' ✔
Technical requirements

★ It should be a WEB application ✔

★ For the client side must be used: HTML, CSS (any libs as Twitter Bootstrap, Blueprint ...), JavaScript (any libs as jQuery, Prototype ...) ✔ (Bootstrap 4.5)

★ For a server side any language as Ruby, PHP, Python, JavaScript, C#, Java ... ✔ (Ruby on Rails)

★ It should have a client side and server side validation ✘ (Only server side validation)

★ It should look like on screens (see attached file 'rg_test_task_grid.png'). ✘ (General resemblance only)

★ It should work like one page WEB application and should use AJAX technology, load and submit data without reloading a page. ✘ (Not a SPA)

★ It should have user authentication solution and a user should only have accesss to their own projects and tasks. ✘

★ It should have automated tests for the all functionality ✘

SQL task
Given tables:

★ tasks (id, name, status, project_id)

★ projects (id, name)
Write the queries for:

    get all statuses, not repeteating, alphabetically ordered

SELECT DISTINCT `status`
FROM `tasks`
ORDER BY `status` ASC

    get the count of all tasks in each project, order by tasks count descending

SELECT `project_id`, COUNT(`id`) `count_of_tasks` 
FROM `tasks` 
GROUP BY `project_id` 
ORDER BY `count_of_tasks` DESC

    get the count of all tasks in each project, order by projects names

SELECT `p`.`name`, COUNT(`t`.`id`) `count_of_tasks` 
FROM `projects` `p`
INNER JOIN `tasks` `t` ON `p`.`id` = `t`.`project_id`
GROUP BY `t`.`project_id`
ORDER BY `p`.`name` ASC

    get the tasks for all projects having the name beginning with "N" letter

SELECT *
FROM `tasks`
WHERE `name` LIKE 'N%'

    get the list of all projects containing the 'a' letter in the middle of the name, and show the tasks count near each project. Mention that there can exist projects without tasks and tasks with project_id=NULL

SELECT `p`.*, COUNT(`t`.`id`) `count_of_tasks` 
FROM `projects` `p`
INNER JOIN `tasks` `t` ON `p`.`id` = `t`.`project_id`
WHERE `t`.`name` LIKE '%a%'
GROUP BY `t`.`project_id`

    get the list of tasks with duplicate names. Order alphabetically

SELECT * 
FROM `tasks`  
INNER JOIN(
    SELECT `name`  
    FROM `tasks`  
    GROUP BY `name`  
    HAVING COUNT(`name`) > 1  
) `temp` ON `tasks`.`name` = `temp`.`name`
ORDER BY `tasks`.`name` ASC

    get the list of tasks having several exact matches of both name and status, from the project 'Garage'. Order by matches count

SELECT `t`.`name`, `t`.`status`, COUNT(`t`.`name`) `c`
FROM `tasks` `t`
INNER JOIN `projects` `p` ON `t`.`project_id` = `p`.`id`
INNER JOIN (
	SELECT CONCAT(`name`, `status`) `ns`
    FROM `tasks`
    GROUP BY `ns`
    HAVING COUNT(`ns`) > 1
) `temp` ON CONCAT(`t`.`name`, `t`.status) = `temp`.`ns`
WHERE `p`.`name` = 'Garage'
GROUP BY `t`.`name`, `t`.`status`
ORDER BY `c` ASC

    get the list of project names having more than 10 tasks in status 'completed'. Order by project_id

SELECT `p`.`name`
FROM `projects` `p`
INNER JOIN (
	SELECT `project_id`
    FROM `tasks`
    GROUP BY `project_id`
    WHERE `status` = 'completed'
    HAVING COUNT(`id`) > 10
) `t` ON `t`.`project_id` = `p`.`id`
ORDER BY `p`.`id` ASC
