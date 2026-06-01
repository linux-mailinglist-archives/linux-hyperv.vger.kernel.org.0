Return-Path: <linux-hyperv+bounces-11426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BO7NvtfHWo/ZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11426-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:33:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1A61D89F
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2B7D3050B6B
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB453939D0;
	Mon,  1 Jun 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cprcCl+l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582AE390CB9;
	Mon,  1 Jun 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309687; cv=none; b=KBIAjSVg9/k+EnFWc7agBMwVL+BF4xNj4PKdv8aLkFnvdfIH8HKEh5zln+y/bI9rbUi3wSWPznRz1l8uQdV8rnSzYfpgdj0LieRk2UIHxO2xMrBETBBLvHlw7dfN1CJCrV/tQEgardn2FDiYPF+AoS4YLW7eg+Hc3tlNCtJcSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309687; c=relaxed/simple;
	bh=/DaFfyq9ICeVB3S45eRPglq7om+Y55et/MZe8504gqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gx/DOb50VhphXrGDIcmEgzyq37nSIBN/TstQ68lA+zlC/ewmWdL1ARVVHv5Yn+8NIvrB+RoyeVJK025x3B/Ja6Vh2VQdkOoFfu0mK5EJ7sTFy3AY0jc6T8FkigJq2PORICt1X42KAOW2KmKCxxqPRMm99Uv/Vtm3yznYJ7OTRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cprcCl+l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0CBBA20B7166; Mon,  1 Jun 2026 03:27:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CBBA20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780309673;
	bh=PLG9HICwnUSq1M2II+tx7YVOo/elDugh6XxlVBxBUGE=;
	h=From:To:Cc:Subject:Date:From;
	b=cprcCl+low3LqSSAzSnobFEX/tuCviycOBlI1EQJYZpTxqZBi9QhqxnOQraT0Atna
	 /wkvKPWE+YRMH/4iG8pp68MxDbJSIfvHaY5h8up335+072ow65eAs1xTtT6IxMdKqZ
	 h+QnCJsR+82ePFFvr+nNOiV+Xskmc111ngEzA3Ug=
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
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu configs
Date: Mon,  1 Jun 2026 03:27:46 -0700
Message-ID: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11426-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: E4B1A61D89F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mana driver, the number of IRQs allocated is capped by the
min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
than the vcpu count, we want to utilize all the vCPUs, irrespective of
their NUMA/core bindings.

This is important, especially in the envs where number of vCPUs are so
few that the softIRQ handling overhead on two IRQs on the same vCPU is
much more than their overheads if they were spread across sibling vCPUs.

This behaviour is more evident with dynamic IRQ allocation. Since MANA
IRQs are assigned at a later stage compared to static allocation, other
device IRQs may already be affinitized to the vCPUs. As a result, IRQ
weights become imbalanced, causing multiple MANA IRQs to land on the
same vCPU, while some vCPUs have none.

In such cases when many parallel TCP connections are tested, the
throughput drops significantly.

Test envs:
=======================================================
Case 1: without this patch
=======================================================
4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)

	TYPE		effective vCPU aff
=======================================================
IRQ0:	HWC		0
IRQ1:	mana_q1		0
IRQ2:	mana_q2		2
IRQ3:	mana_q3		0
IRQ4:	mana_q4		3

%soft on each vCPU(mpstat -P ALL 1) on receiver
vCPU		0	1	2	3
=======================================================
pass 1:		38.85	0.03	24.89	24.65
pass 2:		39.15	0.03	24.57	25.28
pass 3:		40.36	0.03	23.20	23.17

=======================================================
Case 2: with this patch
=======================================================
4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)

        TYPE            effective vCPU aff
=======================================================
IRQ0:   HWC             0
IRQ1:   mana_q1         0
IRQ2:   mana_q2         1
IRQ3:   mana_q3         2
IRQ4:   mana_q4         3

