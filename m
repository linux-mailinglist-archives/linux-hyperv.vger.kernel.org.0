Return-Path: <linux-hyperv+bounces-3750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E95A19D1A
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07DD16BE46
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2BC35977;
	Thu, 23 Jan 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="DVEsxe0e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5C2557A;
	Thu, 23 Jan 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737601654; cv=none; b=RA/PCDYIh/CfzFZtQA4bY3v3csfF8HK4JiNWjJxPHU22o0TkITBY6lhMiZk0nW+6IIZZuBV1ESLhXOQA2/fJslgKj6gAGiXa/dOOS6271mlanP4eqS3SkzsfAkArmvxobsF5mpZa50K/ox6+95vtoArCSEnuJM+nKNso0s1dlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737601654; c=relaxed/simple;
	bh=OvoCBjZNTkaJuuLgBQpQFFGOf/r86dQuhOGXgSD6iQ8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nelCFWyq3m4+f87ep3tZOs+2qqVXVfww440j3KVtoWFsHbppz/6/CFFhiJhPRtDSyYD88Z7Lv+O4RWvrlf7aRPZMwOK3skejpv3g5jspHQsy0vgte5SFKaoLE4AVE467a0En0LpJXMMSG7+r1JYbmBDZSppD3s5BMg2zDiJPet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=DVEsxe0e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9DD20204608E; Wed, 22 Jan 2025 19:07:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DD20204608E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1737601652;
	bh=RjsbqRKCF3hkKQf6YCNsA2AG4JI4CgdM2+DuCL2A04c=;
	h=From:To:Cc:Subject:Date:From;
	b=DVEsxe0eMs8JdY4nLsZDXHB2NkgG51dDxke9lY+Sy22/ejmXWZb2C4hTcuNANTyQI
	 5qMdT9KdX1zVBWlayW0JaovQo/+qKwp8zUXiDfHzntjcY7uVkk+97vK2+vh/vN212W
	 gpbHtbHAwcFw+Rq/tTsHqQQXXj+JF+3um0DflQAE=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <JBottomley@Odin.com>,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>,
	stable@kernel.org
Subject: [PATCH v2] scsi: storvsc: Set correct data length for sending SCSI command without payload
Date: Wed, 22 Jan 2025 19:07:22 -0800
Message-Id: <1737601642-7759-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

In StorVSC, payload->range.len is used to indicate if this SCSI command
carries payload. This data is allocated as part of the private driver
data by the upper layer and may get passed to lower driver uninitialized.

For example, the SCSI error handling mid layer may send TEST_UNIT_READY
or REQUEST_SENSE while reusing the buffer from a failed command. The
private data section may have stale data from the previous command.

If the SCSI command doesn't carry payload, the driver may use this value as
is for communicating with host, resulting in possible corruption.

Fix this by always initializing this value.

Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
Cc: stable@kernel.org
Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Long Li <longli@microsoft.com>

---

Changes:
v2: add details in comment section explaining why there might be uninitialized data in driver private section

 drivers/scsi/storvsc_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..ca5e5c0aeabf 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1789,6 +1789,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
+	payload->range.len = 0;
 	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
-- 
2.43.0


