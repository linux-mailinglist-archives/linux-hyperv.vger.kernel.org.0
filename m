Return-Path: <linux-hyperv+bounces-3837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9ECA28355
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 05:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633A21887550
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7EE21517A;
	Wed,  5 Feb 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c3Lljokf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE521506B;
	Wed,  5 Feb 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738729286; cv=none; b=JG1jWfMD33ia0IrVyYzDSxtanvy2fwKU3aWcrwQpGL5vbBLaYgwTDpUiUZuv3Co6V2ft/sRkv2L+hUUyVvZUpIigqxpeSJ7L48wboQqKlveTNf+nhi55CRxax7C4+cdpZ/2sH5HOMsxPDqbnKbl5gPNYr8bj5SemmlXpuD2yCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738729286; c=relaxed/simple;
	bh=E8iUHYQCKP/1j7j55pY/CX2B6Iqb5sOw+lA53abClEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cTDqsUjGp6dpenqDUl+Zg1WnKBF0cCJ0Q4kKSp3AfeQB36Pv3SDdXR2skFb9Eegl/6l0JxxHKlrP6M9F7HiQuiUFvs2uN1ZmHx46b+AowTHr8OD4GRGCjvKR54UmmYqN9+0hkMpOUQ2vVfPP3Go1Z+tewQvcvi4oaH8E1iswmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c3Lljokf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7152D203F584; Tue,  4 Feb 2025 20:21:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7152D203F584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738729284;
	bh=sZ3N3hVD0JR4oVfFgqsstrJsWl81OqVZs2XGMVGTQ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3LljokfK6sPcYPE7EXp3Oew2WqZZX09h8h9jYk+Cl5RjlET/+iLo68LBUysldWtn
	 f09yoS0/OIvK48xITttPKMDcpzB2+Pdmyfy3irXLvqHsdkMc8FOf5g5ASbDW/5MzvI
	 VoQknRjjKKaDj7ED8z0nbs741FQ/fPrY+g2uCFBs=
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
Subject: [PATCH 1/2] net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE in MANA
Date: Tue,  4 Feb 2025 20:21:22 -0800
Message-Id: <1738729282-25702-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the max TCP segment size to go up-to GSO_MAX_SIZE for MANA NIC.
This patch only increases the max allowable GSO_MAX_SIZE for MANA devices
and does not change the default.
Following are the perf benefits by increasing the segment size from
legacy gso_max_size value(64K) to newer one(up to 511K)

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

Tested on azure env with Accelerated Networking enabled and disabled.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..da630cb37cfb 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2873,6 +2873,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->dev_port = port_idx;
 	SET_NETDEV_DEV(ndev, gc->dev);
 
+	netif_set_tso_max_size(ndev, GSO_MAX_SIZE);
+
 	netif_carrier_off(ndev);
 
 	netdev_rss_key_fill(apc->hashkey, MANA_HASH_KEY_SIZE);
-- 
2.34.1


