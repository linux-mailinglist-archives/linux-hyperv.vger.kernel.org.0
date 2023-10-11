Return-Path: <linux-hyperv+bounces-519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87C7C5E67
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 22:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E87C282500
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78815AC2;
	Wed, 11 Oct 2023 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Cu1n9BEe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD59CA68;
	Wed, 11 Oct 2023 20:31:10 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546690;
	Wed, 11 Oct 2023 13:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AghZqdEV7N6xHIfHsXMa/h/9BndHHSJ6Oe6luJLKFcuzglUxeGzogww2pIbeIPlcdAq6RzwpC9Bxwx1Ry/+onTNeT7ZtAh16OyxO7zxPA2vcIPINnxaEuQa36pVa3he6OxhKTe23RvVjivCe57VrMtgQNsbqxaZuQWyZnrASpi3t9IRzwNsLPag8XnhR8WecWjt5rYal9MTmIS0dOKBOagaLJkeAAQVXTjX5CttnQ5HPCF5lBrST5vjnldJh01HQgtxHZP5KakCn/80DyC4zxmPUMI9Wfl489T6rvk8R6Sud7dAwr986GeqKXssH5vBL5z1gdfw8vZzSXRxtDUFtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyjjA5YiufScKEbzeHtY4MjI1CNT6k5ZDon1yGxTxnE=;
 b=Us592kCvWGqJ3Zx+fFw9HsiUOn1BsCyhGDfh60jMb7B79feRYLkxkK3hIBeiF6FW06a/ewJ3//y6lR/vnMuGAC2Wucv15U3uqvh849JBxTYcoaNC6mf/YjBGgRUKT+k9fJ9QhiGfyNKTzypOMgojzQM4ZzA/XauNZPAetmi2nXxwOgQo4JdCh1kqsuXsuQ3ezbHZZ2p+s9YdMuvICDiQwFFJAwWuBU+eUCfaFEeafqnwwJfSDuxaZfYsa7NDp9R6Ib9RpwHbFQXAs+yfeN2hyrdywUeMV8QPWKi+1rG8ZOmMs9rBq6okVJiL06XrZyN0H/9JaoR4ntEcroxgq9gVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyjjA5YiufScKEbzeHtY4MjI1CNT6k5ZDon1yGxTxnE=;
 b=Cu1n9BEeGgi3nggeU0AIJZxozKtH2b9sEdW+7tERA0kLqKwSZ56/CSROaQkZslBuW5IG4+AFFVOACn5W0a2ym+tSPwwHOFwVU9cYMo+5eXPztxmdFaoOwlCVCEzgPvhDIR+TbW2oH0nG+fRYnXjmrlYgQT3u+ZImWtl+7dtnyRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MN2PR21MB1502.namprd21.prod.outlook.com (2603:10b6:208:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.11; Wed, 11 Oct
 2023 20:31:04 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::34f5:df77:26e3:1481]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::34f5:df77:26e3:1481%7]) with mapi id 15.20.6907.003; Wed, 11 Oct 2023
 20:31:04 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	dsahern@kernel.org,
	ncardwell@google.com,
	ycheng@google.com,
	kuniyu@amazon.com,
	morleyd@google.com,
	mfreemon@cloudflare.com,
	mubashirq@google.com,
	linux-doc@vger.kernel.org,
	weiwan@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
