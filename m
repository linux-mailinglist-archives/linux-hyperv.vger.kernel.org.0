Return-Path: <linux-hyperv+bounces-10681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I5LJkqz/GnlSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10681-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:44:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CF4EB44E
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695D930297B9
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC3449EB0;
	Thu,  7 May 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bVyruTck"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B3544B666;
	Thu,  7 May 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168620; cv=none; b=A+OxotxeZu03AbN0xbHFtQ2v2z4WMak+rZnzA9u07dBOJmbP3YWPklEB6qu6dz7qt7AFiBhWSxmgCZaqEMD+x1sBZxY0FWYa8Idos6yuzLrhds46XjeCJQ6++z7n0Z48Cng2ZBMpdiZWT4SnNuPyVLZAHs9uyiiZPoFYbkU2nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168620; c=relaxed/simple;
	bh=6Lw9qugMS3TkYqERh5xEX7qsqCMePoSgIXYWBDPmq9w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ox5nobwf4Ek3dDh7ZadLpRewiQvEK4d0qV2Hj7NMQ1sdmQ1vtLS26ehq6npvFVcKUttDPrHSSivl8PedVBmiDInMrJRvMKiGtoVWD797d/F6dkHdd3X8gK7LFydAE3QhVFAhFVVHxmQOSZq5WSXXzOc84y6wNNwcETiMEBbhT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bVyruTck; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1FB1F20B7165;
	Thu,  7 May 2026 08:43:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FB1F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168615;
	bh=gM0qXeNlYwKrosv6b9jJKZcoOJOVw2NF1v9wYM0yePc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bVyruTcku3AekcJZeoj8T26r05jW9HuZCBSdrBZIOkMy/H8dgQKq+xCu19UFfsA5u
	 e37dzyfnAVK6M5lJ3s6jHJwqCaIGFO2MM67iukq7x9j0TWbbAj5YWc/fzha88BPTOA
	 D4++tCbJf3p29rAOWdC4ptcS1w/sjVv20ingvuRk=
Subject: [PATCH v4 07/18] mshv: Consolidate irqfd interrupt injection paths
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:38 +0000
Message-ID: 
 <177816861807.21765.8464554617675284788.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A0CF4EB44E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10681-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

irqfd interrupt injection had divergent seqcount snapshot scaffolding in
three places, and inconsistent validity checks between the fast and slow
assert paths:

1. mshv_irqfd_wakeup() snapshotted irqfd_lapic_irq under seqcount, then on
fast-path failure called mshv_assert_irq_slow(), which re-snapshotted both
irqfd_girq_ent and irqfd_lapic_irq under seqcount again — wasteful and
duplicative.

2. The girq_entry_valid check only existed in the slow path.  The fast path
would happily accept a zero-initialised mshv_lapic_irq when routing was not
yet configured for the GSI, potentially injecting vector 0 to VP 0.

3. The slow path's validity predicate was 'guest_irq_num &&
!girq_entry_valid', which short-circuits for GSI 0 (guest_irq_num == 0) and
so bypasses the validity check entirely for that GSI.

4. mshv_irqfd_resampler_ack() read irqfd_lapic_irq.lapic_control without
seqcount protection, which could observe a stale or transient value while
mshv_irqfd_update() was concurrently rewriting irqfd_lapic_irq via
mshv_copy_girq_info()'s memset-and-fill sequence.

Introduce mshv_irqfd_snapshot() that takes a consistent snapshot of both
irqfd_girq_ent and irqfd_lapic_irq inside the seqcount loop; girq_ent is
optional so the resampler ack path can snapshot only the LAPIC IRQ.

Use the helper from mshv_irqfd_resampler_ack() (closes 4),
mshv_irqfd_wakeup() and mshv_irqfd_assign()'s EPOLLIN replay path,
replacing the three ad-hoc seqcount loops.

Move the validity check into mshv_irqfd_wakeup() before either injection
path runs, so the fast path no longer accepts an unrouted irqfd (closes
2).  Use !girq_entry_valid as the condition (closes 3).  Change
mshv_assert_irq_slow() to take a pre-snapshotted const struct
mshv_lapic_irq pointer, eliminating its internal seqcount and SRCU
scaffolding (closes 1).

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |   90 ++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 25bdc5e678849..c24069dff9702 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -74,6 +74,27 @@ static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type)
 }
 #endif
 
