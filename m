Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B36FB576
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEHQrL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjEHQrI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 12:47:08 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6A5BBC;
        Mon,  8 May 2023 09:47:05 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-643a1656b79so2810722b3a.3;
        Mon, 08 May 2023 09:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564425; x=1686156425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtQaPtzPJxzfRzbTYHRDpsI/2RLhceoREjCh61ZXViQ=;
        b=KbMBjUaLdORGVfQPpLvnOFwhKK0iNyhGYZgpm3S86J8neG4LAdE0kITo7/n3kS+mOq
         FplGTSWjneZzJgRsN/C50W9DkEYTLZhEBT7elTpA1ui4elqDasv4h478SQXRB0IrdYuj
         vpDAsVUh6nrfsrdgZxk/zpTuNi8DIl/GNdFaLZaFlyuk29NgupnX382ujmYAixh2J8S+
         9hgh3N0GV5Cfe85Vv7AkgZ711w3crqS+a3JNzQQ2LQcnIkX/Ee/N1NMwUwndPeYY9ii1
         5Mb7S82Di5yjuGbTUyXRCMlZBRAtPXg91tuYPyFJ7JabPTveNvmG1iXGdTv0wTayOQ1n
         Pmyg==
X-Gm-Message-State: AC+VfDy/WcFwuQfETrbZGzdJJxs19+riZymwBTRQtYLo2vBepIK+0Bag
        JABHQqiinByPrS4Bl2BzDII=
X-Google-Smtp-Source: ACHHUZ6iDk6e0wuQs2J3DGya+UkLJQk43UqvvLiv7luXIc/+jRrS052LjhSWHG593AcgPfRc98foMg==
X-Received: by 2002:a05:6a00:1391:b0:643:ba77:f265 with SMTP id t17-20020a056a00139100b00643ba77f265mr10991685pfg.25.1683564425143;
        Mon, 08 May 2023 09:47:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006413bf90e72sm206879pfn.62.2023.05.08.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:47:04 -0700 (PDT)
Date:   Mon, 8 May 2023 16:47:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Message-ID: <ZFknhiprxZUC5Bo7@liuwe-devbox-debian-v2>
References: <1682331016-22561-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB168833D41D1214DE3892874CD76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168833D41D1214DE3892874CD76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 01, 2023 at 04:57:56PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, April 24, 2023 3:10 AM
> > 
> > Assign the realmode pointers to noop, instead of NULL to fix kernel panic.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 1ba5d3b99b16..85d38b9f3586 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -20,6 +20,8 @@ void __init hv_vtl_init_platform(void)
> >  {
> >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> > 
> > +	x86_platform.realmode_reserve = x86_init_noop;
> > +	x86_platform.realmode_init = x86_init_noop;
> >  	x86_init.irqs.pre_vector_init = x86_init_noop;
> >  	x86_init.timers.timer_init = x86_init_noop;
> > 
> > --
> > 2.34.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
