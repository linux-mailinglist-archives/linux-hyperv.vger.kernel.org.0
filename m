Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674639B113
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 05:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhFDDpO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 23:45:14 -0400
Received: from m12-12.163.com ([220.181.12.12]:55624 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhFDDpO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 23:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=67SyH
        5ZOavcPxAra7gc1Zli3sCtHraoSINoTVQU9/8c=; b=UhpwYurjsQSIXG1Ua4f7k
        09ADijh8Jo83HH3OU3Kj3ZytS4unyBd7LUIpcgiXOQB+QygrPOzoOvZZggWpxOPY
        8j9zz6eXkRg9hGkXYukz/7W3xl5755qJO2kNeE/6AFfuFJhRjUT9qiArrL782+Uz
        RjsXumcEdG7Yc2D0ZFfYpk=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAC3vQlylrlg3pK_Hw--.54443S2;
        Fri, 04 Jun 2021 10:56:51 +0800 (CST)
From:   lijian_8010a29@163.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: hyperv_fb: Removed unnecessary 'return'
Date:   Fri,  4 Jun 2021 10:55:52 +0800
Message-Id: <20210604025552.106888-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAC3vQlylrlg3pK_Hw--.54443S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDWEEUUUUU
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBEROnUFaEEmK0EAAAsz
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return' in void function hvfb_get_option().

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/hyperv_fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 23999df52739..c8e57a513896 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -952,7 +952,6 @@ static void hvfb_get_option(struct fb_info *info)
 
 	screen_width = x;
 	screen_height = y;
-	return;
 }
 
 /*
-- 
2.25.1


