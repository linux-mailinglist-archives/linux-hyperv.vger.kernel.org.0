Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380901E1761
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2020 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbgEYVuN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 May 2020 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgEYVuL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 May 2020 17:50:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E30C05BD43;
        Mon, 25 May 2020 14:50:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so22119908lji.12;
        Mon, 25 May 2020 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3gzvIrCtH9Df/NLmyQMD/XYXqiL8jSn2MtUonIxWb8=;
        b=UGNcoda8+SrBWS7eulpI4+FnLj5J6/Qee9MfQ+/mv07vDKuYqIwXG98ShBDrOQze8u
         wR3LZYyo+cv6CWB20fqbmm0i5XxQxg84cgG0STwWelmCH+AvvzlSrHryTMvNsP+GqCvO
         sJSMKKYhR8bNrwiw3PT9zWgeG6pFhpLB3Mw6+vfIfVz6VJGqCOE0EkToek2TMphmPbcv
         W/1OTgvsrHvlvnhB6hyLES6yYtCPZYafElc3zm1f64n/pcBEzdJ2XVwI0H9RYCpVjsTM
         H41UnbpToNdVYqt9gD0D5tGHycJmlNxCdFbgzMtR9cy9Wtj0LNeNfOt0db2/9QDedjUQ
         AQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3gzvIrCtH9Df/NLmyQMD/XYXqiL8jSn2MtUonIxWb8=;
        b=dCHbctmmyQ1IDAjQyKKYAYpgrkCREDxbjdTzTtFZRoEuRq6DQ6MRVOSU0GHnM0GQi5
         YtXJv+fVQdE54e+Tf7NYeIELV+XEa00Uqfjx1XceF1SkuGjiOc9XX6PYgK5YqRdHnTd2
         wQT4xDdnEPBcbWy5QPXwNU42YGa0nqnICviPxcpzQQA7untYKvYO9CEpVhy5P5ZwelAu
         S3iBE6Q3h4hI90Khzvd4MjL21K018ovm2gPRhHQEQ5Qs9SpOYHZu6GSUYSBjVZ2+Z3Yj
         dSeiejFrbHkyblV+lqppiy1JYfsq1NscgM8O+6mOzejw6moUEgdGabXPb8HwvHYUsLRi
         hOVw==
X-Gm-Message-State: AOAM530Qhut26VtUn8NzRRgRh4X2gkC3rzxpsYaJNFx8ka/AICrcWGiw
        7DUSsF/m8tTbZJy95fm9Q3s=
X-Google-Smtp-Source: ABdhPJx9X4aZu61ScTGP3NPyoUfBhL/rS1/qN/91Xs7Cn5s8cR7dXu4bbV3uTG/t0k31ksONuNAa/w==
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr14646090lja.56.1590443408808;
        Mon, 25 May 2020 14:50:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id e21sm3893338ljj.86.2020.05.25.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:50:08 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH 1/2] iommu/hyper-v: Constify hyperv_ir_domain_ops
Date:   Mon, 25 May 2020 23:49:57 +0200
Message-Id: <20200525214958.30015-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The struct hyperv_ir_domain_ops is not modified and can be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   2916    1180    1120    5216    1460 drivers/iommu/hyperv-iommu.o

After:
   text    data     bss     dec     hex filename
   3044    1052    1120    5216    1460 drivers/iommu/hyperv-iommu.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/hyperv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index a386b83e0e34..3c0c67a99c7b 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -131,7 +131,7 @@ static int hyperv_irq_remapping_activate(struct irq_domain *domain,
 	return 0;
 }
 
-static struct irq_domain_ops hyperv_ir_domain_ops = {
+static const struct irq_domain_ops hyperv_ir_domain_ops = {
 	.alloc = hyperv_irq_remapping_alloc,
 	.free = hyperv_irq_remapping_free,
 	.activate = hyperv_irq_remapping_activate,
-- 
2.26.2

