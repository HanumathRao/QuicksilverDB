set datanucleus.cache.collections=false;
set hive.stats.autogather=true;

show partitions srcpart;

drop table nzhang_part1;
drop table nzhang_part2;

create table if not exists nzhang_part1 like srcpart;
create table if not exists nzhang_part2 like srcpart;

set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;

explain
from srcpart
insert overwrite table nzhang_part1 partition (ds, hr) select key, value, ds, hr where ds <= '2008-04-08'
insert overwrite table nzhang_part2 partition(ds='2008-12-31', hr) select key, value, hr where ds > '2008-04-08';

from srcpart
insert overwrite table nzhang_part1 partition (ds, hr) select key, value, ds, hr where ds <= '2008-04-08'
insert overwrite table nzhang_part2 partition(ds='2008-12-31', hr) select key, value, hr where ds > '2008-04-08';


show partitions nzhang_part1;
show partitions nzhang_part2;

select * from nzhang_part1 where ds is not null and hr is not null;
select * from nzhang_part2 where ds is not null and hr is not null;

describe extended nzhang_part1 partition(ds='2008-04-08',hr=11);
describe extended nzhang_part1 partition(ds='2008-04-08',hr=12);
describe extended nzhang_part2 partition(ds='2008-12-31',hr=11);
describe extended nzhang_part2 partition(ds='2008-12-31',hr=12);

describe extended nzhang_part1;
describe extended nzhang_part2;

drop table nzhang_part1;
drop table nzhang_part2;
