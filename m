Return-Path: <linux-hyperv+bounces-2641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A5944249
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 06:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7236B2173D
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BD13D8A7;
	Thu,  1 Aug 2024 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U9rrZop6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35E13D511;
	Thu,  1 Aug 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488143; cv=none; b=K+7y8CJjYiyjIzzJVcbk8k5O4gceumU6yi8k0aCB3CmIfQF3FL4MbG2SJ15h/fxO3rWwgXMvbJzHU1xHYaoFkBvfT/qsimkFPYURO+Z135iwEbQO0OuhNblmUuBo1KS1UQojIveLs56VG5eBIlFcCpVHEvjxSFX7XPx1m01RDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488143; c=relaxed/simple;
	bh=97NBC7ZpgRbtyaCYYGMlXFTaIdrjUOyDg1PD9Qk/1DQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tgaVYW1tOffHaC7tNrv2OCKIp6q31Ai1TXUNqUVA2XrXmA+KAW9E0mm+VsUvPkocW1uo/a4zOQHLQtXQmUFY43pzMokA1nqbn360ZmJJ+Y58N6n+j0j4yPH/l4TwO+epUEbcBiwxC4hsjiMEN+BceKpq1AQrBgZeCo66lYsaYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U9rrZop6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEF1920B7165;
	Wed, 31 Jul 2024 21:55:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEF1920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722488141;
	bh=pj8ZxHjO8beellSxC17OnhVfsUVVIIR4qH190zx6V3U=;
	h=From:To:Cc:Subject:Date:From;
	b=U9rrZop62Py07uugr1lypzCy3CKg0Nh4Qbkd3VIRE3LK1FMoHkyRvczGl0wSn61F2
	 QqTlMb9SYOVmEyo9Esn0LOKk43WNmsjtWuhiDOCYqKEopbpKHy58bM2GDRwYuguD4V
	 iLTLwCKtc4XPaKP0iu348Rj2KUw0a/M/U9oEu4LA=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	srivatsa@csail.mit.edu
Subject: [PATCH v3] Drivers: hv: vmbus: Optimize boot time by concurrent execution of hv_synic_init()
Date: Wed, 31 Jul 2024 21:55:36 -0700
Message-Id: <1722488136-6223-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently on a very large system with 1780 CPUs, hv_acpi_init() takes
around 3 seconds to complete. This is because of sequential synic
initialization for each CPU performed by hv_synic_init().

Schedule these tasks parallelly so that each CPU executes hv_synic_init()
in parallel to take full advantage of multiple CPUs.

This solution saves around 2 seconds of boot time on a 1780 CPU system,
which is around 66% improvement in the existing logic.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
---
[V3]
 - Modify comment, removing hotplug mention
 - Added Reviewed-by

[V2]
 - used cpuhp_setup_state_nocalls_cpuslocked instead of internal function
 - improve commit message and subject
 - Added a comment for cpu hotplug callback

 drivers/hv/vmbus_drv.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c857dc3975be..7242c4920427 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1306,6 +1306,13 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void vmbus_percpu_work(struct work_struct *work)
+{
+	unsigned int cpu = smp_processor_id();
+
+	hv_synic_init(cpu);
+}
+
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1316,7 +1323,8 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
  */
 static int vmbus_bus_init(void)
 {
-	int ret;
+	int ret, cpu;
+	struct work_struct __percpu *works;
 
 	ret = hv_init();
 	if (ret != 0) {
@@ -1355,12 +1363,32 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_alloc;
 
+	works = alloc_percpu(struct work_struct);
+	if (!works) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
 	/*
 	 * Initialize the per-cpu interrupt state and stimer state.
 	 * Then connect to the host.
 	 */
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
-				hv_synic_init, hv_synic_cleanup);
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, vmbus_percpu_work);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	/* Register the callbacks for possible CPU online/offline'ing */
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
+						   hv_synic_init, hv_synic_cleanup);
+	cpus_read_unlock();
+	free_percpu(works);
 	if (ret < 0)
 		goto err_alloc;
 	hyperv_cpuhp_online = ret;
-- 
2.43.0


