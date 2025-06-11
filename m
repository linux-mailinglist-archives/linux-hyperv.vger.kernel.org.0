Return-Path: <linux-hyperv+bounces-5869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B7AD5826
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2A3A7E6C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5CB2874EB;
	Wed, 11 Jun 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fuhBF8uS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED31288C1C;
	Wed, 11 Jun 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651032; cv=none; b=ZZBlVAycUC+aNGt3hKX3xcARizjcYfnuzcVKta2wEhDUziYqTVfWUhxKrq1XoM2gaWY7yavydeQl+0lKcn24/G2mMTMR+0FWfuRQL1GxQoLtgRc4T2UQb32pLbMo30rzgUm/u41cERFRRs/rVk2Xiq6EvJ+P5fO8AioN7jedV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651032; c=relaxed/simple;
	bh=O8b1iR0BorA2fQJLiWlvFsiX8GqxGChfquVY8SFKOys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BgxJ3YEC9wpQUgtBdP5gRvb6rESJ6doRXZw20tqsDMBxeav05bo2rOnn6dW0gsqnywh0Wn7+2uP6/xSyTYomkqz8n2KfNlRwAn1a2Iddngp91k9fm7DYzj7FXxCPwWKO7HXqfmoMPhRQh00BBqZ4wpkcWLrD1miZ9uCehK29dBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fuhBF8uS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id BAF7F2115191; Wed, 11 Jun 2025 07:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAF7F2115191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749651030;
	bh=OvAAbL/c+Rwk797WDOKhGH2iI5RVdUOq6aNBguP1zco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuhBF8uSSAqNfKHjAxHp9ZSmTHWoDUTOnnskDgrB4ULHwzAm7MMSvwmAdAQAdALXo
	 sD7Pjm1olGVP0TUW9Ce9u1FVxmdAzP6f0WYhlaQVnoM+iR3Sd65iVZBsaSjVJgPt8o
	 p/hpzn9dqIDQhFNtp3TFG1WMtj1/thHI1quJefx4=
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
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
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
Subject: [PATCH v6 3/5] net: mana: explain irq_setup() algorithm
Date: Wed, 11 Jun 2025 07:10:29 -0700
Message-Id: <1749651029-9790-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Yury Norov <yury.norov@gmail.com>

Commit 91bfe210e196 ("net: mana: add a function to spread IRQs per CPUs")
added the irq_setup() function that distributes IRQs on CPUs according
to a tricky heuristic. The corresponding commit message explains the
heuristic.

Duplicate it in the source code to make available for readers without
digging git in history. Also, add more detailed explanation about how
the heuristics is implemented.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v5:
 * Corrected the Authur of the patch
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3504507477c6..6c4e143972a1 100644
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


