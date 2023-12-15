Return-Path: <linux-hyperv+bounces-1338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744081511B
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CA8281530
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345136B03;
	Fri, 15 Dec 2023 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPdDuZbB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FD846D;
	Fri, 15 Dec 2023 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e4fb170827so2672707b3.3;
        Fri, 15 Dec 2023 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702672436; x=1703277236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTFSO440Asq/ZjEa0Sv01HBm7pivdxHwzbg+GM27vSQ=;
        b=jPdDuZbB8tQrKheAcYjiqPy2NmdhrVnhxnbX/xJr9zINb9QyCfi8Ii13HlZfbFjqqQ
         dyEa8EMfFlbiU8UllAuxU0DZruv16IIfcfnuOF76PKFBmHXG2GMRuppnjM8oQIIxW+dl
         BdMiNPtVP0DGHATH37b2Plf+dNpgsTvFXTss4hmIHhaq+pDLc2MG1k30O9eMUzBZlbqj
         NMgvRoZTPI8u8PJCUPPhWv3pTW/5+e24tXkLhFq9bpca2KLNHEENuw5lLIRwR6hJabH0
         IRno+2JQhyJXRNWzocM0dIbYWEovEuiomckhF6ZcorswnaJheTHJJlf8uNIoDLfWUA1J
         XMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702672436; x=1703277236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTFSO440Asq/ZjEa0Sv01HBm7pivdxHwzbg+GM27vSQ=;
        b=CbbhY/0H21MkKVgWwP9Jb5ThZHx7B9o72QUDCynvzSjDj8KuzrF7nP8ll2hTskCwxK
         OWeQnwgfsa80i530gqPkhI82hGl/dfc+GYIEjunQdjsu9+zcoOVPX1qHuM+hq/C3Vp2X
         nSkVYLWhMMc9BEH0bluNYWQK+32VFy7epaCDDTVMA2gdwVGRbVeyM5XJbQxWRr/Gb5m3
         1l3seFgt3GfmF1zL+vhg/xZhsZnEdWA3+FwUSsAccLK15mdJpRwFirNVuVMBY2tybjR7
         T355i0NtdwmMbNSD/MkA5p48ws0yQa5tVmKcNRVNxD/HPcDLfulyRixhwHB957VDfvBz
         dB6A==
X-Gm-Message-State: AOJu0Yzj3kfBgGSsNJhiHu/bUv7j2I/eMVIcoIuPYo+X7WFfys+Mbz+M
	4L7ZYEpGeXZBNsHuKfAIxFU=
X-Google-Smtp-Source: AGHT+IEBPSB43oMFVuBjkdcP0BLnp1ab8c+UPrSfZdbiIJxP2j2MUdZbyUdTw+0ZiM9NRGRVjNEdPw==
X-Received: by 2002:a81:df03:0:b0:5ca:c025:3e12 with SMTP id c3-20020a81df03000000b005cac0253e12mr9683230ywn.47.1702672436421;
        Fri, 15 Dec 2023 12:33:56 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:ffe6:85e9:752c:601b])
        by smtp.gmail.com with ESMTPSA id i16-20020a81d510000000b005d8ce4ca469sm6532718ywj.99.2023.12.15.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:33:55 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] net: mana: select PAGE_POOL
Date: Fri, 15 Dec 2023 12:33:53 -0800
Message-Id: <20231215203353.635379-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mana uses PAGE_POOL API. x86_64 defconfig doesn't select it:

ld: vmlinux.o: in function `mana_create_page_pool.isra.0':
mana_en.c:(.text+0x9ae36f): undefined reference to `page_pool_create'
ld: vmlinux.o: in function `mana_get_rxfrag':
mana_en.c:(.text+0x9afed1): undefined reference to `page_pool_alloc_pages'
make[3]: *** [/home/yury/work/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[2]: *** [/home/yury/work/linux/Makefile:1154: vmlinux] Error 2
make[1]: *** [/home/yury/work/linux/Makefile:234: __sub-make] Error 2
make[1]: Leaving directory '/home/yury/work/build-linux-x86_64'
make: *** [Makefile:234: __sub-make] Error 2

So we need to select it explicitly.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/microsoft/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 090e6b983243..01eb7445ead9 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -20,6 +20,7 @@ config MICROSOFT_MANA
 	depends on PCI_MSI && X86_64
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
+	select PAGE_POOL
 	help
 	  This driver supports Microsoft Azure Network Adapter (MANA).
 	  So far, the driver is only supported on X86_64.
-- 
2.40.1


