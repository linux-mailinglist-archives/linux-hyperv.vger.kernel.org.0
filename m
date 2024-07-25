Return-Path: <linux-hyperv+bounces-2582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9293BC07
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 07:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D97286273
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 05:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EAB1C68C;
	Thu, 25 Jul 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aazhQlQn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D269125B9;
	Thu, 25 Jul 2024 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885179; cv=none; b=hgkoEjmzLUWUZCaJa8B6JlNJcJBX5fsHUixR63yvw/v4HD97TuPTRpSSBz5JBBC4clWsV74kQLQOhYvzxqTqoYcoDsQ5DV343lnNABW+VlsKJi58aFUZ09cdHgdQRdelAxFnI25HfePANCgpkvoZVXJbnd+TQpwJHIAvVkV7OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885179; c=relaxed/simple;
	bh=tRluP6WyVirJy8G2zBCqGpb2tqnlhAegLSpbjCzVCBM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XSjdEYHamHGh2ycZKrQKCcZrqY0BTWpo0zXkap5i7hxbQtvo+IfNAFxOzRwtj+HQBYj0nfrk7ael/ldNJfRNgdtbW0ZHaYDdDntdWrA1h+iixOnbzeaGnRaEiEwG4oOKx/w5yIGFsuv4r88xSX+kYoWryJ8IEr7NdB1+0RAXVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aazhQlQn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBED020B7165;
	Wed, 24 Jul 2024 22:26:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBED020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721885172;
	bh=daSIVeFPy9XrJZuvHVC2wNjvN5BkHjuD/V8ojvrxBP4=;
	h=From:To:Cc:Subject:Date:From;
	b=aazhQlQnIEZWV8AX7eGKG1CPAxqxNU2cxe8pZjICNXCQ269UFK/OLdinu/rM8BR46
	 cAxrwXQwC5mglefOhydfURnV7i8BjIUMzlVX+u8dZsbLujU7Te0M8z05A6U/+Ein2B
	 1ljukPSHlIR60hvRt7+UQYKoKeJDPY/HN80zNJE4=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	srivatsa@csail.mit.edu
Subject: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Date: Wed, 24 Jul 2024 22:26:04 -0700
Message-Id: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently on a very large system with 1780 CPUs, hv_acpi_init takes
around 3 seconds to complete for all the CPUs. This is because of
sequential synic initialization for each CPU.

Defer these tasks so that each CPU executes hv_acpi_init in parallel
to take full advantage of multiple CPUs.

This solution saves around 2 seconds of boot time on a 1780 CPU system,
that around 66% improvement in the existing logic.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c857dc3975be..3395526ad0d0 100644
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
@@ -1355,12 +1363,31 @@ static int vmbus_bus_init(void)
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
+	ret = __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online", false,
+					     hv_synic_init, hv_synic_cleanup, false);
+	cpus_read_unlock();
+	free_percpu(works);
 	if (ret < 0)
 		goto err_alloc;
 	hyperv_cpuhp_online = ret;
-- 
2.43.0


