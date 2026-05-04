Return-Path: <linux-hyperv+bounces-10600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF7RLbzv+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10600-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:13:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368684C30B0
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 284B7306D176
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB53EFD22;
	Mon,  4 May 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VXbzlsTI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEC3EF649;
	Mon,  4 May 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921763; cv=none; b=IUXV1uRYTM0Szce0XjM6hiMEinYfQgRG99ajZIPXIw3eF+4JJ9eXVPyZeg+Z97H1pbf37ncFt08ujmjNyXKlaHEfp3U7HuxPa0vL1zheow8Mg6gyh3iMW6j/Z1fJdrC+su9J1MPcpQA0AVm/l7xEVWW2mqo+nyfUceL4xnqVAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921763; c=relaxed/simple;
	bh=GCszAkUZ6N6PEeO5JRUc3/8x0N+lseW9YMRCRB1R8t4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV89lcy+Avc4S6v2XAHNSbYddy7Nh/0IAoCwojQ2xHjYjXkQ/OKdKkgfuoEFepr8hnItHsh2QL9hPLiSfxs+KJYaqPWXs+1QykW4Mhfja+a823JegHRfNhAGf/et9kSJBU+5aEY/nZAGb/gtAkW4uDj+f6Wo11w+t88loD16VtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VXbzlsTI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A135820B7168;
	Mon,  4 May 2026 12:09:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A135820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921759;
	bh=lHdBDtdX+i2Bvo0Y7puGK3HjcBr6MONWxySGf+EzWrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VXbzlsTIEmP/SRfkUy8SpjQdWazDX/22fdzu1/Idr54UAK4AfhR27HexPrT5qdYgg
	 cD5oraqM6ic7BcoI53ckdj5BpjcFWkWgS+WNifMjTk3NR8LBSLxHWPKCG/4gBlgnEc
	 cINsKAIyxjwo7VyCbn1qQ5+CCb7Qqg6qnok/g9Yo=
Subject: [PATCH v3 05/18] mshv: Fix race in mshv_irqfd_deassign
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:21 +0000
Message-ID: 
 <177792176109.90827.9618841734608771680.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 368684C30B0
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10600-lists,linux-hyperv=lfdr.de];
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
 



