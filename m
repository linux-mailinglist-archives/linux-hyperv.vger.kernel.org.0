Return-Path: <linux-hyperv+bounces-5359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C135DAAB892
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C791C174222
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB532AB85;
	Tue,  6 May 2025 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="QzMDCDaS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAC34FB19;
	Tue,  6 May 2025 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493011; cv=none; b=pvqETdVqjFkBXWW6TVYe0QqbFa6EQsKY+DamQS1XvPv/ez05U4DNniVDiDzvH4v89+K7hvfDfX80McJ1sWd3NJnqfwA5cF/2kF6L2vuQBLw3/2G0OQhpFPH94acu/59N3Ymb47z/rwFD3SjdduTcKyWcWQa3MLxma5Sgimpshd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493011; c=relaxed/simple;
	bh=KXhn6Y28CWw7SHrD0L20soN5/9bptpnT4a0FcY/qBd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uq842eRTzE47FatH8+EpL+9fFHtNPfdiwuQgXo0YEEC0tc7yXMCsV1wxooguZjPul/bxpDjTu0TiNqz2qCAwjoxv3J8PbCujjKBeKkmD4RHNMYtnUOIUv6vQxyUvXVNsypy/R7BsecrXNzsY2h3i0QWhYD2u3Ourg6zQu7V9Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=QzMDCDaS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 53D592115DC2; Mon,  5 May 2025 17:56:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53D592115DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493004;
	bh=t61EzT3XMgXNN1USOK5BwI5jrOfGuZzmM3tXBa1w7Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzMDCDaS+do82auib7/8d/X+ARpIQnf2bRJjFyEVjoX34FJE5WAHAKFyeGfxkvtjT
	 XyZKiunbVLtCJe697+riB264id8qBNJ+1oqOo1FZt5apXHEsNRcr4VUCarE5RzyVz3
	 5vskgQtf5Od5igujU/Javho4JFluwxnMSgnavbG4=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v3 1/5] Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
Date: Mon,  5 May 2025 17:56:33 -0700
Message-Id: <1746492997-4599-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

There are use cases that interrupt and monitor pages are mapped to
user-mode through UIO, so they need to be system page aligned. Some
Hyper-V allocation APIs introduced earlier broke those requirements.

Fix this by using page allocation functions directly for interrupt
and monitor pages.

Cc: stable@vger.kernel.org
Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/connection.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8351360bba16..be490c598785 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -206,11 +206,20 @@ int vmbus_connect(void)
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
 	mutex_init(&vmbus_connection.channel_mutex);
 
+	/*
+	 * The following Hyper-V interrupt and monitor pages can be used by
+	 * UIO for mapping to user-space, so they should always be allocated on
+	 * system page boundaries. The system page size must be >= the Hyper-V
+	 * page size.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+
 	/*
 	 * Setup the vmbus event connection for channel interrupt
 	 * abstraction stuff
 	 */
-	vmbus_connection.int_page = hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.int_page =
+		(void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -225,8 +234,8 @@ int vmbus_connect(void)
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = hv_alloc_hyperv_page();
-	vmbus_connection.monitor_pages[1] = hv_alloc_hyperv_page();
+	vmbus_connection.monitor_pages[0] = (void *)__get_free_page(GFP_KERNEL);
+	vmbus_connection.monitor_pages[1] = (void *)__get_free_page(GFP_KERNEL);
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
@@ -342,21 +351,23 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		hv_free_hyperv_page(vmbus_connection.int_page);
+		free_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[0]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[0], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[0]);
 		vmbus_connection.monitor_pages[0] = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[1]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[1], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[1]);
 		vmbus_connection.monitor_pages[1] = NULL;
 	}
 }
-- 
2.34.1


