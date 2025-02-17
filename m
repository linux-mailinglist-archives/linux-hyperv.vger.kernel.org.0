Return-Path: <linux-hyperv+bounces-3959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62536A37A24
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 04:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDABC7A378B
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Feb 2025 03:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD814830A;
	Mon, 17 Feb 2025 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VTRdHjAA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401E2AE7F;
	Mon, 17 Feb 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763749; cv=none; b=aRkCMHa4G1e6okbKR8oKX07iu9hlEiUuMGohR+26cLKpc3yckLAMpoQsCeYkh0ORuhWVdnDIEeKUSex80hApe2iyrlzmDU8rvoLm7fjubgJk20GQ6QHRzvjH7tJaW2yKLqwzq8PdX9l/1ZTCCQglaKJ0qJ5zvucfM74pZRvc4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763749; c=relaxed/simple;
	bh=voOSoIlIQCkbuR8agAHyxxG5l0zOt8PwGkDA5vtz5tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dkQjSytBaC6GGMdvEKrxpTcObIOU1wjWAZ55OCcSAmGuXJhQ32JKBDp1ZRjyGlpAfCcyNhmitE/a27XphiTyymuaQSZMFjgE8h6I/jb7UxiO2EX9aI3QVkE90cb7mF9ia86XZRPVTiTO3Y7iAvV044yz9PMm0OlVRfbWbck6VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VTRdHjAA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id AD031204E5B1; Sun, 16 Feb 2025 19:42:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD031204E5B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739763747;
	bh=xRt24ppM7qDdEUMFrZRNzkp3UV4KiHHsYAoOpYU9TSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTRdHjAAPIDOe0/HttK0SoFqqsFRgccwkgBlmGn73rm3spoFxG8cQLaSzYwsEd1Oh
	 l/VcgRNw3Gqsx8KpUNNqZ6hOq+rQk3tjXbZkIcrd02PDOf0fpft+yoeg41cfhdAldv
	 sDrjidbkbZ/lixhE8FRELVVq1AeKG3Kw+XklaIdI=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v3 net-next 1/2] net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE
Date: Sun, 16 Feb 2025 19:42:26 -0800
Message-Id: <1739763746-28637-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739763715-28412-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1739763715-28412-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
This patch only increases the max allowable gso/gro pkt size for MANA
devices and does not change the defaults.
Following are the perf benefits by increasing the pkt aggregate size from
legacy gso_max_size value(64K) to newer one(up-to 511K

IPv4 tests
for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -r80000,80000
-O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done

min	p90	p99	Throughput		gso_max_size
93	171	194	6594.25
97	154	180	7183.74
95	165	189	6927.86
96	165	188	6976.04
93	154	185	7338.05			64K
93	168	189	6938.03
94	169	189	6784.93
92	166	189	7117.56
94	179	191	6678.44
95	157	183	7277.81

min	p90	p99	Throughput
93	134	146	8448.75
95	134	140	8396.54
94	137	148	8204.12
94	137	148	8244.41
94	128	139	8666.52			80K
94	141	153	8116.86
94	138	149	8163.92
92	135	142	8362.72
92	134	142	8497.57
93	136	148	8393.23

IPv6 Tests
for i in {1..10}; do netperf -t TCP_RR  -H fd00:9013:cadd::4 -p50000 --
-r80000,80000 -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done

min	p90	p99	Throughput		gso_max_size
108	165	170	6673.2
101	169	189	6451.69
101	165	169	6737.65
102	167	175	6614.64
101	178	189	6247.13			64K
107	163	169	6678.63
106	176	187	6350.86
100	164	169	6617.36
102	163	170	6849.21
102	168	175	6605.7

min	p90	p99	Throughput
108	155	166	7183			
110	154	163	7268.87			
109	152	159	7434.35			
107	145	157	7569.15			
107	149	164	7496.17			80K
110	154	159	7245.85			
108	156	162	7266.24			
109	145	158	7526.66			
106	145	151	7785.75			
111	148	157	7246.65			


Tested on azure env with Accelerated Networking enabled and disabled.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v3
 * Add ipv6_hopopt_jumbo_remove() while sending Big TCP packets
---
 Changes in v2
 * Instead of using 'tcp segment' throughout the patch used more accurate
   term 'aggregated pkt size'
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..3b0fb4d95cf7 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -256,6 +256,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
+	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
+		goto tx_drop_count;
+
 	txq = &apc->tx_qp[txq_idx].txq;
 	gdma_sq = txq->gdma_sq;
 	cq = &apc->tx_qp[txq_idx].tx_cq;
@@ -2873,6 +2876,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->dev_port = port_idx;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
+	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
+
 	netif_carrier_off(ndev);
 
 	netdev_rss_key_fill(apc->hashkey, MANA_HASH_KEY_SIZE);
-- 
2.34.1