+/*
+ * Snapshot per-irqfd routing state under seqcount protection so callers
+ * see a consistent point-in-time view of irqfd_girq_ent and
+ * irqfd_lapic_irq even if mshv_irqfd_update() runs concurrently.
+ *
+ * @girq_ent may be NULL when the caller only needs the LAPIC IRQ.
+ */
+static void mshv_irqfd_snapshot(struct mshv_irqfd *irqfd,
+				struct mshv_guest_irq_ent *girq_ent,
+				struct mshv_lapic_irq *irq)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+		if (girq_ent)
+			*girq_ent = irqfd->irqfd_girq_ent;
+		*irq = irqfd->irqfd_lapic_irq;
+	} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+}
+
 static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 {
 	struct mshv_irqfd_resampler *resampler;
@@ -90,7 +111,11 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
 				 irqfd_resampler_hnode,
 				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
-		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
+		struct mshv_lapic_irq irq;
+
+		mshv_irqfd_snapshot(irqfd, NULL, &irq);
+
+		if (hv_should_clear_interrupt(irq.lapic_control.interrupt_type))
 			hv_call_clear_virtual_interrupt(partition->pt_id);
 
 		eventfd_signal(irqfd->irqfd_resamplefd);
@@ -198,37 +223,14 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
 }
 #endif
 
-static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd)
+static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd,
+				 const struct mshv_lapic_irq *irq)
 {
 	struct mshv_partition *partition = irqfd->irqfd_partn;
-	struct mshv_guest_irq_ent girq_ent;
-	struct mshv_lapic_irq irq;
-	unsigned int seq;
-	int idx;
-
-	idx = srcu_read_lock(&partition->pt_irq_srcu);
-
-	do {
-		seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
-		girq_ent = irqfd->irqfd_girq_ent;
-		irq = irqfd->irqfd_lapic_irq;
-	} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
-
-#if IS_ENABLED(CONFIG_X86)
-	WARN_ON(irqfd->irqfd_resampler &&
-		!irq.lapic_control.level_triggered);
-#endif
-
-	if (girq_ent.guest_irq_num && !girq_ent.girq_entry_valid) {
-		srcu_read_unlock(&partition->pt_irq_srcu, idx);
-		return;
-	}
 
 	hv_call_assert_virtual_interrupt(partition->pt_id,
-					 irq.lapic_vector, irq.lapic_apic_id,
-					 irq.lapic_control);
-
-	srcu_read_unlock(&partition->pt_irq_srcu, idx);
+					 irq->lapic_vector, irq->lapic_apic_id,
+					 irq->lapic_control);
 }
 
 static void mshv_irqfd_resampler_shutdown(struct mshv_irqfd *irqfd)
@@ -308,26 +310,31 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 						irqfd_wait);
 	__poll_t flags = key_to_poll(key);
 	int idx;
-	unsigned int seq;
 	struct mshv_partition *pt = irqfd->irqfd_partn;
 	int ret = 0;
 
 	if (flags & EPOLLIN) {
+		struct mshv_guest_irq_ent girq_ent;
 		struct mshv_lapic_irq irq;
 		u64 cnt;
 
 		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
 		idx = srcu_read_lock(&pt->pt_irq_srcu);
-		do {
-			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
-			irq = irqfd->irqfd_lapic_irq;
-		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+		mshv_irqfd_snapshot(irqfd, &girq_ent, &irq);
+
+		if (!girq_ent.girq_entry_valid)
+			goto out_unlock;
+
+#if IS_ENABLED(CONFIG_X86)
+		WARN_ON(irqfd->irqfd_resampler &&
+			!irq.lapic_control.level_triggered);
+#endif
 
 		/* An event has been signaled, raise an interrupt */
-		ret = mshv_try_assert_irq_fast(irqfd, &irq);
-		if (ret)
-			mshv_assert_irq_slow(irqfd);
+		if (mshv_try_assert_irq_fast(irqfd, &irq))
+			mshv_assert_irq_slow(irqfd, &irq);
 
+out_unlock:
 		srcu_read_unlock(&pt->pt_irq_srcu, idx);
 
 		ret = 1;
@@ -517,8 +524,15 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	 */
 	events = vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
 
-	if (events & EPOLLIN)
-		mshv_assert_irq_slow(irqfd);
+	if (events & EPOLLIN) {
+		struct mshv_guest_irq_ent girq_ent;
+		struct mshv_lapic_irq irq;
+
+		mshv_irqfd_snapshot(irqfd, &girq_ent, &irq);
+
+		if (girq_ent.girq_entry_valid)
+			mshv_assert_irq_slow(irqfd, &irq);
+	}
 
 	srcu_read_unlock(&pt->pt_irq_srcu, idx);
 	return 0;



