Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2149043C5CB
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Oct 2021 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhJ0I7m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Oct 2021 04:59:42 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59299 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232689AbhJ0I7m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Oct 2021 04:59:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Uts5uRL_1635325031;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uts5uRL_1635325031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 16:57:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] x86/hyperv: Remove duplicate include
Date:   Wed, 27 Oct 2021 16:57:02 +0800
Message-Id: <1635325022-99889-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Clean up the following includecheck warning:

./arch/x86/hyperv/ivm.c: linux/bitfield.h is included more than once.
./arch/x86/hyperv/ivm.c: linux/types.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/hyperv/ivm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 4d012fd..69c7a57 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -6,11 +6,9 @@
  *  Tianyu Lan <Tianyu.Lan@microsoft.com>
  */
 
-#include <linux/types.h>
 #include <linux/bitfield.h>
 #include <linux/hyperv.h>
 #include <linux/types.h>
-#include <linux/bitfield.h>
 #include <linux/slab.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
-- 
1.8.3.1

