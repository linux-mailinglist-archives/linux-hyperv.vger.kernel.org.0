Return-Path: <linux-hyperv+bounces-3329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05E9C6AD1
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 09:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9BBB21C39
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2024 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40857188708;
	Wed, 13 Nov 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A+7uvjKk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A5178CE4;
	Wed, 13 Nov 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487635; cv=none; b=FzO211gNGJMMIrL2gCYjJBqPUoZhUcURB2hlZ3UCDsdSQuoTXEZf877mJhqe5+43uM0iFXnMywJ7ZKvv6Za6Cv4kWrq3BRu9cDf2dBHbSOLQeJm/A1QJcHjLjyKDyekKi5OODGDknSlc+6+lSB3jJ0IsUMxWCYIhDkH+I2USv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487635; c=relaxed/simple;
	bh=lHNwEUzDlU2n1USh+lgAETBE6fW7vA/BqbL+yHZ2AT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VoE8leVetLhQTfbWr/pKZsYJ71p8qKXWQJQ9aPxB6TTTeygt5+XQEWeHpvkW/MKSWsTkkxEpgq1emfr/ZY0WI2iDyEKV4q4E/7e4QsjCp+p+76pGzf9FCIjW8Xy51vst0nHG2ionvDEjmBwXhkuovwaFQud0eCM8Wam/3AwJ6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A+7uvjKk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5108220BEBD1;
	Wed, 13 Nov 2024 00:47:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5108220BEBD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731487627;
	bh=RIVIKMAGR4u+IiRc8EFSgUII+UDd/pw+fXtdicErCHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+7uvjKkJvhZe7pSE/9Rx+F297drfzV6Twz/5olyI9s0TdhqVLNj6FWfOvuA8F8e7
	 IqUkOHcCh3gPPZ44Xc9EZh3FzJiL9ntyO06aZbY/ae+i4/9nxsBXhyM+YXHeV2cfl2
	 5pdvzt7uHCY7HHMk15en6j3SGa61pXDzau2KhXfs=
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
Subject: [PATCH v3 2/2] Drivers: hv: vmbus: Log on missing offers if any
Date: Wed, 13 Nov 2024 00:47:00 -0800
Message-Id: <20241113084700.2940-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113084700.2940-1-namjain@linux.microsoft.com>
References: <20241113084700.2940-1-namjain@linux.microsoft.com>
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
---
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
index bd3fc41dc06b..08214f28694a 100644
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
+			&channel->offermsg.offer.if_type,
+			&channel->offermsg.offer.if_instance);
+		/* ToDo: Cleanup these channels here */
+	}
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
 
-- 
2.34.1


