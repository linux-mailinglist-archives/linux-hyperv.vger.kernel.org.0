Return-Path: <linux-hyperv+bounces-3154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A589A3DA5
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C29284C70
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263412B94;
	Fri, 18 Oct 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qIpl0s3B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54218028;
	Fri, 18 Oct 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252699; cv=none; b=GEbnLvst88FGoPQV9hqaJ1ySHZOBiWy2xfkklwnHVc06h2+6A7YR6/OWpcNPz0DO0R5J/aKtjf22lWmeUEGZitrsaegdrnACIJjOJMkLJG4LfLwmHOI/nl5xB5QbsLBKeWTAjoFagbyRZ0dBbe3YNQMw6VP82K06h/Jd4ZqYp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252699; c=relaxed/simple;
	bh=V7l0PvQcRAyt31Veefu5777dqgXNHKMi1nxNw1VdZ0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8JeWHL24AsJbAxfZFroufdSHKSpVSgxaMdUInNxhm/YSfXRHKYgEqG3ES2FRSTvmLrsXKdFYSiZSIayUP0DwBEE4LLz6NxpwZsfar8wRZDwDCWw6u9Gx5OMLH9N48Z4bhDn/4YiOL/Rc7iprh1licYZihSBJ5ZzUJln3Wrv+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qIpl0s3B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.corp.microsoft.com (unknown [131.107.147.150])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3358220FE9B9;
	Fri, 18 Oct 2024 04:58:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3358220FE9B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729252698;
	bh=AgkvXZDH7v1BFpc7/7o0bMtbqPdIJtAQPe1CUK+wbLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIpl0s3BkG1bDpFcsFn13Y47VOv7Z+PlB8pvGEYmWW9Y5nYX5PXVHFrrIb6Glx6Bn
	 Gw4pKyIPeCW8Vgxyt1ja/50KioS0Hr6shaCJ3VUnSumATV54SQQlKzMPqeaP+YPVZn
	 vYHpYbWB5pr03/CYhlhR1lih/rexTpDgrsivsTJM=
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
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: Log on missing offers
Date: Fri, 18 Oct 2024 04:58:11 -0700
Message-Id: <20241018115811.5530-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018115811.5530-1-namjain@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
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

Signed-off-by: John Starks <jostarks@microsoft.com>
Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bd3fc41dc06b..1f56d138210e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
 
 static int vmbus_bus_resume(struct device *dev)
 {
+	struct vmbus_channel *channel;
 	struct vmbus_channel_msginfo *msginfo;
 	size_t msgsize;
 	int ret;
@@ -2494,6 +2495,21 @@ static int vmbus_bus_resume(struct device *dev)
 
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
+	}
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
 
-- 
2.34.1


