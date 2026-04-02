Return-Path: <linux-hyperv+bounces-9936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEp2JKPRzmmUqQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9936-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:29:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DA38DF90
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AD0E3020EC2
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC14384232;
	Thu,  2 Apr 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="O6pfK2Bm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6903630B2;
	Thu,  2 Apr 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161532; cv=pass; b=R2xu7v/XtMrhQE1iWnYPONkhY61HD2MjTFCFpDrQ2h6mf6EgkK+cm0gVoV/BLm3sKHKVhVfFtTsSEU1XsCuX6hXbm0J2nsBxE/sU3SHhRaf5ioQshDP8YoYSSQ/mPDcGbMD7HVZg6Uc1dRTxw0OvZbJVu6t928N9deLs/eAoVvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161532; c=relaxed/simple;
	bh=lVeJ2zPl9eCElQeF0GBPzbaDxT0NGRcsP23sOmfq+UY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PytO9pLTTRRZcSzZJZd76PoA+Qpz3TdtKV1YpiUp0ehr94iEZgll0UB4aaQdIU53jnM/KqMXC9R6eQgLPQUfqz6KcdAmyBh9jm7yl2eYJ7yMAWg98wWIsnND4dNMHch+OmACz6MDOY75+HsksrQAzeqYFvBtQ2Xvq1ymV3z29/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=O6pfK2Bm; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1775161458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j+EaK0mEguMAohiFbO2ixc7qPgIio3Pp1tu1BbYbC/TDiUG7q7ksVaaggpox9Wo6UaMGLBBf4apD5maVxziyIbvrFb8SSqGUEfxpxLAtgKLRl1UdlD50rBYQdzlqs+++XB5JjKy+z7RK/YlDL6QZbh9jhJdzwmLDlVZd/yKv2ak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775161458; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id:Cc; 
	bh=9b9I0WnX4tFlJlMp2MLVnr0Zm0zNfG+ly/bSZExSq5Y=; 
	b=bRhL8TYoV06KF1fvczUVKHaizcioEwtVY7UN9hvUUue6QQEsKuaQDWSLJ8KZpaRM4nuhNzSd7vAMsHkTZUqQYwYy/yr1855EitON1mpytXFZi+MLGTAEvfJSCHvuxwVKgpapYMWgHjv+eenQ0tyi5CDg6U+X8Zl0ajdTTBe/US8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775161458;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Cc;
	bh=9b9I0WnX4tFlJlMp2MLVnr0Zm0zNfG+ly/bSZExSq5Y=;
	b=O6pfK2Bm0AuHOD4IeTv5igsBDh6IoCJharo4HB1ytqp4PxH6Zh2vQfVp3fLE2gI9
	y70xfDDkYvlnq3wFHBQjYejnZ5Qp12GG7oXWgnPo5id7dnAYA/lCa/+4Q3y3P6zW3F2
	plrlr1/fD5DH9o8QATKk6RD1nx6PYw5qZWSzClks=
Received: by mx.zohomail.com with SMTPS id 1775161455726733.2763469996942;
	Thu, 2 Apr 2026 13:24:15 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	maz@kernel.org,
	bigeasy@linutronix.de,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 2/2] Drivers: hv: Move add_interrupt_randomness() to hypervisor callback sysvec
Date: Thu,  2 Apr 2026 13:24:00 -0700
Message-Id: <20260402202400.1707-3-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402202400.1707-1-mhklkml@zohomail.com>
References: <20260402202400.1707-1-mhklkml@zohomail.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274b26552e0060022410715b1100009ff3d93fdc116e2ba085cb2d8befaa1e8f8e42ca3f1851de8c:zu08011227414717d93c37576b86649ee80000009ad4f28d8801e1b699aea732b53bb4570ff5e752c3ddafeb:rf0801122c2f68a8295b367b49b13e949d00005090f925957a92263d1ff91871f74059df28ce1cf7aecac9bece74f64ab5:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9936-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,outlook.com:replyto,zohomail.com:dkim,zohomail.com:mid]
X-Rspamd-Queue-Id: 2C1DA38DF90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Kelley <mhklinux@outlook.com>

The Hyper-V ISRs, for normal guests and when running in the
hypervisor root patition, are calling add_interrupt_randomness() as a
primary source of entropy. The call is currently in the ISRs as a common
place to handle both x86/x64 and arm64. On x86/x64, hypervisor interrupts
come through a custom sysvec entry, and do not go through a generic
interrupt handler. On arm64, hypervisor interrupts come through an
emulated GICv3. GICv3 uses the generic handler handle_percpu_devid_irq(),
which does not do add_interrupt_randomness() -- unlike its counterpart
handle_percpu_irq(). But handle_percpu_devid_irq() is now updated to do
the add_interrupt_randomness(). So add_interrupt_randomness() is now
needed only in Hyper-V's x86/x64 custom sysvec path.

Move add_interrupt_randomness() from the Hyper-V ISRs into the Hyper-V
x86/x64 custom sysvec path, matching the existing STIMER0 sysvec path.
With this change, add_interrupt_randomness() is no longer called from any
device drivers, which is appropriate.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/mshv_synic.c        | 3 ---
 drivers/hv/vmbus_drv.c         | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9befdc557d9e..a7dfc29d3470 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -161,6 +161,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	if (vmbus_handler)
 		vmbus_handler();
 
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
+
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		apic_eoi();
 
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d3..e2288a726fec 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/random.h>
 #include <linux/cpuhotplug.h>
 #include <linux/reboot.h>
 #include <asm/mshyperv.h>
@@ -445,8 +444,6 @@ void mshv_isr(void)
 		mb();
 		if (msg->header.message_flags.msg_pending)
 			hv_set_non_nested_msr(HV_MSR_EOM, 0);
-
-		add_interrupt_randomness(mshv_sint_vector);
 	} else {
 		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
 			     msg->header.message_type);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1d71c28fadba..3faa74e49a6b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -32,7 +32,6 @@
 #include <linux/ptrace.h>
 #include <linux/sysfb.h>
 #include <linux/efi.h>
-#include <linux/random.h>
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
@@ -1356,8 +1355,6 @@ static void __vmbus_isr(void)
 
 	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
 	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
-
-	add_interrupt_randomness(vmbus_interrupt);
 }
 
 static DEFINE_PER_CPU(bool, vmbus_irq_pending);
-- 
2.25.1


