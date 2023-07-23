Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C075E5B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jul 2023 01:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWXQA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jul 2023 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGWXQA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jul 2023 19:16:00 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7CE4B;
        Sun, 23 Jul 2023 16:15:58 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b852785a65so24375125ad.0;
        Sun, 23 Jul 2023 16:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690154158; x=1690758958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNkYcJGF2U6ccOrqy8oHiZSNN81wGQ9+4DqeH0IB8jA=;
        b=BZhuJE0lnL1pByH4ROqSIem97zPo4NB+uEkyaQLBv2gMYen7R4bHPGRH4PEYNkGT4+
         7iMfybc5AZD/WC553OK/BwwYKvL5Hp740yTy7IdkzkfFUuMnz50EK3W5qEnMlf4CUmL3
         1aue47uEvFHFyExmU6rXasEAwv2zOe8ByYK2YfV1EcYzGu0jh+HMdZ6mgL4GtvYYorWk
         e4q3V3r02vCnw4ZuqLTVpKrt3KUpJij3kAWsf++MGUmkbwgYTXNWGpRLwqRR40dE0Opn
         DM3ifGed+pEW+r9mnBkk9YzZJn2DdFjHmM4/ypn27dupf+XlpyaZiUJ9d/kS4o3O290I
         ndhg==
X-Gm-Message-State: ABy/qLaHgctcsJaAHviD9s0xZenlPvoZ1N/zTsD77U5eT5IFsanMqEF/
        2h94TlDNI+M+91LRobbBU1Y=
X-Google-Smtp-Source: APBJJlGly9bOV9iyKhNmRbGB0QmVJDspu/SEDpuWGk5dIsUDdACb9Q4GSR0sZ4DPUQ9kLhBMJ7aPKA==
X-Received: by 2002:a17:902:ea0a:b0:1b0:3d03:4179 with SMTP id s10-20020a170902ea0a00b001b03d034179mr10518228plg.6.1690154157985;
        Sun, 23 Jul 2023 16:15:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001b80d399730sm7392329plg.242.2023.07.23.16.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 16:15:57 -0700 (PDT)
Date:   Sun, 23 Jul 2023 23:15:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "huzhi001@208suo.com" <huzhi001@208suo.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Fix warnings in mshyperv.h
Message-ID: <ZL20q7yVHqX0F8K8@liuwe-devbox-debian-v2>
References: <tencent_7A4BAF2CDEE6AC56AB5ABBCE9CA1C2FE5205@qq.com>
 <f5f5e7f2627ea55d81bc2d39420c40e8@208suo.com>
 <BYAPR21MB16885FB2E77FC9ADB1C8B48DD736A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16885FB2E77FC9ADB1C8B48DD736A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 12, 2023 at 09:06:30PM +0000, Michael Kelley (LINUX) wrote:
> From: huzhi001@208suo.com <huzhi001@208suo.com> Sent: Wednesday, July 12, 2023 4:23 AM
> > 
> > The following checkpatch warnings are removed:
> > WARNING: Use #include <linux/io.h> instead of <asm/io.h>
> 
> The "Subject:" of the patch should probably start with "x86/hyperv",
> not "clocksource".  Usually I look back at the commit history of a
> particular file and try to be consistent with the Subject: prefix that
> has been used in the past.  "x86/hyperv" is typical for this
> include file.
> 
> Other than that,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

There is only one warning fixed.

I changed the subject line and commit message.

Applied to hyperv-fixes. Thanks.

> > 
> > Signed-off-by: ZhiHu <huzhi001@208suo.com>
> > ---
> >   arch/x86/include/asm/mshyperv.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/mshyperv.h
> > b/arch/x86/include/asm/mshyperv.h
> > index 88d9ef98e087..fa83d88e4c99 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -5,7 +5,7 @@
> >   #include <linux/types.h>
> >   #include <linux/nmi.h>
> >   #include <linux/msi.h>
> > -#include <asm/io.h>
> > +#include <linux/io.h>
> >   #include <asm/hyperv-tlfs.h>
> >   #include <asm/nospec-branch.h>
> >   #include <asm/paravirt.h>
