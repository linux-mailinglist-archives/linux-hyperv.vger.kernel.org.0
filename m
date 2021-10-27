Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4143C613
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Oct 2021 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhJ0JIT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Oct 2021 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhJ0JIT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Oct 2021 05:08:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D629C061570;
        Wed, 27 Oct 2021 02:05:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m21so2243599pgu.13;
        Wed, 27 Oct 2021 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqVpo2UqAbSygTHypSN0KNUq0+j4kDd6u6NCg3V4iYg=;
        b=dAtSaXD5wh/RyLLKB2ZeCxosDgq0VzzMbGS8qHTDkvQrf8UMKpmDt3CPngb8bd7V9o
         Z/yUaRIWdncbJj8oAGNMtflBEwFFbVARk4tgZZNZ6W5CrkuOsdtPdjll0JAKo4MBPOz0
         EwsSNoj9tSqOKGaTyI1XHF8YpoT8DXFHjld4ad/5VkyCerQhLzYW92VIkpjTU0Q+/iLj
         drbyH9MdGjSLqzNdHRkQGN9YmqCSBI67CFSI5Qvq0v/Wk8M1gDUxhZfDvZgWFS3JfQzK
         ivm0iI4jW2JjDRTPsrbt+3znb3J+IXjXB+GgiujgqnTeo8BgO9HUpFBcz5pFpxxEU0Gx
         ZNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqVpo2UqAbSygTHypSN0KNUq0+j4kDd6u6NCg3V4iYg=;
        b=3ObqFS1b1tHt8wpTR83NGQHxQV/0m7BDUk97Q+KTOvc3qYE5gQ9y0tT3FqZ8vxYKjV
         0zBdJNCBuWBImqGOo4YlBceVitvEJUaOq9Tbybbq/ruie8Lzq5Jgbnx5fAH2W909n+5O
         RTuKFsof0Cjxgpiox3U4wheVSlju4+sRu+dVzp31TrTu/TjjvmvnoaSP3yCj/fHQtKvU
         aqyBS2KgDUgjWKLUDE04CmtosYTPUH6hXc7o/uKGopCSvyZkCk3OZzqYSht4zhr1sjEe
         merAb3dcAMFXGTeDVxyjlD0S3taBC8RLaW8YzJfijesUnO1clfisfd0XN1hkHOoXY7WV
         /NYw==
X-Gm-Message-State: AOAM5325PzG5ehSyDADnMv6T3L47nEbjX6O32ISjISvXrUL0XNgniy8C
        MDSLVa1klCc0sdlLtoUDB0M=
X-Google-Smtp-Source: ABdhPJwnUpgqIvUcI5M6UTN6L8zovE2ZtBhR6BKxEGcxu0V6i/hmnjtzKZD0mPRvkBbZhEVo3IDbig==
X-Received: by 2002:a05:6a00:21c6:b0:44c:937:fbf3 with SMTP id t6-20020a056a0021c600b0044c0937fbf3mr31598999pfj.2.1635325554176;
        Wed, 27 Oct 2021 02:05:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k13sm29030348pfc.197.2021.10.27.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 02:05:53 -0700 (PDT)
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
Subject: [PATCH] x86/hyperv: remove duplicate include in ivm.c
Date:   Wed, 27 Oct 2021 09:05:44 +0000
Message-Id: <20211027090544.2383-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'linux/types.h' included in 'arch/x86/hyperv/ivm.c'
 is duplicated.It is also included on the 12 line.
'linux/bitfield.h'included in 'arch/x86/hyperv/ivm.c'
is duplicated.It is also included on the 13 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 arch/x86/hyperv/ivm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 4d012fd9d95d..479201ceae8e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -9,8 +9,6 @@
 #include <linux/types.h>
 #include <linux/bitfield.h>
 #include <linux/hyperv.h>
-#include <linux/types.h>
-#include <linux/bitfield.h>
 #include <linux/slab.h>
 #include <asm/svm.h>
 #include <asm/sev.h>
-- 
2.25.1

