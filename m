Return-Path: <linux-hyperv+bounces-3705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC28A146E0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BFB16BBC5
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344213B2A9;
	Fri, 17 Jan 2025 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ChLcA5uT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240341DC9BF;
	Fri, 17 Jan 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072015; cv=none; b=WgJXtCt3xhmuwUQCOPjZ3EW27GItIc3ka4mZT56SkoGhJxBf3v8Nx9uNGbq8qwaulw03hk55vTVj4GPL++8Qab8/j5ybRdAI306Gc3IqVjBKZ8BW0iPuSsEJD8CozFp9cAHe6uI4Ay9uGeV6etQ1KL/20J/W+L9Vbr4HZzHezkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072015; c=relaxed/simple;
	bh=bumM6SHdKIfRqq0jgQzzgk+FqG20uDhaorghaG3gjtM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PajkXuTGignkwSkT2aQjpnGZSllXrqR9nY/XXWrjyERRLME1+ZoW7dwYurPYacTAEt+HbtPGkY2yrSm/39PYnPs/rRoSNnrRgZJiPkzuggNQzw2Gctp+h+YDavnvwXX6YOE1ln5V4UppUDb+PN5TVwzXvmWOuFnmRcpbMGv7WMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ChLcA5uT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 625FC20591A6; Thu, 16 Jan 2025 16:00:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 625FC20591A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1737072013;
	bh=Suo+WpdGCkX7MsFAoak0w+IQ7n7KHDwbjKCC7FAckuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ChLcA5uTh6FVkeX8QBohCv6zIKu2+9ZreZ2ayd+Uum4EjcgHq1rYdNCCB9ceMAvwl
	 /JZOYuKc/yqN5coKZZSBbs9oc8jYk1Th9oxDiciYM+Mm++dSeSpODdHhbUsk7OY5J+
	 OP9S+ku0JbXA7i8ox2iDSX4fyYrAS9KvPz71xai0=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <JBottomley@Odin.com>,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@kernel.org
Subject: [PATCH] scsi: storvsc: Set correct data length for sending SCSI command without payload
Date: Thu, 16 Jan 2025 15:59:58 -0800
Message-Id: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

In StorVSC, payload->range.len is used to indicate if this SCSI command
carries payload. This data is allocated as part of the private driver
data by the upper layer and may get passed to lower driver uninitialized.

If a SCSI command doesn't carry payload, the driver may use this value as
is for communicating with host, resulting in possible corruption.

Fix this by always initializing this value.

Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
Cc: stable@kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..ca5e5c0aeabf 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1789,6 +1789,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
+	payload->range.len = 0;
 	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
-- 
2.43.0


