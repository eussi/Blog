DROP DATABASE IF EXISTS blogdb;
CREATE DATABASE blogdb DEFAULT CHARACTER SET utf8;
USE blogdb;


/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018/10/13 17:59:23                          */
/*==============================================================*/


drop table if exists t_article;

drop table if exists t_category;

drop table if exists t_comment;

drop table if exists t_keyword;

drop table if exists t_msg;

drop table if exists t_user;

drop table if exists t_user_info;

drop table if exists t_user_login_log;

/*==============================================================*/
/* Table: t_article                                             */
/*==============================================================*/
create table t_article
(
   id                   varchar(20) not null comment '标识',
   title                varchar(100) comment '标题',
   description          text comment '描述',
   pic                  text comment '图片地址',
   content              text comment '内容',
   click                int comment '点击量',
   time                 timestamp comment '发表日期',
   category_id          varchar(20) comment '类别',
   username             varchar(15) comment '作者用户名',
   comment_num          int comment '评论数',
   is_top               varchar(1) comment '是否置顶',
   primary key (id)
);

alter table t_article comment '文章';

/*==============================================================*/
/* Table: t_category                                            */
/*==============================================================*/
create table t_category
(
   id                   varchar(20) not null comment '标识',
   name                 varchar(50) comment '类别名称',
   description          text comment '描述',
   primary key (id)
);

alter table t_category comment '文章分类';

/*==============================================================*/
/* Table: t_comment                                             */
/*==============================================================*/
create table t_comment
(
   id                   varchar(20) not null comment '标识',
   parent_id            varchar(20) comment '被恢复id',
   article_id           varchar(20) comment '文档id',
   content              text comment '内容',
   date                 timestamp comment '日期',
   user_id              varchar(20) comment '用户id',
   primary key (id)
);

alter table t_comment comment '评论';

/*==============================================================*/
/* Table: t_keyword                                             */
/*==============================================================*/
create table t_keyword
(
   article_id           varchar(20) not null comment '文章id',
   keywords             varchar(20) not null comment '关键字',
   primary key (article_id, keywords)
);

alter table t_keyword comment '关键字';

/*==============================================================*/
/* Table: t_msg                                                 */
/*==============================================================*/
create table t_msg
(
   id                   varchar(20) not null comment '标识',
   parent_id            varchar(20) comment '留言回复',
   user_id              varchar(20) comment '用户id',
   content              text comment '内容',
   date                 timestamp comment '时间',
   primary key (id)
);

alter table t_msg comment '留言';

/*==============================================================*/
/* Table: t_user                                                */
/*==============================================================*/
create table t_user
(
   id                   varchar(20) not null comment '标识',
   username             varchar(15) comment '用户名',
   password             varchar(15) comment '密码',
   salt                 varchar(5) comment '加密盐',
   user_type            varchar(1) comment '用户类型',
   locked               varchar(1) comment '是否被锁',
   last_visit           timestamp comment '上次访问时间',
   last_ip              varchar(15) comment '上次访问ip',
   primary key (id)
);

alter table t_user comment '用户表';

/*==============================================================*/
/* Table: t_user_info                                           */
/*==============================================================*/
create table t_user_info
(
   user_id              varchar(20) not null comment '用户id',
   realname             varchar(15) comment '真实姓名',
   email                varchar(50) comment '邮箱',
   tel                  varchar(12) comment '手机',
   introduction         varchar(150) comment '个人介绍',
   primary key (user_id)
);

alter table t_user_info comment '用户详细信息';

/*==============================================================*/
/* Table: t_user_login_log                                      */
/*==============================================================*/
create table t_user_login_log
(
   id                   varchar(20) not null comment '标识',
   user_id              varchar(20) comment '用户id',
   login_date           timestamp comment '登录日期',
   login_ip             varchar(15) comment '登录ip',
   primary key (id)
);

alter table t_user_login_log comment '用户登录日志';

alter table t_article add constraint FK_fk_article_category foreign key (category_id)
      references t_category (id) on delete restrict on update restrict;

alter table t_article add constraint FK_fk_article_user foreign key (username)
      references t_user (username) on delete restrict on update restrict;

alter table t_comment add constraint FK_fk_comment_article foreign key (article_id)
      references t_article (id) on delete restrict on update restrict;

alter table t_comment add constraint FK_t_comment_comment foreign key (parent_id)
      references t_comment (id) on delete restrict on update restrict;

alter table t_comment add constraint FK_t_comment_user foreign key (user_id)
      references t_user (id) on delete restrict on update restrict;

alter table t_keyword add constraint FK_fk_keyword_article foreign key (article_id)
      references t_article (id) on delete restrict on update restrict;

alter table t_msg add constraint FK_t_msg_msg foreign key (parent_id)
      references t_msg (id) on delete restrict on update restrict;

alter table t_msg add constraint FK_t_msg_user foreign key (user_id)
      references t_user (id) on delete restrict on update restrict;

alter table t_user_info add constraint FK_fk_userinfo_user foreign key (user_id)
      references t_user (id) on delete restrict on update restrict;

alter table t_user_login_log add constraint FK_fk_user_userlogin foreign key (user_id)
      references t_user (id) on delete restrict on update restrict;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `t_user` VALUES ('1','wangxm','1234','2','2','1','2018-10-13 16:09:15','0.0.0.0');
INSERT INTO `t_user_info` VALUES ('1','wangxueming','g@mail.com','343432','介绍');
INSERT INTO `t_category` VALUES ('1','散文','精品散文');
INSERT INTO `t_article` VALUES ('1','我喜欢出发','我喜欢出发。','','只是到达了的地方，都属于昨天。哪怕那山再青，那水再秀，那风再温柔。太深的流连便成了一种羁绊，绊住的不仅有双脚，还有未来。\r\n怎么能不喜欢出发呢?没见过大山的巍峨，真是遗憾；见了大山的巍峨没见过大海的浩瀚仍然遗憾；见了大海的浩瀚没见过大漠的广袤，依旧遗憾；见了大漠的广袤没见过森林的神秘，还是遗憾。世界上有不绝的风景，我有不老的心情。\r\n我自然知道，大山有坎坷，大海有浪涛，大漠有风沙，森林有猛兽。即便这样，我依然喜欢。\r\n打破生活的平静便是另一番景致，一种属于年轻的景致。真庆幸，我还没有老。即便真老了又怎么样，不是有句话叫老当益壮吗?\r\n于是，我还想从大山那里学习深刻，我还想从大海那里学习勇敢，我还想从大漠那里学习沉着，我还想从森林那里学习机敏。我想学着品味一种缤纷的人生。\r\n人能走多远?这话不是要问两脚而是要问志向；人能攀多高?这事不是要问双手而是要问意志。于是，我想用青春的热血给自己树起一个高远的目标。不仅是为了争取一种光荣，更是为了追求一种境界。目标实现了，便是光荣；目标实现不了，人生也会因这一路风雨跋涉变得丰富而充实；在我看来，这就是不虚此生。\r\n是的，我喜欢出发，愿你也喜欢。','0','2018-10-13 17:55:27','1','wangxm','0','1');
