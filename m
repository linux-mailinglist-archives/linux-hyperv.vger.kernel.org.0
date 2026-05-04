Return-Path: <linux-hyperv+bounces-10601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBb/Ec7v+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10601-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:13:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBA4C30C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6C7A3072019
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B23F211A;
	Mon,  4 May 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gyw3ZU11"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF573F0771;
	Mon,  4 May 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921768; cv=none; b=ayqQiI+xEojH1y1xDKYd5bBR8zkE+i+yqY7a7KbtWfgxdmm6H6VwjX46M3vAT9L1Sht5E0iHrc1HLwfybbDOkyqkqSbviQclcAb38TBB7PDp7AWnA8LEPuS8sf3xhC/jwANE7WYitQvveGP5AAYy6MY2GcnUSX2k7TY9d3m4liU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921768; c=relaxed/simple;
	bh=kF88lu0+Ocw5C9Jq3CXNMGXixgKn4qw5/2Ep8kOgnRQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rU9eP/bLd+86jIGdhcO9iSCxxLU0mrvTcorIqGRioW0gVSmkvtm0VbfBkHM4HmxZus8aJVrduQHtP/l8bzoKfiV775JvN9w/+PqdpgSGr3lVxoVe88h65WzGceVOw3/S+kgO0O618r9Ao5JPMlcx0dqPBN6Upu7j4tJLk34Tf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gyw3ZU11; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D19220B7168;
	Mon,  4 May 2026 12:09:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D19220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921765;
	bh=hEp07iJkKFnOnKhzkqaNpdLZthXI/i1ZLlt/y4LgudY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gyw3ZU11GBMnN3RnK2WP9hOByIWMKyIwJoxbFqfoH0L8GrhGYKi0WSpnpZG7Uc0Nv
	 pcEbYVlbqqzUE2ESCYdwjY2H53KCVzES61UmxDUDsLINwWmJEESO6GWl65uFrvXmQI
	 PABnGeL7lTC2waCzSemnJBZXaxC2XA7hcnc5zKBg=
Subject: [PATCH v3 06/18] mshv: Add defensive synchronize_srcu in irqfd
 shutdown
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:26 +0000
Message-ID: 
 <177792176646.90827.1714236627708622678.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: B6FBA4C30C5
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
	TAGGED_FROM(0.00)[bounces-10601-lists,linux-hyperv=lfdr.de];
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

mshv_irqfd_assign() adds the irqfd to the partition's hlist and then
registers the wait entry on the eventfd waitqueue via vfs_poll(). A
narrow window exists between these two operations where the irqfd is
visible to deactivation paths but the wait entry is not yet initialized
on the waitqueue.

Currently this is not reachable because mshv_irqfd_assign() and
mshv_irqfd_deassign() are serialized by the partition mutex, and the
EPOLLHUP wakeup path can only fire after vfs_poll() has registered the
wait entry. However, if future refactoring removes or relaxes that
serialization, mshv_irqfd_shutdown() could call
eventfd_ctx_remove_wait_queue() before the wait entry is on the queue,
causing a NULL pointer dereference (the list_head is zeroed by kzalloc
and not initialized by init_waitqueue_func_entry()).

Add synchronize_srcu_expedited() at the start of mshv_irqfd_shutdown()
as a defensive measure, ensuring the assignment path's SRCU read-side
section (which covers vfs_poll() registration) has completed. This
follows the pattern established by KVM in irqfd_shutdown().

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 5995a62aff8d8..3ab6338064237 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -248,8 +248,12 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
 {
 	struct mshv_irqfd *irqfd =
 			container_of(work, struct mshv_irqfd, irqfd_shutdown);
+	struct mshv_partition *pt = irqfd->irqfd_partn;
 	u64 cnt;
 
+	/* Make sure irqfd has been initialized in assign path. */
+	synchronize_srcu_expedited(&pt->pt_irq_srcu);
+
 	/*
 	 * Synchronize with the wait-queue and unhook ourselves to prevent
 	 * further events.



