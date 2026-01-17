Return-Path: <linux-hyperv+bounces-8354-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0509D38B01
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 02:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5629C302D2F7
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F319ABD8;
	Sat, 17 Jan 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aIYVVZc5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186B197A7D;
	Sat, 17 Jan 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768611788; cv=none; b=iNpKo6/pz8A3a15YyIsWymMp6INQGXmL+2DzhRcao/1GELFjVia2rH2GGTodHYW2MG9ihAyw3WFSVWS65l4xYeVejyU5CEXpfknop4PKyM5Yi3zRNYa17qdKdossGf4c8YQYsFzyWZpSE3TgrLQQhhRvDsXviLmEKrHb3IWIuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768611788; c=relaxed/simple;
	bh=qYlIIrBPIEP3E4116vVkrPhNjNlBFTYSNovWxMKH+No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLkzZQCJ6WScoTDEbvBC5j4Aai3csKnOQ4Kt7zWJYkxsqTidAYx1dICxS0Hw2LuU6mXMWhHCW53oM2Vi8SzbeaWXu1LyJIw5+1nWNLspN1fyc76vdySpva3V31ZUlNv2abBi78/uarbCaBD2kSRvaMX6/cyB/cRbl0nW/QwbF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aIYVVZc5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9B9B820B7165; Fri, 16 Jan 2026 17:03:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B9B820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768611786;
	bh=0HtMix7iilBBIm8yk2pxbjvrH2AoOEvPD6oAREMdMv4=;
	h=From:To:Cc:Subject:Date:From;
	b=aIYVVZc5fZBszJ7Myu/oAjHNmkLvtpDxOodeYuu9NU41MYU1IqjeqMvS7dp8UBxHz
	 Z+LUpnRTIlWIB4WRaHuTAbN4VCt7N9EF1YRQbens02XPMbuLBvMehj2wnn4BAbJbYu
	 yRNl/h7qoGuW7V5E7bItEM25L/VzyMab/2mY0dQ8=
From: longli@linux.microsoft.com
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <JBottomley@Odin.com>,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [Patch v2] scsi: storvsc: Process unsupported MODE_SENSE_10
Date: Fri, 16 Jan 2026 17:03:02 -0800
Message-ID: <20260117010302.294068-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

The Hyper-V host does not support MODE_SENSE_10 and MODE_SENSE.
The driver handles MODE_SENSE as unsupported command, but not for
MODE_SENSE_10. Add MODE_SENSE_10 to the same handling logic and
return correct code to SCSI layer.

Fixes: 89ae7d709357 ("Staging: hv: storvsc: Move the storage driver out of the staging area")
Cc: stable@kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Change in v2:
Added MODE_SENSE_10 to the code comment

 drivers/scsi/storvsc_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6e4112143c76..b43d876747b7 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1144,7 +1144,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 * The current SCSI handling on the host side does
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
-	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] == 0x1c
 	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
@@ -1154,6 +1154,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
 	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE_10) ||
 	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
 	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
-- 
2.34.1


