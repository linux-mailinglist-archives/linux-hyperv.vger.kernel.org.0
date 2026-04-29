Return-Path: <linux-hyperv+bounces-10483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELpCJZhL8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10483-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:19:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB283498E62
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C3D30A77F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40241C318;
	Wed, 29 Apr 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dODM+/c3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91241C312;
	Wed, 29 Apr 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486677; cv=none; b=cySupyvqzIbq57Saoyz8KekdFinGfge84sZz0cbXbx9p7bOW4dVpVITAjETPZ+O+1Vk4GgecmMMNFKHQ3uqarWpXqbJZTLuy93TLfXl0kTgnNoYUWArSWKVRDl8jlLxhRv+C62tKtKmmyI19qUX5vDNrPKhV2g2H/PHHONwHVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486677; c=relaxed/simple;
	bh=VVoG+T+qWS+flBVHWmdlsTZhrquZvIcYDLSknOQFmDo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJnDGXbh9woPPF6suj0yHMPbY1EdIo3o5X41U4odkM45Z3qr3X7Ug47cXuZisFE4Lav/F+pwFxg0KlGwxNRJdYThNEcsZylK8QcSPAlaXxEfTllMyxlMEPfmTmhRFsf+0ULqP9GqLxx+z0Jb3/ZJcM588BJbA3NyTWLrj9UbD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dODM+/c3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1360F20B7171;
	Wed, 29 Apr 2026 11:17:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1360F20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486674;
	bh=sf3gagrBTMQJ8BHpybeBSy0HL6KPww0Rh89VlrybCHU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dODM+/c3Z0SZS9IrIFyo8fUKHY0q3pQDbB+bRQVJiXWCee8cGItwMKmFraJTYvlSW
	 oNPeSZ2s99UxT8rtwqQai4rJHXcJRvPZ0P4RVkhZ2U+9tMtSvK4Z5WGd122TiJWJYU
	 vW1LT91FYzm+fH0K3GOkvoDIZEt+JJ0JAaOd/P9c=
Subject: [PATCH 03/10] mshv: Fix missing lock in mshv_irqfd_deassign
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:17:53 +0000
Message-ID: 
 <177748667337.144491.17551824636177658257.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB283498E62
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
	TAGGED_FROM(0.00)[bounces-10483-lists,linux-hyperv=lfdr.de];
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

mshv_irqfd_deactivate() and the hlist traversal of pt_irqfds_list
require pt->pt_irqfds_lock to be held, but mshv_irqfd_deassign()
omits it. This races with the EPOLLHUP path in mshv_irqfd_wakeup(),
which does take the lock before calling mshv_irqfd_deactivate().

Add the missing spin_lock_irq/spin_unlock_irq around the list
traversal, matching the pattern in mshv_irqfd_release().

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 90959f639dc32..704c229ee3b19 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
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
 



