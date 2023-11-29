Return-Path: <linux-hyperv+bounces-1148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD97FE2D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 23:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C38E28212B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4821F2B9D5;
	Wed, 29 Nov 2023 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OjVaYLAy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 539B5A3;
	Wed, 29 Nov 2023 14:17:40 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id A96B720B74C0; Wed, 29 Nov 2023 14:17:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A96B720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701296259;
	bh=Zsx1oRRDG0ud+KYg27YMp0ZwJzk7FpHaUGfDgfFevRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjVaYLAyvGNrgGT5XdUkbanydr+2zb91Ww6pBQ5v7UdvypeSsJzEFiwbBN4YUcoFd
	 iRxOfYUrSOzPaW6u8WICfgphPuL+DCUWLY0RuJKcwQcuRJaa9zIdMunYSLQCHHaTLV
	 34olHXNtIiUoYZircMeYAoW1H3Tphn9/XH4vo8ys=
Date: Wed, 29 Nov 2023 14:17:39 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231129221739.GA20858@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <20231127100639.5f2f3d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127100639.5f2f3d3e@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 27, 2023 at 10:06:39AM -0800, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 09:36:38 +0000 Souradeep Chakrabarti wrote:
> > easier to keep things inside the mana driver code here
> 
> Easier for who? Upstream we care about consistency and maintainability
> across all drivers.
I am refactoring the code and putting some of the changes in topology.h
and in nodemask.h. I am sharing the proposed change here for those two
files. Please let me know if they are acceptable.

Added a new helper to iterate on numa nodes with cpu and start from a 
particular node, instead of first node. This helps when we want to
iterate from the local numa node.

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 8d07116caaf1..6e4528376164 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -392,6 +392,15 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
        for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */

+#if MAX_NUMNODES > 1
+#define for_each_node_next_mask(node_start, node_next, mask)           \
+       for ((node_next) = (node_start);                                \
+            (node_next) < MAX_NUMNODES;                                \
+            (node_next) = next_node((node_next), (mask)))
+#else
+#define for_each_node_next_mask(node_start, node_next, mask)   \
+       for_each_node_mask(node_next, mask)
+#endif
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -440,6 +449,8 @@ static inline int num_node_state(enum node_states state)

 #define for_each_node_state(__node, __state) \
        for_each_node_mask((__node), node_states[__state])
+#define for_each_node_next_state(__node_start, __node_next, __state) \
+       for_each_node_next_mask((__node_start), (__node_next), node_states[__state])

 #define first_online_node      first_node(node_states[N_ONLINE])
 #define first_memory_node      first_node(node_states[N_MEMORY])
@@ -489,7 +500,8 @@ static inline int num_node_state(enum node_states state)

 #define for_each_node_state(node, __state) \
        for ( (node) = 0; (node) == 0; (node) = 1)
-
+#define for_each_node_next_state(node, next_node, _state) \
+       for_each_node_state(node, __state)
 #define first_online_node      0
 #define first_memory_node      0
 #define next_online_node(nid)  (MAX_NUMNODES)
@@ -535,6 +547,8 @@ static inline int node_random(const nodemask_t *maskp)

 #define for_each_node(node)       for_each_node_state(node, N_POSSIBLE)
 #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
+#define for_each_online_node_next(node, next_node)  \
+                                 for_each_node_next_state(node, next_node, N_ONLINE)

 /*
  * For nodemask scratch area.
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3..a06b16e5a955 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -43,6 +43,9 @@
        for_each_online_node(node)                      \
                if (nr_cpus_node(node))

+#define for_each_next_node_with_cpus(node, next_node)  \
+               for_each_online_node_next(node, next_node)      \
+               if (nr_cpus_node(next_node))
 int arch_update_cpu_topology(void);

 /* Conform to ACPI 2.0 SLIT distance definitions */

