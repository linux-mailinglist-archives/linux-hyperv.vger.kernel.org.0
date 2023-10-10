Return-Path: <linux-hyperv+bounces-504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBAA7C40EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F102814BB
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6F29D11;
	Tue, 10 Oct 2023 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YcDLH/oD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCB321B8;
	Tue, 10 Oct 2023 20:12:16 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F0193;
	Tue, 10 Oct 2023 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696968736; x=1728504736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6W9/K6/ze2C0HD+HbZjeDA0xZ+XZ+0g7jpColbh2S4=;
  b=YcDLH/oDtINJYJJEZleBAVRDQIcVeRwcS8xCnInXsiQov4+E68bN1T3F
   7OPhWM/RBG/R/UqUnizmqGOMb2gCn99bvSM62b3F/AlN4oVYl81aSmUTL
   WJWQFBBwbcZ9Y4ODBthDFQcRK4bHlzJDj41oh6T2WBp/PkQeQZ8UHy0PL
   E=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="677566915"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 20:12:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 754B940AEB;
	Tue, 10 Oct 2023 20:12:06 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 20:12:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 20:12:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <haiyangz@microsoft.com>
CC: <corbet@lwn.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<kys@microsoft.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mfreemon@cloudflare.com>, <morleyd@google.com>, <mubashirq@google.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<weiwan@google.com>, <ycheng@google.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
Date: Tue, 10 Oct 2023 13:11:54 -0700
Message-ID: <20231010201154.31898-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.11]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Tue, 10 Oct 2023 12:23:30 -0700
> TCP pingpong threshold is 1 by default. But some applications, like SQL DB
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
> 
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
> 
> There is no single value that fits all applications.
> Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> optimal performance based on the application needs.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: Make it per-namesapce setting, and other updates suggested by Neal Cardwell,
> and Kuniyuki Iwashima.
> 
> ---
>  Documentation/networking/ip-sysctl.rst |  8 ++++++++
>  include/net/inet_connection_sock.h     | 16 ++++++++++++----
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
>  net/ipv4/tcp_ipv4.c                    |  2 ++
>  net/ipv4/tcp_output.c                  |  4 ++--
>  6 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 5bfa1837968c..c0308b65dc2f 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1183,6 +1183,14 @@ tcp_plb_cong_thresh - INTEGER
>  
>  	Default: 128
>  
> +tcp_pingpong_thresh - INTEGER
> +	TCP pingpong threshold is 1 by default, but some application may need a
> +	higher threshold for optimal performance.
> +
> +	Possible Values: 1 - 255
> +
> +	Default: 1
> +
>  UDP variables
>  =============
>  
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index 5d2fcc137b88..0182f27bce40 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -325,11 +325,10 @@ void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
>  
>  struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
>  
> -#define TCP_PINGPONG_THRESH	1
> -
>  static inline void inet_csk_enter_pingpong_mode(struct sock *sk)
>  {
> -	inet_csk(sk)->icsk_ack.pingpong = TCP_PINGPONG_THRESH;
> +	inet_csk(sk)->icsk_ack.pingpong =
> +		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
>  }
>  
>  static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
> @@ -339,7 +338,16 @@ static inline void inet_csk_exit_pingpong_mode(struct sock *sk)
>  
>  static inline bool inet_csk_in_pingpong_mode(struct sock *sk)
>  {
> -	return inet_csk(sk)->icsk_ack.pingpong >= TCP_PINGPONG_THRESH;
> +	return inet_csk(sk)->icsk_ack.pingpong >=
> +	       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_pingpong_thresh);
> +}
> +
> +static inline void inet_csk_inc_pingpong_cnt(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	if (icsk->icsk_ack.pingpong < U8_MAX)
> +		icsk->icsk_ack.pingpong++;
>  }
>  
>  static inline bool inet_csk_has_ulp(const struct sock *sk)
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index d96d05b08819..9f1b3eb9473e 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -191,6 +191,7 @@ struct netns_ipv4 {
>  	u8 sysctl_tcp_plb_rehash_rounds;
>  	u8 sysctl_tcp_plb_suspend_rto_sec;
>  	int sysctl_tcp_plb_cong_thresh;
> +	u8 sysctl_tcp_pingpong_thresh;
>  
>  	int sysctl_udp_wmem_min;
>  	int sysctl_udp_rmem_min;

Maybe a hole after sysctl_tcp_backlog_ack_defer is a good place
to put a new TCP knob.

After sysctl_tcp_plb_cong_thresh, we can fill 1-byte hole but the
cacheline seems cold for TCP.

$ pahole -C netns_ipv4 vmlinux
struct netns_ipv4 {
...
	u8                         sysctl_tcp_backlog_ack_defer; /*   402     1 */

	/* XXX 1 byte hole, try to pack */

	int                        sysctl_tcp_reordering; /*   404     4 */
...
	int                        sysctl_tcp_plb_cong_thresh; /*   572     4 */
	/* --- cacheline 9 boundary (576 bytes) --- */
	int                        sysctl_udp_wmem_min;  /*   576     4 */
	int                        sysctl_udp_rmem_min;  /*   580     4 */
	u8                         sysctl_fib_notify_on_flag_change; /*   584     1 */
	u8                         sysctl_tcp_syn_linear_timeouts; /*   585     1 */
	u8                         sysctl_igmp_llm_reports; /*   586     1 */

	/* XXX 1 byte hole, try to pack */
...


> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e7f024d93572..f63a545a7374 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1498,6 +1498,14 @@ static struct ctl_table ipv4_net_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "tcp_pingpong_thresh",
> +		.data		= &init_net.ipv4.sysctl_tcp_pingpong_thresh,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +	},
>  	{ }
>  };
>  
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a441740616d7..f603ad9307af 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3288,6 +3288,8 @@ static int __net_init tcp_sk_init(struct net *net)
>  	net->ipv4.sysctl_tcp_syn_linear_timeouts = 4;
>  	net->ipv4.sysctl_tcp_shrink_window = 0;
>  
> +	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
> +
>  	return 0;
>  }
>  
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 8885552dff8e..5736a736b59c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -170,10 +170,10 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
>  	tp->lsndtime = now;
>  
>  	/* If it is a reply for ato after last received
> -	 * packet, enter pingpong mode.
> +	 * packet, increase pingpong count.
>  	 */
>  	if ((u32)(now - icsk->icsk_ack.lrcvtime) < icsk->icsk_ack.ato)
> -		inet_csk_enter_pingpong_mode(sk);
> +		inet_csk_inc_pingpong_cnt(sk);
>  }
>  
>  /* Account for an ACK we sent. */
> -- 
> 2.25.1


