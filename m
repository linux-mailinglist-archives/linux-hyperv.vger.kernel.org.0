Return-Path: <linux-hyperv+bounces-10605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABE6IyPw+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10605-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:14:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA44C3134
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47B9308F9B3
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441F13F1657;
	Mon,  4 May 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i3zv5u1Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D43F1654;
	Mon,  4 May 2026 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921790; cv=none; b=egGI3qnA/PCfMOXQRREx1kZSpmwqNrAfTktNoD6OVAUX1MCAZeWCtFTmb/rO29u4cO7x+WY4WPCvOfp0sna8e7ahIMtVyXY0pSz1GMsU9aXQNcFpP+RH/0/fcACbhWeyBzsw7C9pzh9rXv1TrdKNhdFRgvamp+oKwg/DLae5VyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921790; c=relaxed/simple;
	bh=O+iwR2H+1uS6nejhOb0vUXPexvOK70zh2iW2n0VBvsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJfffRJyQX3eJ9gCIB8AFUw1Hcxl2S61RH6F/yf5S1q0n8G6llg6EhA47SsWhdDawzhihWpKQVAH3LA9HFnTT3Mdvq0yF+1/26xn+Fid9e1JfGwnD6zTR43yuLmkxzFv2/0/qRflzJtIUchC2AAksBvaVDq9vnOShf/e47+jXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i3zv5u1Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B30520B7168;
	Mon,  4 May 2026 12:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B30520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921787;
	bh=Qqs1rJSF5BoTMZX5Z3oHPNLYYv+RowLG027cgziD1xE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i3zv5u1ZzVSc4MquuRw6cjBW+hn6gUSClpV/tSwQE0klFVCtDBK5kcd/DJyFwyzUT
	 R0JSx+kYu9knNu28Ly8Aod6I4bgCeIJ4nfRkLl4lcgg56xjwPhdTFVEthSJeDbGItb
	 MWF9ItcKp6hVw8rIzc84o6lhr9+7GP7EKyeiOoDY=
Subject: [PATCH v3 10/18] mshv: Fix level-triggered check on uninitialized
 data
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:48 +0000
Message-ID: 
 <177792178847.90827.4208857103170937607.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 4FCA44C3134
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10605-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

In mshv_irqfd_assign(), the level-triggered validation for resample
irqfds checks irqfd_lapic_irq.lapic_control.level_triggered before
mshv_irqfd_update() has populated the field. Since the irqfd struct is
zero-allocated, level_triggered is always 0 at that point, causing the
check to always reject resample irqfds with -EINVAL. This makes
level-triggered interrupt resampling — used to avoid interrupt storms
with assigned devices — completely non-functional.

Move the check after the mshv_irqfd_update() call, which resolves the
IRQ routing entry and populates irqfd_lapic_irq with the actual trigger
mode.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 8a5a1b517ad4b..c99ca5770d3d0 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -483,6 +483,19 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	init_poll_funcptr(&irqfd->irqfd_polltbl, mshv_irqfd_queue_proc);
 
 	spin_lock_irq(&pt->pt_irqfds_lock);
+	ret = 0;
+	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
+		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
+			continue;
+		/* This fd is used for another irq already. */
+		ret = -EBUSY;
+		spin_unlock_irq(&pt->pt_irqfds_lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&pt->pt_irq_srcu);
+	mshv_irqfd_update(pt, irqfd);
+
 #if IS_ENABLED(CONFIG_X86)
 	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
 	    !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
@@ -491,22 +504,12 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 		 * Otherwise return with failure
 		 */
 		spin_unlock_irq(&pt->pt_irqfds_lock);
+		srcu_read_unlock(&pt->pt_irq_srcu, idx);
 		ret = -EINVAL;
 		goto fail;
 	}
 #endif
-	ret = 0;
-	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
-		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
-			continue;
-		/* This fd is used for another irq already. */
-		ret = -EBUSY;
-		spin_unlock_irq(&pt->pt_irqfds_lock);
-		goto fail;
-	}
 
-	idx = srcu_read_lock(&pt->pt_irq_srcu);
-	mshv_irqfd_update(pt, irqfd);
 	hlist_add_head(&irqfd->irqfd_hnode, &pt->pt_irqfds_list);
 	spin_unlock_irq(&pt->pt_irqfds_lock);
 



