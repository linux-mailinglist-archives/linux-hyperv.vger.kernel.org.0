Return-Path: <linux-hyperv+bounces-1838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471F88E121
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B468A296F45
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9F5155310;
	Wed, 27 Mar 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM28g1N3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242D155302;
	Wed, 27 Mar 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541738; cv=none; b=ackhj9CIUV2dosZ+HEOH5jYLMU3MMl4Z2/jThDL+hA0GCfjuYNL9NWj79itFY/Sdsri5IjWWKxNQiyiX0VIVnwS2ywAxQkBLQkoNKZBCx+FPP6icw9ruSM3RogfT5easKvnhPkeOxgXxWGKkqOSIsmE7HjIOCGYfMR9QYC0WZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541738; c=relaxed/simple;
	bh=lHt9D14ybf0nnCyk5lSioH5vZZl9kQOLC2vqJw8avK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s75FR/UF+gW79OIcpPSWI8NSEHaaCVz8QP5ZSCp++4pFPfEAsMeepzLD9BNJ8Q24ZUD0TkKjTBGMXFn1GfC5boXZfoEPJrBHMY0ZUkWCtaxgGXnEP7BsyPzFp8ub9PZvpqznpwr8NK7KkfsK8rJkkTYtj0cFXr6C+H/XJypzEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM28g1N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB88C433F1;
	Wed, 27 Mar 2024 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541738;
	bh=lHt9D14ybf0nnCyk5lSioH5vZZl9kQOLC2vqJw8avK8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZM28g1N3oWXkNTB/3BP/mxDQfA1bHQPS0LsIAs0IbJUY7LPC5U6ss3aYt/MLqG8Zo
	 grnPfZ+pwns9sShKCQTSGebRH96+2nlbVywOEnBEtcVM2b/IBF7g6Iy2SAvFuXNA0v
	 b2ujEcFUvngQqv29FjZC5JUxl1C77WoZ5bbQ4c9GC58Lolc4o/KK1LopQRLwEoAnFp
	 a3LpIbHpVg4XW+gK7/2hfKZ1ZtalD6OXR2mSDukIlGIXy/0HHtu0yMMWKXZzYNBXlK
	 mAeDw/Sp6aBX9KPJCNKBV9Rr3BF+3kS8n6M8saJ18yIPG2d0+2V+ntvEA+f//5tTb2
	 KQiWgoZB7ITRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mhklinux@outlook.com
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "PCI: hv: Fix ring buffer size calculation" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:35 -0400
Message-ID: <20240327121536.2832043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b5ff74c1ef50fe08e384026875fec660fadfaedd Mon Sep 17 00:00:00 2001
From: Michael Kelley <mhklinux@outlook.com>
Date: Fri, 16 Feb 2024 12:22:40 -0800
Subject: [PATCH] PCI: hv: Fix ring buffer size calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For a physical PCI device that is passed through to a Hyper-V guest VM,
current code specifies the VMBus ring buffer size as 4 pages.  But this
is an inappropriate dependency, since the amount of ring buffer space
needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
is used for only a few messages during device setup and removal, so any
space above a few Kbytes is wasted.

Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
header is properly accounted for, and so the size is rounded up to a
page boundary, using the page size for which the kernel is built. While
w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
64 Kbyte ring buffer, that's the smallest possible with that page size.
It's still 128 Kbytes better than the current code.

Link: https://lore.kernel.org/linux-pci/20240216202240.251818-1-mhklinux@outlook.com
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Long Li <longli@microsoft.com>
Cc: <stable@vger.kernel.org> # 5.15.x
---
 drivers/pci/controller/pci-hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d4..5992280e8110b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -49,6 +49,7 @@
 #include <linux/refcount.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
+#include <linux/sizes.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -465,7 +466,7 @@ struct pci_eject_response {
 	u32 status;
 } __packed;
 
-static int pci_ring_size = (4 * PAGE_SIZE);
+static int pci_ring_size = VMBUS_RING_SIZE(SZ_16K);
 
 /*
  * Driver specific state.
-- 
2.43.0





