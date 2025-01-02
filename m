Return-Path: <linux-hyperv+bounces-3565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE89FF9A1
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 14:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75E83A3382
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9D19D071;
	Thu,  2 Jan 2025 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJqxFdvP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4423A9;
	Thu,  2 Jan 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735823244; cv=none; b=MVpBaNyxsIawp/3PPne+Y2r1wjlpv4LUL/1Dw1NmLs7pNe+grSNKHfqvKm63tO3aRyv00Hvkdpbrf+Tb4e31pzqVcIGNwY1o8FgroEhCrZ1z1viT9TMCf668wS7xlD4GfxHhqFm/VPPs34Of1dcJyJnBHA3QqMEzAgqhk1iddm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735823244; c=relaxed/simple;
	bh=kJ6vG7d5D3FbyBQwSPfLrY+kveT5yYcevw+A+nnsn2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swjoBxKSWyVVPuT2TCZXtTQEbJef3mQqd0Fu7gXmqFLYpBZz44vdmMhnZ+2uyeyxwF4xcH2yBgOG7zNJQ55/opVgsN0lJHD7esoOD/qzDOU5ot3UG+6W3iMqViKvkoPjivrZ8LArUQ1kPD7Y5JtU5yFk5C4E2d4MRny7U/PVqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qJqxFdvP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF7062069419;
	Thu,  2 Jan 2025 05:07:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF7062069419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735823236;
	bh=2BnHuL5uJGIVH4iFHjRkt3PlJKIR1VMc675KdTqjIbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJqxFdvPBHp9bA8GDHg1qb60KK9GoqLIGuCthSEa1v3ioRNhNJe98oVBcEBxtFGFb
	 AXkVhHqPiKxF8QVKy+OpXKu1ZLVOAhlrQGD7c4dp/f0JzyiO0ojbqkOy/hNiXTepgC
	 X7k2DYK4tTx6XT5SitaW5COz/jsDbwWEwepbCxIc=
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
Subject: [PATCH v5 2/2] Drivers: hv: vmbus: Log on missing offers if any
Date: Thu,  2 Jan 2025 13:07:11 +0000
Message-ID: <20250102130712.1661-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102130712.1661-1-namjain@linux.microsoft.com>
References: <20250102130712.1661-1-namjain@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Changes since v4:
Rebased on latest tip and added Michael's Reviewed-by tag.

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
index bf5608a74056..0f6cd44fff29 100644
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
2.43.0


