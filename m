Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E295F8DEE
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Oct 2022 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJIUqi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Oct 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJIUqh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Oct 2022 16:46:37 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5B248C0;
        Sun,  9 Oct 2022 13:46:36 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id a10so14380113wrm.12;
        Sun, 09 Oct 2022 13:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aw+71CytpGk0aa1LMaSDXWBT629GJafQ2n8JcZFAks=;
        b=6lvs7B/Su132jEE0rPmbnBcanNWUHHxX2X/BGc5JxgA0Mtm5IlToIWfm2BB7nhjVd5
         N7fdP1tqYE4wQpy6nVZTL2bl6fI79MLYmRBs5WS3GgSJ6/bWha9RkU/qNKADtUD01t6O
         uiBWdgmqOIVsfQbobwbkdWGC6dc/jcHTJdW4haaD4Ym+2Yx3WsGhUnFgNpVaklNgJ/+N
         PBO9nQYTQyIbGNWbFcjgAF5Ae5WjsCdYO7bd2SaRTJ6Y9gXyVsxchSJPMRE/v5CFaI7I
         ErH8IDyVmih8Pe12Fc5Jb7jV1PVmKrOUjM5W05EKuZzwyzsCTI5gTJyMzSpOaYwCC0dY
         NAyg==
X-Gm-Message-State: ACrzQf0HC59NlMprFUjlFUn3j+yGUL42dx3sx4ikTFqFgrfGTM4HwYKk
        1FOQOPIajVS5CTCByDBRj/Y=
X-Google-Smtp-Source: AMsMyM4Mt2Uwocpva1GM/HMR8gajgdLfsws6PMbLFJB1tZVyRvvylo8SP/uCTea7NMgq6iBpYOwnFg==
X-Received: by 2002:a05:6000:170b:b0:22e:44d0:6bae with SMTP id n11-20020a056000170b00b0022e44d06baemr9347156wrc.99.1665348395186;
        Sun, 09 Oct 2022 13:46:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c2e5200b003c65c9a36dfsm1767119wmf.48.2022.10.09.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 13:46:34 -0700 (PDT)
Date:   Sun, 9 Oct 2022 20:46:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <Y0MzKa1nzfP+mhtX@liuwe-devbox-debian-v2>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
 <YzqiSK/s/oExlSrb@liuwe-devbox-debian-v2>
 <Yz7kd9oTs2Zn4YD3@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7kd9oTs2Zn4YD3@liuzhao-OptiPlex-7080>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 06, 2022 at 10:21:43PM +0800, Zhao Liu wrote:
> On Mon, Oct 03, 2022 at 08:50:16AM +0000, Wei Liu wrote:
> > Date: Mon, 3 Oct 2022 08:50:16 +0000
> > From: Wei Liu <wei.liu@kernel.org>
> > Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
> > 
> > On Wed, Sep 28, 2022 at 02:08:40PM +0000, Wei Liu wrote:
> > > On Wed, Sep 28, 2022 at 05:56:40PM +0800, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > kmap() is being deprecated in favor of kmap_local_page()[1].
> > > > 
> > > > There are two main problems with kmap(): (1) It comes with an overhead as
> > > > mapping space is restricted and protected by a global lock for
> > > > synchronization and (2) it also requires global TLB invalidation when the
> > > > kmap's pool wraps and it might block when the mapping space is fully
> > > > utilized until a slot becomes available.
> > > > 
> > > > With kmap_local_page() the mappings are per thread, CPU local, can take
> > > > page faults, and can be called from any context (including interrupts).
> > > > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > > > the tasks can be preempted and, when they are scheduled to run again, the
> > > > kernel virtual addresses are restored and are still valid.
> > > > 
> > > > In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> > > > single thread and is short live. So, in this case, it's safe to simply use
> > > > kmap_local_page() to create mapping, and this avoids the wasted cost of
> > > > kmap() for global synchronization.
> > > > 
> > > 
> > > The kmap call in that function is not performance critical in any way,
> > > and at this point in the initialization process I don't expect there to
> > > be any contention, so the downside of kmap is not really a concern here.
> > > 
> > > That being said, kmap getting deprecated is a good enough reason to
> > > switch to kmap_local_page. And I appreciate this well-written,
> > > well-reasoned commit message.
> > > 
> > > I will apply it to hyperv-next later -- I doubt people will object to
> > > this change, but just in case.
> > 
> > Applied to hyperv-next. Thanks.
> 
> Sorry Wei, based on Ira and Fabio's comments, do you agree me to send a
> follow on patch to remove that BUG_ON()? Or send the v2 patch?
> 

I just sent a PR to Linus. That PR includes your v1 patch.

While the code can be improved, BUG_ON that does nothing is harmless.
You can send a follow-up patch to remove the BUG_ON.

Thanks,
Wei.

> Thanks,
> Zhao
