Return-Path: <linux-hyperv+bounces-3346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E19D6233
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FD61606EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122881DE3A8;
	Fri, 22 Nov 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXT+XwL/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596F1ABEB0
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Nov 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292646; cv=none; b=KSe3IC2TBdtemJ6oQZsGpGhmh6irmR9we/leJctJ1SgX816TZdJNCeclEmrl6uSRxVFi+0HcwYPLbuCRk274NTTvRQejCW4uvNgKDS97XZAWB5+F4y3YVoau8JeJwH+9ZfGoQ4xnkHCE4D6wQy/HUxG9bUAuo/Iv8mUfxZ1pUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292646; c=relaxed/simple;
	bh=am5gMCEqcAHadTbeKZXEyvDZpg5BK1pJn6k52uyAhRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeHe8GwdYgAr0wC0HtklkQfzcea0uE/MzOwfprKeq3cnBF5ppfR9+Dhkuk4h03WEPoAixJ9E5Hsfa24WJwaZZzTViu5dtTn4HgXNDH3zPNbY0zYCaN/iNLzmebfm/X/FQXDh6OuSMsSFQjVCQFmpnxxe/9qqNkWy/q3k6K1QK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXT+XwL/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aXnxx3B2tcp5cdKACkOG+bj26AqLlAOFj+Nndy4Prnk=;
	b=cXT+XwL/CNBqsgIRAE+8cxbI3BVrHwIikC/NpN1flU/hU6jSScCZ/VU6zvBEogimi/6+wA
	BVPtH/HOUqg3FXb0RpOJRWKOJGYKUpa9BkOPTnMDbZXWugAGN4GjLu89BHwPb4PIPIw7et
	YUV978IPD6mdG/rM6i1herhh8afgf3M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-0W0asaY-MVSAnxicHEH49A-1; Fri,
 22 Nov 2024 11:24:00 -0500
X-MC-Unique: 0W0asaY-MVSAnxicHEH49A-1
X-Mimecast-MFC-AGG-ID: 0W0asaY-MVSAnxicHEH49A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D8591979204;
	Fri, 22 Nov 2024 16:23:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E8281955F49;
	Fri, 22 Nov 2024 16:23:55 +0000 (UTC)
From: Cathy Avery <cavery@redhat.com>
To: kys@microsoft.com,
	martin.petersen@oracle.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	jejb@linux.ibm.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: bhull@redhat.com,
	emilne@redhat.com,
	loberman@redhat.com
Subject: [PATCH] scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error
Date: Fri, 22 Nov 2024 11:23:55 -0500
Message-ID: <20241122162355.2859481-1-cavery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch partially reverts

	commit 812fe6420a6e789db68f18cdb25c5c89f4561334
	Author: Michael Kelley <mikelley@microsoft.com>
	Date:   Fri Aug 25 10:21:24 2023 -0700

	scsi: storvsc: Handle additional SRB status values

HyperV does not support MAINTENANCE_IN resulting in FC passthrough
returning the SRB_STATUS_DATA_OVERRUN value. Now that SRB_STATUS_DATA_OVERRUN
is treated as an error multipath ALUA paths go into a faulty state as multipath
ALUA submits RTPG commands via MAINTENANCE_IN.

[    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
[    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752

This patch essentially restores the previous handling of MAINTENANCE_IN
along with supressing any logging noise.

Signed-off-by: Cathy Avery <cavery@redhat.com>
---
 drivers/scsi/storvsc_drv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..088fefe40999 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
 */
 static int vmstor_proto_version;
 
+static bool hv_dev_is_fc(struct hv_device *hv_dev);
+
 #define STORVSC_LOGGING_NONE	0
 #define STORVSC_LOGGING_ERROR	1
 #define STORVSC_LOGGING_WARN	2
@@ -980,6 +982,13 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	void (*process_err_fn)(struct work_struct *work);
 	struct hv_host_device *host_dev = shost_priv(host);
 
+	// HyperV FC does not support MAINTENANCE_IN ignore
+	if ((scmnd->cmnd[0] == MAINTENANCE_IN) &&
+		(SRB_STATUS(vm_srb->srb_status) == SRB_STATUS_DATA_OVERRUN) &&
+		hv_dev_is_fc(host_dev->dev)) {
+		return;
+	}
+
 	switch (SRB_STATUS(vm_srb->srb_status)) {
 	case SRB_STATUS_ERROR:
 	case SRB_STATUS_ABORTED:
@@ -1161,6 +1170,12 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	stor_pkt->vm_srb.sense_info_length = min_t(u8, STORVSC_SENSE_BUFFER_SIZE,
 		vstor_packet->vm_srb.sense_info_length);
 
+	// HyperV FC does not support MAINTENANCE_IN ignore
+	if ((SRB_STATUS(vstor_packet->vm_srb.srb_status) == SRB_STATUS_DATA_OVERRUN) &&
+		(stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN) &&
+		hv_dev_is_fc(device))
+		goto skip_logging;
+
 	if (vstor_packet->vm_srb.scsi_status != 0 ||
 	    vstor_packet->vm_srb.srb_status != SRB_STATUS_SUCCESS) {
 
@@ -1181,6 +1196,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 			vstor_packet->status);
 	}
 
+skip_logging:
 	if (vstor_packet->vm_srb.scsi_status == SAM_STAT_CHECK_CONDITION &&
 	    (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID))
 		memcpy(request->cmd->sense_buffer,
-- 
2.42.0


