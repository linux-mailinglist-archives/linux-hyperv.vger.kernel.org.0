Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0F729845
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jun 2023 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjFILi2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFILi1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 07:38:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678130E8
        for <linux-hyperv@vger.kernel.org>; Fri,  9 Jun 2023 04:38:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so11963795e9.3
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Jun 2023 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686310703; x=1688902703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6e5QbRUnU+agFZANreqZIgq4SD5UQhoPe6DRJUY6y9k=;
        b=YMwWwqAnsDoN4SkvomdU10HDl54IFKKlrEjetiCPwmKf2brL04M3tC2/hSLmW31nPB
         HE4IJnCcnnApNMje3Akdyb7kZAMQRFTao7i/N2oXp+vhpJBz4AlksxYQVeEgWDs5pVFk
         WhlQrAjm3HGufIfHlnIfnhJhhvW24ZH9sUFq3EftfbMwaSHkMFzMKpOE/sr2UTyfuhGs
         yHyL0RlZpXRy8G6jSsWOv7yq/rxTTd2tLMYpcIWVtvuPmw0zj8yceWAV5mcPYozfl1W3
         tZ5YKbtv8WmiSkdwqDEPla45xeAmRU4oIu8eUGvwFnbHTzAG8a4BqC1FPhP3cxaIS/A/
         lKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310703; x=1688902703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e5QbRUnU+agFZANreqZIgq4SD5UQhoPe6DRJUY6y9k=;
        b=DwD7M5bX+pYxW6zwOqxZ/Thf+EtsFDPOqPlAycxVzdv0gpOurG5vbHuC8EJc08JVp+
         5q7efdErM/EfqF4LbgdL50GcP3HJ7s3nJb+RPRCY6GBzT0cOdW67uRZFLH2DBcKew+xF
         4GkHoeF/+rE2ArhvkxQi+54efzP9bVft93Fnb9qlrjUY8quN+pIU7MP/3q+vggOyZMOR
         3kox85wrZpmNascaJUM2iC4Bwpy1H45CADIYKi2ZaKpgKurvlSw3vRzckgwHjuZdVzr1
         UkJHqHmN939AMJxL9ErnouBg/NGwqLcMZfI/vnAzneIg6b/jVyXZedmg1DVCbIIm4Wnr
         FetA==
X-Gm-Message-State: AC+VfDzYmRCID/T7UuCKDyj101sy6w1qnUk8SFPWQvvUKpQWp4vdOD8Y
        a4l8Ck+WYwdve8g0GSKcuRnPWg==
X-Google-Smtp-Source: ACHHUZ5tXNBQnN0YokqinPTWBRgL5yCO5urh+1uT1H6tsM9CPm+SC1MbYVNW80JpCuQ2kovJMT8d2g==
X-Received: by 2002:a05:600c:cd:b0:3f7:e7a0:967c with SMTP id u13-20020a05600c00cd00b003f7e7a0967cmr748405wmm.19.1686310703366;
        Fri, 09 Jun 2023 04:38:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f6f6a6e769sm2422024wmi.17.2023.06.09.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:38:22 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:38:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     simon.horman@corigine.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] tools: ynl: Remove duplicated include in
 devlink-user.c
Message-ID: <ZIMPLYi/xRih+DlC@nanopsycho>
References: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fri, Jun 09, 2023 at 10:52:47AM CEST, yang.lee@linux.alibaba.com wrote:
>./tools/net/ynl/generated/devlink-user.c: stdlib.h is included more than once.
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
>Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>---
> tools/net/ynl/generated/devlink-user.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
>index c3204e20b971..18157afd7c73 100644
>--- a/tools/net/ynl/generated/devlink-user.c
>+++ b/tools/net/ynl/generated/devlink-user.c

You are patching generated file, as the path suggests.
See what the file header says:
/* Do not edit directly, auto-generated from: */
/*      Documentation/netlink/specs/devlink.yaml */


>@@ -8,7 +8,6 @@
> #include "ynl.h"
> #include <linux/devlink.h>
> 
>-#include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <libmnl/libmnl.h>
>-- 
>2.20.1.7.g153144c
>
>