%soft on each vCPU(mpstat -P ALL 1) on receiver
vCPU            0       1       2       3
=======================================================
pass 1:         15.42	15.85	14.99	14.51
pass 2:         15.53	15.94	15.81	15.93
pass 3:         16.41	16.35	16.40	16.36

=======================================================
Throughput Impact(in Gbps, same env)
=======================================================
TCP conn	with patch	w/o patch
20480		15.65		7.73
10240		15.63		8.93
8192		15.64		9.69
6144		15.64		13.16
4096		15.69		15.75
2048		15.69		15.83
1024		15.71		15.28

Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
Cc: stable@vger.kernel.org
Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v3
 * Optimize the comments in mana_gd_setup_dyn_irqs()
 * add more details in the dev_dbg for extra IRQs 
---
Changes in v2
 * Removed the unused skip_first_cpu variable
 * fixed exit condition in irq_setup_linear() with len == 0
 * changed return type of irq_setup_linear() as it will always be 0
 * removed the unnecessary rcu_read_lock() in irq_setup_linear()
 * added appropriate comments to indicate expected behaviour when
   IRQs are more than or equal to num_online_cpus()
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 60 ++++++++++++++++---
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 712a0881d720..00a28b3ca0a6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -197,6 +197,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	} else {
 		/* If dynamic allocation is enabled we have already allocated
 		 * hwc msi
+		 * Also, we make sure in this case the following is always true
+		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
 		 */
 		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
 	}
@@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
 	return 0;
 }
 
+/* should be called with cpus_read_lock() held */
+static void irq_setup_linear(unsigned int *irqs, unsigned int len)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (len == 0)
+			break;
+
+		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
+		len--;
+	}
+}
+
 static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	bool skip_first_cpu = false;
 	int *irqs, irq, err, i;
 
 	irqs = kmalloc_objs(int, nvec);
@@ -1729,6 +1744,8 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 		return -ENOMEM;
 
 	/*
+	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
+	 * nvec is only Queue IRQ (HWC already setup).
 	 * While processing the next pci irq vector, we start with index 1,
 	 * as IRQ vector at index 0 is already processed for HWC.
 	 * However, the population of irqs array starts with index 0, to be
@@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	 * first CPU sibling group since they are already affinitized to HWC IRQ
 	 */
 	cpus_read_lock();
-	if (gc->num_msix_usable <= num_online_cpus())
-		skip_first_cpu = true;
+	if (gc->num_msix_usable <= num_online_cpus()) {
+		err = irq_setup(irqs, nvec, gc->numa_node, true);
+		if (err) {
+			cpus_read_unlock();
+			goto free_irq;
+		}
+	} else {
+		/*
+		 * When num_msix_usable are more than num_online_cpus, our
+		 * queue IRQs should be equal to num of online vCPUs.
+		 * We try to make sure queue IRQs spread across all vCPUs.
+		 * In such a case NUMA or CPU core affinity does not matter.
+		 * Note: in this case the total mana IRQ should always be
+		 * num_online_cpus + 1. The first HWC IRQ is already handled
+		 * in HWC setup calls
+		 * However, if CPUs went offline since num_msix_usable was
+		 * computed, queue IRQs will be more than num_online_cpus().
+		 * In such cases remaining extra IRQs will retain their default
+		 * affinity.
+		 */
+		int first_unassigned = num_online_cpus();
+		if (nvec > first_unassigned) {
+			char buf[32];
+
+			if (first_unassigned == nvec - 1)
+				snprintf(buf, sizeof(buf), "%d",
+					 first_unassigned);
+			else
+				snprintf(buf, sizeof(buf), "%d-%d",
+					 first_unassigned, nvec - 1);
+
+			dev_dbg(&pdev->dev,
+				"MANA IRQ indices #%s will retain the default CPU affinity\n", buf);
+		}
 
-	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
-	if (err) {
-		cpus_read_unlock();
-		goto free_irq;
+		irq_setup_linear(irqs, nvec);
 	}
 
 	cpus_read_unlock();

base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.34.1


