Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E976CDEF
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHBNJA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHBNJA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 09:09:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726F268F
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Aug 2023 06:08:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f94328a4so659776b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Aug 2023 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690981738; x=1691586538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBqsAak3f8r/pBMp8meKMO8oHy1JW3Rq4B3baHzRz4o=;
        b=VPf6NqoPsprCbobtw/gxZCb/cj2Z5jYdgStMQjLAVKe3N5i6kMDCiAHGxw+kAkqWgT
         aXjwZoFchcfKppVDlU5yhq8c7B2t6LVHJ00cxq4ynfp0APN+lsKPunGBd9DYbsnJ1MTI
         pLWiCX8xeXhExfriJV/u25rDi7Y34fCap0yrTpUXI0j5LuYdnCBfIvstVSi2qMZdblp0
         sGrFGReWVPnXsCF5KxU9+IqfhNNvTgAymmxvsmpVvEaj/rKQaTwAeb9bMD6D9sA9hx4Z
         0HQOnCYH11ZEj5puIXQmpu2luRpLeM6gWfIqvRJGmV84ScyWxZrU9IWshiSN2U2N4AsU
         UOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981738; x=1691586538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqsAak3f8r/pBMp8meKMO8oHy1JW3Rq4B3baHzRz4o=;
        b=CVgIrPvncq0S8/d5sTf1QU4EHTXfRwUeE4zbeU8QT9e1pz/iW0eHw2QiISMB5bUEpb
         objsm4vt/Jh3VHCN92eNAwPNyGEQ4JNF1Wu9a4DpupfnzE/MJJG1TpDITup7dKu7hGWL
         0hzGI1WVx+fgAx8pHe23pXWsVln76LJuD0gvOofP+lT69AimoiufMdEDa3s6gIs48TMs
         AN+hPabNr0vpzwP1a7VthPAsynpp0PbiL7y0tBZ/4UhO7fi0PSBLfrR9FJsCG1ItunzS
         9VjAOCBgvWIFenwkMJDk53aKDV+yhw1XsahTXIS+3Y4V+J17+zPY8xd2OmUeyW8Tvzp3
         05aQ==
X-Gm-Message-State: ABy/qLa5HUw+tHaFUxvzXWhlRKpBkKH68Tjt/ISQ1wwnHUaZFoQsvUBs
        Ba6b7TBa6CUMROl9U5cd3J8M4A==
X-Google-Smtp-Source: APBJJlFDzrrksNLZ0Z6EgXh+jLOsPBCq5y3pEl5aO2DCttyleRHNSkSTQiZbg7FdpLd1xjmhEkcD6A==
X-Received: by 2002:aa7:9a8c:0:b0:686:5f73:4eac with SMTP id x12-20020aa79a8c000000b006865f734eacmr17349199pfi.13.1690981738109;
        Wed, 02 Aug 2023 06:08:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k5-20020aa78205000000b00682a0184742sm11344911pfi.148.2023.08.02.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:08:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qRBax-0032ah-HB;
        Wed, 02 Aug 2023 10:08:55 -0300
Date:   Wed, 2 Aug 2023 10:08:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ajay Sharma <sharmaajay@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt
 support to mana ib driver.
Message-ID: <ZMpVZwh9Y5W1XCsX@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
 <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMmZO9IPmXNEB49t@ziepe.ca>
 <F17A4152-0715-4E73-B276-508354553413@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F17A4152-0715-4E73-B276-508354553413@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 02, 2023 at 04:11:18AM +0000, Ajay Sharma wrote:
> 
> 
> > On Aug 1, 2023, at 6:46 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > ﻿On Tue, Aug 01, 2023 at 07:06:57PM +0000, Long Li wrote:
> > 
> >> The driver interrupt code limits the CPU processing time of each EQ
> >> by reading a small batch of EQEs in this interrupt. It guarantees
> >> all the EQs are checked on this CPU, and limits the interrupt
> >> processing time for any given EQ. In this way, a bad EQ (which is
> >> stormed by a bad user doing unreasonable re-arming on the CQ) can't
> >> storm other EQs on this CPU.
> > 
> > Of course it can, the bad use just creates a million EQs and pushes a
> > bit of work through them constantly. How is that really any different
> > from pushing more EQEs into a single EQ?
> > 
> > And how does your EQ multiplexing work anyhow? Do you poll every EQ on
> > every interrupt? That itself is a DOS vector.
> 
> User does not create eqs directly . EQ creation is by product of
> opening device ie allocating context. 

Which is done directly by the user.

> I am not sure if the same
> process is allowed to open device multiple times 

Of course it can.

> of lock implemented. So million eqs are probably far fetched .

Uh, how do you conclude that?

>  As for how the eq servicing is done - only those eq’s for which the
> interrupt is raised are checked. And each eq is tied only once and
> only to a single interrupt.

So you iterate over a list of EQs in every interrupt?

Allowing userspace to increase the number of EQs on an interrupt is a
direct DOS vector, no special fussing required.

If you want this to work properly you need to have your HW arrange
things so there is only ever one EQE in the EQ for a given CQ at any
time. Another EQE cannot be stuffed by the HW until the kernel reads
the first EQE and acks it back.

You have almost got this right, the mistake is that userspace is the
thing that allows the HW to generate a new EQE. If you care about DOS
then this is the wrong design, the kernel and only the kernel must be
able to trigger a new EQE for the CQ.

In effect you need two CQ doorbells, a userspace one that re-arms the
CQ, and a kernel one that allows a CQ that triggered on ARM to
generate an EQE.

Thus the kernel can strictly limit the flow of EQEs through the EQs
such that an EQ can never overflow and a CQ can never consume more
than one EQE.

You cannot really fix this hardware problem with a software
solution. You will always have a DOS at some point.

Jason
