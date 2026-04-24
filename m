Return-Path: <linux-hyperv+bounces-10359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPuXGuYK62lJHwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10359-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 08:17:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A345A2D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 014BB3003D05
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A01534C9A3;
	Fri, 24 Apr 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pW5s0dH0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8FF19E7F7;
	Fri, 24 Apr 2026 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011428; cv=none; b=gBZXm+KeTLSyQvnLMa99lx5yPy8ErwM6mOBaVJsCd7aRIVBNi301KDZ7TLXc7pv1zw7f8dFaeYhnKZxoEFkvydWngFeMLaxlvObOD+BDnsbQ50cUzo1YqPlehwJVWzqWtVCvitWUFspIMIOKtIEuZi7r4n8PI4K8ZFT2+DszLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011428; c=relaxed/simple;
	bh=vJCZbmCN9ikb6EAz9PzXqsYAY2hNnM/b8swTEOTbwdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnc7C3DlVKeOiwNdQM3sPa5Q7/0EI9eZ0bSIi6214im5q604ah1sJNQ3ma5z5+X0BMGUQAef+px8dIc3er7mWB2DgStZvGAS+Pm3VfGdwteRAmeEnjgue35lRchI+FQajFmJJugI1JiPnBOV8WvMHs+n7vGNIVfz2nfEWa4g98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pW5s0dH0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C741920B7165; Thu, 23 Apr 2026 23:17:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C741920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777011426;
	bh=9HBq+z9XRcq8ufOpr4qgjO+oq4+Q+22OPqnEnhpd96I=;
	h=From:To:Cc:Subject:Date:From;
	b=pW5s0dH0RzCxOfvuJdm7FZa8ekzh1+hE/qSsjZgzV+5ypgl1JQqgMdoGJDQ58cXBN
	 cYIxr7a1GYSTpQMiDTaKRmySRwKv5HcJMsWWthg11e0zMsMP4yzh2Js8c3HbcbEE2U
	 VjtAphlhSkzBj8BxErQEwPVa5X/Q/IM26biiV5Ik=
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
Subject: [PATCH net] net: mana: Optimize irq affinity for low vcpu configs
Date: Thu, 23 Apr 2026 23:17:00 -0700
Message-ID: <20260424061702.1442618-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B9A345A2D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10359-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

In mana driver, the number of IRQs allocated are capped by the
min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
than the vcpu count, we want to utilize all the vcpus, irrespective of
their NUMA/core bindings.

This is important, especially in the envs where number of vcpus are so
few that the softIRQ handling overhead on two IRQs on the same vcpu is
much more than their overheads if they were spread across sibling vcpus

This behaviour is more evident with dynamic IRQ allocation. Since MANA
IRQs are assigned at a later stage compared to static allocation, other
device IRQs may already be affinitized to the vCPUs. As a result, IRQ
weights become imbalanced, causing multiple MANA IRQs to land on the
same vCPU.

In such cases when many parallel TCP connections are tested, the
throughput drops significantly

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
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 098fbda0d128..433c044d53c6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1672,6 +1672,23 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
 	return 0;
 }
 
+static int irq_setup_linear(unsigned int *irqs, unsigned int len)
+{
+	int cpu;
+
+	rcu_read_lock();
+	for_each_online_cpu(cpu) {
+		if (len <= 0)
+			break;
+
+		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
+		len--;
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
@@ -1722,10 +1739,24 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	 * first CPU sibling group since they are already affinitized to HWC IRQ
 	 */
 	cpus_read_lock();
-	if (gc->num_msix_usable <= num_online_cpus())
+	if (gc->num_msix_usable <= num_online_cpus()) {
 		skip_first_cpu = true;
+		err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
+	} else {
+		/*
+		 * In case our IRQs are more than num_online_cpus, we try to
+		 * make sure we are using all vcpus. In such a case NUMA or
+		 * CPU core affinity does not matter.
+		 * Note that in this case the total mana IRQ should always be
+		 * num_online_cpu + 1. The first HWC IRQ is already handled
+		 * in HWC setup calls
+		 * So, the nvec value in this path should always be equal to
+		 * num_online_cpu
+		 */
+		WARN_ON(nvec > num_online_cpus());
+		err = irq_setup_linear(irqs, nvec);
+	}
 
-	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
 	if (err) {
 		cpus_read_unlock();
 		goto free_irq;

base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
-- 
2.34.1


