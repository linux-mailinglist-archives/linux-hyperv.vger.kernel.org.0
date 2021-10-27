Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC543C4EE
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Oct 2021 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhJ0IUv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Oct 2021 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbhJ0IUu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Oct 2021 04:20:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB20C061570;
        Wed, 27 Oct 2021 01:18:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s136so2190408pgs.4;
        Wed, 27 Oct 2021 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXRPSN6OlIv6jlVZjC7cOJCLvxxJIsw2Rw1gemHlZyI=;
        b=Ft+chDfvPPl73yp5hjTRT1amfGEuSr3Uw/MjmPxb3B2mnBsMt35ANthkILFrjF4Z9A
         yrhDiPMnDNM8t9HjGJGotbc2xqPa02+Vu/IxYf8MU3HrkU047GuGMINGZSNY79dYw/eg
         4JVev1cxx8rduNhcP+Avw487JjDzl5QTN4HMmG4BoMKGeI8NjWLk4nJuJOhF3ll3Ns5C
         CGhLDFrNSPNOEPtfZnNAR+PQHInzQNPuHco8Cq63cXLS+Y/QcOSmduxodWlf4lWKosSY
         aM3jShzSYaFCBnch0wIgZ3V8G0XPoWhA72wq/0xd8R9hN4L9QeKFnwwtG5OVxKEmTUCH
         S4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXRPSN6OlIv6jlVZjC7cOJCLvxxJIsw2Rw1gemHlZyI=;
        b=ZCAsNbvbNMjyQ7e5xLAoeA7QER/RIovp57JtnuGu2ySWH8YnQ/5MXNHNKnWCzl+hyL
         x5DpwwmcAcCTcIJvvNapoqCzwch3tGwdGdW0//s/Aun3hfJwhjQQqDPoXO1+aCXhNg+l
         EhewTT2eDSlLJumsFli1zxqVrZyPbVTMtdISdGDPPnA6X/eaCNVpvpHTwkyvB/tsOqsg
         QinkXYVXzdDp2fRLQUzEQpeG1pOZKNH57xXxU4rEbhfCkTDdOMKOidQa/Y6gZho/dzfU
         tVZ/HqZ00405r/f153jmR9f0K05ywsJeqp/z1zUEkiC8PJamHLGo3lmSYxS1piO+bvqk
         vHfA==
X-Gm-Message-State: AOAM532pfbUYzddl6LqyZV963BQw3s49FmXBIViZiUPV4CpwTyfVhcnF
        5DxNTG28Lx7gSpPAjWSyWJykWKRqh1g=
X-Google-Smtp-Source: ABdhPJxx+7ebJVfHEH0GgucCgPhQHcerTc7P/V5apt64IXnJe6kcSV2KD8C7SpHi9pxXvz/CsWs2UA==
X-Received: by 2002:aa7:951a:0:b0:47c:608:1f3f with SMTP id b26-20020aa7951a000000b0047c06081f3fmr13167715pfp.30.1635322694535;
        Wed, 27 Oct 2021 01:18:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p16sm21623141pgd.78.2021.10.27.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:18:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/hyperv: remove duplicate include in hv_init.c
Date:   Wed, 27 Oct 2021 08:18:08 +0000
Message-Id: <20211027081808.2099-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'linux/io.h' included in 'arch/x86/hyperv/hv_init.c'
 is duplicated.It is also included on the 23 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 arch/x86/hyperv/hv_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a16a83e46a30..4fb7c7bb164e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,7 +20,6 @@
 #include <linux/kexec.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
-#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
-- 
2.25.1

