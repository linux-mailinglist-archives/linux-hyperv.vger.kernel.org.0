Return-Path: <linux-hyperv+bounces-11524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +MAiIOIjJmrMSgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11524-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 04:07:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9336522C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 04:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zohomail.com header.s=zm2022 header.b=KlJwMYN4;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11524-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11524-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zohomail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B13300FEEA
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C03F30D405;
	Mon,  8 Jun 2026 02:06:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4983002D1;
	Mon,  8 Jun 2026 02:06:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884397; cv=pass; b=dbSUjS/8dUUEabRbhChxvBhsfc9RaeDl25tKjKXs1JUWPTBFZyrzXWRepTHVczag9DdLyL/ZeKJlx+9Y59f1v07YJl7AHUA4bhL9o0s09pxIKeXNyOYQr1a0JkvJknr6cqKqyxgLtYInw0G6gpeY05Q4PtBTJiFJQgyxiHuBDLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884397; c=relaxed/simple;
	bh=GRpxiDhOYdxhJE98yqlJqGSfb/ssfUh+7GJa7oi4J6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j1l6xrLBzyvEOe9M5g3YaZozBa0D0h6neQBi2j61YFZHq3elhtgNY37xit4ZmYCRPQOSD98iVusLZMNSDBdShJEC41Y8g2X/mV9e4JkeQmXBcKMuXRuwJzaLC+PFD69JYVplg7rG9SK8dZHhON0j34LSdoYM4Dw2rUuHXrsLbmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=KlJwMYN4; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal: i=1; a=rsa-sha256; t=1780884391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qb4P1o9wSVjfJvc9OGSYG5WMmlvgyFN/0decw9mTOtDSnJZ5qhfGgrHyf5H2czS6zFXC6gLSnbWaEOrnYX572B6Biba3vTJ0wInF3svNY3PfFcFnwfTnpuM3dSGp1R4pDtrHjttVLV5JXY0foGxenQrGkQrZ44kvlZwXAGpL8ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780884391; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=djL16uw205VVL6gItTBwIsFHnNXMGG9l+tcLExhjJr4=; 
	b=doDDEyf1wekckQkVNWu/Tut11gLodPQQGeKWAA/lV6TzfhJSDr56CnrqupoXVY/+6rHo8muNKYklNG6A+w6TNE/LWi16xwOAMMfXUP2RX2/2dczX2iUM/tNCbEmYeyw3OENFZbXQVx7nj6mirD9YUpH1hpFXa+aHGGjSFk0eX90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780884391;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=djL16uw205VVL6gItTBwIsFHnNXMGG9l+tcLExhjJr4=;
	b=KlJwMYN4Z0Vr1sUkg5yWDmhn+Ox0cMrqglY2UaD083zUwgRDmNNjcLiORa1D2ESI
	4Ftkt0dpWQydjDZM7/SEeaUaLUDALLB98IyoADzoYsrfTMrr4h1ZOJh2WLSjeNo2vjf
	+IhhsAO22DQrbVXD7Zh4aV2qwOOhIYlLNh8a4ncg=
Received: by mx.zohomail.com with SMTPS id 1780884389211937.589742357867;
	Sun, 7 Jun 2026 19:06:29 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus devices
Date: Sun,  7 Jun 2026 19:06:16 -0700
Message-Id: <20260608020616.52852-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112272fcdaf1d591ed5cfa619beb80000f021b97d0acaf2b4153a41a6c980372e33844824cb6293770d:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11524-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:replyto,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.com:mid,zohomail.com:from_mime,zohomail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD9336522C9

From: Michael Kelley <mhklinux@outlook.com>

In current code, the coherent_dma_mask for VMBus devices is not set, so
it has the default value of 0, which essentially means "invalid". Because
drivers for VMBus devices do not use dma_alloc_*() functions, the usual
use of the coherent mask does not occur, and no errors result.

However, a valid coherent_dma_mask may be needed even though the drivers
don't use dma_alloc_*() functions. In a CoCo VM, the VMBus storvsc and
netvsc drivers must bounce buffer DMA operations through the swiotlb
because the Hyper-V host can't DMA into encrypted guest memory. If the
kernel is built with CONFIG_SWIOTLB_DYNAMIC and the initial swiotlb size
is small, swiotlb code may need to grow the swiotlb in response to a DMA
mapping request. That growth first allocates a transient pool while the
swiotlb is expanded in the background. The transient pool memory is
allocated from the DMA atomic pools, and the allocation code checks for
a valid coherent_dma_mask. With current code, this check fails, then the
DMA mapping request from the storvsc or netvsc driver fails, and finally
an I/O error occurs.

Fix this problem by setting coherent_dma_mask for VMBus devices at the
same time that dma_mask is set. Being a synthetic bus, VMBus does not
have any restrictions on coherent DMA, so the coherent mask is set to
the full 64 bits for all VMBus devices, just like with dma_mask.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I have not provided a Fixes: tag because the scenario under which
the error occurs is an artificial test case that I came across
while stressing a unrelated patch set. The fix is valid for general
goodness, but the likelihood of the problem occurring in the real
world is extremely small. So I see little value in adding this
patch to the stable kernel maintainers' workload. If someone wants
to argue otherwise, I have no fundamental objection to adding the
Fixes: tag.

 drivers/hv/vmbus_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c9eeb2ec365d..26e8273bbddd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2192,6 +2192,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
+	dma_set_coherent_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
 	/*
 	 * Register with the LDM. This will kick off the driver/device
-- 
2.25.1


