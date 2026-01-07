Return-Path: <linux-hyperv+bounces-8175-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668BCFFF08
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 21:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A443630DC30C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED051DED4C;
	Wed,  7 Jan 2026 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aHcRHot4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20F212F5A5;
	Wed,  7 Jan 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815833; cv=none; b=LLtGvSziD2bfLdrciQFCx2Cd/YgSOF2x35WMrDs0juTFMhiSqFUD6+H2T9yE+m/59z5FH27W1zA+Z/BYGZdrJ2w2ZRbp6PTLzUosYat7N5ZKeNidDN76yEaPkLvJA7+MySz7VzomrnkUgZRDiTjBhhay6jK5alnwb3fYxCVAWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815833; c=relaxed/simple;
	bh=ASsd+pspub8cgMHq1IjbneKTcraE7xQvxuYHVFTSN5c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fArkwch2WoklMcnoiP0QzHtEQ7SITEmqpl51+nAnZ4KYinwtnY1z0rLVHV3c9ZL8tHBeTbCp3ls9fMga6EYHUuvM8/id6oBgxhE3mDC/BqcvyEkMAR2G8fZAujCOvslSawLQOiNKfZKRflwzZAFe2ng1c6v0nsHXqvJ9eQbGmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aHcRHot4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 454F8212688B; Wed,  7 Jan 2026 11:57:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 454F8212688B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767815831;
	bh=1vUE6y/ezNfMdTpjWsRWs17aeuMCUUsyQ5gMTO1daA4=;
	h=From:To:Cc:Subject:Date:From;
	b=aHcRHot4vVlBVWmh2lhuVi1mMh2Q247AQOeEhADv3zbjpIzbl8/j6XJ5O8Vs+W16z
	 f9yiLCOnwuKLKHISPVOOk4WLMrP5ma4SMcCxlLYraGnHCLrkK7wWS+n0t+HITQsK3x
	 TyxR3WRc8HdCPx52jM2y+1gIZqrScAOoEygjmPC8=
From: longli@linux.microsoft.com
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
Subject: [PATCH] scsi: storvsc: Process unsupported MODE_SENSE_10
Date: Wed,  7 Jan 2026 11:56:43 -0800
Message-Id: <1767815803-3747-1-git-send-email-longli@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

The Hyper-V host does not support MODE_SENSE_10 and MODE_SENSE.
The driver handles MODE_SENSE as unsupported command, but not for
MODE_SENSE_10. Add MODE_SENSE_10 to the same handling logic and
return correct code to SCSI layer.

Fixes: 89ae7d709357 ("Staging: hv: storvsc: Move the storage driver out of the staging area")
Cc: stable@kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6e4112143c76..9b15784e2d64 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1154,6 +1154,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
 	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE_10) ||
 	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
 	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
-- 
2.34.1


