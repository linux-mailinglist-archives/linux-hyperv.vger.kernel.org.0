Return-Path: <linux-hyperv+bounces-5443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89816AB1024
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA49178834
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71A28EA7E;
	Fri,  9 May 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tkbqnbb3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485E274674;
	Fri,  9 May 2025 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785629; cv=none; b=VgeE8kEj+FEiYSlnS5ti8ARDDECGVj6deXskM0mScxP5P8D6ss9SAU+cmzkH50uR96UtrAD8Om5FB7YPDucCmlNDH1TaKdK8+SHihp56HDzBqg3ZuFut5/ieELS5jn+IOzkEKleCfeEXGICnS0XsW1vSllvPB1A2qI+d1/n5WdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785629; c=relaxed/simple;
	bh=BUJ8x0JLhkS7DoHd6lHAsVOFU72/Ls1DqhLRpDoFWOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FLTvGYVVtAZj46JS7UYppmjS9YTK1Uko9wZ+UrtGvL49y4sRhFwm7oWUeF61hssRevLwbxTIKQ7rd9vWVnTx4xzXCG1+uylBxuk5aaYG7ZMqusNDGJl3dlOLXodg9RgOMmTuA5rZFAUViSzy+hjZi4LhCYXI69UlyA12wgdbkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tkbqnbb3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4972C2098462; Fri,  9 May 2025 03:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4972C2098462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746785627;
	bh=gEW7wXPmdwYptJzvTzaNmB9Cse5HO3g+2gZnzmwQfaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tkbqnbb3uFxEnjLH/M27IoWSeGc2Mhez63YAaoeMgyGQfhJ7w2ZOWOusJfZ7sl5K3
	 DaqwZoH5E96HJXMBfgwMjsjvv4Vq9GnbPmJrZjaQguKKDbqqb+TSLQeHCw2f3gKsK3
	 LXU3DmiXeD7b5jnhTUTiXLikUNECTMJ5BTYwHlKw=
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
	Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for affinity
Date: Fri,  9 May 2025 03:13:45 -0700
Message-Id: <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In order to prepare the MANA driver to allocate the MSI-X IRQs
dynamically, we need to prepare the irq_setup() to allow skipping
affinitizing IRQs to first CPU sibling group.

This would be for cases when number of IRQs is less than or equal
to number of online CPUs. In such cases for dynamically added IRQs
the first CPU sibling group would already be affinitized with HWC IRQ

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..2de42ce43373 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1288,7 +1288,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
-static int irq_setup(unsigned int *irqs, unsigned int len, int node)
+static int irq_setup(unsigned int *irqs, unsigned int len, int node,
+		     bool skip_first_cpu)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
 	cpumask_var_t cpus __free(free_cpumask_var);
@@ -1303,9 +1304,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
 		while (weight > 0) {
 			cpumask_andnot(cpus, next, prev);
 			for_each_cpu(cpu, cpus) {
+				/*
+				 * if the CPU sibling set is to be skipped we
+				 * just move on to the next CPUs without len--
+				 */
+				if (unlikely(skip_first_cpu)) {
+					skip_first_cpu = false;
+					goto next_cpumask;
+				}
+
 				if (len-- == 0)
 					goto done;
+
 				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
+next_cpumask:
 				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
 				--weight;
 			}
@@ -1403,7 +1415,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 		}
 	}
 
-	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
+	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node, false);
 	if (err)
 		goto free_irq;
 
-- 
2.34.1


