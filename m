Return-Path: <linux-hyperv+bounces-3341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0A9D0A09
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2024 08:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019EC282515
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2024 07:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA813D279;
	Mon, 18 Nov 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XQB4XwJW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418AC13A89A;
	Mon, 18 Nov 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913657; cv=none; b=SZzoDXakmsH5ZlonOFYpOqVIIm0OLSyq6gbcmYc69ym/n1Sj3E833TQVJIZLjYEHhxDjTX2trLwH2RydvynX+jEGsCTOAuvorNA4ml3AKGLlvpKrELBjJ/KJ03n8NSIUfob54zD5PXGKusu+cfUjkBUa1+6BwyeAx3jIsD2bN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913657; c=relaxed/simple;
	bh=GHpyFUvLr8LtVLVvlyyI7tvyH683HGJb5S4eqEIxSsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6IUkfjhYiQCXBWUJ7t/NrXnMWFmqgKYCoZKh++t1lIyhN4lv0XJ6Xy1aAjblT/Qx9s/Gno3oh/zRv9HT1HOnrDfgQ94YktnHb+GOtJooqeTxzA/Qu+p33RGDvLKn+DJW9epqRDlFGC9bkQCAAWB8MFN3xjMtt8gLYk/byYElqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XQB4XwJW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.159.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 23F8E206BCE8;
	Sun, 17 Nov 2024 23:07:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23F8E206BCE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731913650;
	bh=qSnPPxztzUe4BJjc8R4VwilVM9ib9oQFIqvimzWWLw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQB4XwJWFuRp8XmJm3q1PEh7mJho9fHfA7PQfDDd4CexTjjbtz8Np4WmjSdafzIeX
	 3XkBLRU/BQdnA1MywD9r9qfJcNwxInTBLDf6P954ZPxfO9/tg2ZeF8ud33gwgrRJ1n
	 UUPDaqX1/FaL6UdTeavXZAXIGSozFTV+ILy3AYCY=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naman Jain <namjain@linux.microsoft.com>,
	John Starks <jostarks@microsoft.com>,
	jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v4 2/2] Drivers: hv: vmbus: Log on missing offers if any
Date: Sun, 17 Nov 2024 23:07:25 -0800
Message-Id: <20241118070725.3221-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118070725.3221-1-namjain@linux.microsoft.com>
References: <20241118070725.3221-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Starks <jostarks@microsoft.com>

When resuming from hibernation, log any channels that were present
before hibernation but now are gone.
In general, the boot-time devices configured for a resuming VM should be
the same as the devices in the VM at the time of hibernation. It's
uncommon for the configuration to have been changed such that offers
are missing. Changing the configuration violates the rules for
hibernation anyway.
The cleanup of missing channels is not straight-forward and dependent
on individual device driver functionality and implementation,
so it can be added in future with separate changes.

Signed-off-by: John Starks <jostarks@microsoft.com>
Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
Changes since v3:
Fixed minor checkpatch style warning coming with "--strict" option,
addressing Saurabh's comments.

Changes since v2:
* Addressed Michael's comments:
  * Changed commit msg as per suggestions
* Addressed Dexuan's comments, which came up in offline discussion:
  * Minor additions in commit subject.

Changes since v1:
* Added Easwar's Reviewed-By tag
* Addressed Saurabh's comments:
  * Added a note for missing channel cleanup in comments and commit msg
---
 drivers/hv/vmbus_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bd3fc41dc06b..6b27d3abc2db 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
 
 static int vmbus_bus_resume(struct device *dev)
 {
+	struct vmbus_channel *channel;
 	struct vmbus_channel_msginfo *msginfo;
 	size_t msgsize;
 	int ret;
@@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev)
 
 	vmbus_request_offers();
 
+	mutex_lock(&vmbus_connection.channel_mutex);
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (channel->offermsg.child_relid != INVALID_RELID)
+			continue;
+
+		/* hvsock channels are not expected to be present. */
+		if (is_hvsock_channel(channel))
+			continue;
+
+		pr_err("channel %pUl/%pUl not present after resume.\n",
+		       &channel->offermsg.offer.if_type,
+		       &channel->offermsg.offer.if_instance);
+		/* ToDo: Cleanup these channels here */
+	}
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
 
-- 
2.34.1


