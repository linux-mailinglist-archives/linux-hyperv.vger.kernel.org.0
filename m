Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857F87505E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jul 2023 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGLLXb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jul 2023 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGLLXa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jul 2023 07:23:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73597E5C
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jul 2023 04:23:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1FjK2L0lzBR7bB
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jul 2023 19:23:17 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689160997; x=1691752998; bh=SOvz6GqC7vW1AVzVuhoB8WL+4kp
        TaF3/5GQfCwX7vHk=; b=wL5GIQYyca3loGpKOw+c7u2g2JSwSaR1ACCvI9kJs2L
        hKWt4ym9BN3eXCdgP42sENataiPZsPhQO/UoScHliCPuqCohtKhosVTJ5iufbMma
        MbjC+xWIqmW9+63Zlk76ua2FDkEjNlUQSzH+ZH7stiZTMjVu0lt6xlk8hKBa931D
        tbgg+RIkNq73REHO3Qkt6H5CTyU801Pbz00xMXGNn7wSFHlctorPOLihFzYtk2pt
        ZRfd30xYYwZCAAQGz529Kmo0B4UdLqAEPvxSc3VQF/zWesgpnN61G13VAY1k0xzZ
        DkHmP+OW5ScKerh/f+rvmzPNMCM6dFoRzbgtUrWXAXA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AmYf7PlWz-Ms for <linux-hyperv@vger.kernel.org>;
        Wed, 12 Jul 2023 19:23:17 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1FjJ4RGZzBR5lc;
        Wed, 12 Jul 2023 19:23:16 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 19:23:16 +0800
From:   huzhi001@208suo.com
To:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, tglx@linutronix.de, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Cc:     hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Fix warnings in mshyperv.h
In-Reply-To: <tencent_7A4BAF2CDEE6AC56AB5ABBCE9CA1C2FE5205@qq.com>
References: <tencent_7A4BAF2CDEE6AC56AB5ABBCE9CA1C2FE5205@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f5f5e7f2627ea55d81bc2d39420c40e8@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The following checkpatch warnings are removed:
WARNING: Use #include <linux/io.h> instead of <asm/io.h>

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/mshyperv.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mshyperv.h 
b/arch/x86/include/asm/mshyperv.h
index 88d9ef98e087..fa83d88e4c99 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -5,7 +5,7 @@
  #include <linux/types.h>
  #include <linux/nmi.h>
  #include <linux/msi.h>
-#include <asm/io.h>
+#include <linux/io.h>
  #include <asm/hyperv-tlfs.h>
  #include <asm/nospec-branch.h>
  #include <asm/paravirt.h>
