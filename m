Return-Path: <linux-hyperv+bounces-10611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG+fFMPw+Gmr3QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10611-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:17:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5444C31E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8EB30798D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9CE3F0771;
	Mon,  4 May 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SLJU+Yvx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D843EFD04;
	Mon,  4 May 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921823; cv=none; b=blVzgI/ysEXc+cw28TAhZWc94x+ECB9pkq8OqPYovHTgycReJqe9TdMT5QbBvT/mJEAc/pRhcJNpWaeG9J4znTll4XDvV3lenNDZyBqT19BsZQeCy0do3ixsh56y6QTLCcATkWzd5oX6tH+v6MlksNGs09EXoifeaGz142ZLXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921823; c=relaxed/simple;
	bh=hb75P4zVCEb6nMKA25GcnK/f0doCpcA7O3t7uOVRF/4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUzBwxWACPmSYONyQXoWRV06rfD5PIXuDbGH4/sbv6G86ir2pW7kELVIrhGItFHCrsizugPzoVdkrUHB76HS5mlBva6GkuobXxvc8tWke3vnSaW15boISRqnM2z0I8lCsAFpqpzu7oKDu4HzQhJ1Rp9GlMbYJkSaVYdy0cCfwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SLJU+Yvx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2792320B7168;
	Mon,  4 May 2026 12:10:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2792320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921820;
	bh=+s7tsR6iE29kkFzW6c9m1K9R7aevw22tyIU74FsMCDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SLJU+YvxbCKmhUlvPtH60L22FKtrwAh0oUJbR0GAvBSxNLxT9K5OntSt6ya04psoV
	 QCIwdSXitbC2mUojkkyvD4A8NB/h5sc/9cNwrn/5ykLkWZwQ/q9GixrXyRD03oehd6
	 4D6lLo3d+7cpKhodU+wvswktlksFplnBjqy78pQU=
Subject: [PATCH v3 16/18] mshv: Add store/load ordering for VP array publish
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:21 +0000
Message-ID: 
 <177792182140.90827.17774533141642010534.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AD5444C31E6
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
	TAGGED_FROM(0.00)[bounces-10611-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

mshv_vp_create() publishes a VP pointer to pt_vp_array with a plain
store. The ISR reads this array locklessly from interrupt context on
other CPUs. Without memory ordering, a reader may observe the non-NULL
pointer before all VP fields (e.g. vp_register_page, run.vp_suspend_queue)
are fully initialized, leading to use of uninitialized data.

Fix by using smp_store_release() when publishing the VP pointer and
smp_load_acquire() on all lockless ISR read sites. This guarantees that
all VP initialization is visible to readers before the pointer itself.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c   |    2 +-
 drivers/hv/mshv_root_main.c |    3 ++-
 drivers/hv/mshv_synic.c     |    6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index c99ca5770d3d0..780f0ea43f2c6 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -180,7 +180,7 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
 	if (irq->lapic_apic_id >= MSHV_MAX_VPS)
 		return -EINVAL;
 
-	vp = partition->pt_vp_array[irq->lapic_apic_id];
+	vp = smp_load_acquire(&partition->pt_vp_array[irq->lapic_apic_id]);
 	if (!vp)
 		return -EINVAL;
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 0e9b696853fcb..4d58e0b005183 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1224,7 +1224,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
-	partition->pt_vp_array[args.vp_index] = vp;
+	/* Ensure VP is fully initialized before visible to lockless ISR readers */
+	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
 	goto out;
 
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 39c6b22e1e11e..a916a39888aad 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -245,7 +245,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 				goto unlock_out;
 			}
 
-			vp = partition->pt_vp_array[vp_index];
+			vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 			if (unlikely(!vp)) {
 				pr_debug("failed to find VP %u\n", vp_index);
 				goto unlock_out;
@@ -294,7 +294,7 @@ handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
 			break;
 		}
 
-		vp = partition->pt_vp_array[vp_index];
+		vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 		if (!vp) {
 			pr_debug("failed to find VP %u\n", vp_index);
 			break;
@@ -390,7 +390,7 @@ mshv_intercept_isr(struct hv_message *msg)
 		goto unlock_out;
 	}
 	vp_index = array_index_nospec(vp_index, MSHV_MAX_VPS);
-	vp = partition->pt_vp_array[vp_index];
+	vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);
 		goto unlock_out;



