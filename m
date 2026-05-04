Return-Path: <linux-hyperv+bounces-10604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEU4HVXy+GnJ3QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10604-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:24:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64074C331F
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02FF321F11C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6603F075C;
	Mon,  4 May 2026 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cSmaiMA8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064E3F0758;
	Mon,  4 May 2026 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921785; cv=none; b=Fxmuu8BnUFnF2yNMjz4bKIrHC4wsCSRVGKYKOhHp7YeWVJLKNb6BAhesk4QYYK79SvNoZVq9dZbQsTHfdANgtJsGcRzuJ4KVFhqtqlLnaoY3ZGc28e6HyXhyLadhHt7wUEzlW0xz++9oa8ZLUP9+pXzfHOVU4uJWq3JHPZ8osIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921785; c=relaxed/simple;
	bh=fy6OVBdeF2b+UqnbFawq2j4kRHnwu3lFyDw0V4749TM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJU9ELtVh+coKi1huPmx92aaDl4lfIzW4d3ncy3LmiyZLz5feJM71bf7HwG7nPdQcDoiMN5xOWieW2spKiysKql27TkZlvdYKv52eJHPJlRUTj++K/SnEBVldxnNGdD8i4GIcLExuv/GuANIcuM1xmGuMNeAFkDX6XKx6lDRgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cSmaiMA8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C52120B7168;
	Mon,  4 May 2026 12:09:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C52120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921781;
	bh=TjuI9ErRSwdq+87EA+T3HMLWgsOj3uNRL7DX52Ldv0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cSmaiMA88V9fx0qj04efPtQ7PZ3bZgiMmmq/AW7pO/QkEpu8jnpvwUSDPiGvic0E7
	 xogpKJl9b+YoYo9hKvPl8xavk7azZCi8siZbxr00x2f1YvXq9vHasVtNQHOD66CFo1
	 /1bRdaAn4Grw3AbdyMdi8eBWJxglXSmOESZ+h0GA=
Subject: [PATCH v3 09/18] mshv: Consolidate irqfd interrupt injection paths
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:42 +0000
Message-ID: 
 <177792178281.90827.191592071968740057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C64074C331F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10604-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

The irqfd interrupt injection had duplicated seqcount reads and
inconsistent validity checks between the fast and slow paths:

1. The wakeup handler snapshots irqfd_lapic_irq under seqcount, then on
   fast-path failure calls mshv_assert_irq_slow() which re-reads both
   girq_ent and lapic_irq under seqcount again — wasteful and confusing.

2. The validity check (girq_entry_valid) only existed in the slow path.
   The fast path would blindly accept a zero-initialized structure when
   routing was not configured, potentially injecting vector 0 to VP 0.

3. The condition 'girq_ent.guest_irq_num && !girq_ent.girq_entry_valid'
   short-circuits for GSI 0 (guest_irq_num == 0), bypassing the
   validity check entirely.

4. mshv_irqfd_resampler_ack() reads irqfd_lapic_irq.lapic_control
   without seqcount protection, allowing torn reads when racing with
   mshv_irqfd_update().

Consolidate by:
- Moving the seqcount snapshot and validity check into the wakeup
  handler, performed once before either injection path.
- Changing mshv_assert_irq_slow() to accept a pre-snapshotted
  const struct mshv_lapic_irq pointer, eliminating its internal
  seqcount read and SRCU lock/unlock.
- Using !girq_entry_valid alone as the validity condition, fixing the
  GSI 0 bypass.
- Adding seqcount protection in mshv_irqfd_resampler_ack() to prevent
  torn reads of interrupt_type.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |   64 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 7275b9eaa7541..8a5a1b517ad4b 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -90,7 +90,15 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
 				 irqfd_resampler_hnode,
 				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
-		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
+		struct mshv_lapic_irq irq;
+		unsigned int seq;
+
+		do {
+			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+			irq = irqfd->irqfd_lapic_irq;
+		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+
+		if (hv_should_clear_interrupt(irq.lapic_control.interrupt_type))
 			hv_call_clear_virtual_interrupt(partition->pt_id);
 
 		eventfd_signal(irqfd->irqfd_resamplefd);
@@ -198,36 +206,19 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
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
-	if (girq_ent.guest_irq_num && !girq_ent.girq_entry_valid) {
-		srcu_read_unlock(&partition->pt_irq_srcu, idx);
-		return;
-	}
 
 #if IS_ENABLED(CONFIG_X86)
 	WARN_ON(irqfd->irqfd_resampler &&
-		!irq.lapic_control.level_triggered);
+		!irq->lapic_control.level_triggered);
 #endif
 
 	hv_call_assert_virtual_interrupt(partition->pt_id,
-					 irq.lapic_vector, irq.lapic_apic_id,
-					 irq.lapic_control);
-	srcu_read_unlock(&partition->pt_irq_srcu, idx);
+					 irq->lapic_vector, irq->lapic_apic_id,
+					 irq->lapic_control);
 }
 
 static void mshv_irqfd_resampler_shutdown(struct mshv_irqfd *irqfd)
@@ -316,6 +307,7 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 	int ret = 0;
 
 	if (flags & EPOLLIN) {
+		struct mshv_guest_irq_ent girq_ent;
 		struct mshv_lapic_irq irq;
 		u64 cnt;
 
@@ -323,14 +315,18 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 		idx = srcu_read_lock(&pt->pt_irq_srcu);
 		do {
 			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+			girq_ent = irqfd->irqfd_girq_ent;
 			irq = irqfd->irqfd_lapic_irq;
 		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
 
+		if (!girq_ent.girq_entry_valid)
+			goto out_unlock;
+
 		/* An event has been signaled, raise an interrupt */
-		ret = mshv_try_assert_irq_fast(irqfd, &irq);
-		if (ret)
-			mshv_assert_irq_slow(irqfd);
+		if (mshv_try_assert_irq_fast(irqfd, &irq))
+			mshv_assert_irq_slow(irqfd, &irq);
 
+out_unlock:
 		srcu_read_unlock(&pt->pt_irq_srcu, idx);
 
 		ret = 1;
@@ -520,8 +516,20 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	 */
 	events = vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
 
-	if (events & EPOLLIN)
-		mshv_assert_irq_slow(irqfd);
+	if (events & EPOLLIN) {
+		struct mshv_guest_irq_ent girq_ent;
+		struct mshv_lapic_irq irq;
+		unsigned int seq;
+
+		do {
+			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+			girq_ent = irqfd->irqfd_girq_ent;
+			irq = irqfd->irqfd_lapic_irq;
+		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+
+		if (girq_ent.girq_entry_valid)
+			mshv_assert_irq_slow(irqfd, &irq);
+	}
 
 	srcu_read_unlock(&pt->pt_irq_srcu, idx);
 	return 0;



