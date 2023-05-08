Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FED6FB607
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjEHRiy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjEHRil (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 13:38:41 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DA7AAA;
        Mon,  8 May 2023 10:38:32 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so32658615ad.3;
        Mon, 08 May 2023 10:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567511; x=1686159511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QoFpsxFnIi43IA3WhIvzttrLZvU1US3Lj4LjDzMa2M=;
        b=QcPdAXdccNqF0WKZ8HsZ9p/VACdx2Zy5WIU3kxitFe/TjxOmvnr8u5trJZBSlHz/Tw
         nz/bvEDfY56gGnb+wnv+fus7YVCaJSUDQO2mGIBmiLm0OyYBC7/Tckmk2fwFes7vLWEv
         /NsrflbUbvH1h3AI1aL9qVUGLbcRTqG7b5Skl1ccekzLu74WGNgeOMr7N3x/RMFUdt5v
         d73lJ3kw0FdOlZS1IC9z2Imhf0owRA+ItkK7/w1v1UGq7ZkCu8PKtWm0+FAjJ3XCUD4G
         w2lBnMi+WeexnGqrGPs1HhnOrSKMtlj4JczZ8ceKa/IanWkKlIuMtwIzJBc3MfPNvAjA
         Eg9g==
X-Gm-Message-State: AC+VfDya/mIX/XWbRxbi+tk800taObznLeV0SHGdHJZH8KeY8zDM7ppV
        s7cPldSCaB0iln36aoEDqx5ER3tofyE=
X-Google-Smtp-Source: ACHHUZ6DJUfR6S3+HMNfkw8Wb61YopxgIZbPDTFWp0W5kCXFBb/FfPA5QI1Ak/S4pKL0NMgC0tup3g==
X-Received: by 2002:a17:903:191:b0:1ac:750e:33f4 with SMTP id z17-20020a170903019100b001ac750e33f4mr5844935plg.32.1683567511266;
        Mon, 08 May 2023 10:38:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id om8-20020a17090b3a8800b002471deb13fcsm10375690pjb.6.2023.05.08.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:38:30 -0700 (PDT)
Date:   Mon, 8 May 2023 17:38:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if
 hv_synic_alloc() fails
Message-ID: <ZFkzlQCoUYDimcMI@liuwe-devbox-debian-v2>
References: <20230504224155.10484-1-decui@microsoft.com>
 <BYAPR21MB168862E4608ACC6F734EECA4D7739@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB13353DEBB073AB77C933C885BF739@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13353DEBB073AB77C933C885BF739@SA1PR21MB1335.namprd21.prod.outlook.com>
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

On Sat, May 06, 2023 at 02:38:04AM +0000, Dexuan Cui wrote:
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Friday, May 5, 2023 5:30 PM
> > ...
> > From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, May 4, 2023 3:42
> > PM
> > >
> > > Commit 572086325ce9 ("Drivers: hv: vmbus: Cleanup synic memory free
> > > path")
> > > says "Any memory allocations that succeeded will be freed when the caller
> > > cleans up by calling hv_synic_free()", but if the get_zeroed_page() in
> > > hv_synic_alloc() fails, currently hv_synic_free() is not really called
> > > in vmbus_bus_init(), consequently there will be a memory lead, e.g.
> > 
> > s/lead/leak/
> 
> Sorry for the typo. Wei, can you please help fix this?
>  
> > > hv_context.hv_numa_map is not freed in the error path. Fix this by
> > > updating the goto lables.
> > 
> > s/lables/labels/
> Ditto.
>  
> > The statement in commit 572086325ce9 was true at the time of that
> > commit.  But I broke things in commit 4df4cb9e99f8.  Should add a
> > "Fixes:" tag for 4df4cb9e99f8.
> 
> I suppose Wei can help add the line:
> Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU onlining")
> 
> > Nits notwithstanding,
> > 
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
