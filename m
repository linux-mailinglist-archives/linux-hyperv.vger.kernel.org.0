Return-Path: <linux-hyperv+bounces-10075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOzoBRUF1mkbAwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10075-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 09:34:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC93B85A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 09:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8D24302080A
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B829992A;
	Wed,  8 Apr 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfeVMJoV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80D352C5B
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Apr 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633474; cv=none; b=Oj92rFmH7S6uVfu1NUIwvehwmIE4FCwE62mh7STEhT8nQ27FKlAz+Fuhj2eZVxeGJr+0fKiOXVGEjPpvd0ucKZrfw6l1Ezz3utS0xlb6VdcKfp908v1ENYNvYaWSZHJpXtcNcC5w4g+Mu/BsYLCXpHq9r3Tw264hmZTsfCHHGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633474; c=relaxed/simple;
	bh=ytB53dNuSiSNA7KpLGzUUg37w5+LYWgYBJoL01WyyRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RiVQFd3hg3KVAJAH35KltzXSiLq64GhPqhCjWR8x3cMsq1srv2xBoRq3npBUy4ZL4xQ8fAdyiLubpdv91soKp4ZqyWs7uBlKkvGKBdpXicqNowDXzd47V9u2yt/pPea0P/u0tyz2h8fZNFcmDCYcUIJh9QCamQ4kt8aNjlbT1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfeVMJoV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so6378818a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Apr 2026 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775633473; x=1776238273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlstBpIKOzxoAPZSb6mPVzZ0DWzq15OlHmrRs8yLD0g=;
        b=FfeVMJoVmXRXMd10eUsz9UGYLuRl6HB/Tzs+JPJUXLpoQHQToZ/0RrLoslvTL7SbD6
         dzp8nivx7L0qElkCJOEFtNYGZ/t9Om+B/hBE0dcq+Ip9tRN36WcX1oGwiAV1+b9l9x7P
         fF1QVrxD/QYlhHvAtLzUZ/B/LSh8dmf6DFSWWtTH/L5BzTeD99Ycb5EnvvWyFNbdLt5D
         tg10V9FrYTY+kBhWs7Q2hz284hUfxJzqZQX0O06yqouFSe8rfSYndI4ZkzsR88P61LSp
         5KFbaKyQrauKTfxl43/ZoAZNaHOi6iAEN4wGbEx7ioBxldhkpX9uA6LGFMsTL2deInN2
         /U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633473; x=1776238273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlstBpIKOzxoAPZSb6mPVzZ0DWzq15OlHmrRs8yLD0g=;
        b=gb7W1kL6skeYNPoh49aADrF438Ftzse2VeqxyG+JgAWaeylF7e85JpBJZ26zAiUDa8
         OMoNcjr/PCmPQR+hx3rnTSmsbKJh1a68z91U612ScSkg6VF1aOc/vLMSOLFa3QKxU912
         ziteRmS3by/BvUSyzePAGXAuZja/rxo9cqTy7zGB4YcKxvuxfX2Pun55tCprgBLWvH3N
         iIUipkpP2mHm13S1KQI/ARV4l37c1Be0jHjTR3GGE3OQXrinAop9OyYFGTBZnbbpXllY
         HTojK08hI7/Tr3puon14zwgZ5mudehFogNZ9P2Ly6hwU+T57x9OD0ojxNFARKRBXGt7w
         d0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVmBWQwIKVUnge9i+UYo0/LaRgfSGlYYppEChwXPhoBGEgLs69odO9oxqlE9OBj3shzLNse4LIpdG4ZY1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFclCJMA5uRru2CxX+YTVpee0oEYjtYbRvLoSu7gXR400t9Bvd
	zzUehqzYfsLfKcVaYfOreX2BSd0k6YzGKdwb9ModVRh836ytIQSXhLwX3NWbrg==
X-Gm-Gg: AeBDiev4QIjjdG9U9jVw2IFzGPeoSUimvWXH6TnNgRKi7tLutbW3dfqlRrF3IDsnqow
	OdTA1uJ7OCI0hb9kLsXJZ3ENWQtdqxFPk0szwiO4oTGsZvokPoZsDH8Kd7u6Ge8YgEGed8EI1Av
	Su1mRau7WxCsUc2smdIr5FI66Jv2XXrrFFHY35aDvtozj2GP60elYCB4BZ7ysORMVG7gDM1u06k
	/ZhcHokpyFGE9tBxbK2SBQ+PNdveEK5GUn1Ct5ewwOEg8OGfsuyDWYR9vlEYqnzkMui0tqsNEX2
	GlsDxDFxiFYEyjKhh2JDBzpJy2crmrGA5Zfz1Qa2fLzCI+i+UQItwpQYU8aLFb2WoDXP4IY3K1a
	sHO/Ii3RT3/6XKJRibkbyak2mly7UyP66HLWvDz7IITfLhv7YlsoWFMvh5EfwCcBOoeS6H2/ah6
	73+vtbnXCy2gdiHFb2D6PVBSZ7FTjceGW9bpwaxxZ0/9l+7eQ=
