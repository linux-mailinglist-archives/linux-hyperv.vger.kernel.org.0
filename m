Return-Path: <linux-hyperv+bounces-5672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CEAC528E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5250F1BA3D30
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCEE27D784;
	Tue, 27 May 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YHYsLA9t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C727C86B;
	Tue, 27 May 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361527; cv=none; b=AI+sH44UWc+S5/DvJFTqA9WF6ZylH65YwWbzlhMuNKsAWJZYxDnXzeDiHUV8hHE9PkfYeLv9Vx9qFX9EvpKTHYpY2ARBXf1hdvzoZcOorlpkEaCvNb0SotuEm32r/AI/wUfUGTFfkjlZ/y/Z34O/MYsQXYAzAF5w32FOzZjr1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361527; c=relaxed/simple;
	bh=b8sMpoLVme1kGwGMb56xFMPBVe+zcUzYdDTbIVM7ygw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mg7TvXrJQt/pFStCEwWhS8Ue1TUp+gurs3iHVUpuaZiK55oHGxE0v+SBMmZebvCoH9tb5dYLwewT94RHsVOy6zjk+h7h8w09NzYyZ+DZwmgg2OJm2uSvecpFjcw6LO91xC5dGElyxWZ+gOATFcixtQJc7d/lkNS+/G3XUwo0t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YHYsLA9t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E3877206B778; Tue, 27 May 2025 08:58:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3877206B778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748361525;
	bh=BwIXn4Mm68cZw0MA8Sj97K1PtJksjPbNJ6YWr0nO2/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHYsLA9tpGgv/v7gMk32D+Lc9PPP1fioktKRI3/XxMDH/2ohO79892DVxKp2nr2He
	 RUZrSlSSOjIZRYPHE36sQj6lqR3quwK36o2pjmigjvZpv/JyItIP8aDQvy6i07Mt15
	 XVu4TQ+uswTUPmWeiDIssHf+xuNGA7eh9eY2uxEY=
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
Subject: [PATCH v4 4/5] net: mana: Allow irq_setup() to skip cpus for affinity
Date: Tue, 27 May 2025 08:58:44 -0700
Message-Id: <1748361524-25653-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In order to prepare the MANA driver to allocate the MSI-X IRQs
dynamically, we need to enhance irq_setup() to allow skipping
affinitizing IRQs to the first CPU sibling group.

This would be for cases when the number of IRQs is less than or equal
to the number of online CPUs. In such cases for dynamically added IRQs
the first CPU sibling group would already be affinitized with HWC IRQ.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 Changes in v4
 * fix commit description
 * avoided using next_cpumask: label in the irq_setup()
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index f9e8d4d1ba3a..763a548c4a2b 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1329,7 +1329,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
  * do the same thing.
  */
 
-static int irq_setup(unsigned int *irqs, unsigned int len, int node)
+static int irq_setup(unsigned int *irqs, unsigned int len, int node,
+		     bool skip_first_cpu)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
 	cpumask_var_t cpus __free(free_cpumask_var);
@@ -1344,11 +1345,18 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
 		while (weight > 0) {
 			cpumask_andnot(cpus, next, prev);
 			for_each_cpu(cpu, cpus) {
+				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
+				--weight;
+
+				if (unlikely(skip_first_cpu)) {
+					skip_first_cpu = false;
+					continue;
+				}
+
 				if (len-- == 0)
 					goto done;
+
 				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
-				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
-				--weight;
 			}
 		}
 		prev = next;
@@ -1444,7 +1452,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 		}
 	}
 
-	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
+	err = irq_setup(irqs, nvec - start_irq_index, gc->numa_node, false);
 	if (err)
 		goto free_irq;
 
-- 
2.34.1


