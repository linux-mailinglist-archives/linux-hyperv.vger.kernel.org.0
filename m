Return-Path: <linux-hyperv+bounces-8928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNIpCqeOmGnjJgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8928-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 17:41:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A101695D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2996D301AB9B
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF434E743;
	Fri, 20 Feb 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="HwadN5R9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC8329E62;
	Fri, 20 Feb 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605658; cv=pass; b=kU/SDcDvG/25+sx/gPO3sakYHnkLDd0rKsEVIp91H+nJcyjAGxcxkwoRKh1oWeEyw0HFxjvuGdXOEu3vHj1hwjJzXGJDC68EcLWOCYYIn33XwG5mxyERXsc2Wfr/+/QhaEVCcUQBqF4e+Is64MgRhPv9gWClLL2vFjn2TAGEIX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605658; c=relaxed/simple;
	bh=QG21drfVOdtahs43homKlTXIkTJZUiDYh+qhWi/ipN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3YlUg9cHg1Pnbl8FsqXyezfg6mdySFMeszchjBRYQaWUnDoK0EeWNxTXJwq8PvmbtApKI4mxR1WUwC24qTH9D3c5ONVkVkwap86T8wvLLiRbapbkeEtpwspXFXT7X+g8nc+gP9gEYK+qEx3V7PillRyF6zVzuAZ0IIZmoJk9R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=HwadN5R9; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771605650; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iwDxDAPP4tthk/9RttlPF39Zt+iwXfWABLEPW2BUDWlHXglWhz+H6LNW7+VyYH3N8aBqYmCozKL2fdQ2lrJLaCdyZrBaj+w7dTutUY6rnZILwaERlh6fUn8TK0oDetSoq9g/puVo8ICbZHTu/9fl0yPnCq5jfCbATQhLRptLVUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771605650; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=Qfibf9vstByWn3C9zUNrukBNoIXHjXiZNIeHXq0IAgc=; 
	b=hrwwIqKHZO6lmddVGwJR7MWnkRyuFbzOU79tpVSMFZHCth9F8WYc92ZIt9JaMdVTDbPPqZ3X9qNbXtlNYCGnHP3F6ToVGaybAw44vAeIxbTAKff2czdIMBl4TF1rtKIiSRHS37QwyJuFoLrKMA0olcYpU4/BK9b+5KG246l6IDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771605650;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=Qfibf9vstByWn3C9zUNrukBNoIXHjXiZNIeHXq0IAgc=;
	b=HwadN5R9LT/ORNg6gDi//5cmotx6fTcKZICMSIhI4V8NgoDid2L0eIeCLw1e+lxN
	YrwkDuRDLyB7IfRL/bg3R8rTwB8IXWK0o78xTVs/4CduUA95uEO6gEANPMhOqFPbc3t
	GeSK8e6iLAvPZmlStldvMdRw3eFOYyBE9lhZKd1k=
Received: by mx.zohomail.com with SMTPS id 177160564925721.434851319871314;
	Fri, 20 Feb 2026 08:40:49 -0800 (PST)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Limit channel interrupt scan to relid high water mark
Date: Fri, 20 Feb 2026 08:40:45 -0800
Message-Id: <20260220164045.1670-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227fa056908db7f7b3a6c51136e000032fe2b09a027699ce9d9229fbaf08e4680ba74bd48eb5ca674:zu0801122734506468a3e5b75756fd6cc500002adb71fcd14c04ccc5c6cdef7c9fe62015389b05185fdcfb9b:rf080112267dd82af6cf8f9178da3097f70000804d3f1b5e6c327f1e8696c5f6426fc86823f4dd90e0245c:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8928-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:replyto,outlook.com:email,zohomail.com:mid,zohomail.com:dkim]
X-Rspamd-Queue-Id: 94A101695D3
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

When checking for VMBus channel interrutps, current code always scans the
full SynIC receive interrupt bit array to get the relid of the
interrupting channels. The array has HV_EVENT_FLAGS_COUNT (2048) bits.
But VMs rarely have more than 100 channels, and the relid is typically
a small integer that is densely assigned by the Hyper-V host. It's
wasteful to scan 2048 bits when it is highly unlikely that anything will
be found past bit 100. The waste is double with Confidential VMBus because
there are two receive interrupt arrays that must be scanned: one for the
hypervisor SynIC and one for the paravisor SynIC.

Improve the scanning by tracking the largest relid that has been offered
by the Hyper-V host. Then when checking for VMBus channel interrupts, only
scan up to this high water mark.

When channels are rescinded, it's not worth the complexity to recalculate
the high water mark. Hyper-V tends to reuse the rescinded relids for any
new channels that are subsequently added, and the performance benefit of
exactly tracking the high water mark would be minimal.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c | 16 ++++++++++++----
 drivers/hv/hyperv_vmbus.h |  3 ++-
 drivers/hv/vmbus_drv.c    |  7 +------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 74fed2c073d4..61f7dffd0f50 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -384,8 +384,18 @@ static void free_channel(struct vmbus_channel *channel)
 
 void vmbus_channel_map_relid(struct vmbus_channel *channel)
 {
-	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
+	u32 new_relid = channel->offermsg.child_relid;
+
+	if (WARN_ON(new_relid >= MAX_CHANNEL_RELIDS))
 		return;
+
+	/*
+	 * This function is always called in the tasklet for the connect CPU.
+	 * So updating the relid hiwater mark does not need to be atomic.
+	 */
+	if (new_relid > READ_ONCE(vmbus_connection.relid_hiwater))
+		WRITE_ONCE(vmbus_connection.relid_hiwater, new_relid);
+
 	/*
 	 * The mapping of the channel's relid is visible from the CPUs that
 	 * execute vmbus_chan_sched() by the time that vmbus_chan_sched() will
@@ -411,9 +421,7 @@ void vmbus_channel_map_relid(struct vmbus_channel *channel)
 	 *      of the VMBus driver and vmbus_chan_sched() can not run before
 	 *      vmbus_bus_resume() has completed execution (cf. resume_noirq).
 	 */
-	virt_store_mb(
-		vmbus_connection.channels[channel->offermsg.child_relid],
-		channel);
+	virt_store_mb(vmbus_connection.channels[new_relid], channel);
 }
 
 void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 7bd8f8486e85..2c90c81a3b0f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -276,8 +276,9 @@ struct vmbus_connection {
 	struct list_head chn_list;
 	struct mutex channel_mutex;
 
-	/* Array of channels */
+	/* Array of channel pointers, indexed by relid */
 	struct vmbus_channel **channels;
+	u32 relid_hiwater;
 
 	/*
 	 * An offer message is handled first on the work_queue, and then
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3e7a52918ce0..a96da105b593 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1258,17 +1258,12 @@ static void vmbus_chan_sched(void *event_page_addr)
 		return;
 	event = (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE_SINT;
 
-	maxbits = HV_EVENT_FLAGS_COUNT;
+	maxbits = READ_ONCE(vmbus_connection.relid_hiwater) + 1;
 	recv_int_page = event->flags;
 
 	if (unlikely(!recv_int_page))
 		return;
 
-	/*
-	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
-	 * One possible optimization would be to keep track of the largest relID that's in use,
-	 * and only scan up to that relID.
-	 */
 	for_each_set_bit(relid, recv_int_page, maxbits) {
 		void (*callback_fn)(void *context);
 		struct vmbus_channel *channel;
-- 
2.25.1


