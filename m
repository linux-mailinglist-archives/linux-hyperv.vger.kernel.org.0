Return-Path: <linux-hyperv+bounces-4151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B05A48CCD
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 00:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E273A6626
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579BD1BD9D0;
	Thu, 27 Feb 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RMvSoDI4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042B276D1C;
	Thu, 27 Feb 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699074; cv=none; b=iSG4evlV3tVxHyEJgwj0alHJoA4tGdtzcVGYnTtCN3dSR0ftriBrqkelIGCnr1fQiJwLmnyJyhwSjk4p4/tX3ek+8zs7n5nurdM5jfK1pyxaz86Q/a36G6VUxbtXGH5PyEKXnxreKD8sbD8uq8DqVzCxDMgXC8xVl0IBRiVzVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699074; c=relaxed/simple;
	bh=Ox2k/er+A/bOimdXt/szjkoTmJr8XmSSxQ89pyfQ3dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd5s+5S7TpZB0sBE5yO4tjsb0S3CYjIfCGNV6mxkQPP2qLLvZdKAvDHD4bf2fp7vwjH5PLupXAnT3oVFo5CgkW4odLNQMwbq80gii+HUkR27RBHE2MdqXXTQ78T+osU+oXWu8mrN3jIjMYiX+jaWKv7sROT1fX+q7w2p7yIY6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RMvSoDI4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71E8D210D0F2;
	Thu, 27 Feb 2025 15:31:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71E8D210D0F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740699072;
	bh=p09IWZVM4LGvEIF0LtvyW3RczsHretpcUKg5KuZbxiE=;
	h=From:To:Cc:Subject:Date:From;
	b=RMvSoDI4FyOJVx+8H0CuR6b3QrW4i98WNg4iFvs81loWo+H3kc3rlk6TCRAL9elRH
	 wSY5cB7twYCPYSS/m4p35rtBeth09DfwUQ8PScFykoJsBlZTQ00TxOglcaH5JnIbjz
	 CWtxOyfqV32mzU2qJZFrIfxR22fh8sA6Q6V724JY=
From: Roman Kisel <romank@linux.microsoft.com>
To: kys@microsoft.com,
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
Subject: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status the hypercall status
Date: Thu, 27 Feb 2025 15:31:10 -0800
Message-ID: <20250227233110.36596-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The log statement reports the packet status code as the hypercall
status code which causes confusion when debugging.

Fix the name of the datum being logged.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a8614e54544e..d7ec79536d9a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
 		storvsc_log_ratelimited(device, loglevel,
-			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
+			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x sts 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
 			vstor_packet->vm_srb.scsi_status,
-- 
2.43.0


