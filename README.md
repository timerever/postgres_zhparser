# PostgreSQL Dockerfile with Zhparser

Version: 14

Based on [Zhparser](https://github.com/amutu/zhparser)

More about postgres image: [postgres](https://hub.docker.com/_/postgres)

## Usage:
```
-- create the extension
CREATE EXTENSION zhparser;
-- make test configuration using parser
CREATE TEXT SEARCH CONFIGURATION testzhcfg (PARSER = zhparser);
-- add token mapping
ALTER TEXT SEARCH CONFIGURATION testzhcfg ADD MAPPING FOR n,v,a,i,e,l WITH simple;

-- ts_parse
SELECT * FROM ts_parse('zhparser', 'hello world! 2010年保障房建设在全国范围内获全面启动，从中央到地方纷纷加大 了保障房的建设和投入力度 。2011年，保障房进入了更大规模的建设阶段。住房城乡建设部党组书记、部长姜伟新去年底在全国住房城乡建设工作会议上表示，要继续推进保障性安居工程建设。');
-- test to_tsvector
SELECT to_tsvector('testzhcfg','“今年保障房新开工数量虽然有所下调，但实际的年度在建规模以及竣工规模会超以往年份，相对应的对资金的需求也会创历>史纪录。”陈国强说。在他看来，与2011年相比，2012年的保障房建设在资金配套上的压力将更为严峻。');
-- test to_tsquery
SELECT to_tsquery('testzhcfg', '保障房资金压力');
```
