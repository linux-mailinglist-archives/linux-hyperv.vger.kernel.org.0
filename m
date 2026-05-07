Return-Path: <linux-hyperv+bounces-10680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLxIFe0/GmOSwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10680-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:48:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E74EB5A2
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186D33002F8A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299D428833;
	Thu,  7 May 2026 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BmfdmFuo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501FF402B8B;
	Thu,  7 May 2026 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168614; cv=none; b=ldlvwmlnEeiZ79KCDzbeJEJE9nIbc1i2ZWd45wZ+E+W4jLU4fVdu4brIhCA80Alf0CkrOqa/nhXATTMxkqMsoZizGFvXdgDf6n5VRdjFGEigGrRaJyvR5qNMHU4JZWPYeWnOS1BeaiM/buPTZtyXPQBZQqv3u41aQwI3ef+lvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168614; c=relaxed/simple;
	bh=1Dyc96c1oV2QyycedTgNBnAsfaFMYjgNi/syLWaQgHE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQqIkEVH0epSwPlfiq+/dovoSG+SmK+EA1h4iosIzE66F/0ABlfS24zZR6ap43DK4sizhD+XblQUSm75qrGIE+1OXGfvZgUsm829rqUgeMo6FE5ORiYI63g9h8G/Pq707cd2+Ej1hFuQ5yq0QxBCfqTuofzwv8xxKExEf3a0mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BmfdmFuo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9FA5B20B7165;
	Thu,  7 May 2026 08:43:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FA5B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168609;
	bh=S7oDBWBs9uCP2A7KSLvbLrTi4RJNz/QyCKCRXdcmvS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BmfdmFuoSAvl4JIzbpX9ylwVY+BemZJ13MF5BPlmRD4VQL6u+u20lMigpWHJLiHLF
	 M8M47j4sfn1e0MisJkABB292IdKVXauDwmQbETqTnrq11kLQc37RQMSP3Ul9rTmE53
	 nw45h0NPArJEQhhOHQZvmjyo7cRcpUXktx3TBVpk=
Subject: [PATCH v4 06/18] mshv: Fix broken seqcount read protection
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:32 +0000
Message-ID: 
 <177816861261.21765.13558267650972571126.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D34E74EB5A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10680-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

mshv_irqfd_update() writes both irqfd_girq_ent and irqfd_lapic_irq as a
logical unit under seqcount write protection.  Readers must snapshot these
fields inside the seqcount begin/retry loop to obtain a consistent
point-in-time view; otherwise a concurrent update can produce a torn read
where one field comes from the old state and the other from the new.

Both mshv_assert_irq_slow() and mshv_irqfd_wakeup() got this wrong: the
seqcount loop bodies were empty (just spinning until a stable sequence was
observed), and all reads of the protected fields happened after the loop
with no protection from concurrent writes. If mshv_irqfd_update() races
with interrupt assertion, the caller may use a stale or mixed
vector/apic_id/control combination, delivering an interrupt to the wrong
vCPU, with the wrong vector, or with the wrong trigger mode.  This can
cause spurious or lost interrupts in the guest, or a stuck interrupt line
in the level-triggered case.

Fix mshv_assert_irq_slow() by snapshotting both irqfd_girq_ent and
irqfd_lapic_irq into local variables inside the seqcount loop, then using
those locals for the validity check, the resampler WARN_ON() and the
hypercall.  Reorder the function so the seqcount loop runs first and every
subsequent read of the protected fields is satisfied from the snapshot.

Fix mshv_irqfd_wakeup() by snapshotting irqfd_lapic_irq inside its seqcount
loop and passing the snapshot to mshv_try_assert_irq_fast(), so the fast
path operates on the consistent copy rather than reading the field directly
outside seqcount protection.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index b398e58411dd7..25bdc5e678849 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -151,10 +151,10 @@ static int mshv_vp_irq_set_vector(struct mshv_vp *vp, u32 vector)
  * Try to raise irq for guest via shared vector array. hyp does the actual
  * inject of the interrupt.
  */
-static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
+static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
+				    const struct mshv_lapic_irq *irq)
 {
 	struct mshv_partition *partition = irqfd->irqfd_partn;
-	struct mshv_lapic_irq *irq = &irqfd->irqfd_lapic_irq;
 	struct mshv_vp *vp;
 
 	if (!(ms_hyperv.ext_features &
@@ -191,7 +191,8 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
 	return 0;
 }
 #else /* CONFIG_X86_64 */
-static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
+static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
+				    const struct mshv_lapic_irq *irq)
 {
 	return -EOPNOTSUPP;
 }
@@ -200,30 +201,33 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
 static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd)
 {
 	struct mshv_partition *partition = irqfd->irqfd_partn;
-	struct mshv_lapic_irq *irq = &irqfd->irqfd_lapic_irq;
+	struct mshv_guest_irq_ent girq_ent;
+	struct mshv_lapic_irq irq;
 	unsigned int seq;
 	int idx;
 
+	idx = srcu_read_lock(&partition->pt_irq_srcu);
+
+	do {
+		seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+		girq_ent = irqfd->irqfd_girq_ent;
+		irq = irqfd->irqfd_lapic_irq;
+	} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+
 #if IS_ENABLED(CONFIG_X86)
 	WARN_ON(irqfd->irqfd_resampler &&
-		!irq->lapic_control.level_triggered);
+		!irq.lapic_control.level_triggered);
 #endif
 
-	idx = srcu_read_lock(&partition->pt_irq_srcu);
-	if (irqfd->irqfd_girq_ent.guest_irq_num) {
-		if (!irqfd->irqfd_girq_ent.girq_entry_valid) {
-			srcu_read_unlock(&partition->pt_irq_srcu, idx);
-			return;
-		}
-
-		do {
-			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
-		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+	if (girq_ent.guest_irq_num && !girq_ent.girq_entry_valid) {
+		srcu_read_unlock(&partition->pt_irq_srcu, idx);
+		return;
 	}
 
-	hv_call_assert_virtual_interrupt(irqfd->irqfd_partn->pt_id,
-					 irq->lapic_vector, irq->lapic_apic_id,
-					 irq->lapic_control);
+	hv_call_assert_virtual_interrupt(partition->pt_id,
+					 irq.lapic_vector, irq.lapic_apic_id,
+					 irq.lapic_control);
+
 	srcu_read_unlock(&partition->pt_irq_srcu, idx);
 }
 
@@ -309,16 +313,18 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 	int ret = 0;
 
 	if (flags & EPOLLIN) {
+		struct mshv_lapic_irq irq;
 		u64 cnt;
 
 		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
 		idx = srcu_read_lock(&pt->pt_irq_srcu);
 		do {
 			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+			irq = irqfd->irqfd_lapic_irq;
 		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
 
 		/* An event has been signaled, raise an interrupt */
-		ret = mshv_try_assert_irq_fast(irqfd);
+		ret = mshv_try_assert_irq_fast(irqfd, &irq);
 		if (ret)
 			mshv_assert_irq_slow(irqfd);
 



