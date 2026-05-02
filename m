Return-Path: <linux-hyperv+bounces-10557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKqwF2V99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10557-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:28:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DD4B0D71
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77FBC3014912
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8F292918;
	Sat,  2 May 2026 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ihm5cB6U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC228DB49;
	Sat,  2 May 2026 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696061; cv=none; b=hfV3s9TKyFTtz8zDFuOtoCsq/z3h5mBXZeEqz1tAprbll0LRlUZ6W/bDdCKxCkwRwMh1ubzWc0oHoz8nypl1B+9rKFSP0lUXrgt+Umxa8NZUFUyNlwkl86WwgFv2nWFVjGBGpFglj+sLzJiicdBIOqSjhvHdYC+BnzpA5eHjS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696061; c=relaxed/simple;
	bh=GCszAkUZ6N6PEeO5JRUc3/8x0N+lseW9YMRCRB1R8t4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgmTmbGtlTWu7+dxrnCUzGG2PO6cP7rE8lVobw4wSFX/sGc9CpSGNQoHBD9fW4AbOkObAAZCcjc39gyjqnZEyKe7BRbTj3M74RmB7I/XK+vmpg7JoS8SLMkW9owgFAyo49Uoq2dwXtpxkZyr+m6WwJ0fkQIoV1yeewQ0Frx4ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ihm5cB6U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45F0720B7168;
	Fri,  1 May 2026 21:27:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45F0720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696059;
	bh=lHdBDtdX+i2Bvo0Y7puGK3HjcBr6MONWxySGf+EzWrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ihm5cB6UpcNkxVQ6j2Coo0aE0ibDNEdMt3uoIe2pFh4cm0ZbGTMQainLeqQCYTZzA
	 lEiLRovABPKNIrAyF9QGwJoo0VdbUVB9gPu1/nyiXUXoHrcrniL0+Z4PmgZQjYoI9p
	 xNgBoLOKphEROTtVajON8kUlKbZhUcUFJOTEMQ/o=
Subject: [PATCH v2 05/18] mshv: Fix race in mshv_irqfd_deassign
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:39 +0000
Message-ID: 
 <177769605931.222166.4827178616733218470.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6C1DD4B0D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10557-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

mshv_irqfd_deactivate() and the hlist traversal of pt_irqfds_list
require pt->pt_irqfds_lock to be held, but mshv_irqfd_deassign()
omits it. This races with the EPOLLHUP path in mshv_irqfd_wakeup(),
which does take the lock before calling mshv_irqfd_deactivate().

Additionally, mshv_irqfd_deactivate() uses hlist_del() which poisons
the node pointers rather than resetting them. Since
mshv_irqfd_is_active() relies on hlist_unhashed() (checks pprev ==
NULL), a poisoned node still appears active. If a concurrent path calls
mshv_irqfd_deactivate() again on the same irqfd, the guard fails to
prevent a double hlist_del() on poisoned pointers.

Fix both issues:
- Add the missing spin_lock_irq/spin_unlock_irq around the list
  traversal in mshv_irqfd_deassign(), matching mshv_irqfd_release().
- Use hlist_del_init() instead of hlist_del() so the node is properly
  marked as unhashed after removal, making the is_active guard reliable.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 90959f639dc32..5995a62aff8d8 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -284,7 +284,7 @@ static void mshv_irqfd_deactivate(struct mshv_irqfd *irqfd)
 	if (!mshv_irqfd_is_active(irqfd))
 		return;
 
-	hlist_del(&irqfd->irqfd_hnode);
+	hlist_del_init(&irqfd->irqfd_hnode);
 
 	queue_work(irqfd_cleanup_wq, &irqfd->irqfd_shutdown);
 }
@@ -541,13 +541,14 @@ static int mshv_irqfd_deassign(struct mshv_partition *pt,
 	if (IS_ERR(eventfd))
 		return PTR_ERR(eventfd);
 
+	spin_lock_irq(&pt->pt_irqfds_lock);
 	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list,
 				  irqfd_hnode) {
 		if (irqfd->irqfd_eventfd_ctx == eventfd &&
 		    irqfd->irqfd_irqnum == args->gsi)
-
 			mshv_irqfd_deactivate(irqfd);
 	}
+	spin_unlock_irq(&pt->pt_irqfds_lock);
 
 	eventfd_ctx_put(eventfd);
 



