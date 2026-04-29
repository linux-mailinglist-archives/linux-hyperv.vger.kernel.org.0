Return-Path: <linux-hyperv+bounces-10459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFEmDfHK8Wn+kQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10459-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:10:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F93491969
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0155230547E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670A3BA25F;
	Wed, 29 Apr 2026 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UJcmu71O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C81DF25C;
	Wed, 29 Apr 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453603; cv=none; b=BTSufWqOfnSyt4oBbP9XzJDzZHAKxJxbtg1HadJk9zf5n8dsjDQGG6Svv1cSu8YHl3LaTSvQtpUbwwhfN/ZVei/AcmImK0BaT3LZOfq7Uq0xVc/tFE2OGjxxW4BVnI3BweAw7gfBlvLDLaAYjLrYCBxGGbCXsLUUp7JOtNwuXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453603; c=relaxed/simple;
	bh=xpDsb9TnyWmJ1AkE2rIeWJVfyu8QLqL1lFAm7MNZ8to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzsYbRDc10CzVokePj5V1OEbRnq6CIwyTDMDh4ES1b/yJHceTMoAhO6w/j/7KbSNDx8n4F6Bq0+5sCW7x05452GrrMzAIcVAfhZcGol1pc1bjFIC0uRZfOm4NlPLgYnfA4+gihJ+mWnCVpO9pbncDA98gtcOvHpMjZkekP7qs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UJcmu71O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 107A320B716C; Wed, 29 Apr 2026 02:06:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 107A320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777453602;
	bh=Qe8O0g3Ko5WnnnKQNFmZBLhQmwZhiY4RiL4WEuVfoCs=;
	h=From:To:Cc:Subject:Date:From;
	b=UJcmu71OH5QgxUdLgjqCkskc16d04Khos/6FWpzIUzMGVl0AWxv0n/9LXZgqDGnED
	 JvvdC89uc3ABxZy/PD1dJJIylPDrh677wYIKV7vEO99r+M+kP2X0cDj9ikpexTAOPJ
	 CGuPHVFYdCyZMVR6yoLjuoKmLy06I74Uoj18qM7Q=
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
Subject: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu configs
Date: Wed, 29 Apr 2026 02:06:37 -0700
Message-ID: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82F93491969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10459-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FROM_HAS_DN(0.00)[]

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
---
Changes in v2
 * Removed the unused skip_first_cpu variable
 * fixed exit condition in irq_setup_linear() with len == 0
 * changed return type of irq_setup_linear() as it will always be 0
 * removed the unnecessary rcu_read_lock() in irq_setup_linear()
 * added appropriate comments to indicate expected behaviour when
   IRQs are more than or equal to num_online_cpus()
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 47 ++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 098fbda0d128..d740d1dc43da 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -167,6 +167,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	} else {
 		/* If dynamic allocation is enabled we have already allocated
 		 * hwc msi
+		 * Also, we make sure in this case the following is always true
+		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
 		 */
 		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
 	}
@@ -1672,11 +1674,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
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
@@ -1722,13 +1737,31 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
+		 * When num_msix_usable are more than num_online_cpus, we try to
+		 * make sure we are using all vcpus. In such a case NUMA or
+		 * CPU core affinity does not matter.
+		 * Note: in this case the total mana IRQ should always be
+		 * num_online_cpus + 1. The first HWC IRQ is already handled
+		 * in HWC setup calls
+		 * However, if CPUs went offline since num_msix_usable was
+		 * computed, nvec count will be more than num_online_cpus().
+		 * In such cases remaining extra IRQs will retain their default
+		 * affinity.
+		 */
+		if (nvec > num_online_cpus())
+			dev_dbg(&pdev->dev,
+				"IRQ count %d exceeds online CPU count %d. Some IRQs will share CPU\n",
+				nvec, num_online_cpus());
 
-	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
-	if (err) {
-		cpus_read_unlock();
-		goto free_irq;
+		irq_setup_linear(irqs, nvec);
 	}
 
 	cpus_read_unlock();

base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
-- 
2.34.1


