Return-Path: <linux-hyperv+bounces-9749-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPKmAI6Vw2ncrgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9749-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 08:58:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8A320FBD
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 08:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9CB83047011
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED022390999;
	Wed, 25 Mar 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKQYQ3Iy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDB3537D6
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425420; cv=none; b=N57ZbqZkF+8fQdS4J97aZK/sQ3WLenSaDdFXweOHjQ1W7vYteAJdCk2G7QqCLzYxB0T/oVfiZzArzv9OiwGZQqVfw4iLYiVfUbDjk888jAF4RDZ10c8RLZfTvUCRqxnYGBAcPtbgO3S65K1VHPMRtn2hZPMoRmI3IYzXN2N5aLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425420; c=relaxed/simple;
	bh=Nlk2krWXigXedYIVbGLe3NHoVJ85MDZPNxBmyiex99U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bY33CfEqrIOmlzMgd8niLjDlIb0rDOS8D3b5zHixkMvcmvmqsS1VSJmlodLyPdS2HJTVB/pd22B0XoUzvAHd6kFumwxGNLcZ3aiDewiXHE0Ew+wjuE6Id/+worepWw+2aH0IJB7sMv8DNtfvXrvmxVJ6UJx3EAKEnMaxHl/UG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKQYQ3Iy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c124d2613so146090a91.2
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425415; x=1775030215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdEHDzLyvba5udnwz8c2vdy7nbbUB2Sw/8exS3LVD2c=;
        b=MKQYQ3IyqsZjThYDBeRWLtpl6yJ8coH0kS/vw9KZ47IV/SFf8Yu9fxWR09oeAe/EnE
         dtoI5rMIXDJ3ksWArbKVLeHg52UYFo2OZ9FIoDH+XjoToAXLFMGtIY5oV6eojKUDuoyL
         Q+yIaGYiZCLEMqHw6HYC7fIsyqnesi6obYlaud2F/3nVwc68BmQ4YBX89eLWVB2F0BKL
         vFddS+mRCpUGGdgEdTcWBhffjxa+oyFCEXgHFjuV4urwgg3vH9P9GeB+8ZDF+rfHkZxO
         BYXWnPiF7h7oOywv2usOOdTYRfkQN1qycABVcjt+qTN+9N0q168mxY0xhjDHsme3gbse
         i7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425415; x=1775030215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdEHDzLyvba5udnwz8c2vdy7nbbUB2Sw/8exS3LVD2c=;
        b=K7S3ZXXT3kgHVtgNtlfeqWkE2IPWWkA/QLXDAYmv6ojes4gFYaR+Qf/zd5pVLuedT0
         1/o5yD/qkGZ9DnSRqebdLm1E8FdrvhG+mFAr214WCn9HCDLaqPBK4KttSCL0FOZNY3WP
         uOUyELDtBo8dZYWp7+mLwgcQ4+ns1v8lSmU1QZR91bqsN55ZHkhLuFUQH3rpQkVzSN4Y
         H4+cROa3muMCE0hWkOd52VWHzY6kIRyHAa+zVd9lARkAQHQOXZkmWN1OY+BjGi2S+SIG
         s3DvbQjH+CPgV9KQ4sdENHVs1OTKJG4UGBOJv3lqde7xrPMdymEcOvELL+12t7O2raJa
         g4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/4aiwyQR2ui6vNYb0Otc9kFP+K7Q+x1nFU9tv3UJoxAVHivs1ajE4nL4U8kLpnVDuLLQwOm3Hh5dskA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOi4TfKBMrGZdvuC+LDWUPGais50ZlafU09CIm/00ZzkjNqaz
	9rC8LnYUrvxzSgw4uKRoe/GoU+ORWZ9MMsqFjKTn4gk1mAKOj8azt9iW
X-Gm-Gg: ATEYQzyjfXQuknCNz3HPlYFzah9qIKNHO9+jcWOFBmUy7XgL/tjHni9DJi+SwF3wisk
	jeN5n51cwFBXSqtE+8XhbiCFsteQtSrAaTDvwvwELdqdVAclGIvTCpXErLhtffMmQoNZReLaiWl
	HwEFyzsYU+9BTNN5iGblel4UwZbJ9hliN/wI8Jif5JP20FgyNSoBBi6in/Juy72wdJFApaw+I2/
	i3LtMHkalZleQ24BsXw8CCJuxCLGjZiiWmpQ8pCgKl+Y3/loIRrxgymCpOXrZoJj8zRGQoyZGpw
	1nl3niPJHtsA9P65Eg5UJX0RshDONA/Au4H4/03ocXz/5cih0iooAHnBd38Ddhqq87U5jqO9Cp+
	J5Bq8Omgt4deiRoTx2wUfiVq/5tUp8F0V0fK5QHybPobQXcrTdlyUejk5vobhcAIzthd4YdW7Bm
	WHs/TjpMFoWpFg16qStJziwd6DPc5avBNglqiIC1PtbFbsfVgS+mHOSk0p4w==
X-Received: by 2002:a17:90b:17c8:b0:35b:e591:99d1 with SMTP id 98e67ed59e1d1-35c0ddc4118mr2246370a91.29.1774425415489;
        Wed, 25 Mar 2026 00:56:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([104.43.2.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0ac5b287sm2769966a91.4.2026.03.25.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:56:55 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	vdso@hexbites.dev,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
Date: Wed, 25 Mar 2026 03:56:49 -0400
Message-Id: <20260325075649.248241-1-tiala@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,lists.linux.dev,vger.kernel.org,infradead.org,hexbites.dev,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9749-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 9FB8A320FBD
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
from the default for Linux CoCo VMs, so disable the VMBus
device's use of swiotlb.

Expose swiotlb_dev_disable() from DMA Core to disable
bounce buffer for device.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/vmbus_drv.c  | 6 +++++-
 include/linux/swiotlb.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3d1a58b667db..84e6971fc90f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
 	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 
+	device_initialize(&child_device_obj->device);
+	if (child_device_obj->channel->co_external_memory)
+		swiotlb_dev_disable(&child_device_obj->device);
+
 	/*
 	 * Register with the LDM. This will kick off the driver/device
 	 * binding...which will eventually call vmbus_match() and vmbus_probe()
 	 */
-	ret = device_register(&child_device_obj->device);
+	ret = device_add(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
 		put_device(&child_device_obj->device);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..7c572570d5d9 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_pool(struct device *dev,
 	return NULL;
 }
 
+static inline bool swiotlb_dev_disable(struct device *dev)
+{
+	return dev->dma_io_tlb_mem == NULL;
+}
+
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-- 
2.50.1


