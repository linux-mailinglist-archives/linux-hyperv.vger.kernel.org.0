Return-Path: <linux-hyperv+bounces-10679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGFVOjCz/GnlSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10679-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:43:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689CE4EB440
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9619D30094C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECAF449EB0;
	Thu,  7 May 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eFswLw1D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937A41B344;
	Thu,  7 May 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168608; cv=none; b=uNmr26ncqIzD6fVnjCtKKorgCwYFD8RXUtK4bEj4sE7WhXZKQSiGKzOvsp8LhtaR/2kSNR4L4WDGEQA5TQhhSbxPGD+lGsLupzDCWYudH4BxWl/pFIY1BH5kJATvYkerKplXyFBHZUTETbNZK1pEEZWJzjNZeH9Em5FyKmkDTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168608; c=relaxed/simple;
	bh=zLrX6ITHKCte2X13vhhHzwA/THpJbxaTulmaQshRJEQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI3G90ACqDU+8NDEJMH9YFEkmqEEoz/+gjxRAlsX9HiyuEp02I092LzkNuDJpaHiFLEmTW50+4Am6bNpYTf2TxsBZQkSo5GzAey7RqIb1P9Nx46ms1L36Fv3WQAaPPm8wCoSiAnBImWr5fT+/509GLusctpijVOLWNV/OkHoTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eFswLw1D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F60620B716D;
	Thu,  7 May 2026 08:43:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F60620B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168603;
	bh=TfqYwZll6MjW9Mc6UZz86GGiIGwNN/wXo9TiJ1njMEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eFswLw1DMP5HFv/KxLnhdn4M80lrhNuzWg1X8R+yWYEqDmDfpyI3ES/bkGV9dvrnd
	 SmPev22CaPefHqRXJcglieirV/U3TX1oxkJ2MC5COOX54MSDm6GsXn0R1gOLLY5zWn
	 pO47JCGsjDNHK0aE9gl5D6atHGfg5hCurQ85sQg8=
Subject: [PATCH v4 05/18] mshv: irqfd: Reject routing updates that invalidate
 resampler binding
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:26 +0000
Message-ID: 
 <177816860654.21765.18233051386312037873.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 689CE4EB440
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
	TAGGED_FROM(0.00)[bounces-10679-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

A resampler-bound irqfd is only meaningful for level-triggered interrupts,
because the resampler signals userspace on guest EOI and edge-triggered
interrupts have no EOI to react to.  mshv_irqfd_assign() already rejects
the combination at registration time, but nothing prevented a subsequent
MSHV_SET_MSI_ROUTING ioctl from flipping the cached
lapic_control.level_triggered bit to edge-triggered while the resampler was
still attached. Once that happened, the WARN_ON() in mshv_assert_irq_slow()
was the only signal of an inconsistency the kernel had no way to recover
from: the resampler stayed wired in but no EOI ever arrived, so userspace
never saw a resample signal and the guest interrupt could become stuck.

Add mshv_irqfd_validate_routing() and call it from
mshv_update_routing_table() before publishing the new table. It walks
pt_irqfds_list looking for resampler-bound irqfds whose new routing entry
would be valid but not level-triggered, and returns -EINVAL to reject the
routing change atomically. The check is x86-only because
lapic_control.level_triggered is only populated on x86; on ARM64
mshv_copy_girq_info() unconditionally sets asserted = 1 and the invariant
does not apply.

The validator briefly takes pt_irqfds_lock for the list walk and drops it
before mshv_irqfd_routing_update() reacquires it.  This is safe because the
partition ioctl dispatcher holds pt_mutex for the duration of every
partition ioctl, so MSHV_IRQFD (which calls mshv_irqfd_assign()) cannot run
concurrently with MSHV_SET_MSI_ROUTING; no new resampler-bound irqfd can be
inserted between validation and refresh.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_irq.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
index b3142c84dcbc2..59584a132ca9f 100644
--- a/drivers/hv/mshv_irq.c
+++ b/drivers/hv/mshv_irq.c
@@ -14,7 +14,44 @@
 #include "mshv.h"
 #include "mshv_root.h"
 
-/* called from the ioctl code, user wants to update the guest irq table */
+static int mshv_irqfd_validate_routing(struct mshv_partition *pt,
+				       struct mshv_girq_routing_table *new)
+{
+	int r = 0;
+#if IS_ENABLED(CONFIG_X86)
+	struct mshv_irqfd *irqfd;
+
+	if (!new)
+		return 0;
+
+	spin_lock_irq(&pt->pt_irqfds_lock);
+	hlist_for_each_entry(irqfd, &pt->pt_irqfds_list, irqfd_hnode) {
+		struct mshv_guest_irq_ent ent = {};
+		struct mshv_lapic_irq lirq;
+
+		if (!irqfd->irqfd_resampler)
+			continue;
+
+		if (irqfd->irqfd_irqnum < new->num_rt_entries)
+			ent = new->mshv_girq_info_tbl[irqfd->irqfd_irqnum];
+
+		mshv_copy_girq_info(&ent, &lirq);
+
+		if (ent.girq_entry_valid &&
+		    !lirq.lapic_control.level_triggered) {
+			r = -EINVAL;
+			break;
+		}
+	}
+	spin_unlock_irq(&pt->pt_irqfds_lock);
+#endif
+	return r;
+}
+
+/*
+ * Called from the ioctl code, user wants to update the guest irq table.
+ * Serialized with mshv_irqfd_assign by partition mutex.
+ */
 int mshv_update_routing_table(struct mshv_partition *partition,
 			      const struct mshv_user_irq_entry *ue,
 			      unsigned int numents)
@@ -65,6 +102,11 @@ int mshv_update_routing_table(struct mshv_partition *partition,
 
 swap_routes:
 	mutex_lock(&partition->pt_irq_lock);
+	r = mshv_irqfd_validate_routing(partition, new);
+	if (r) {
+		mutex_unlock(&partition->pt_irq_lock);
+		goto out;
+	}
 	old = rcu_dereference_protected(partition->pt_girq_tbl, 1);
 	rcu_assign_pointer(partition->pt_girq_tbl, new);
 	mshv_irqfd_routing_update(partition);



