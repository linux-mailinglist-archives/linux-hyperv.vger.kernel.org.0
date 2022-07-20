Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5464F57C109
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Jul 2022 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiGTXnl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jul 2022 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiGTXnj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jul 2022 19:43:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D163570E49
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jul 2022 16:43:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i4so5058702qvv.7
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jul 2022 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RMWa0xSoaL7B2aaDLU4AquBAwXY5T4zVNdrwgZSQKQ=;
        b=Ot5athrApcpdcvUNzLe9OfexoqvO26PdLjB8LFKfQpvSTzGIzRKJM2L4RH1uc+ME0M
         92kFtslZKestwARBw+eBvp1K34x9uqwSiUROG6sU1q1HrxlTRwpPPsuGsd0iU765aEvG
         Rn34ICnJN/3L/k6GhkTtDQcpLolrJlTbUm9eZdboYQHiyXyGyplYgOi4dIQJunsb5jHA
         nqOwyG//HVJCxRZ0UxvzSRaP8Uty4I65JmvxrKYAIDOH9TX7L1WOSA3r1mklTG+o7pNr
         8fjH0DH3t3EBQukMMX2JNR5N0Q/Nw/3Y7teIU4a/lor6SePtXtaFAdvc8xcPMpZO+nax
         vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RMWa0xSoaL7B2aaDLU4AquBAwXY5T4zVNdrwgZSQKQ=;
        b=vHsOpkieKbtpkWoH+6aH8myAeGLQ9Va7SncmBbLneCaM1joblvRTBnNH0+Ff7kAj3s
         d3TN6JCjVZWlyUmvgpzzLDFW3duURD+V9OP+GfFpB9KAlaB5qHlHbOSyiLyjAx91wI9I
         3+EGrqE/8oLRxdaNFiDO2e7GxU47cRHYIn4beBrS348tUs2PXh0c1qgV8bloVWLAYlgq
         ncA4qEJLLpmx+IO3mPVHIOSvnVijizb5mSkWtCWy7AsN1jO1kOSgeYP6tia2WAHYvYTu
         QxC2FTpWMBHURtYpdVqHujSmeDszwmzAaPlOeWeHfF/Z0IifkKPxsOEYURrG1H2LLM3c
         p4pQ==
X-Gm-Message-State: AJIora82UslmyTX3eJutxERegjAOUISrFodvwTrsP37J5SkdgknMT5wb
        Aa7fAPLBu8Ns4u4T7M3X5BZu+g==
X-Google-Smtp-Source: AGRyM1tB9R3rUDukTdF+KkNXaMIev5xhPYoFuvblwiYMzmV8PCMT2wlMNqlR3rzngTwV4TVtix/8hg==
X-Received: by 2002:a05:6214:27ef:b0:474:9aa:9e4d with SMTP id jt15-20020a05621427ef00b0047409aa9e4dmr2893624qvb.82.1658360618033;
        Wed, 20 Jul 2022 16:43:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bk4-20020a05620a1a0400b006b5fe4c333fsm364916qkb.85.2022.07.20.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:43:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEJLs-001hkt-NS; Wed, 20 Jul 2022 20:43:36 -0300
Date:   Wed, 20 Jul 2022 20:43:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Patch v4 06/12] net: mana: Define data structures for
 protection domain and memory registration
Message-ID: <20220720234336.GR5049@ziepe.ca>
References: <1655345240-26411-1-git-send-email-longli@linuxonhyperv.com>
 <1655345240-26411-7-git-send-email-longli@linuxonhyperv.com>
 <SN6PR2101MB13276E8879F455D06318118EBF879@SN6PR2101MB1327.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB13276E8879F455D06318118EBF879@SN6PR2101MB1327.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 11, 2022 at 01:29:08AM +0000, Dexuan Cui wrote:
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > Sent: Wednesday, June 15, 2022 7:07 PM
> > 
> > The MANA hardware support protection domain and memory registration for
> s/support/supports
>  
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma.h
> > b/drivers/net/ethernet/microsoft/mana/gdma.h
> > index f945755760dc..b1bec8ab5695 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma.h
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma.h
> > @@ -27,6 +27,10 @@ enum gdma_request_type {
> >  	GDMA_CREATE_DMA_REGION		= 25,
> >  	GDMA_DMA_REGION_ADD_PAGES	= 26,
> >  	GDMA_DESTROY_DMA_REGION		= 27,
> > +	GDMA_CREATE_PD			= 29,
> > +	GDMA_DESTROY_PD			= 30,
> > +	GDMA_CREATE_MR			= 31,
> > +	GDMA_DESTROY_MR			= 32,
> These are not used in this patch. They're used in the 12th 
> patch for the first time. Can we move these to that patch?

This looks like RDMA code anyhow, why is it under net/ethernet?

Jason
