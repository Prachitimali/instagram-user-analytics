-- Instagram user analytics
--  Description:
-- Analysing user interactions and engagement with the Instagram app to provide valuable insights that can 
-- help the business grow.User analysis involves tracking how users engage with a digital product, such as a
-- software application or a mobile app.The insights derived from this analysis can be used by various teams 
-- within the business.

-- A)  Marketing Analysis:
use ig_clone;
-- 1.  Identify the five oldest users on Instagram from the provided database.
select *from users;

select username,created_at from users order by created_at limit 5;

-- 2.  Identify users who have never posted a single photo on Instagram.
select *from photos,users;
select *from users u left join photos p on p.user_id=u.id where p.image_url is not null order by u.username;

-- 3.Determine the winner of the contest and provide their details to the team.
select * from likes, photos,users;

select likes.photo_id,users.username, count(likes.user_id) as nooflikes
from likes inner join photos on likes.photo_id=photos.id
inner join users on photos.user_id=users.id group by 
likes.photo_id,users.username order by nooflikes desc;

-- 4.  Identify and suggest the top five most commonly used hashtags on the platform.
select * from photo_tags, tags;
select t.tags_name, count(p.photo_id) as ht from photo_tags p inner join tags t on t.id=p.tag_id
group by t.tag_name order by ht desc;


-- 5.  Determine the day of the week when most users register on Instagram.Provide insights on when to 
--      schedule an ad campaign
select * from users;
select date_format((created_at), '%W') as  d,count(username) from users group by 1 order by 2 desc; 


-- B)  Investor Metrics:

-- 1. Calculate the average number of posts per user on Instagram. Also, provide the total number of 
--    photos on Instagram divided by the total number of users.
select * from photos,users;
with base as (
select u.id as userid, count(p.id) as photoid from users u left join phots p on p.user_id=u.id group by 
u.id)
select sum(photoid) as totalphotos,count(userid) as total_users,sum(photoid)/count(userid) as photoperuser
from base;
-- 2. Identify users (potential bots) who have liked every single photo on the site, as this is not 
--    typically possible for a normal user.
select * from users,likes;
with base as(
select u.username,count(l.photo_id) as likess from likes l inner join users u on u.id=l.user_id
group by u.username)
select username,likess from base where likess=(select count(*) from photos) order by username;
