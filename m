Return-Path: <linux-hyperv+bounces-1349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41781626F
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 22:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A55B1F217D5
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFA4B131;
	Sun, 17 Dec 2023 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2BgPGcK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4449F98;
	Sun, 17 Dec 2023 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b3b819f8a3so132375839f.1;
        Sun, 17 Dec 2023 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702848742; x=1703453542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9EUtlC/PMv4Un3TQIvI6rNRv4BEn/NrIpICR/MmGos=;
        b=Q2BgPGcKFLcr1fSJmlUw66t671tYkTyrzSm9Vh2AwIyaqwNyPAgvO3nXj77HvgGG2n
         iH8Mij1vaDJQb10NbUr+UMUU/ksKH/owHnlIIUfI7hFBIxyVXA1dgamS8o3jN8UydJd4
         pBonbJhd+ETQY/uV2N5P4A0YHBHdSSGm4veBsUIkjbQjVH69d08/nH1PcI/jVzbDaZ3m
         azP6OQwZDyry5J2YTw/ATC+O8lRORB8F3CLrSXqWfDQzDX7Z4BN+DfGFBU60vAoMLpaq
         RhKt3LAXWjV5iSe2wEi/NRUf3BY+GpjNlb6LDIBl5CFhfkNhriyccrneb8oYuzcTi83z
         BepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702848742; x=1703453542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9EUtlC/PMv4Un3TQIvI6rNRv4BEn/NrIpICR/MmGos=;
        b=oGvwWY0bwvNQr2PM5guOv8+BtlzkOXZLvqyaAtGOiy6XavfWXO8FhEhRNDbb5HxIVQ
         D3YMZYlJhBOinqWwemWAuUXlPS0X9ooqvxafn+S56FXdJivALiNIDp6gW6xURvxX+UV1
         WfJ2o+KKERvAibxV/XImUgMPHUczQmPc3ENzBMj1itWI2jF4mi/t+ABfj4MhIMQX8J8L
         WlFsG7qj53Ri1cwq4ODb2ZNqmBa4586yu5mfOcOtPDOuFqHggrmGmGcdGQA+T2nffJQa
         0Ks2lx3iRKorED+AwkPceukLppGn0puYZyB2i21Q09Kluo5BJOxWvtiP5u0sF2zKjknv
         nMig==
X-Gm-Message-State: AOJu0YzFd/rnCkdor1RysE+echqtElEdJ0ZkeedJAc5cHx/6AXIaWaMa
	lWXnY2/MqbyxZ8vgdj5PdNQ=
X-Google-Smtp-Source: AGHT+IEtk5oBf0yL162N5sduVtfni1aVSJeCPUAgGE2Xbp4M7tnAcPmIbMNqo1Wg89oUvIg7rz6GvA==
X-Received: by 2002:a92:ca4a:0:b0:35c:e547:d759 with SMTP id q10-20020a92ca4a000000b0035ce547d759mr15814238ilo.12.1702848741771;
        Sun, 17 Dec 2023 13:32:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:9c41:1dd2:7d5d:e008])
        by smtp.gmail.com with ESMTPSA id e4-20020a0df504000000b005d746ac7f6bsm8197364ywf.69.2023.12.17.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:32:21 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 3/3] net: mana: add a function to spread IRQs per CPUs
Date: Sun, 17 Dec 2023 13:32:14 -0800
Message-Id: <20231217213214.1905481-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217213214.1905481-1-yury.norov@gmail.com>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Souradeep investigated that the driver performs faster if IRQs are
spread on CPUs with the following heuristics:

1. No more than one IRQ per CPU, if possible;
2. NUMA locality is the second priority;
3. Sibling dislocality is the last priority.

Let's consider this topology:

Node            0               1
Core        0       1       2       3
CPU       0   1   2   3   4   5   6   7

The most performant IRQ distribution based on the above topology
and heuristics may look like this:

IRQ     Nodes   Cores   CPUs
0       1       0       0-1
1       1       1       2-3
2       1       0       0-1
3       1       1       2-3
4       2       2       4-5
5       2       3       6-7
6       2       2       4-5
7       2       3       6-7

The irq_setup() routine introduced in this patch leverages the
for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups
as described above.

According to [1], for NUMA-aware but sibling-ignorant IRQ distribution
based on cpumask_local_spread() performance test results look like this:

./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:05:20 INFO: 17 threads created
08:05:28 INFO: Network activity progressing...
08:06:28 INFO: Test run completed.
08:06:28 INFO: Test cycle finished.
08:06:28 INFO: #####  Totals:  #####
08:06:28 INFO: test duration    :60.00 seconds
08:06:28 INFO: total bytes      :630292053310
08:06:28 INFO:   throughput     :84.04Gbps
08:06:28 INFO:   retrans segs   :4
08:06:28 INFO: cpu cores        :192
08:06:28 INFO:   cpu speed      :3799.725MHz
08:06:28 INFO:   user           :0.05%
08:06:28 INFO:   system         :1.60%
08:06:28 INFO:   idle           :96.41%
08:06:28 INFO:   iowait         :0.00%
08:06:28 INFO:   softirq        :1.94%
08:06:28 INFO:   cycles/byte    :2.50
08:06:28 INFO: cpu busy (all)   :534.41%

For NUMA- and sibling-aware IRQ distribution, the same test works
15% faster:

./ntttcp -r -m 16
NTTTCP for Linux 1.4.0
---------------------------------------------------------
08:08:51 INFO: 17 threads created
08:08:56 INFO: Network activity progressing...
08:09:56 INFO: Test run completed.
08:09:56 INFO: Test cycle finished.
08:09:56 INFO: #####  Totals:  #####
08:09:56 INFO: test duration    :60.00 seconds
08:09:56 INFO: total bytes      :741966608384
08:09:56 INFO:   throughput     :98.93Gbps
08:09:56 INFO:   retrans segs   :6
08:09:56 INFO: cpu cores        :192
08:09:56 INFO:   cpu speed      :3799.791MHz
08:09:56 INFO:   user           :0.06%
08:09:56 INFO:   system         :1.81%
08:09:56 INFO:   idle           :96.18%
08:09:56 INFO:   iowait         :0.00%
08:09:56 INFO:   softirq        :1.95%
08:09:56 INFO:   cycles/byte    :2.25
08:09:56 INFO: cpu busy (all)   :569.22%

[1] https://lore.kernel.org/all/20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..11e64e42e3b2 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,6 +1243,34 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int node)
+{
+	const struct cpumask *next, *prev = cpu_none_mask;
+	cpumask_var_t cpus __free(free_cpumask_var);
+	int cpu, weight;
+
+	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	rcu_read_lock();
+	for_each_numa_hop_mask(next, node) {
+		weight = cpumask_weight_andnot(next, prev);
+		while (weight-- > 0) {
+			cpumask_andnot(cpus, next, prev);
+			for_each_cpu(cpu, cpus) {
+				if (len-- == 0)
+					goto done;
+				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
+				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
+			}
+		}
+		prev = next;
+	}
+done:
+	rcu_read_unlock();
+	return 0;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
 	unsigned int max_queues_per_port = num_online_cpus();
-- 
2.40.1


