Return-Path: <linux-hyperv+bounces-3465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67D9ED603
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FCE169D87
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C94232C98;
	Wed, 11 Dec 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YInbqZVb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C359232C93;
	Wed, 11 Dec 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943278; cv=none; b=SehfXDndkB5h42a+VJbXJG5ZFmzWS8lUw57IV0LcGSNI7OaHdOZFM4qp6NVm1sWQprwVE2CXEPkJmYK5S4SWi87cIwpVPBOFo+9FobHfFVd85i3YyP8T3qXHhSimyklLO7zbYIFAcwnv/tl1qJKN8XoJObrWbqtpxrNu10Pl+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943278; c=relaxed/simple;
	bh=jtt4dCSkbCQHfenEfCILr7iaPTs69XyDRsTmowY3//k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZL2Wwos3Q0X2wNLzY5dlrKBjIoUYOLix28L+Lpjhpk8MLnfzCPtP6OjF3fEND45CRXgd7RM+Tyv+RAg8+akq3LzfMFSKgHDBOaG396dNHGAKYpbAVaePSQW86TlJqvVEs0RYbsiIvzWKTlQXm2TMyRzzc3miXxwuY/dOAPvTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YInbqZVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3C8C4CED2;
	Wed, 11 Dec 2024 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943278;
	bh=jtt4dCSkbCQHfenEfCILr7iaPTs69XyDRsTmowY3//k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YInbqZVbxzrT/8AUJXlWP3TIjvTyCD/d5M/9iDSuKoyf3Oz8cUXOW0nOhngWyS78N
	 j6hMMPw8YWKYM8TT0faaGywEQETmGPRhdONtDdwIVc2IwvbTdcYbkgUAzKecYUQDcv
	 qO+vnHzmzwwMCbVWygHoAw7V8YLvewiPN6EbNn72nHIqKHbPIr/n1dOSM7rYHJ/68p
	 9+6h6aX/FtUEVcsOYRUV6zqbsMCgw39WyIXGyFXgZGmOQ4XgCj5yerbs60SiupBbrK
	 y5V/08vLL2uNvW+FKNkhFS/eak/7Zfk2ldg/GcMcG7wcoPK1HcyKF4j32GWi/upUlA
	 oWC0JrW8iXaBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cathy Avery <cavery@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/10] scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error
Date: Wed, 11 Dec 2024 13:54:15 -0500
Message-ID: <20241211185419.3843138-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185419.3843138-1-sashal@kernel.org>
References: <20241211185419.3843138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Cathy Avery <cavery@redhat.com>

[ Upstream commit b1aee7f034615b6824d2c70ddb37ef9fc23493b7 ]

This partially reverts commit 812fe6420a6e ("scsi: storvsc: Handle
additional SRB status values").

HyperV does not support MAINTENANCE_IN resulting in FC passthrough
returning the SRB_STATUS_DATA_OVERRUN value. Now that
SRB_STATUS_DATA_OVERRUN is treated as an error, multipath ALUA paths go
into a faulty state as multipath ALUA submits RTPG commands via
MAINTENANCE_IN.

[    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
[    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752

Make MAINTENANCE_IN return success to avoid the error path as is
currently done with INQUIRY and MODE_SENSE.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Cathy Avery <cavery@redhat.com>
Link: https://lore.kernel.org/r/20241127181324.3318443-1-cavery@redhat.com
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 37ad5f5256474..7dc916ce0c3c8 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -155,6 +155,8 @@ static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
 */
 static int vmstor_proto_version;
 
+static bool hv_dev_is_fc(struct hv_device *hv_dev);
+
 #define STORVSC_LOGGING_NONE	0
 #define STORVSC_LOGGING_ERROR	1
 #define STORVSC_LOGGING_WARN	2
@@ -1153,6 +1155,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
 	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
@@ -1160,7 +1163,9 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 */
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE)) {
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
+	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
-- 
2.43.0


