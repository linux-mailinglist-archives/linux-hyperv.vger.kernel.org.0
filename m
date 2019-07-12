Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1662A6691E
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGLI1k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:27:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLI1k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:27:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so4003413pfq.0;
        Fri, 12 Jul 2019 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZ8XQcqFPiBgKnC9B3u3J7ZO1DNl4k/Ar4Bg2fpOBFk=;
        b=ALfhC6m44wKGFkOBKD8GefYMIEHZd/i4kpqkHV7sELvOgFNGfnbbzj6oHuAltng+he
         AG0qyfbgmGNEe+ra92PRQ5Z1/meB/K87KLjtRJsLkGr3Lgijr+Ld5chPcmxmZcKi22iK
         NeSP9XxEYXoNqwgmgWO3o1PE4RG9f3Nw0na5qw16WODApyKYZh9oBfi3z/o9mCDugvSs
         dc6u1AJe+kvXzoSwouzr7z2EZbhBzzdrnJTz6ouMLahrTiQ/8En+7ySBO3o9P6tRN2a2
         /W0K61bounkFiRtSkjas1o885NCV8YNnSBIWgZmega5Spfl2VQVZ6fnyc8d4d1YAbeQz
         fWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZ8XQcqFPiBgKnC9B3u3J7ZO1DNl4k/Ar4Bg2fpOBFk=;
        b=AL8VpcqlaSgXjpSd8yhjtc8OgYF1HBZnLc5dPhI7Ic+JGT8hn0x6Z2BMNavT0tOmIA
         mBFy2i7gv1XYwsCkG7iTOKeqM92FmjLeefOsfb2YgOfLzZBipeHkhL995jdqGX0fYa2x
         cPdOhQ9PeBrYuFQb6hC1R+5ABFf7M4NvNczlW7VxCoh2tgNdSMdqkTQAgwnfVz+ASHss
         izAl1oFz35PkvuapRHvSJCuzJUYhze5OC77TATs5ZRO0y9H7iCWbZdleeddoY603ti6M
         pJJkDh+2D5cw+PpT/Kwaji9QldMi6nmWt5NdI0WHVFw3RP33B7ZTObPXuCGl47myYGgd
         +MRw==
X-Gm-Message-State: APjAAAV9EZ+t0iAiLi3sMu//UEREVfOKhA17/EYVAg3rouFLtRJMvvMK
        rbum1x0K9F4+/1l0TWvJz6PO9ejojRIuCQ==
X-Google-Smtp-Source: APXvYqxonCLjfrokyrAVOBWC/q01LGs7wcdrgVS/OXZZhdP3H7d0IBGzolaTtQZrkHunsms/ZKWvlg==
X-Received: by 2002:a17:90a:2305:: with SMTP id f5mr10738884pje.128.1562920059465;
        Fri, 12 Jul 2019 01:27:39 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id x25sm7938074pfa.90.2019.07.12.01.27.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:27:39 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:27:38 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] HID: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <5cfa6f8ded52ee709ede57a97fc71e8671b1ceb1.1562916939.git.m.maya.nakamura@gmail.com>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hid/hid-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7795831d37c2..cc5b09b87ab0 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -104,8 +104,8 @@ struct synthhid_input_report {
 
 #pragma pack(pop)
 
-#define INPUTVSC_SEND_RING_BUFFER_SIZE		(10*PAGE_SIZE)
-#define INPUTVSC_RECV_RING_BUFFER_SIZE		(10*PAGE_SIZE)
+#define INPUTVSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define INPUTVSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 
 enum pipe_prot_msg_type {
-- 
2.17.1

