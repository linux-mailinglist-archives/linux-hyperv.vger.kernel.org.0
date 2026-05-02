Return-Path: <linux-hyperv+bounces-10558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PkIFpJ99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10558-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:29:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BBB4B0DAB
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A1D53043D4F
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C928C84A;
	Sat,  2 May 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TIl5aSb6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364428DB49;
	Sat,  2 May 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696066; cv=none; b=qSTcNi6cNTaDOvU5txl9CjMeD0oAvJGbU0Jk42sL4OIStiTqR75c2lFORBRuibRbKMAJvqdjNzUqckV3blepPwKWWrLFR/yDDWc+WAIj4dqH8oumvMcdui7zxCBqNVUDBTVV2AmgoyefWKGhVIHn6mfAXOwi7XnWvk3DEcJYt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696066; c=relaxed/simple;
	bh=kF88lu0+Ocw5C9Jq3CXNMGXixgKn4qw5/2Ep8kOgnRQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV7BsCqiktE8EbP4bjmDTBfODNp3CXJEwgQ2oyK4wxj87PY6NhPdswNYbeuO0AQ+VqAaj1wyq8KLy9DBo2R1hAzbY28xprX4U68gulXfakF/ybxJVu1iiofwtSLMHfHKAS2sV6Jf25o5UPprTux9BDeANjPXGahlv94/zUPo6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TIl5aSb6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A744520B7168;
	Fri,  1 May 2026 21:27:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A744520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696064;
	bh=hEp07iJkKFnOnKhzkqaNpdLZthXI/i1ZLlt/y4LgudY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TIl5aSb6I8CwmJqwJUn/f8EgTTqx+StZd8qRimqM61VnVoXOwZxPAVRYK77KUzCd/
	 +SUUgJ1VVzM9J/NqO0L5CNoDl91v5dRsPijPF1/DjYMMC2zkvUi5cELTu9ezncpz4i
	 wQsVFH9uGjV6NaxhRMX/Hc6ajjNHGo0cLHcMbb/M=
Subject: [PATCH v2 06/18] mshv: Add defensive synchronize_srcu in irqfd
 shutdown
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:44 +0000
Message-ID: 
 <177769606469.222166.1139960771862923986.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: C3BBB4B0DAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-10558-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

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



