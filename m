Return-Path: <linux-hyperv+bounces-510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047127C4483
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 00:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02B2281BD0
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70029CE1;
	Tue, 10 Oct 2023 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y20IsFwc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446353551F
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 22:48:09 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5629B99;
	Tue, 10 Oct 2023 15:48:08 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1172)
	id CA09920B74C0; Tue, 10 Oct 2023 15:48:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA09920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696978087;
	bh=7/ZIVn50LkClYO8V7dbxCg5jRS1URuYBZ92bH8lp5jA=;
	h=From:To:Cc:Subject:Date:From;
	b=Y20IsFwc2nBR62fY4pVvhX1kao+yZHmSBJUsKtUFgzbI1EjTU5TsKbTk+bDKUFOP7
	 7N2Z7IWfLx4y1xsXeX6OC8QUzK53mWZEDck3a3wicf8ejXOi+b2haXMZz/tFpt7KcK
	 GY4N0zv2Mfi5fCtJJ4QFMi+Zuwgh61ZnJcw3WwhA=
From: Angelina Vu <angelinavu@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Subject: [PATCH] hv_balloon: Add module parameter to configure balloon floor value
Date: Tue, 10 Oct 2023 15:48:07 -0700
Message-Id: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently, the balloon floor value is automatically computed, but may be
too small depending on app usage of memory. This patch adds a balloon_floor
value as a module parameter that can be used to manually configure the
balloon floor value.

Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 64ac5bdee3a6..87b312f99b2e 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
 	}
 }
 
+unsigned long balloon_floor;
+module_param(balloon_floor, ulong, 0644);
+MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ballooning will not remove");
+
 static unsigned long compute_balloon_floor(void)
 {
 	unsigned long min_pages;
@@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
 	 *    8192       744    (1/16)
 	 *   32768      1512	(1/32)
 	 */
+	if (balloon_floor)
+		return MB2PAGES(balloon_floor);
+
 	if (nr_pages < MB2PAGES(128))
 		min_pages = MB2PAGES(8) + (nr_pages >> 1);
 	else if (nr_pages < MB2PAGES(512))
-- 
2.34.1


