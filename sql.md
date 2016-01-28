create table status ( created_at text
,id integer primary key 
,mid integer 
,idstr text,text text,source text,favorited integer,truncated integer,in_reply_to_status_id text ,in_reply_to_user_id text 
,in_reply_to_screen_name text,thumbnail_pic text,bmiddle_pic text,original_pic text,geo blob,user blob,retweeted_status blob 
,reposts_count integer 
,comments_count integer,attitudes_count integer,mlevel integer,visible string,pic_urls blob)