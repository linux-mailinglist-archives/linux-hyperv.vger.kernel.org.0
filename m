Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420EA1D9CCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgESQdQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 12:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgESQdP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 12:33:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749FF20826;
        Tue, 19 May 2020 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905995;
        bh=eZ1bHq1CoG5hjqUOKxdZChtO/EqOip0Cz6ip1fVxHZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lp/dAYwDKiIcHHjB6thsH9YaDjZ13tYqeQtGPyL5YPXKrHM0hLWXZtW+7WTe/ryr1
         LBE6gwdv60kTj30t1CrmWuB7WqdCSVzJBPARRur4jpQCE10IGwhvSsZe5wb6tYZV/o
         B//kvRikCGtf4AtGzcRJvOVMKJoq+cSGhGMCtoYI=
From:   Sasha Levin <sashal@kernel.org>
To:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org, Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 3/4] Drivers: hv: vmbus: hook up dxgkrnl
Date:   Tue, 19 May 2020 12:32:33 -0400
Message-Id: <20200519163234.226513-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Register a new device type with vmbus.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hyperv.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 692c89ccf5df..ad16e9bc676a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1352,6 +1352,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
 			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
 
+/*
+ * GPU paravirtualization global DXGK channel
+ * {DDE9CBC0-5060-4436-9448-EA1254A5D177}
+ */
+#define HV_GPUP_DXGK_GLOBAL_GUID \
+	.guid = GUID_INIT(0xdde9cbc0, 0x5060, 0x4436, 0x94, 0x48, \
+			  0xea, 0x12, 0x54, 0xa5, 0xd1, 0x77)
+
+/*
+ * GPU paravirtualization per virtual GPU DXGK channel
+ * {6E382D18-3336-4F4B-ACC4-2B7703D4DF4A}
+ */
+#define HV_GPUP_DXGK_VGPU_GUID \
+	.guid = GUID_INIT(0x6e382d18, 0x3336, 0x4f4b, 0xac, 0xc4, \
+			  0x2b, 0x77, 0x3, 0xd4, 0xdf, 0x4a)
+
 /*
  * Synthetic FC GUID
  * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
-- 
2.25.1

