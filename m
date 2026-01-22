Return-Path: <linux-hyperv+bounces-8446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMqLKFSGcWk1IAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8446-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 03:07:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9D60B3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 03:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ED07820205
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8F35CB89;
	Thu, 22 Jan 2026 02:03:55 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4B30C615;
	Thu, 22 Jan 2026 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047434; cv=none; b=UqElr/LRc+WSYt2MUtIOccD6ShEJumnViaNDEuR1hPqvMxVuGV07D1101IQzvDGe6IrJIPqwUfaw1niyCuQvA9kGIc3z7SlV9KF65UBjTunkCzzWkTMyeyjGgJUsQqmRRzKCWdu7KONwpaXChMmwwVGVBjfEa/AG8POHUObv7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047434; c=relaxed/simple;
	bh=w83I06vDjrhR5j7M6vefS6yAGb619Wxa7/JnmjLaOiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSl9Thr87jAPJTy2F7UDr8COH/ID8p6vUEtZSc1czuAMiuQ6MiIfC63HreRIQb3HqbfkYda/4fRAsxV7gBzXKK1f70OGWzYCwBV00rO/fkBtRmLRFo2SXtfafdA7cZDIHUEYc3NSElCC2FTFuuRABNulPtHLOhJ3iePv1Hqs6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 40A6220B7167; Wed, 21 Jan 2026 18:03:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40A6220B7167
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jakeo@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mhklinux@outlook.com,
	stable@vger.kernel.org
Subject: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config window
Date: Wed, 21 Jan 2026 18:03:37 -0800
Message-ID: <20260122020337.94967-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.24 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : No valid SPF, No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8446-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BB9D60B3D
X-Rspamd-Action: no action

There has been a longstanding MMIO conflict between the pci_hyperv
driver's config_window (see hv_allocate_config_window()) and the
hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
both get MMIO from the low MMIO range below 4GB; this is not an issue
in the normal kernel since the VMBus driver reserves the framebuffer
MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram() can
always get the reserved framebuffer MMIO; however, a Gen2 VM's kdump
kernel fails to reserve the framebuffer MMIO in vmbus_reserve_fb() because
the screen_info.lfb_base is zero in the kdump kernel: the screen_info
is not initialized at all in the kdump kernel, because the EFI stub
code, which initializes screen_info, doesn't run in the case of kdump.

When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
kdump kernel, if pci_hyperv in the kdump kernel loads before hyperv_drm
loads, pci_hyperv's vmbus_allocate_mmio() gets the framebuffer MMIO
and tries to use it, but since the host thinks that the MMIO range is
still in use by hyperv_drm, the host refuses to accept the MMIO range
as the config window, and pci_hyperv's hv_pci_enter_d0() errors out:
"PCI Pass-through VSP failed D0 Entry with status c0370048".

This PCI error in the kdump kernel was not fatal in the past because
the kdump kernel normally doesn't reply on pci_hyperv, and the root
file system is on a VMBus SCSI device.

Now, a VM on Azure can boot from NVMe, i.e. the root FS can be on a
NVMe device, which depends on pci_hyperv. When the PCI error occurs,
the kdump kernel fails to boot up since no root FS is detected.

Fix the MMIO conflict by allocating MMIO above 4GB for the
config_window.

Note: we still need to figure out how to address the possible MMIO
conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
MMIO BARs, but that's of low priority because all PCI devices available
to a Linux VM on Azure should use 64-bit BARs and should not use 32-bit
BARs -- I checked Mellanox VFs, MANA VFs, NVMe devices, and GPUs in
Linux VMs on Azure, and found no 32-bit BARs.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-hyperv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1e237d3538f9..a6aecb1b5cab 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3406,9 +3406,13 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 
 	/*
 	 * Set up a region of MMIO space to use for accessing configuration
-	 * space.
+	 * space. Use the high MMIO range to not conflict with the hyperv_drm
+	 * driver (which normally gets MMIO from the low MMIO range) in the
+	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
+	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
+	 * zero in the kdump kernel.
 	 */
-	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
+	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
 				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
 	if (ret)
 		return ret;
-- 
2.43.0


