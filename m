Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4734A1EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Mar 2021 07:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCZGgV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Mar 2021 02:36:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14488 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCZGgB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Mar 2021 02:36:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6ByH2NvGzyNs8;
        Fri, 26 Mar 2021 14:33:59 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:35:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>
CC:     <linux-hyperv@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] x86/hyperv: remove unused including <linux/version.h>
Date:   Fri, 26 Mar 2021 14:49:42 +0800
Message-ID: <20210326064942.3263776-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yongjun Zheng <zhengyongjun3@huawei.com>
---
 arch/x86/hyperv/hv_proc.c | 1 -
 1 file changed, 1 deletion(-)
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 60461e598239..27e17ad3ba49 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>

