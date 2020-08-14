Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF82449D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgHNMjN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 08:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNMjN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:39:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2BE22B49;
        Fri, 14 Aug 2020 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408752;
        bh=4V7/CqFsrxdA6kdFPpHDAIJXGjG47K7pqbvNTGXP7uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmenKQt4riv24xeraz8s7NQ6/O7Gkk+LAJW1/wrbi0jWR1Rv0PMa0bCM4hlqRf+KQ
         h8IW2FIRqM90Bv72rQdLM4+0ZIwnFYGmKpvf+T8a1HI97JAiKRqP05/7gtG89JZGs0
         nsdyvMNhK2+bN96wTbYO4YE7KhE/wUMn4aMtkSoU=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 2/4] drivers: hv: dxgkrnl: hook up dxgkrnl
Date:   Fri, 14 Aug 2020 08:38:54 -0400
Message-Id: <20200814123856.3880009-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814123856.3880009-1-sashal@kernel.org>
References: <20200814123856.3880009-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Connect the dxgkrnl module to the drivers/hv/ makefile and Kconfig.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/Kconfig  | 2 ++
 drivers/hv/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 79e5356a737a..07d4e7c36e3a 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -26,4 +26,6 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+source "drivers/hv/dxgkrnl/Kconfig"
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf8240c95..2474b70c161d 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_DXGKRNL)		+= dxgkrnl/
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
-- 
2.25.1

