Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628FB4CD42C
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Mar 2022 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiCDMZX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Mar 2022 07:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiCDMZW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Mar 2022 07:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4AF1B018C
        for <linux-hyperv@vger.kernel.org>; Fri,  4 Mar 2022 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646396673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aq65+bpnjtXS9LRe8ZYemtc30hGHcnGxIQBdfQAG9Cc=;
        b=XGFhb1T9+jgEj5XqcDckx9/B8iKIdqMfOs7f3bmgNlHsg5ViJy7P/RYRBwbk+ORTPin2Q+
        G2d/Rqv7Md+knuymp6J+27h9v/LNUTuXkJ9PYblRI6B5A0Ba9OquCj4hsK53ADi3heXK3j
        9hwOx/cioiyWvC5AYwHWlAe4/l5zl4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-N9HDgfL-O1WzoMJsH2VmOQ-1; Fri, 04 Mar 2022 07:24:30 -0500
X-MC-Unique: N9HDgfL-O1WzoMJsH2VmOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBD8800423;
        Fri,  4 Mar 2022 12:24:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9364A7D704;
        Fri,  4 Mar 2022 12:24:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hyperv: make the format of 'Hyper-V: Host Build' output match x86
Date:   Fri,  4 Mar 2022 13:24:25 +0100
Message-Id: <20220304122425.1638370-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, the following is observed on Hyper-V/ARM:

 Hyper-V: Host Build 10.0.22477.1061-1-0

This differs from similar output on x86:

 Hyper-V Host Build:20348-10.0-1-0.1138

and this is inconvenient. As x86 was the first to introduce the current
format and to not break existing tools parsing it, change the format on
ARM to match.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/arm64/hyperv/mshyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index bbbe351e9045..7b9c1c542a77 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -60,8 +60,8 @@ static int __init hyperv_init(void)
 	b = result.as32.b;
 	c = result.as32.c;
 	d = result.as32.d;
-	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
-		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
+	pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
+		a, b >> 16, b & 0xFFFF, c, d >> 24, d & 0xFFFFFF);
 
 	ret = hv_common_init();
 	if (ret)
-- 
2.35.1

