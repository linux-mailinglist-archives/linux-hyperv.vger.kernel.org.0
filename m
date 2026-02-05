Return-Path: <linux-hyperv+bounces-8727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH6eEv9mhGkh2wMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8727-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 10:46:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F2F1009
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AC413012942
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405A3A0B10;
	Thu,  5 Feb 2026 09:40:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC461E51E0;
	Thu,  5 Feb 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284448; cv=none; b=GLykYJkhe8lkPzLDp5d6sdvk8MneGjSvft+eUnPyBnEgOfh2N01w0IFW2pk7iMbdDDo+P6V0Laht2e4MHQ2XQy3qD1grm8IRKzPpl1jWuoKU43r2wBYkAoHIHe6BqbaonpS2QE/sjCBl5VrhJSHTbbFjeiwmtJyQc1iBe+BjR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284448; c=relaxed/simple;
	bh=7Xu72t7704DcIYSUq14TsbDG6k6nauXuo4rVAgorQp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShzTOUxhBUzHL4IH6uxQblx2JYiSvdUl6xDduYiz17H0ZUehaEz0Hn50BC+3GodJKZlFZAuU4xj8RgOgkIvOYjueqVQCxOpTcJaGhRlrIKW43XWuBVfoAtzBgJ//2h+G6iI0tgXGabTdKNDzYbQCqecFUOgihwsXjtRt4oNGRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] mshv: fix SRCU protection in irqfd resampler ack handler
Date: Thu, 5 Feb 2026 04:40:10 -0500
Message-ID: <20260205094010.4301-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8727-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 772F2F1009
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

Replace hlist_for_each_entry_rcu() with hlist_for_each_entry_srcu()
in mshv_irqfd_resampler_ack() to correctly handle SRCU-protected
linked list traversal.

The function uses SRCU (sleepable RCU) synchronization via
partition->pt_irq_srcu, but was incorrectly using the RCU variant
for list iteration. This could lead to race conditions when the
list is modified concurrently.

Also add srcu_read_lock_held() assertion as required by
hlist_for_each_entry_srcu() to ensure we're in the proper
read-side critical section.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/hv/mshv_eventfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 0b75ff1..6d176ed 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -87,8 +87,9 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 
 	idx = srcu_read_lock(&partition->pt_irq_srcu);
 
-	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
-				 irqfd_resampler_hnode) {
+	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
+				 irqfd_resampler_hnode,
+				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
 		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
 			hv_call_clear_virtual_interrupt(partition->pt_id);
 
-- 
2.9.4