Date: Wed, 11 Oct 2023 13:30:44 -0700
Message-Id: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|MN2PR21MB1502:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ae8f49-42f8-4fa4-46c5-08dbca98fd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	weB2ZE7sxe2aCqF95EKloRQ9gVfmCDJOkEuHOWdBdfq02dT2fpv33O9JCnj9GJYIA/Cfdn92A8TeCXxemjWQUI/1Ccv2fIlNXLNO6ItBW7ojYWHtWNVH6ErCPfpZJx+EKh4Fer6FrUUuH1+oUCvAVfTstlL+0viEdUMbjIuZ32uPfpdLoKbiTf+gLknca25EGstwYns+PvkJBikYrGla+awG8umabT/SldaqASuD4yTenHRrTSLzAHeCBev+crF2X9p/WKWD2wYrZfiMqpkaqXmrVnyF5Mz5NAXnjGyK3+y0GU+l8IeGcu+q3D7gUQuXADJ01QONm4iGV3mj3WdAYs4BjCoq5/L3ZsQSnn1qY37DoqGVDc6cXRrcmbvof/WvYTiVZH5r0j8LQsw3LLt4ZTPoCG5fsXE7uoZaoqLvs6IBEWaxtRsT7mXBjiFUOJafWIBCU37Om2M2S/ScmkrVD/raDvVjdR4/rKUruFw/jHhRYjVGxLG7yqqgBL6/wMhPXlDktCcVc9PIDkGr1Wvtt9RiIJEe7oeOnrAedHZAIKguBG8M1CnNQ9oJes/WFaK+oVQ/ZpxhkvDIDH6wMMLgMLstQvVk0mF3lqH4G59WwoEqTU5u3hS0vqF1E74eI7X/3V2xSIFXq2bkjIm+AkfG603+cSXvR3a8tqXMNi7NCxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38350700002)(38100700002)(2906002)(82950400001)(82960400001)(66476007)(66556008)(66946007)(10290500003)(478600001)(6486002)(2616005)(5660300002)(7416002)(4326008)(6666004)(26005)(7846003)(8936002)(8676002)(6506007)(52116002)(83380400001)(6512007)(36756003)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5M/PuJb6tPkavm20DpTetXgYHk30kF32a058IKjTeLS8J3nKOLT54etDSKRd?=
 =?us-ascii?Q?MAETTtixF1XIopF/ifPxx/SJ8lzAicKXmYt7w3MtCnpboQnexKPHyZhgTP6u?=
 =?us-ascii?Q?W80hhv+UR3DE/Jj6XDPAB454hGMYxiemkC0IvHo7vS5B8C8NhMYVwj4A7Mws?=
 =?us-ascii?Q?R1EbyTZ+qibimg3lWjCeMFgYj9hYdnt4WSk2WJlLxG41P0GNGZJgiiVjb9P5?=
 =?us-ascii?Q?t8K6p3ykyQuqj9oFxvPSLtjkhTZ/gLU3dOGxGyQ2XY+nmbYZnzuzjdMUCNR/?=
 =?us-ascii?Q?7qigIXzBQ9KxhOUykolPjK9r8N6LnB+8RYCVgxKG0wTQYZcpvB3/xKK5eUQG?=
 =?us-ascii?Q?q9sSj7i6KMZzLqDozAH6OqjlciuvPCr1na1INOiFIb2sZRGrgQ2zFJjfvIPZ?=
 =?us-ascii?Q?7SPso1yNUwjsuxT9g15Z5FW+AXP99HIkHX9qXn2qhRRXEA72sR1AGZZUevWK?=
 =?us-ascii?Q?CmVVgmi14k0zsR8815PHRrrjrGfbLB9JpV0/ciFBOpX1P1Gpk8fyUqpU3q+e?=
 =?us-ascii?Q?wHaxCymKfZdSTauZonCrFJyFDdFiluoETNc2zQuzz/zukBfqlE6jw/6zTjYC?=
 =?us-ascii?Q?oBQxKxqCP5dy/o07AM8Q2wZT+JVo+uRlfq+cGXwH1iAij2dudN2nL+FJvUU0?=
 =?us-ascii?Q?cDygQNVeJHF3bJcTmSJLeF+hsOpNInvjCy9BVjEOPEwoZqEai76h1j2Va44S?=
 =?us-ascii?Q?3UA+oVXOGZtk0WvZKZV17HBgXMDhi06BKt5HRVdUqOevbtGdHlg1WUb6SZHq?=
 =?us-ascii?Q?Lwrkg4383mEYHDyWzJJmSqmY66TqCVL+iBtlYzaz8n7U/IZw0znmvlfqctUU?=
 =?us-ascii?Q?rU/20KaUYU8HdwGYWiMD8hmi+O1fgbBPxmGc4r9RW+QsApz7FMHnxJ5gVbcL?=
 =?us-ascii?Q?wh05CSyUHgHupATSvHVL4SqQVCdMI2LcEoLWxoSdkeDw0Otexp5fKiWjfGJv?=
 =?us-ascii?Q?JPVD+IF9AqeFObid2gSCJ79fB5aqBm1Z3yqQXGzZOGqzy/Znpq3EMq3boQrU?=
 =?us-ascii?Q?f6T3UbuZoXNJ48er6BvrnpZWDVpHupi5kaLQ0ZfjgGVwoDggSUKg6Z/xR58m?=
 =?us-ascii?Q?vVgNg/alnl3uFcwIGZzXC9rvxjcXonxSog1oRH0gtjP4H8GJVIR5m9un3y/i?=
 =?us-ascii?Q?nOYhngDjGJ2lthcQthOTNMxDXcCy3YTxLY9JTpDOwBKqrbtFmYJLOOZ2Yl0E?=
 =?us-ascii?Q?RXLpWfMBubb2eS9Hxz8X4wqn0NkSYT6MGSA6x5QBLBXgN/6oBcDTjbLc65TC?=
 =?us-ascii?Q?jlGcKZl5fK4TjtyX4yqffbpfUQnDe23z5JrSKQCQjt9hedOdv1HAf8RM70xQ?=
 =?us-ascii?Q?ZfggVBPJLrp74UJ+DfDgGUXx/FEUrImFa9Vc6sOnCWS1ySHa+7FgdlWFlhDn?=
 =?us-ascii?Q?/sw9C8AJ+IM9k652LmIErL3HH0cEvipwJ7rAoat+3ppRmqqt57vs6Us5SYO5?=
 =?us-ascii?Q?lpCsZiC/x+tB3YtL9pD32CU1IedBP00Nrp9nCuKMw0Vf7RNHf6zrBC/ex6su?=
 =?us-ascii?Q?pGWu/8fpjX36miXwvLeJWKAaHzo044JOBquEdcDJMr/brAgU8YGZqBghH/dv?=
 =?us-ascii?Q?byuwmsQ/nVmC7IFaI44w4D9qQkGZVMCJ3jv3e/Ed?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ae8f49-42f8-4fa4-46c5-08dbca98fd2b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:31:04.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MR3Iwjs5ey4883X2KEfvg9IUErE63qTeTzQgjhWKbLiHS+mG4EwBY9c5o3bmMlPu4G6lyawAwJfPkfOsR29gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCP pingpong threshold is 1 by default. But some applications, like SQL DB
