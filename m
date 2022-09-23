Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC425E7858
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIWK36 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIWK3u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 06:29:50 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C881EACD;
        Fri, 23 Sep 2022 03:29:33 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so453652wml.5;
        Fri, 23 Sep 2022 03:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SE7j1SyBj/+TA8gJBsOv8qKC0/+Bq0DCDf8kH6ZzU7Y=;
        b=IdInhTcz6QiO5G97sat5gDPGBHMKtt4vqhrxauoWj7xKW9zfkceW0AzgJHAvSFyeSc
         /m1OxANT60Q7eOYr7f1+uZ7TI1dkmcHNBUq2rRfZWz3HPJeW24Boggj5NQb6E1oiWY/w
         GgshbcukQE4mbGxFRCE6tE1sH3Zj7emGtnZAEJrQ32jhDlR4Uf8YXXGxi7rJRx+g/A43
         eT69+UMXgR2ccj6DqamFeaTBktY+xnZ/035gTkAp6ZxJ60bfy631O0K+DEFlYx1NWeNZ
         d+34ipal5g1i+SRfaImTk6o4D+5jvBo6jnru1prnsojqPll/wHffAt5/Cma+cY98f/GX
         iXUg==
X-Gm-Message-State: ACrzQf03px80Dj28p5k2kjyR6HoGwyiWNF2mSvCT+bAjBtfSVReanVWe
        GWIO2c3SM2elz/a9FaWJc2n9CpC+SpI=
X-Google-Smtp-Source: AMsMyM41XZ1QnkyEzPlCTwXp3tBbyxAA1Mmdgf8UHYIakAw0nNLZ+ah6MCM3MMqFCWdvMEQ9qQ/+gA==
X-Received: by 2002:a05:600c:4651:b0:3b3:3f99:4ad6 with SMTP id n17-20020a05600c465100b003b33f994ad6mr5509311wmo.90.1663928971951;
        Fri, 23 Sep 2022 03:29:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b003b47575d304sm2436352wmj.32.2022.09.23.03.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:29:31 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:29:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix kernel-doc
Message-ID: <Yy2Kioe5+MglezEq@liuwe-devbox-debian-v2>
References: <20220919063815.1881-1-jiapeng.chong@linux.alibaba.com>
 <BYAPR21MB1688D522A27450BF8F0BF067D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688D522A27450BF8F0BF067D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 22, 2022 at 10:37:27PM +0000, Michael Kelley (LINUX) wrote:
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Sunday, September 18, 2022 11:38 PM
> > 
> > drivers/hv/vmbus_drv.c:1587: warning: expecting prototype for
> > __vmbus_child_driver_register(). Prototype was for __vmbus_driver_register() instead.
> > 
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2210
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 7b9f3fc3adf7..621702a1725f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1573,7 +1573,7 @@ static int vmbus_bus_init(void)
> >  }
> > 
> >  /**
> > - * __vmbus_child_driver_register() - Register a vmbus's driver
> > + * __vmbus_driver_register() - Register a vmbus's driver
> >   * @hv_driver: Pointer to driver structure you want to register
> >   * @owner: owner module of the drv
> >   * @mod_name: module name string
> > --
> > 2.20.1.7.g153144c
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
