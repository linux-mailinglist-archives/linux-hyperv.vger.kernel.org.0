Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6616E52AC0B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 May 2022 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiEQTf1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 May 2022 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352773AbiEQTfT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 May 2022 15:35:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F28522DB
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 12:35:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z126so15346890qkb.2
        for <linux-hyperv@vger.kernel.org>; Tue, 17 May 2022 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnbKYBhh3c63Yumph0EWjqW7Wj2wBUNjFmt4Rfdy8jc=;
        b=UCDLE6mdjuGa1AhVdCEcBtExr96rjGXBSfEIQfr7ykTyHhQER0s0t79knhisfx/JC1
         LjKqwJmJLW3zBjmEU2Rnwt7SKxPUics0pfUJVLOHxKJJL3Q18/6zj6anFNufHe7u6Twr
         LNNH2zyFm1uVvNAvNrH6PLvqGI5JoCIpeafoNbKLk2ArMwb81GrFbAO0pw1kAq5TfDWw
         lIO8eTksc5Cgo1IbAOny3t54T3tlORvXjrZ2VxK2keaT+hG7v0H6LH8ca5anh2hlDwDE
         y02VhaC+GMQGeVU/EG/l6UccIUFS9muojSW9hKGhwex+CwPVJm9IvzBQ+NRJGsIXocRd
         rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnbKYBhh3c63Yumph0EWjqW7Wj2wBUNjFmt4Rfdy8jc=;
        b=yxJ9seNQj3im2/WDAisI6PiNWn6o/WD8lN+/o7VFgBHtZ13kaWd06y5uZBnHDuEZuE
         Dt/UfpQGbq+/cABYZEcVzGaiTICBiN277YYx5Vl07h53fM5HRIZmtKwSrnT4ogJ5qngn
         +cU1F9dkUtHRfjeZDGcCDIiovZPndk4yAOAYGQWl9ZndvSf2x3oS5zdBb8FrGLNZUvGX
         8iccHlWgOpkGaXO6Bs3YZlb+hzS7IAHhUVyC3ar5wxSt3EuUxT6bW+XZRFfai75IsKY/
         GKOZ+UWolmP4kekaS/QxzeN+CVQ1aFpoj0173OCtpd9ypcOOXpA5872/A84ZNOKbPvw+
         z0ag==
X-Gm-Message-State: AOAM530tpWvT/atDiw26qmEQI8ZZxWOdsozk/rS2Ray2KWZdCMn3wODh
        DMWpNAi7o8ufSj37ozXgKXrMyA==
X-Google-Smtp-Source: ABdhPJw0eqpSbzGKh5H8X2cDcZfGERE5Mhf/8w5a5kiJ3PoOwP56ky0cT+SyFvH1q1HRmRLcR5AZ6Q==
X-Received: by 2002:a37:a04b:0:b0:69f:baff:b185 with SMTP id j72-20020a37a04b000000b0069fbaffb185mr17318830qke.176.1652816117436;
        Tue, 17 May 2022 12:35:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a114600b002f39b99f69esm8203853qty.56.2022.05.17.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:35:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nr2yR-008A2U-Qr; Tue, 17 May 2022 16:35:15 -0300
Date:   Tue, 17 May 2022 16:35:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
Message-ID: <20220517193515.GN63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
 <20220517145949.GH63055@ziepe.ca>
 <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 17, 2022 at 07:32:51PM +0000, Long Li wrote:
> > Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
> > 
> > On Tue, May 17, 2022 at 02:04:29AM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > The system chooses default 64K page size if the device does not
> > > specify the max page size the device can handle for DMA. This do not
> > > work well when device is registering large chunk of memory in that a
> > > large page size is more efficient.
> > >
> > > Set it to the maximum hardware supported page size.
> > 
> > For RDMA devices this should be set to the largest segment size an ib_sge can
> > take in when posting work. It should not be the page size of MR. 2M is a weird
> > number for that, are you sure it is right?
> 
> Yes, this is the maximum page size used in hardware page tables.

As I said, it should be the size of the sge in the WQE, not the
"hardware page tables"

Jason
