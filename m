Return-Path: <linux-hyperv+bounces-8565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHOXByZLemkp5AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8565-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:45:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F8A715E
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D9F3028EC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906D31E0FB;
	Wed, 28 Jan 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DvnrCSw9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA228CF6F;
	Wed, 28 Jan 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622123; cv=none; b=Xllc6HuMKS5J4D+/GFPMAimhhA83M6d4f1jyBY1L0lMCqC59WqMNW8aqm/MkylSrnloHzbmwfYiXx+MEv0sJioKjEWFK11SYdpWVMZwDpVgqnkTTcIPadp6H4wty00KrMYNMcmHKrnsfP0LFNKOY6lP2Yrze9LTu6OuolOFE1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622123; c=relaxed/simple;
	bh=a2uK/DPWKK9or/3ApipBtxVHDoyWYTzSwq8Jgym17X8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4kPXcm+1l0fylwJc59OPNKIwQaX52icqcZFb6KueBfZ4r8V5GiRTPa0XfZ+2M6vsBnR8lY7D0Ax8tOuTcBNXGwk8xrG9hd2FGdf52U4a9BgQP5B2hysXMTDJua4hi955CqtJo1aarZvIMWmppA/PDj1pbUPJwctB8rQYKXfoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DvnrCSw9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06ED720B7167;
	Wed, 28 Jan 2026 09:42:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06ED720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769622122;
	bh=8SqHw41EAdVlzG5tsfsM6/eoFMPvWeoo+r07cYXCW8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DvnrCSw9Ph5QEjihqQ8sJSPp+5VEcsMWDj14YEefJHmm0/tWsTQQULO8w+EM//Ui9
	 wnAz2COGAKG5CcVTNRWwvJhuiI0rOywJL79mIZ520M/NI4orBKrXhc38X1HsnplOE2
	 18nWlLeURWXw1riBuMuKxA+LgSyQ04xJgEMg6rAY=
Subject: [PATCH 1/2] kexec: Add permission notifier chain for kexec operations
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 17:42:01 +0000
Message-ID: 
 <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8565-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: B98F8A715E
X-Rspamd-Action: no action

Add a blocking notifier chain to allow subsystems to be notified
before kexec execution. This enables modules to perform necessary
cleanup or validation before the system transitions to a new kernel or
block kexec if not possible under current conditions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/linux/kexec.h |    6 ++++++
 kernel/kexec_core.c   |   24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..311037d30f9e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -35,6 +35,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/notifier.h>
 #include <asm/kexec.h>
 #include <linux/crash_core.h>
 
@@ -532,10 +533,13 @@ extern bool kexec_file_dbg_print;
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
+extern int kexec_block_notifier_register(struct notifier_block *nb);
+extern int kexec_block_notifier_unregister(struct notifier_block *nb);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
 struct kimage;
+struct notifier_block;
 static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
@@ -543,6 +547,8 @@ static inline int kexec_crash_loaded(void) { return 0; }
 static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
+static inline int kexec_block_notifier_register(struct notifier_block *nb) { }
+static inline int kexec_block_notifier_unregister(struct notifier_block *nb) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 0f92acdd354d..1e86a6f175f0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -57,6 +57,20 @@ bool kexec_in_progress = false;
 
 bool kexec_file_dbg_print;
 
+static BLOCKING_NOTIFIER_HEAD(kexec_block_list);
+
+int kexec_block_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kexec_block_list, nb);
+}
+EXPORT_SYMBOL_GPL(kexec_block_notifier_register);
+
+int kexec_block_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kexec_block_list, nb);
+}
+EXPORT_SYMBOL_GPL(kexec_block_notifier_unregister);
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
@@ -1124,6 +1138,12 @@ bool kexec_load_permitted(int kexec_image_type)
 	return true;
 }
 
+static int kexec_check_blockers(void)
+{
+	/* Notify subsystems of impending kexec */
+	return blocking_notifier_call_chain(&kexec_block_list, 0, NULL);
+}
+
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
@@ -1139,6 +1159,10 @@ int kernel_kexec(void)
 		goto Unlock;
 	}
 
+	error = kexec_check_blockers();
+	if (error)
+		goto Unlock;
+
 	error = liveupdate_reboot();
 	if (error)
 		goto Unlock;



