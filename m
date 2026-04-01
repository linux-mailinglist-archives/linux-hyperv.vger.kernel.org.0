Return-Path: <linux-hyperv+bounces-9867-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHeQNDM5zWnfawYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9867-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:26:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4839237D0C2
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AFC5301485B
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BB3FA5ED;
	Wed,  1 Apr 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hReNgqji";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/++yGdb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8043603C2
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Apr 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056527; cv=none; b=hfapLwG0+B392W51MwrQx5s+sPG6zNmPvvYYiQD/kOi36A/j1i1GFDyu8iT+5mE9OkCGtDd/+rDp6XqiV7FeRR76r3AZpuUw63Hfo8hhsUesYMmEnabfO/th8jGoUvkBXpbXRcUou3A4wKKOOA/Yc/g4BFzbv4iETsqDU9s3njw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056527; c=relaxed/simple;
	bh=P1gP3Uilw7VoauyiFRHNGwT/F08wPcfvhNwZ/NEz8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCxx8De030asqXcbfVRmspfN/1KZMYlA+sQn8jOWyGYOPxzIxqqV+l880Po4ovO4Pi5yK+SyR9GjGKTWE56AZSy2abSANsJwzPxPnk3q62nZ1mGKe4DO/eWkEqCUywB2LaE2D+rZ+FDz2lqvKyUA/oxP0nZGZ8cXP7Jl7Q5LIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hReNgqji; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/++yGdb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PE3yGuxBE8fZWkDlxjkheUUb9DSy2R9+OrZvzc+cxw=;
	b=hReNgqjiog5Jqlqt27XfooCk4vHW2073EJrsZkN6YURRD7VIM0ivXzobK9HyUGxi5E/ldd
	Rx7EUsIkH13muq4cIRj284zfudfev6sKvqQz+BN/xJgKD16M+qq0eVc3vQbfUM1S9AwJDo
	7xxqHjM5/6KA1nXXCUHwmYMz8MPLd+wEoZk2EVpRxpZ5r9WV3L2RhuL6VdUbEbjrelvcGt
	6Bwns/wCGpX+LS8iu1u3AVBKpPIlMV92AVhMuSu7MhZPO2zbjotFRKP5Acnoo84P/IA2Ic
	U3aexrGVTbExuYTJEp2KXZirM4RVkM4nCcBzRcJDujWzHTPPvn3d1+/fD9+vJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PE3yGuxBE8fZWkDlxjkheUUb9DSy2R9+OrZvzc+cxw=;
	b=+/++yGdbcnTxfABiYR23EuiqsIU0mFujQ0ad3914Itil9KgipeyiLn0XE2WtqIx4XIezaC
	nykc7yyUQLcebYBA==
To: linux-hyperv@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] hv: vmbus: Remove vmbus_irq_initialized
Date: Wed,  1 Apr 2026 17:15:17 +0200
Message-ID: <20260401151517.1743555-3-bigeasy@linutronix.de>
In-Reply-To: <20260401151517.1743555-1-bigeasy@linutronix.de>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,siemens.com,outlook.com,kernel.org,linutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9867-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4839237D0C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmbus_irq_initialized is only true if the registration of the per-CPU
threads succeeded. If it failed, the whole registration aborts and the
vmbus_exit() path is never called.

Remove vmbus_irq_initialized.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hv/vmbus_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e44275370ac2a..7417841cd1f70 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1392,8 +1392,6 @@ static void run_vmbus_irqd(unsigned int cpu)
 	__vmbus_isr();
 }
=20
-static bool vmbus_irq_initialized;
-
 static struct smp_hotplug_thread vmbus_irq_threads =3D {
 	.store                  =3D &vmbus_irqd,
 	.setup			=3D vmbus_irqd_setup,
@@ -1513,11 +1511,10 @@ static int vmbus_bus_init(void)
 	 * the VMbus interrupt handler.
 	 */
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		ret =3D smpboot_register_percpu_thread(&vmbus_irq_threads);
 		if (ret)
 			goto err_kthread;
-		vmbus_irq_initialized =3D true;
 	}
=20
 	if (vmbus_irq =3D=3D -1) {
@@ -1561,10 +1558,8 @@ static int vmbus_bus_init(void)
 	else
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
 err_setup:
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
-		vmbus_irq_initialized =3D false;
-	}
 err_kthread:
 	bus_unregister(&hv_bus);
 	return ret;
@@ -3033,10 +3028,9 @@ static void __exit vmbus_exit(void)
 		hv_remove_vmbus_handler();
 	else
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
-		vmbus_irq_initialized =3D false;
-	}
+
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
--=20
2.53.0


