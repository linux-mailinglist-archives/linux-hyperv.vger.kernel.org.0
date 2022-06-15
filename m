Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0E54D0E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jun 2022 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358448AbiFOS2x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Jun 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiFOS2u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Jun 2022 14:28:50 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41703C499;
        Wed, 15 Jun 2022 11:28:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id c21so16512570wrb.1;
        Wed, 15 Jun 2022 11:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1SFZ6MZWRb+dA4s/bCJZ/ZRO+w+dyhlktivoc3kZFU=;
        b=kpmoCEusZIUb5cAtZvecB91+JUuCEJJSF39RxiQxrd0dLbg/59ReB6RSrwcMc/SBRF
         49zPlC2I1JJk3GZh0BbmixH/jO4ZKbEw4NRziRoMGEAksMFeyMxMjnw6lLyKAFYwvxKu
         YK2j1zlwUhWSbKq2cdNNlUrsM2WYRwXlEgrCZLgHmXQCrx52b6rviYf8M3ZaXiZUFSBJ
         wetzU8SWwGLh++So50oe0EneSutVBlSFam4VeX2e84hc7R2bV9bE8naTeL3HKPtrnFna
         0P3SWueuH3886IG2bu8IbhfW7ZW+pWRMQwFGCqJvudIbFG3i/BsXy/5n4oqLmiVLULtU
         kl3w==
X-Gm-Message-State: AJIora9z0pRTxy4FB8YrPxOZZwuRqJFQHNjgWt70jHVVxtPLeuRsfheK
        NuwxnBDE+/kOxIVRtaDVM6c=
X-Google-Smtp-Source: AGRyM1uVqkRyKPo9IPy3Znjd5I3YXbPg0SecgRP3nQPk9x9/HkOToyOmF/NisS4GUV9w/gu3cI4eOg==
X-Received: by 2002:adf:fd0a:0:b0:210:32dc:7519 with SMTP id e10-20020adffd0a000000b0021032dc7519mr1043351wrr.181.1655317728299;
        Wed, 15 Jun 2022 11:28:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b00212a83b93f3sm15386971wrz.88.2022.06.15.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 11:28:47 -0700 (PDT)
Date:   Wed, 15 Jun 2022 18:28:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: Re: [PATCH V3] x86/Hyper-V: Add SEV negotiate protocol support in
 Isolation VM
Message-ID: <20220615182846.oliacmkrivhh5kx7@liuwe-devbox-debian-v2>
References: <20220614014553.1915929-1-ltykernel@gmail.com>
 <PH0PR21MB30252886961F6D7EA7B7EBE6D7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30252886961F6D7EA7B7EBE6D7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 14, 2022 at 04:50:36PM +0000, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 13, 2022 6:46 PM
> > 
> > Hyper-V Isolation VM current code uses sev_es_ghcb_hv_call()
> > to read/write MSR via GHCB page and depends on the sev code.
> > This may cause regression when sev code changes interface
> > design.
> > 
> > The latest SEV-ES code requires to negotiate GHCB version before
> > reading/writing MSR via GHCB page and sev_es_ghcb_hv_call() doesn't
> > work for Hyper-V Isolation VM. Add Hyper-V ghcb related implementation
> > to decouple SEV and Hyper-V code. Negotiate GHCB version in the
> > hyperv_init() and use the version to communicate with Hyper-V
> > in the ghcb hv call function.
> > 
> > Fixes: 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB version")
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> > Change since v1:
> >        - Negotiate ghcb version in Hyper-V init.
> >        - use native_wrmsrl() instead of native_wrmsr() in the
> >        	 wr_ghcb_msr().
> > ---
> >  arch/x86/hyperv/hv_init.c       |  6 +++
> >  arch/x86/hyperv/ivm.c           | 84 ++++++++++++++++++++++++++++++---
> >  arch/x86/include/asm/mshyperv.h |  4 ++
> >  3 files changed, 88 insertions(+), 6 deletions(-)
> > 
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
