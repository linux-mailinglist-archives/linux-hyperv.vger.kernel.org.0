Return-Path: <linux-hyperv+bounces-502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29E7C0488
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 21:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FEE281CB1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68432188;
	Tue, 10 Oct 2023 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="btDcUagu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693332185;
	Tue, 10 Oct 2023 19:24:40 +0000 (UTC)
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4597111D;
	Tue, 10 Oct 2023 12:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGZxpTjDob9DvArz5d95s0FLsVW1LGh2pj+a8+e0+XmW0il7tAg+cugP4tO0KGktilJknH1My6tVE3ASN8vlPZsgQZYPJGFuDh0YC/DG8zBVLTqHEoF2a0y3sJpQEMu7e/NtZ7nd7s63RWjPy/9Did4q27EE5i6855swL7maHOpp2fY1D4s1SVYfAAayhmXNGK9xjAyq62j6hhRDsc/YNw/QRWsi0gf5cblde9yd2hbjCd6npQ2n3PDXzKrgqc/xaHHlmkqhM6yJgshPeHe6psYrc8lnjBR/Z06P37r+fQQumt3xxcJVZ4SNbRvfCEL8amixmDNmNxr1Dztaah69vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9mooSgaAOk7cvDmxhjbSQVED9lwUpf3OEMriesuLyY=;
 b=Umcl6wW215UrSenYTNY9C2ECvw9PZ4MsNL++sKErywzoJ1w+3pLtzabMZ7wPe+jkz+OgQYl/FwTV5dABrApleMDBFYAF7RqVFWJC8tdctklNBI/x4HmImv/DWpk+T6Xn4wjjxNjmNqkHW5oHb3pvimzyTl6Z0KBS/kyoaa3839mBgu1I89pwU3Vo4SzBF6noSrb6Slq2IvebuiqEiRDi43oAU0wGsCEc2A8B3b544kZk6yBPhBCblAOiyt27mLpLK0Eljcn2HFy6e4vngC9rrumKDXYZLdfAaDlkTS38e7GLpnEYefUXMUUB+6ldl7EE2CD0CNwJ7N2ITTQQR3X1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9mooSgaAOk7cvDmxhjbSQVED9lwUpf3OEMriesuLyY=;
 b=btDcUaguuy/pjpH86IUckicP7c4wM6qaazxze+isrKMQ9yWtFvXqs1SyNTK77DwzOzqE32P98cuXhouzZjDZpH6Y/2G9yfs6edG+jUhHMSYfGLiOF7jx4gNmojZyDIq87lDPhZC74MAmYnzp0YLjZh3dS6mp6lrBxAtmHQdg5xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by PH7PR21MB3946.namprd21.prod.outlook.com (2603:10b6:510:24a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.2; Tue, 10 Oct
 2023 19:24:09 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::34f5:df77:26e3:1481]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::34f5:df77:26e3:1481%7]) with mapi id 15.20.6907.003; Tue, 10 Oct 2023
 19:24:09 +0000
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
Subject: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Date: Tue, 10 Oct 2023 12:23:30 -0700
Message-Id: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|PH7PR21MB3946:EE_
X-MS-Office365-Filtering-Correlation-Id: d10d6626-bc75-4c43-3379-08dbc9c679bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m1Tq9RimIG2cvFgzJ+GiwNilVTOR1i2pFyxkPPcwYzU2nFF9mDGgxNEhJp6toWqJyMc8/dkaq2yuCMJPOybwZ7+RUD4iLx3N+8FgDu2yNnn+hynniWRhPrq5fcPLwRJ8QKehXIG4lNbHTBUuJm8EgU0qyGMCtLSXVd34OGwb0V6CwpKMH2AgRWtaVPpkw/1YyYI7oSk/dPn5OQb+VfDRp4v1hEhBgL718qW07zAhkYHirvitmTTpRgJAGYd8T5aXs+j8YQfNWRPheSMFRLXJQcCCZpkAwpWBGdVYRAvFFbN+WqcYvBlj9GfQLhgjGEPw8+0TDxRqs8EsUOJScaZORXsM1jhFGaGCqqPtGvYHXriPAZz38XUaHZKW9ax+1jWE4ebMej6U1WKXRg7K/T5SQdG92JOQadHS9xoySob8fnTOwF6KexoijYapvJhia7/uSIYFSyXdgVIkdgo0M9qAC1UX+936J8Q3ZYf/+ZJSZ/jb9iq2Vk8NqH/uthfLPhfBWnSCjsRN4Y9umjg5zqStsir+RYtBENuX4+NcOX50J5Cq3Fq0XMaDukrTnsMKhCe+2rkcDWT383MqkwIrVCU0rxhRvwRWGW9rzDzHNyGc7Bhesj2dijYMqjOI4GkhY526E6B4VFl0ZBoomZEupkf40HOmhp9b4Vnobx1AawjEYUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38100700002)(82950400001)(82960400001)(38350700002)(36756003)(2906002)(478600001)(41300700001)(6506007)(6512007)(5660300002)(10290500003)(6486002)(8936002)(4326008)(52116002)(83380400001)(2616005)(66476007)(7846003)(66556008)(316002)(8676002)(7416002)(6666004)(26005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1y1BELVg8qc0dEmJMGnxwSE0WyLqwtX2i4vofMDLLmDrpRgWqK3bHh1+L9gd?=
 =?us-ascii?Q?Ye0ua+qSF2/6IdiXxPv09tlEpq7oIAci0jrGfU3x26jVZl5SXDj0ReIgsUcm?=
 =?us-ascii?Q?jXUFdnkAmPAsGBnvX7fq/1EK9+NieIDYC+CZTyEq3JHPCaHd6OJKjf46xlsu?=
 =?us-ascii?Q?Ww7/clfxnNCkfotVSVmkdAw8WQb7yF6we6cqfuzwFn//k5IUSfzGXAVSp/fl?=
 =?us-ascii?Q?TSFJktMNtnD3tqURR8c5md+m6s78FW1LLcmZ02wG7bTqVVOjUyhs/7uxLJQP?=
 =?us-ascii?Q?c4nNdcRBQgeUYM9qXjiRen6OpPC/rVEy+dhhqe1Ka/CnwI64+sr6ypMGfv5t?=
 =?us-ascii?Q?rFFRO2j9H/RUP/2EaK5dEKksMH6fLgvxHoti0O4/rR0AeDVxnbttj59hC5+L?=
 =?us-ascii?Q?R3Hh9gkRDEgrWadKDAHjeWGSKLeipWNltYMaw9pu9osDydMEfqRJNeWp7OMn?=
 =?us-ascii?Q?JwHUBsrssrn7NFvorM3Er5nm/vDjI04nkb5Npf+uYF7i8eT+9Qce6RTPZFKI?=
 =?us-ascii?Q?EHFiHYp2H5Ato0omSB6qjA42CCxrcn/PRn+TIUAIeTuCuZB1xkVn+JbD6IM9?=
 =?us-ascii?Q?HvHaNJykj+D3pc7N01kQQBr6Z/WjQepoo2K6Tuk1gq5lU2+9EmaGHZTwtt9f?=
 =?us-ascii?Q?Ii5JMGUpxPi7zHPRMhDmSqSGUUGHRm/z032u21mrlfc/LmOejEi7SZaDDczF?=
 =?us-ascii?Q?ErwhYEYITkGPQlTxqbrOIudUcBi5Swi4Fo4M1/IrSUxvUe9ImRgARd3ffear?=
 =?us-ascii?Q?CQHYRv9X9jGDvfII6AuJTC+8eE9xjDF8d9aJ89FtyUyTBW0zcrmTMqE9GW5C?=
 =?us-ascii?Q?FMvxffgVmTWKc5QekHOKw4gzfqBxZpkPVwXaTG7X8WfUJU92Ye3Y+ZpLon9U?=
 =?us-ascii?Q?JmYFZbF+BsCAeRdY1U4XEQT/MXbz+xbeGWcKAMaI735H9ONRqV5H2HVjm8vz?=
 =?us-ascii?Q?h6dasmT3xlF1eywgCR+hSUeg13kVEVFiLWMwfVurN2vRzk9HB2bvw6vQOPZR?=
 =?us-ascii?Q?RvpRyiDR9lj23AXBRcPs5JwjcDjE2gzxpxV1FdbAYhA4PgVeUpAYv3gYOPSu?=
 =?us-ascii?Q?fsT13Mb8P3MoAGvWnxEcxxJzhYbFb0EmzmsII0H53zbP2u6mm1NIsw8Jj7dj?=
 =?us-ascii?Q?jhaWnbSFxAvyK2lVeIZk0flYOK04yZwiUx6atCT2GjJ3BIfXsjFD16yNDxkf?=
 =?us-ascii?Q?MnbpZFUA6gEy0z/gueqPuqcoAcUmXIkKftU+46Le5lLCLNsGbN4h11bm/jg/?=
 =?us-ascii?Q?g6egxjfD5GS2QMeIzViMA+aH38YTHtxM7oJeLFjArons/N9hi9jTRvX4QL1q?=
 =?us-ascii?Q?REFHnQ1AuZ31wP7Pqb8RvSdbOckGIm6UFYKo9vtRUQIc936u4i1pIBjJd0HD?=
 =?us-ascii?Q?Ogt/3NS4t7HXqMNBjN59KYvNfAsRNdfFdFpEpTvMQcs9YuKcoDr7JTObJEwr?=
 =?us-ascii?Q?1iI3vUyK0wl2soFUCkLQH2CZ2BNlKvQImvj0XgzHLnK4CLUrgqbcVnJYjrr7?=
 =?us-ascii?Q?nMeBMO2dHs2b0m7z3sfwC1VTuPmE2mh0D1RjM3yPTB8SFzbmLRQllR8ZXmgT?=
 =?us-ascii?Q?KR5Fk4k0C4BoeAu18Ed9FPhpEE27UBKTdNhPL8DT?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10d6626-bc75-4c43-3379-08dbc9c679bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 19:24:08.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgyB/y+FLm74zEAVECsK+/q5D47EPCBXQbNOk9vZylP06DlW+KDEsfUfKN62pvqyPtnMBNDh8MBfjlrz6mw7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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
v2: Make it per-namesapce setting, and other updates suggested by Neal Cardwell,
and Kuniyuki Iwashima.

---
 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/net/inet_connection_sock.h     | 16 ++++++++++++----
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  2 ++
 net/ipv4/tcp_output.c                  |  4 ++--
 6 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 5bfa1837968c..c0308b65dc2f 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1183,6 +1183,14 @@ tcp_plb_cong_thresh - INTEGER
 
 	Default: 128
 
+tcp_pingpong_thresh - INTEGER
+	TCP pingpong threshold is 1 by default, but some application may need a
+	higher threshold for optimal performance.
+
+	Possible Values: 1 - 255
+
+	Default: 1
+
 UDP variables
 =============
 
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 5d2fcc137b88..0182f27bce40 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -325,11 +325,10 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
 
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
@@ -339,7 +338,16 @@ static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
 
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
index d96d05b08819..9f1b3eb9473e 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -191,6 +191,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_plb_rehash_rounds;
 	u8 sysctl_tcp_plb_suspend_rto_sec;
 	int sysctl_tcp_plb_cong_thresh;
+	u8 sysctl_tcp_pingpong_thresh;
 
 	int sysctl_udp_wmem_min;
 	int sysctl_udp_rmem_min;
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
index 8885552dff8e..5736a736b59c 100644
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