X-Received: by 2002:a17:903:1a28:b0:2b0:c90f:44b2 with SMTP id d9443c01a7336-2b28173548amr214128665ad.12.1775633472474;
        Wed, 08 Apr 2026 00:31:12 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([104.43.2.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2ae05991bsm47105515ad.70.2026.04.08.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:31:12 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	apais@microsoft.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	vdso@hexbites.dev,
	mhklinux@outlook.com
Subject: [PATCH] x86/VMBus: Confidential VMBus for dynamic DMA transfers
Date: Wed,  8 Apr 2026 03:31:05 -0400
Message-Id: <20260408073105.272255-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,vger.kernel.org,hexbites.dev,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-10075-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvmm.dev:url]
X-Rspamd-Queue-Id: A8EC93B85A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hyper-V provides Confidential VMBus to communicate between
device model and device guest driver via encrypted/private
memory in Confidential VM. The device model is in OpenHCL
(https://openvmm.dev/guide/user_guide/openhcl.html) that
plays the paravisor role.

For a VMBus device, there are two communication methods to
talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
DMA transfer.

The Confidential VMBus Ring buffer has been upstreamed by
Roman Kisel(commit 6802d8af47d1).

The dynamic DMA transition of VMBus device normally goes
through DMA core and it uses SWIOTLB as bounce buffer in
a CoCo VM.

The Confidential VMBus device can do DMA directly to
private/encrypted memory. Because the swiotlb is decrypted
memory, the DMA transfer must not be bounced through the
swiotlb, so as to preserve confidentiality. This is different
from the default for Linux CoCo VMs, so not use DMA(SWIOTLB)
API in VMBus driver when confidential dynamic DMA transfers
capability is present.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 28 +++++++++++++++++++++-------
 include/linux/hyperv.h     |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ae1abab97835..79b7611518b7 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1316,7 +1316,8 @@ static void storvsc_on_channel_callback(void *context)
 					continue;
 				}
 				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
-				scsi_dma_unmap(scmnd);
+				if (!device->co_external_memory)
+					scsi_dma_unmap(scmnd);
 			}
 
 			storvsc_on_receive(stor_device, packet, request);
@@ -1339,6 +1340,8 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 
 	device->channel->max_pkt_size = STORVSC_MAX_PKT_SIZE;
 	device->channel->next_request_id_callback = storvsc_next_request_id;
+	if (device->channel->co_external_memory)
+		device->co_external_memory = true;
 
 	ret = vmbus_open(device->channel,
 			 ring_size,
@@ -1805,7 +1808,7 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		struct scatterlist *sg;
-		unsigned long hvpfn, hvpfns_to_add;
+		unsigned long hvpfn, hvpfns_to_add, hvpgoff;
 		int j, i = 0, sg_count;
 
 		payload_sz = (hvpg_count * sizeof(u64) +
@@ -1821,7 +1824,11 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-		sg_count = scsi_dma_map(scmnd);
+		if (dev->co_external_memory)
+			sg_count = scsi_sg_count(scmnd);
+		else
+			sg_count = scsi_dma_map(scmnd);
+
 		if (sg_count < 0) {
 			ret = SCSI_MLQUEUE_DEVICE_BUSY;
 			goto err_free_payload;
@@ -1836,9 +1843,16 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 			 * Such offsets are handled even on other than the first
 			 * sgl entry, provided they are a multiple of PAGE_SIZE.
 			 */
-			hvpfn = HVPFN_DOWN(sg_dma_address(sg));
-			hvpfns_to_add = HVPFN_UP(sg_dma_address(sg) +
-						 sg_dma_len(sg)) - hvpfn;
+			if (dev->co_external_memory) {
+				hvpgoff = HVPFN_DOWN(sg->offset);
+				hvpfn = page_to_hvpfn(sg_page(sg)) + hvpgoff;
+				hvpfns_to_add =	HVPFN_UP(sg->offset + sg->length) -
+							hvpgoff;
+			} else {
+				hvpfn = HVPFN_DOWN(sg_dma_address(sg));
+				hvpfns_to_add = HVPFN_UP(sg_dma_address(sg) +
+							 sg_dma_len(sg)) - hvpfn;
+			}
 
 			/*
 			 * Fill the next portion of the PFN array with
@@ -1860,7 +1874,7 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 	ret = storvsc_do_io(dev, cmd_request, smp_processor_id());
 	migrate_enable();
 
-	if (ret)
+	if (ret && (!dev->co_external_memory))
 		scsi_dma_unmap(scmnd);
 
 	if (ret == -EAGAIN) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..bcb143766d6e 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1285,6 +1285,7 @@ struct hv_device {
 
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
+	bool co_external_memory;
 
 };
 
-- 
2.50.1


