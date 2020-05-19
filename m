Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF71D9CC2
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgESQdO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 12:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgESQdN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 12:33:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E2820884;
        Tue, 19 May 2020 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905993;
        bh=KqBKhr6to6bxExK2bg4wDA0x7D/o81eMVQb7vBHPcOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLwx4XLbCMMeNgYFg4LZMUs5N+usEH/X5Qa4Zk8BnvMKDRFfHDVBfZYva3KPQfDKf
         FY6B9ylSZcXEiPLjvYxUvlHwF0OOEMpO9CUJHOWlWBfze0aPtZ9sNcq49fgY8g2dX4
         XEO/DAXqGVEXQTGY+jSpNnrmuxQ9lQypen2aTuVM=
From:   Sasha Levin <sashal@kernel.org>
To:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org, Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 2/4] gpu: dxgkrnl: hook up dxgkrnl
Date:   Tue, 19 May 2020 12:32:32 -0400
Message-Id: <20200519163234.226513-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Connect the dxgkrnl module to the drivers/gpu/ makefile and Kconfig.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/Makefile  | 2 +-
 drivers/video/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..28c22c814494 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -3,6 +3,6 @@
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-y			+= drm/ vga/ dxgkrnl/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 427a993c7f57..362c08778a54 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -19,6 +19,8 @@ source "drivers/gpu/ipu-v3/Kconfig"
 
 source "drivers/gpu/drm/Kconfig"
 
+source "drivers/gpu/dxgkrnl/Kconfig"
+
 menu "Frame buffer Devices"
 source "drivers/video/fbdev/Kconfig"
 endmenu
-- 
2.25.1

