Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400544EAE4B
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Mar 2022 15:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiC2NWX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiC2NWW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 09:22:22 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5641BEA8;
        Tue, 29 Mar 2022 06:20:39 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so1177127wmq.0;
        Tue, 29 Mar 2022 06:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKTqZIz9JeHSISPinldYjkY8di7f/5w6ccPx7r2EMfs=;
        b=4rGqTaUXW7yeFJtt0BuRHoBPXUtJQJBtIt7IE0BHMLTXnGGnqs25SC79wGVvuMGnoj
         wjWQBhy7L/jWR5Hd+q5WOp7UGdLZC6Z+wA7M2TR2ioOf8hHuAU6+9cuqlXjFs1um03oi
         vX8ok9OnRar36ExK5Ul42muPWARaL0Ky5RHd1wsoFnWEFQ4mM9P0UDq0HW25LeOnVYlL
         yfewiQLL0EHrOs/scyo5mm1KhVqq2vyuCS5ujTcWyV4FF2cKUj7fqlv7kMcxWTWPZXiP
         ma2RuMMlKoyWhExgwgK+Jn+njY/michYH7SxO3LSqxlvhsIdriNGU/8L0Z3VwSlr8rcz
         S11w==
X-Gm-Message-State: AOAM530tcMrh7BdfSAmXUwCaQCeWt8aoNGGAizyVqY4R+avkL4jJjAJW
        2V7pxc8AUXH+BI7cJwNcKy4=
X-Google-Smtp-Source: ABdhPJwdNlS6AjgkfIPNK8gfKDsWUJC+PTZeEYJpNvdu2Zdo6uZKQnVrvlt9tCWMXb0Erc+rXAqadw==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr6835620wmk.118.1648560038007;
        Tue, 29 Mar 2022 06:20:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b0038cc9d6ff5bsm2202162wms.4.2022.03.29.06.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:20:37 -0700 (PDT)
Date:   Tue, 29 Mar 2022 13:20:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com, decui@microsoft.com
Subject: Re: [PATCH 1/1] hv: drivers: vmbus: Prevent load re-ordering when
 reading ring buffer
Message-ID: <20220329132035.k6zjsp6lpx4xm3k5@liuwe-devbox-debian-v2>
References: <1648394710-33480-1-git-send-email-mikelley@microsoft.com>
 <20220328231233.GA102571@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328231233.GA102571@anparri>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 29, 2022 at 01:12:33AM +0200, Andrea Parri wrote:
> On Sun, Mar 27, 2022 at 08:25:10AM -0700, Michael Kelley wrote:
> > When reading a packet from a host-to-guest ring buffer, there is no
> > memory barrier between reading the write index (to see if there is
> > a packet to read) and reading the contents of the packet. The Hyper-V
> > host uses store-release when updating the write index to ensure that
> > writes of the packet data are completed first. On the guest side,
> > the processor can reorder and read the packet data before the write
> > index, and sometimes get stale packet data. Getting such stale packet
> > data has been observed in a reproducible case in a VM on ARM64.
> > 
> > Fix this by using virt_load_acquire() to read the write index,
> > ensuring that reads of the packet data cannot be reordered
> > before it. Preventing such reordering is logically correct, and
> > with this change, getting stale data can no longer be reproduced.
> > 
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> 
> Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> 
> Nit: subject prefix -> "Drivers: hv: vmbus:".

Applied to hyperv-fixes. Thanks.

> 
> Thanks,
>   Andrea
