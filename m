Return-Path: <linux-hyperv+bounces-3801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC191A21E65
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 15:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DDA3A85D2
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC61D63CC;
	Wed, 29 Jan 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs+3WGA7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FE1D5AAD;
	Wed, 29 Jan 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159316; cv=none; b=t4+MuoS+GEZTqJ0q6RCubYBckqfUEovz8Q15DAtBMKey0p7afalkRsS7TVr6R+z8h/H4cNwvXxUq5kM+ZD+PRUC6/iaOcS24gXXP/4KR6yNLzW6W3jcgdSzhCT7kSu5SbAz5K4C64gZQl/lIQ4AS19dpBsxKmbGAx9efdhVpEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159316; c=relaxed/simple;
	bh=voIWkLBDBCXJbEggRp5QU5TuAA5XCbOQwieDiSZ+jN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1yqCLsR8SrCwo0vcJdcNmJicZvci1CPeofjrPhVZVz3eRld28/tEf65kYBcTnfvtOLsU4+FUkFN5bzOsAKTPQj4dX0tOmgmI07Tkx8EkC41NT6nQrthrAefCpgXZNTAnK1LBn1EM0yq4lwhoMHYLZ3SpQx8oNyhm/WY5wT6Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs+3WGA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D98C4CEE1;
	Wed, 29 Jan 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159316;
	bh=voIWkLBDBCXJbEggRp5QU5TuAA5XCbOQwieDiSZ+jN8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qs+3WGA74YxkERrrBNt4i34W5uXp4krjrQ0Fg1PQC3Qeoy0nEjKM1LMnoXFsi73C4
	 3h3EQdl/bVi6EgKaMwc/9c8/KqJvtgHf9A/8G8hWAjsbpO6erDzz0wTwNlQyZgqzSq
	 tssrfznxpUdvnnQoNwTzP8nQvgL67vW6HwvI2Y+aRKuU79oKaSKbN3BGkWFPp+hbDT
	 Cw1e0CLy2rjj14bCr5vbQb+eaffpkYIsqjhramHo7xUA+AGDrMiyKGfeJAor7nysde
	 UlIczM3Q0CfWWNiV3DxbO4K+5EB7/AlK0Bmt90I2LHXj8Z4Mgd3bagRtol/LFIrUHO
	 bAGqQ6ZzrEx7A==
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
Subject: [PATCH AUTOSEL 6.1 1/4] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Wed, 29 Jan 2025 07:58:10 -0500
Message-Id: <20250129125813.1272819-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 0685cbe7f0eba..d47adab00f04a 100644
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
@@ -1168,7 +1174,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		int loglevel = (stor_pkt->vm_srb.cdb[0] == TEST_UNIT_READY) ?
 			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
 
-		storvsc_log(device, loglevel,
+		storvsc_log_ratelimited(device, loglevel,
 			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
 			scsi_cmd_to_rq(request->cmd)->tag,
 			stor_pkt->vm_srb.cdb[0],
-- 
2.39.5


