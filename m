Return-Path: <linux-hyperv+bounces-3799-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A186A21E53
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C891889058
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D61195980;
	Wed, 29 Jan 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/x1loR8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A8152160;
	Wed, 29 Jan 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159284; cv=none; b=HRSOXG4WIJLtJ4LT8Q//ldgux8Ua+l3CdD1t0gDfnvT1TvtTOX9yQ6Vm1Z1HK6MGZtp6ba9WVHyvrp0l5Htio+KnWieDp5apJTa+vUpADy9p3nWGnt7SBuXa2aGthaW3sx0e9FrcVNt0/ItPpe1mtYgpF6iNTlgODQBbd+DTVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159284; c=relaxed/simple;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5qG2KGTeIYI7zuBDNNKfoxotANVmpG55aq+O3E7XyyZWgzN1U07AhGFnbHd0ASeFo4VBDMQ712nTcuRgENoKl462Jg0cqCmaI67o5PMtDDTQcS/f1u8TD414KqD1nmw6zG6oqbzkt0oR0gIiF1FlEbSx2Gxok6NQ7hwl92S3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/x1loR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5E9C4CED1;
	Wed, 29 Jan 2025 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159283;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:From;
	b=F/x1loR8qon5Juj/4WYr2kH9hZkvzcQkGFW+XiZM5HYK33MZNqDgUbRKBplvFsDpY
	 PgbLFAWt8RQbdL+r34hvCcLF45MP+g/ADiPuup+E78lW7RjBsYmU3JJLSRTQHdMphp
	 dsB0GSyiMlJON4qzu91AwmaJR2TNTlbkNmmooVV9w21N67A1x7HcdPzGbN3ve0NLVm
	 oBsHrrW3lo9dCOoOJDlzjteU2XJYnQtn6c7OWbIO+SCeaAycIqyO/5ILpOfJOE48+h
	 PX5tD0K8pTJJvxHy/fDl3Iz0bBrYg4xYweKx/+fVdXt8Yu4pR9H3dq4oB3i9jv133r
	 1PWTwTeLwqudQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 1/4] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Wed, 29 Jan 2025 07:57:38 -0500
Message-Id: <20250129125741.1272609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <eahariha@linux.microsoft.com>

[ Upstream commit d2138eab8cde61e0e6f62d0713e45202e8457d6d ]

If there's a persistent error in the hypervisor, the SCSI warning for
failed I/O can flood the kernel log and max out CPU utilization,
preventing troubleshooting from the VM side. Ratelimit the warning so
it doesn't DoS the VM.

Closes: https://github.com/microsoft/WSL/issues/9173
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d0b55c1fa908a..b3c588b102d90 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -171,6 +171,12 @@ do {								\
 		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
+do {										\
+	if (do_logging(level))							\
+		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 struct vmscsi_request {
 	u16 length;
 	u8 srb_status;
@@ -1177,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
-- 
2.39.5


