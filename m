Return-Path: <linux-hyperv+bounces-531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF67CB043
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B121C20991
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6582E648;
	Mon, 16 Oct 2023 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vfl84jOT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A4286AF;
	Mon, 16 Oct 2023 16:50:02 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D62D4B;
	Mon, 16 Oct 2023 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697474999; x=1729010999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3l+YeDhb2m5yEYQ+Uz0O6KM2oDfAiG0VxShhKQFeOM=;
  b=Vfl84jOTUS+Bn5apYMifaGYH7RruxXqGFjeQsvFA1mD5x64jBkdHTRnl
   dJxPpE0db+VcOhIuptnOoKv2GmA4cVsc3WE70Mn/JGnCvuK7WPgti8mwD
   2N6k2E0k4mVxR1e98JRdaOCOHE2JxzJuXjcDMsm3cJkr5AVgvJrbXj01s
   w=;
X-IronPort-AV: E=Sophos;i="6.03,229,1694736000"; 
   d="scan'208";a="678687985"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:49:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id 866DE805BA;
	Mon, 16 Oct 2023 16:49:45 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:4719]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.209:2525] with esmtp (Farcaster)
 id 0c6df8e9-0c7b-461f-aaca-88f72a41d973; Mon, 16 Oct 2023 16:49:44 +0000 (UTC)
X-Farcaster-Flow-ID: 0c6df8e9-0c7b-461f-aaca-88f72a41d973
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:49:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:49:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <haiyangz@microsoft.com>
CC: <corbet@lwn.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<kys@microsoft.com>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mfreemon@cloudflare.com>, <morleyd@google.com>, <mubashirq@google.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<weiwan@google.com>, <ycheng@google.com>
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
Date: Mon, 16 Oct 2023 09:49:27 -0700
Message-ID: <20231016164927.30126-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Wed, 11 Oct 2023 13:30:44 -0700
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

