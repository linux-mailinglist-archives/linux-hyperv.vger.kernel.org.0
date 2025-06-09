Return-Path: <linux-hyperv+bounces-5810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF014AD2034
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43783164216
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9792225B1F0;
	Mon,  9 Jun 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bvNwdHhh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1A1EE7D5;
	Mon,  9 Jun 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476981; cv=none; b=bUyQUltPmzZH2AGDXalq3tO1UotIi/F8ZvVlrU+D06rqtq2qKPG+jLogqwGRiHOjJ+4tptNG4n5IYRpJg3Ix0Z5uX6K3YYIPg8Me5gL+yXuIzpKevai2PEUfk1QRvVKMNkSb/I7OYtvrMjgDRBfr++eS+ATPahLMq8G3Umzhxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476981; c=relaxed/simple;
	bh=YSp+OCRS4Er/rKV59ecBvAywmM/mat0WmmI7fzDrWgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=utbuax+mGIbvRGhR+m4AyUxay2aOhs9CeKxl4Hbv2QqfKC42emSzBI2Syswq7WxL3wPcumKA4w6jI9euySKD8n3tEbXjTUKgKP9zP7AVvSPLfGjH277cBJZeSpc4FXYGAFRodfgZ54hmBYEGTnwpfTF6IsKxi995gaPyJv2Tl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bvNwdHhh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C436A2117474; Mon,  9 Jun 2025 06:49:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C436A2117474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749476979;
	bh=Hxqph0KHOimiusBQXR//CugMtz83aYE3KaxyzEF/pPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvNwdHhhJymoSpzuJJDkQIY/gr12I+iNDEDbpRR1dfL1MHj2GTkk/br6Gw0tTROis
	 9eSqKL760hLEunCDNBeDtNAWf4etntCDt5U24+y8EEG41rtx+KZVUCi92NIO1JT1QH
	 zUVLve/cqqBZOpr7xqk0U570pgYqCGVBmLlBYYvY=
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
Subject: [PATCH v5 4/5] net: mana: Allow irq_setup() to skip cpus for affinity
Date: Mon,  9 Jun 2025 06:49:38 -0700
Message-Id: <1749476978-27698-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749476901-27251-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749476901-27251-1-git-send-email-shradhagupta@linux.microsoft.com>
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
index 6c4e143972a1..6e468c0f2c40 100644
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


