Return-Path: <linux-hyperv+bounces-3206-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DD9B43AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 09:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323D11F23387
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB192038AB;
	Tue, 29 Oct 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mJEuTtbM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC06202F90;
	Tue, 29 Oct 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188926; cv=none; b=Oy4g6GhJlZzGpNUyCwWR9s+L+CuW5vOPcLm13JLXFoeLbKzPOxAIXB1AlY8km2tGMnpGe5/IgFFTBd90z/BB6bI1Be9kmceUtCuSnxqNrXdbPsUihftE0Kmnr4Kk7T3bXiy6kg8Vh9IGSW6r5V0StvQlaVf4biHLkNhciL7+I9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188926; c=relaxed/simple;
	bh=TzE9XJ/NGUpnXJ9GzVQup0mgsWSQDbIP9eiRsX+f8qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaPpTcqKhih+sdiFeFe0IDJ95gGA1o4BMS3rYP7X5bJTJ4v505SBCAXL0GRwvQMFMGjy5WsGv7QBHoZio7yTRHZ2eWZ3QiG2qpLb2xH9NnTooomdo3Cb26BWp4/Zrp8JMKPn8XuJO0AVxGzQ5hvr4zSYnmy+QinTeraXueDL4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mJEuTtbM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id DE246211F7B6;
	Tue, 29 Oct 2024 01:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE246211F7B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730188918;
	bh=NKV+k3dlEbrG9sZ9zRlaT0sMeThJ1IOr1+L+0VkaEX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJEuTtbMs1xofqcpBOlS+s8BpyPNOiGUfutfrIK619srSPXmJa3i9aP9hbAxF8Nyc
	 1SYVqp14tBoqAm3bnLNBcoFs2Axaeb++zOs48pSg9uCabQ0BbV+eNs4katOivybPrW
	 S6qicmAFycYEu9V1kua9qeACIj55w7GiERhPYZXU=
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
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
Date: Tue, 29 Oct 2024 01:01:47 -0700
Message-Id: <20241029080147.52749-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029080147.52749-1-namjain@linux.microsoft.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
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
In general, the essential virtual devices configured for a VM, remain
same, before and after the hibernation and its not very common that
some offers are missing. The cleanup of missing channels is not
straight-forward and dependent on individual device driver
functionality and implementation, so it can be added in future as
separate changes.

Signed-off-by: John Starks <jostarks@microsoft.com>
Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
Changes since v1:
https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com
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


