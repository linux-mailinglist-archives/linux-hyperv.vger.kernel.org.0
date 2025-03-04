Return-Path: <linux-hyperv+bounces-4200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28744A4CFB2
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E773D7A6F76
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547433C9;
	Tue,  4 Mar 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lnoXGO27"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275628F4;
	Tue,  4 Mar 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046984; cv=none; b=JmLgN2PRFGS7XdyfG2+km/vGv3PKzJo1c7QTb//60RtqCygUgF9URGgY8SptzuIxeVyOU2LNaCCLl9b20lR2lSx5ilXEd4opsg40G9UgSUOxxbKGj6RxXmmu2ZCFHnbjp4Cod4gEqa8WnBGIHfdoCuYE162bfY+inljU9NwB2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046984; c=relaxed/simple;
	bh=8QTX0gSTcUhFewuiZj/6AB6PoOE/TdhC/NsZANgtDsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXhutcVn6HpK8WuLNtCitIoty7qHKUrGaW1u4sbXL4ahoIy6BexXQA07XE3FY7vTpt+m1uUiA9qZmGq+fG6F4FpxfX7LZCm4PT0H/GM6ygWdW92IeMGvWN9Qsu02Fhcka0XA3sU0kPyYYp91fQWwf/JZZm0DcyeqQk3IZRXzap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lnoXGO27; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F81F2110499;
	Mon,  3 Mar 2025 16:09:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F81F2110499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741046982;
	bh=wKyL8JEg7oY2WkvOaVvvBUT+gAUjHPmQCOIZqydTSq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnoXGO27ng0PwYk+yFV08K1fTS4bNhSC1XthXWzebLKWXY0nFsCA2dpMUVmQKH0vo
	 VlwrasqA8aD2eEVMWs4nob8oG/I014MwB9GYptttpTwD+dVuBfmoomr88mhojRN3QO
	 KBzJt6AbSLmMKYhSpxCMX/DM6hMyb/hCOf3xSoRY=
From: Roman Kisel <romank@linux.microsoft.com>
To: eahariha@linux.microsoft.com,
	mhklinux@outlook.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 1/1] scsi: storvsc: Don't report the host packet status as the hv status
Date: Mon,  3 Mar 2025 16:09:40 -0800
Message-ID: <20250304000940.9557-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304000940.9557-1-romank@linux.microsoft.com>
References: <20250304000940.9557-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The log statement reports the packet status code as the hv
status code which causes confusion when debugging as "hv"
might refer to a hypervisor, and sometimes to the host part
of the Hyper-V virtualization stack.

Fix the name of the datum being logged to clearly indicate
the component reporting the error. Also log it in hexadecimal
everywhere for consistency.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a8614e54544e..35db061ae3ec 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -776,7 +776,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 
 	if (vstor_packet->operation != VSTOR_OPERATION_COMPLETE_IO ||
 	    vstor_packet->status != 0) {
-		dev_err(dev, "Failed to create sub-channel: op=%d, sts=%d\n",
+		dev_err(dev, "Failed to create sub-channel: op=%d, host=0x%x\n",
 			vstor_packet->operation, vstor_packet->status);
 		return;
 	}
@@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
 		storvsc_log_ratelimited(device, loglevel,
-			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
+			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x host 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
 			vstor_packet->vm_srb.scsi_status,
-- 
2.43.0


