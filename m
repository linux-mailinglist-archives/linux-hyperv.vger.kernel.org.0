Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD1305999
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jan 2021 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313546AbhAZW5c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 17:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbhAZVkC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 16:40:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35DFC20449;
        Tue, 26 Jan 2021 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611697140;
        bh=BFt1CTVwzPElHxuy6NFo94gOSrVHxpCiSyyX9w25274=;
        h=From:To:Cc:Subject:Date:From;
        b=jBwmbBKX8flB15zXQmvuubtaUlS3EioUJy+cZy68rXwqK5a90M3xPHUjpKivmWpge
         nw85CPXkf2iI3m3iXA+uZAD0/X+2KSH86JwAP2U8/w+fjzvjl7zqoYR303ih049s3f
         RnlXG2LuDE19WwsdC8vS2iQ5uv6QcxJvuja9utoSSsCW/qjFTifLc1K+emW3/IE5uX
         ly4z5uRl0L5oNQbsKNnclJt9qlgnM1RjJUzZhZIy42vXMoN6AFxdd7RUEgaVupNoxO
         4UaOU2ACnKQV8GxMFAPVTgWEVEK9oerun2aIRzR6k0ajCxnCYr3/9PtRHISRdq6efn
         1rDocfhVws3Ww==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: hv: Fix typo
Date:   Tue, 26 Jan 2021 15:38:55 -0600
Message-Id: <20210126213855.2923461-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix misspelling of "silently".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6db8d96a78eb..da0c22eb4315 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1714,7 +1714,7 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	 * resumed and suspended again: see hibernation_snapshot() and
 	 * hibernation_platform_enter().
 	 *
-	 * If the memory enable bit is already set, Hyper-V sliently ignores
+	 * If the memory enable bit is already set, Hyper-V silently ignores
 	 * the below BAR updates, and the related PCI device driver can not
 	 * work, because reading from the device register(s) always returns
 	 * 0xFFFFFFFF.
-- 
2.25.1

