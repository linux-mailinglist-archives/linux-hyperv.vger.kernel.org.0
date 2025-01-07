Return-Path: <linux-hyperv+bounces-3596-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA93A0484A
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 18:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56B33A6667
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922E1F63CB;
	Tue,  7 Jan 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O/bl6gzR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6FD1F429A;
	Tue,  7 Jan 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270936; cv=none; b=ou3nBpPWZ2na4OASOD9l0fO7gMehxd4fDPkreRzQilqSw7IFajaBDK9ic3ZosahAsGhG8/KXeoJCOgVlj+oRRaS4VcNgj3LPcE7HioDGkyfh6IFsqUZfuypgXyZpsLkBI55/NJWEEwvSCa03BMsynCzJjNc8QO8d49tu+5aZOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270936; c=relaxed/simple;
	bh=TisQnCmmSL0Nfk54fDb9nFoo1EhZB2GRxYFF9PdNH/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o1rkgeKhNJPIW208wUgGIvwJQnjEqfGPbFlmdpFVOBbRDKfeitHn2ueVun1D3/eL8SomPK37lBjHjVFt2zj8tEoLZ/wngVa1ZxR/YmnOsUI8FbAovV4fnX8vAk8xQ1Jh4DI3TbY/YHp8C1X+bmDSyR+oWwxkpv0jZaJWUEHHdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O/bl6gzR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id E6D8E206AB9F;
	Tue,  7 Jan 2025 09:28:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6D8E206AB9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736270935;
	bh=6I+kWiGEEYc47l6CYP9wmZuo3hMSP2dj+LxZQBdvPaE=;
	h=From:Date:Subject:To:Cc:From;
	b=O/bl6gzRhfW5wPtxlsVm/wXqymoD+uPkJ6TMZw6QNIXGHHZdKWtsyAGkEheew8Swi
	 cJsvWMqo8AFDx1koQaR28qefA0recAj01LoEqqLa4V3r/yVqJYk4UKTngQh583poi2
	 n2eT9fvgek1xzu4cV938dJInqPiOJTdL7jSlz344=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 07 Jan 2025 17:28:40 +0000
Subject: [PATCH] scsi: storvsc: Ratelimit warning logs to prevent VM denial
 of service
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com>
X-B4-Tracking: v=1; b=H4sIAEdkfWcC/x3MwQqDMAwA0F+RnBeorcLwV2SHzKVrYGslKSKI/
 27x+C7vAGMVNpi6A5Q3MSm5oX90sCTKX0b5NIN3fuidD8iUSCURKlX+yV8qWi262YLvEHkM0Xk
 an9CCVTnKfufz6zwvAhRLeGwAAAA=
X-Change-ID: 20241023-eahariha-ratelimit-storvsc-b3fe53f02a58
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@linux.microsoft.com>, 
 Long Li <longli@microsoft.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mitchell Levy <levymitchell0@gmail.com>, 
 Mitchell Levy <mitchelllevy@linux.microsoft.com>, 
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vijay Balakrishna <vijayb@linux.microsoft.com>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

If there's a persistent error in the hypervisor, the scsi warning for
failed IO can flood the kernel log and max out CPU utilization,
preventing troubleshooting from the VM side. Ratelimit the warning so
it doesn't DOS the VM.

Closes: https://github.com/microsoft/WSL/issues/9173
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
If there's a persistent error in the hypervisor, the scsi warning for
failed IO can overwhelm the kernel log and max out CPU utilization,
preventing troubleshooting. Ratelimit the warning so it doesn't DOS the
VM.

This is not super critical and can be deferred to an 6.14 rc since it
mostly occurs when there's a problem with the host disk or filesystem.
---
 drivers/scsi/storvsc_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 45665d4aca925a10ce4293edf40cebdc4d4997f2..5a101ac06c478aad9b01072e7a6c5af48219f5c8 100644
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
@@ -1176,7 +1182,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],

---
base-commit: 4e16367cfe0ce395f29d0482b78970cce8e1db73
change-id: 20241023-eahariha-ratelimit-storvsc-b3fe53f02a58

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>


