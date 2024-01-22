Return-Path: <linux-hyperv+bounces-1460-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D06836CE7
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755791C21033
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257134F8B5;
	Mon, 22 Jan 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE/QYKBQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC21DA5E;
	Mon, 22 Jan 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940449; cv=none; b=XxyOoQ51T/J+y820hZ/NE6P/2bCguYRg+SaXvR4wuUeE8lVKhGqGZugYqWvSkgRjy6o7EjQafPBQUAfn9m5BS3ifPY+9bgDT2k+c24oGQquuuIcTLDbTwcaTU2WExGk14M9aMRRNLlHf4Ga3/SLFxPvyZ2DCyyUB2g3gcQWhWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940449; c=relaxed/simple;
	bh=bSPac5w3Ua0/oFHQn7g5yByEiVkWk7NFgy25K0R0z6M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OiRynBisCWdsWcfLHqNVsXeWon/4yrWKuMu2Yh5GOkirD4MM+tojuawUDyuap/98TuOEsBEK5hRilr15sYSLMzfoeuQSD0XM1bEq0OxEvvdkfXWEJcx3OkqHG4xbL6TXhTewQ3w7CZk1BgmpKKZWzQ9jaMfED/TeWUI2Gxjvg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE/QYKBQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d427518d52so23572425ad.0;
        Mon, 22 Jan 2024 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705940447; x=1706545247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beNCKY2YPTCQZoiFJNHwWZK4ngyBLzXSe58xPdpNeOE=;
        b=hE/QYKBQA5IfKMo7x331+lBcOC9kNU52VSZHpiycN02hkEPDide5Nxu/tqwqNXXsDs
         oRsyO7Ui5TkyMEFZ5no3lDMB4KtFpln+VxPuRF11ylZBFTPwa6jSL5WwuqekYTsrc+vz
         EZCEVpKXeK9mwPjfGBiU0YnoTtoFiDGgciYZyl9ZCTsDRUPkLeQif9PwJ7t7nvcOwHUx
         UdUDbKUUf+hVtVw4kN0FX+WU4CTjmZglcXgkt+ebFM8MHbPcNM5ASqAtn5i5X1PVh078
         4CZLHUG9JK+KBidFPpIPoeGKmyQsJpnburfFctp+PkM02q8YuaLhz0QOT6yw88THx6cK
         voFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940447; x=1706545247;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beNCKY2YPTCQZoiFJNHwWZK4ngyBLzXSe58xPdpNeOE=;
        b=bblL56+7JFO0mfPF/NUca8cQDAWcqWEvM2QJ5+IFLhZ71hnpEvoXLUbjaYYn1pPXsM
         40ak7UCsHCwHfPLuhQrzqpmAOVBnTjl6Tx3C0RWy8wyr/I6U6+POZfLAiYfN8KCPouPM
         hccSrD7izxm3E0TlL+ntS4Qf/Q9/On89bT7P/WIJ31/LXkGfE/BLJVwaJYh3Jjxlsvyf
         w4GyTbNT/tN5x2rkddN5D/djW4KACwUAXsl5SknDgNzyXK2tXLZmzwDB/jYWzrnbDyM5
         mp0LKgZuCaIB9Gqu37eOGKjh9d1vu3jyCnX0C7R18fRAVUvrNu19/YzG7Aa5ybE1Ug0U
         h+/A==
X-Gm-Message-State: AOJu0YzkNupRvAHwINsOh08IuI3XOJHp3RB+jUeyIo+rHUC+UmPiOS0F
	e4rVGYtjGc9irEw/HVK8JBJtXoTTZZo3BJKZDVntgPmcrHAiJUEF
X-Google-Smtp-Source: AGHT+IEq4zaOL3uQnFuYGqQgFx0cvUA2U0zZLlFxaZA5UV3GQ7HzTUEsbVt/kQs9dPpoQG/BBdJEiQ==
X-Received: by 2002:a17:902:aa92:b0:1d7:274e:1573 with SMTP id d18-20020a170902aa9200b001d7274e1573mr5210584plr.60.1705940446972;
        Mon, 22 Jan 2024 08:20:46 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d74a674620sm2388514plb.198.2024.01.22.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:20:46 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes
Date: Mon, 22 Jan 2024 08:20:28 -0800
Message-Id: <20240122162028.348885-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code in netvsc_drv_init() incorrectly assumes that PAGE_SIZE
is 4 Kbytes, which is wrong on ARM64 with 16K or 64K page size. As a
result, the default VMBus ring buffer size on ARM64 with 64K page size
is 8 Mbytes instead of the expected 512 Kbytes. While this doesn't break
anything, a typical VM with 8 vCPUs and 8 netvsc channels wastes 120
Mbytes (8 channels * 2 ring buffers/channel * 7.5 Mbytes/ring buffer).

Unfortunately, the module parameter specifying the ring buffer size
is in units of 4 Kbyte pages. Ideally, it should be in units that
are independent of PAGE_SIZE, but backwards compatibility prevents
changing that now.

Fix this by having netvsc_drv_init() hardcode 4096 instead of using
PAGE_SIZE when calculating the ring buffer size in bytes. Also
use the VMBUS_RING_SIZE macro to ensure proper alignment when running
with page size larger than 4K.

Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 4406427d4617..273bd8a20122 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -44,7 +44,7 @@
 
 static unsigned int ring_size __ro_after_init = 128;
 module_param(ring_size, uint, 0444);
-MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
+MODULE_PARM_DESC(ring_size, "Ring buffer size (# of 4K pages)");
 unsigned int netvsc_ring_bytes __ro_after_init;
 
 static const u32 default_msg = NETIF_MSG_DRV | NETIF_MSG_PROBE |
@@ -2807,7 +2807,7 @@ static int __init netvsc_drv_init(void)
 		pr_info("Increased ring_size to %u (min allowed)\n",
 			ring_size);
 	}
-	netvsc_ring_bytes = ring_size * PAGE_SIZE;
+	netvsc_ring_bytes = VMBUS_RING_SIZE(ring_size * 4096);
 
 	register_netdevice_notifier(&netvsc_netdev_notifier);
 
-- 
2.25.1


