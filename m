Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA62449D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgHNMjQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 08:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgHNMjO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:39:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1914622BEA;
        Fri, 14 Aug 2020 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408754;
        bh=eV6iRKHvvB1DoGt+hTS0spUI3jbD+6MTs1x0BAJz1G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3SYkgQniaZcIZXagUTbJrBO1tKFc/bfVYVfrML8m8T/BjaDwwo9mW8MXSkacsCuw
         4yqOMCIlvm/UEvH32y0gEMQ5oavTSihgpGz9GerYKR98Xbp32lXJxpCT4GjI1Y1bzk
         thBFTDZntPvW1H+P0WCzEzVwbK9KwLVYlMONC+Js=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3/4] drivers: hv: vmbus: hook up dxgkrnl
Date:   Fri, 14 Aug 2020 08:38:55 -0400
Message-Id: <20200814123856.3880009-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814123856.3880009-1-sashal@kernel.org>
References: <20200814123856.3880009-1-sashal@kernel.org>
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
index 40df3103e890..40fff19ecde3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1343,6 +1343,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
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

