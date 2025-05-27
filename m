Return-Path: <linux-hyperv+bounces-5671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8EAC5282
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7441BA3756
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6E27D776;
	Tue, 27 May 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Go1JEj6f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533327CCF0;
	Tue, 27 May 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361510; cv=none; b=c2rDcoXrAUargn9uBixbH+d9WIBbPSROEljr1Oz6J3PMkN63P1U2SFSOmVszoH7cTbCrUP8mtASWP3MeYKsj0MuQT/lfPIzxckAco55IpSbPZDMsSDhEq1g1XJws+dd3103VjxQetIJH7RF0db/JOaKbIfBbXg5hQDRcgAqtT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361510; c=relaxed/simple;
	bh=RGSVF44FBBzUEZBfOnOpMUcFXv44SdNQJk9aIiREjiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D+HZUKmjyj/9bKTXSmUp6/UBkohxVO380oUp6Q1C37k4WAzNPMP0U0Xx6aI1ocBsxjELyjPElP2rdaBnKXkqZm2IMXmSx2w1ljiTFV+ftv7IcProu7Ilq30LFNzsIzMSpDHhNN5vGYKhd8y1qNTqbWoANsh0BfqttEfISvpzBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Go1JEj6f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8B8D7206834A; Tue, 27 May 2025 08:58:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B8D7206834A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748361508;
	bh=+ek6z3vu4GJHoGb/47gC/EKJziuFy+gbpylZmyG5YEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Go1JEj6fWWZ5y8IKi9mLMxrfnSOl6HFUh9ZjgNV7mDKcn3wbff4xYCzx8MGGrWc+d
	 Ha9kQr+Lw94SGm1wuno0c01V8p2RqKCUHnnAL7zSZxd2AgiWPg/4zb1ivGiQ91YNpn
	 PI52lWvjT49303KyOLJF9rMCjE89h8WtAm9W6JMQ=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v4 3/5] net: mana: explain irq_setup() algorithm
Date: Tue, 27 May 2025 08:58:25 -0700
Message-Id: <1748361505-25513-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
added the irq_setup() function that distributes IRQs on CPUs according
to a tricky heuristic. The corresponding commit message explains the
heuristic.

Duplicate it in the source code to make available for readers without
digging git in history. Also, add more detailed explanation about how
the heuristics is implemented.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..f9e8d4d1ba3a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1288,6 +1288,47 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+/*
+ * Spread on CPUs with the following heuristics:
+ *
+ * 1. No more than one IRQ per CPU, if possible;
+ * 2. NUMA locality is the second priority;
+ * 3. Sibling dislocality is the last priority.
+ *
+ * Let's consider this topology:
+ *
+ * Node            0               1
+ * Core        0       1       2       3
+ * CPU       0   1   2   3   4   5   6   7
+ *
+ * The most performant IRQ distribution based on the above topology
+ * and heuristics may look like this:
+ *
+ * IRQ     Nodes   Cores   CPUs
+ * 0       1       0       0-1
+ * 1       1       1       2-3
+ * 2       1       0       0-1
+ * 3       1       1       2-3
+ * 4       2       2       4-5
+ * 5       2       3       6-7
+ * 6       2       2       4-5
+ * 7       2       3       6-7
+ *
+ * The heuristics is implemented as follows.
+ *
+ * The outer for_each() loop resets the 'weight' to the actual number
+ * of CPUs in the hop. Then inner for_each() loop decrements it by the
+ * number of sibling groups (cores) while assigning first set of IRQs
+ * to each group. IRQs 0 and 1 above are distributed this way.
+ *
+ * Now, because NUMA locality is more important, we should walk the
+ * same set of siblings and assign 2nd set of IRQs (2 and 3), and it's
+ * implemented by the medium while() loop. We do like this unless the
+ * number of IRQs assigned on this hop will not become equal to number
+ * of CPUs in the hop (weight == 0). Then we switch to the next hop and
+ * do the same thing.
+ */
+
 static int irq_setup(unsigned int *irqs, unsigned int len, int node)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
-- 
2.34.1


