Return-Path: <linux-hyperv+bounces-3798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D236FA21E45
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 15:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F451883D24
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38713CFA6;
	Wed, 29 Jan 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkcE9Q3i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1C10A1F;
	Wed, 29 Jan 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159267; cv=none; b=FAfu5O8KLFwXBRph3STNAfRRQ0H9bOfdPrqBJBFysGrWHtNv4bwv3TtWf3YjPP9BOkPKoi00ZV7fvU8OufM6+aE7pEAI4xr3qteIGJUhsV/A0HNP1e9SrJKMLhssM0nVlkMAd+5k2INf5GxEdvWgU1ZDGE87bSnamlN/QdKDtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159267; c=relaxed/simple;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+37ligiLk1kRy8vdX9XDwvfGBdpx27XEMUvvzf3xxVfW8TBt6XbxZVK5PQgQ4jfQiHuzYoYF1fbxHucU/d6Btb9V9cmyZEe3BZxQXIR1T1Qi26NuONanfm72sJNbg4lm77I86/WlClm3OTOvIqOO3sKWoHbPutAKlhrhuv7Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkcE9Q3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D191DC4CED1;
	Wed, 29 Jan 2025 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159266;
	bh=of+qFZwyz1ljoL5PX10TFoOn09zYGwhGgo6csFa5igc=;
	h=From:To:Cc:Subject:Date:From;
	b=KkcE9Q3i2xfnWRQAadKA9RKLrt7egweYBBDaHZhhfmWgHUfbN0nU8Dte2U7z0p55Y
	 MCzeGJHpovDtmZrPZOM5qw14Ag5hYIgUMB722EZUoVqb+jWkVzY2oBG5rbBU9sIZ8W
	 xI/Vfy+owyo3YgC7e2qUsVhekR/6fEmGYx4+GhrGiT6IFDpTyHQ0sZ3NOiO2mQHBtV
	 PfBRT7FOpKcF6+hAMZRk5BR73kGa4/VujXdQs9ePaDcdcI3O5W0YhzjUmVapH8pRve
	 IIbzB4cuZRVXxcIbLOJvzFFk2JBAL5XhhJlyqO6ttbarW9OakQef9KXb2nrA2F2sFG
	 H16E7clbnl+wQ==
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
Subject: [PATCH AUTOSEL 6.13 1/4] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Wed, 29 Jan 2025 07:57:20 -0500
Message-Id: <20250129125724.1272534-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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


