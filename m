Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973CD431A9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Oct 2021 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhJRNVu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 18 Oct 2021 09:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRNVs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 18 Oct 2021 09:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CD46103C;
        Mon, 18 Oct 2021 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634563176;
        bh=7tj9sq8JJDJOPu5HaXd4ssS9coNEsTV0TbD99mXN8vU=;
        h=From:To:Cc:Subject:Date:From;
        b=QPLWe72+D9TTkdSKM9wWmKogdrx6GKXSB8IPBmL2ns0YnmFZrIUuiz7tQKurm9jhh
         YQPkjO4k/q5B8yJWwtcmSo8bu3mTrTLqzCq3GT0zukEQUF8mpDVyC0rPyYwfAw0Bff
         nYjFL7xYeRzjkt9CxJx48mXU7CytPFlADrOB+UUANj3go6DEANMDSGkwV4EhxFqrYy
         PlbklJ6GcPhUsFSoZgj74qy3p63QSnvQcYMEJ+wjF8D1zlTqLXrXWpzb1IFl96pPHP
         X7Cv8GKQJT3wjHpEwu4gTGMBns433dTYmgGjs85FobWyjlVzl3asthtFTrwIilTxs5
         15M0TlAg9mZrg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andres Beltran <lkmlabelt@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hypverv/vmbus: include linux/bitops.h
Date:   Mon, 18 Oct 2021 15:19:08 +0200
Message-Id: <20211018131929.2260087-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On arm64 randconfig builds, hyperv sometimes fails with this
error:

In file included from drivers/hv/hv_trace.c:3:
In file included from drivers/hv/hyperv_vmbus.h:16:
In file included from arch/arm64/include/asm/sync_bitops.h:5:
arch/arm64/include/asm/bitops.h:11:2: error: only <linux/bitops.h> can be included directly
In file included from include/asm-generic/bitops/hweight.h:5:
include/asm-generic/bitops/arch_hweight.h:9:9: error: implicit declaration of function '__sw_hweight32' [-Werror,-Wimplicit-function-declaration]
include/asm-generic/bitops/atomic.h:17:7: error: implicit declaration of function 'BIT_WORD' [-Werror,-Wimplicit-function-declaration]

Include the correct header first.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure what started this, I first saw it on linux-next-20211015
---
 drivers/hv/hyperv_vmbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 42f3d9d123a1..d030577ad6a2 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -13,6 +13,7 @@
 #define _HYPERV_VMBUS_H
 
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <asm/sync_bitops.h>
 #include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
-- 
2.29.2

