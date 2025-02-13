Return-Path: <linux-hyperv+bounces-3945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65CA350F5
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB6E16D729
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E9245B1B;
	Thu, 13 Feb 2025 22:10:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEBA206F15;
	Thu, 13 Feb 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484613; cv=none; b=f9LARJW3Zlombg5/NSuiZ9V6Nbm6kAxLxRG+KxOmFLIyLzm2VfCf5T1Jkcd0ZQUU9iWCH43kXTFCZpr9Lnc0IS9lDw+mu8nd18FEw+gQjiNu/IqTukIfIDFvDlZDv2LZ9zVo4CNWYxsSr/f1Nwmi4lMlIPppbH/2WlGBKAzwyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484613; c=relaxed/simple;
	bh=+Cx6uQi9DEuIA58SpFtAbOYBmigfXtiBak9bUVX3VRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c6N1lQDtICSjCNeXVHg2B/a9eVyeR/aLBgPo9dAFV41nrt6YC+HELLbZ3tVycoMcccIZ4CWVufCMMiTU7nLXjWLAOD9Aes44Wt3svMVNhdhYTxvZsK5WbIS9h3dQkUMXX9neW23w1s0gT1pNynQabF30s+YfwhDiUqrbhnSTCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 8E432203F3E6; Thu, 13 Feb 2025 14:10:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E432203F3E6
From: Long Li <longli@microsoft.com>
To: <stable@vger.kernel.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4.y] scsi: storvsc: Set correct data length for sending SCSI command without payload
Date: Thu, 13 Feb 2025 14:09:54 -0800
Message-Id: <1739484594-23512-1-git-send-email-longli@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <2025021055-utensil-raven-b270@gregkh>
References: <2025021055-utensil-raven-b270@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In StorVSC, payload->range.len is used to indicate if this SCSI command
carries payload. This data is allocated as part of the private driver data
by the upper layer and may get passed to lower driver uninitialized.

For example, the SCSI error handling mid layer may send TEST_UNIT_READY or
REQUEST_SENSE while reusing the buffer from a failed command. The private
data section may have stale data from the previous command.

If the SCSI command doesn't carry payload, the driver may use this value as
is for communicating with host, resulting in possible corruption.

Fix this by always initializing this value.

Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
Cc: stable@kernel.org
Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://lore.kernel.org/r/1737601642-7759-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
(cherry picked from commit 87c4b5e8a6b65189abd9ea5010ab308941f964a4)
---
 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 44f4e10..ffba2c3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1639,6 +1639,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
 	payload_sz = sizeof(cmd_request->mpb);
+	payload->range.len = 0;
 
 	if (sg_count) {
 		if (sg_count > MAX_PAGE_BUFFER_COUNT) {
-- 
1.8.3.1


