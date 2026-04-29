Return-Path: <linux-hyperv+bounces-10485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD1DOdFL8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10485-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:20:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA83498E91
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FDB30F5781
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D794218AC;
	Wed, 29 Apr 2026 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XwUY2Muq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0333ADAE;
	Wed, 29 Apr 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486687; cv=none; b=Za3vi0EppDpAMBF7Nzhj+ih3KQ3svlbSJFwd0uzDNGs+HeRtyz7J/96NxzM5tW5HNdvKYferd86xMRnDb5u7i7Kl+k8X2XnbVgPqCe98sDtivTPn/cw8FcWLKwsCdtr0s7+xKOP1xQ335ihqvZhD5506b/bP6Ud5z/vU0ofAM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486687; c=relaxed/simple;
	bh=jqtLbFNt35ZWDMpDoc6iNv1M/CaZ6ptIHMJXzwFx1ZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCwv4HaL3QD1+jNM4KJp38++GTPAScUvPNgfbvo6/str8w8TTVLLyrDW+7marU0vFmFBBLsTxulC4SYKkqHfI+OVQCXDqJ2AUUP5awmZbEtkSjSjjxCEVur/1xbr54sKnhsSGegdv7TrX85oXnC+XmXXpJdzs8sgf9D7c5VfAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XwUY2Muq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E08EC20B716C;
	Wed, 29 Apr 2026 11:18:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E08EC20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486684;
	bh=MBPzwZnwBvEFUR7adLX293VgQYR+7yXHsWo6RkHOOek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XwUY2MuqMjwg5n5zRlkKooTj/iOG85To7fKxOHwTyCUejvuO74kqkU8oxhcIBLDSA
	 1q6wyloZa3tU2D3C+I1c7yg6sFG7TRfkwv13MHAqTbROxm7VSO3sAtmaftZFWOT9nX
	 QulsPGjy5IPXJO04ujpnkPQApXpvWasnfEwSLnCY=
Subject: [PATCH 05/10] mshv: Fix level-triggered check on uninitialized data
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:18:04 +0000
Message-ID: 
 <177748668420.144491.11896912928710581562.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3AA83498E91
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10485-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

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
index d9491a14f30f1..fd594acce3235 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -478,6 +478,19 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
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
@@ -486,22 +499,12 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
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
 



