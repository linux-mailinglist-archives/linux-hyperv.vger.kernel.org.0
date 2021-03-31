Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4534F885
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Mar 2021 08:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhCaGHw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Mar 2021 02:07:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15049 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhCaGG7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Mar 2021 02:06:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9G3h69z6zNrXH;
        Wed, 31 Mar 2021 14:04:16 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.177.129) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 14:06:46 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     <linux-hyperv@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] Drivers: hv: vmbus: Remove unused including <linux/version.h>
Date:   Wed, 31 Mar 2021 14:06:46 +0800
Message-ID: <20210331060646.2471-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/hv/hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 917b29e873c5..3e6ff83adff4 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
-#include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>