may prefer a higher pingpong threshold to activate delayed acks in quick
ack mode for better performance.

The pingpong threshold and related code were changed to 3 in the year
2019 in:
  commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
And reverted to 1 in the year 2022 in:
  commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")

There is no single value that fits all applications.
Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
optimal performance based on the application needs.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v3: Updated doc as suggested by Neal Cardwell.
    Updated variable location in struct netns_ipv4 as suggested by Kuniyuki
    Iwashima.

v2: Make it per-namesapce setting, and other updates suggested by Neal Cardwell,
and Kuniyuki Iwashima.
---
 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/inet_connection_sock.h     | 16 ++++++++++++----
 include/net/netns/ipv4.h               |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  2 ++
 net/ipv4/tcp_output.c                  |  4 ++--
 6 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f7dfde3b09a9..e7ec9026e5db 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1183,6 +1183,19 @@ tcp_plb_cong_thresh - INTEGER
 
 	Default: 128
 
+tcp_pingpong_thresh - INTEGER
+	The number of estimated data replies sent for estimated incoming data
+	requests that must happen before TCP considers that a connection is a
+	"ping-pong" (request-response) connection for which delayed
+	acknowledgments can provide benefits.
+
+	This threshold is 1 by default, but some applications may need a higher
+	threshold for optimal performance.
+
+	Possible Values: 1 - 255
+
+	Default: 1
+
 UDP variables
 =============
 
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d6d9d1c1985a..086d1193c9ef 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -328,11 +328,10 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 
 struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
 
-#define TCP_PINGPONG_THRESH	1
-
 static inline void inet_csk_enter_pingpong_mode(struct sock *sk)
 {
-	inet_csk(sk)->icsk_ack.pingpong = TCP_PINGPONG_THRESH;
+	inet_csk(sk)->icsk_ack.pingpong =
+		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
 }
 
 static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
@@ -342,7 +341,16 @@ static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
 
 static inline bool inet_csk_in_pingpong_mode(struct sock *sk)
 {
-	return inet_csk(sk)->icsk_ack.pingpong >= TCP_PINGPONG_THRESH;
+	return inet_csk(sk)->icsk_ack.pingpong >=
+	       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
+}
+
+static inline void inet_csk_inc_pingpong_cnt(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	if (icsk->icsk_ack.pingpong < U8_MAX)
+		icsk->icsk_ack.pingpong++;
 }
 
 static inline bool inet_csk_has_ulp(const struct sock *sk)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index d96d05b08819..73f43f699199 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -133,6 +133,8 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_migrate_req;
 	u8 sysctl_tcp_comp_sack_nr;
 	u8 sysctl_tcp_backlog_ack_defer;
+	u8 sysctl_tcp_pingpong_thresh;
+
 	int sysctl_tcp_reordering;
 	u8 sysctl_tcp_retries1;
 	u8 sysctl_tcp_retries2;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e7f024d93572..f63a545a7374 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1498,6 +1498,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "tcp_pingpong_thresh",
+		.data		= &init_net.ipv4.sysctl_tcp_pingpong_thresh,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 	{ }
 };
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a441740616d7..f603ad9307af 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3288,6 +3288,8 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_syn_linear_timeouts = 4;
 	net->ipv4.sysctl_tcp_shrink_window = 0;
 
+	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
+
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f207712eece1..7d0fe76d56ef 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -170,10 +170,10 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 	tp->lsndtime = now;
 
 	/* If it is a reply for ato after last received
-	 * packet, enter pingpong mode.
+	 * packet, increase pingpong count.
 	 */
 	if ((u32)(now - icsk->icsk_ack.lrcvtime) < icsk->icsk_ack.ato)
-		inet_csk_enter_pingpong_mode(sk);
+		inet_csk_inc_pingpong_cnt(sk);
 }
 
 /* Account for an ACK we sent. */
-- 
2.25.1


