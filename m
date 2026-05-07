Return-Path: <linux-hyperv+bounces-10688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MDgFSa0/GnlSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10688-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:47:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF494EB574
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8748309AE80
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF444CAF3;
	Thu,  7 May 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oDsNLqUr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0544D023;
	Thu,  7 May 2026 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168658; cv=none; b=Xzh1T/r7+BbJ5xVu7QksZo3SSJWiZZINtwNDVc+C4QeCtT2BvFdWCK9PupkjUlHlx4aXZexIXGRmaYOEoAJtAACmxqIAKp9N3hG16SKuveDkXFaEPeAGfKA6dOn6bNC7AbgFs0YJ5vgILc6+tz4BPbAZCFYLPfVaAcqLYfCMRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168658; c=relaxed/simple;
	bh=6K7ipNlhLqydG75KxxumaulwKffPqksz2sKlLxnavBQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WW3z2yg5zgECuFYH9vmH6VTkcceCTy6wckTJ67JDEEwsxPTzcNKm8k0Eah8Ss+94BR5rcTdNFv9UibajPbe2u/DUeMhW1O+7HSCrGy2toGxExEPk5F/w93DR+MiUKFwlDKPhAaUnmejbj7FU0umnwOYOdH8ghJgNZmTH8lWuTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oDsNLqUr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 179AA20B7165;
	Thu,  7 May 2026 08:44:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 179AA20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168653;
	bh=cgQ9MqBfnJMSXc/LVq6GRNkLytUOtfbQbwcpF3+6B/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oDsNLqUrhSGLRPm9cEK/aNCxqrNBaApXhBovMHxgDmDNF3L7w0v5VYqSP0+VeXAVv
	 W8thjqTP0M6Or7tFBjIC7NfMu/Pz84Ec/BjQoQfpvaz1V+sXMYLy/GM620edASGkc1
	 DePt8i/yAR6kC20ydEQgZU9zYq754apeFJlN1qTQ=
Subject: [PATCH v4 14/18] mshv: Order pt_vp_array publish against irqfd
 assertion path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:16 +0000
Message-ID: 
 <177816865606.21765.9555294064589953949.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: DAF494EB574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10688-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mshv_partition_ioctl_create_vp() initialises a VP struct (allocations,
mutex_init, init_waitqueue_head, page mappings) and then publishes the
pointer into partition->pt_vp_array.  Several ISR paths read this array
locklessly: the intercept ISR, the two scheduler ISRs, and
mshv_try_assert_irq_fast() on the irqfd fast path.

Of these, only mshv_try_assert_irq_fast() can structurally race the
publish.  It runs from an eventfd waker without holding pt_mutex, and
MSHV_IRQFD does not require the target lapic_apic_id (== vp_index) to
refer to an existing VP at registration time.  A user can therefore
register an irqfd targeting a yet-to-be-created VP, then trigger
mshv_try_assert_irq_fast() concurrently with MSHV_CREATE_VP for the
same index.  On weakly-ordered architectures the reader can observe a
non-NULL pointer in pt_vp_array before the initialising stores to the
VP struct become visible, leading to use of partially-initialised
fields (e.g. vp_register_page).

The other ISR readers cannot reach this race: the hypervisor will not
generate intercept or scheduler messages for a VP that has never been
told to run, and the user can only call MSHV_RUN_VP on the VP fd
returned by MSHV_CREATE_VP, which by construction is returned after
the publish.  Leave those readers as plain loads.

Use smp_store_release() in mshv_partition_ioctl_create_vp() to publish
the pointer, and pair it with smp_load_acquire() in
mshv_try_assert_irq_fast().  On x86 these compile to plain accesses
under TSO; on ARM64 they emit one-instruction acquire/release barriers,
acceptable on this fast path.

The destroy-side path (destroy_partition() clearing pt_vp_array[i] to
NULL after kfree(vp)) has a separate ordering and lifetime concern
that is out of scope here.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c   |    9 ++++++++-
 drivers/hv/mshv_root_main.c |    8 +++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 11a6006f80194..5f0dd243e1445 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -197,7 +197,14 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd,
 	if (irq->lapic_apic_id >= MSHV_MAX_VPS)
 		return -EINVAL;
 
-	vp = partition->pt_vp_array[irq->lapic_apic_id];
+	/*
+	 * Pairs with smp_store_release() in mshv_partition_ioctl_create_vp().
+	 * MSHV_IRQFD does not require the target lapic_apic_id to refer to an
+	 * existing VP, so this read can race a concurrent VP creation; the
+	 * acquire ensures that a non-NULL pointer implies the VP's
+	 * initialising stores are visible.
+	 */
+	vp = smp_load_acquire(&partition->pt_vp_array[irq->lapic_apic_id]);
 	if (!vp)
 		return -EINVAL;
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 7e4252b6bc65c..381aa86c5b90e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1224,7 +1224,13 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
-	partition->pt_vp_array[args.vp_index] = vp;
+	/*
+	 * Pairs with smp_load_acquire() in mshv_try_assert_irq_fast(), which
+	 * can run concurrently from an irqfd waker without holding pt_mutex.
+	 * The release ensures the VP's initialising stores are visible to any
+	 * reader that observes a non-NULL pointer in pt_vp_array.
+	 */
+	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
 	goto out;
 



