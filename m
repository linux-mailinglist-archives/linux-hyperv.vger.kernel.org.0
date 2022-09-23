Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB895E7866
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIWKcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiIWKcF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 06:32:05 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2A11E940;
        Fri, 23 Sep 2022 03:31:43 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id cc5so19756090wrb.6;
        Fri, 23 Sep 2022 03:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A9wlHYFAq0AQmjZo7EO8S4zutuhpaxaPGL/xvuEkjLw=;
        b=SQD4nUUWYh7NcKGyvqv90wFeI+5RweyAoH8VUQ9lDvchl9JWpkc6W4jjtUvLROKRvo
         AUIHX2RVuHDAQrLdAbYd+DdRBMwmrRVfpT+lYiXIEghhUzraQr2OBuuguFFCfrakny36
         sZMoSzPwMW6RTcDTBwnoOmoap8LKwZcmRuOwFu/bLNcBh9E5bqOq2Mn9bgXPMjKIo0m6
         uDhaRkRJp0feYhU94KtZZ85Y562rdwaJRScA2WcxN7+vezT0AsBUP+wsueViGuH+RA0T
         zPdUjzjAa0YJZ8nOyEZObYgB1BYu8OqtW0EzBo5ySGgWvuMjeS/2XJvPIDlVCfOwS7oC
         QfCQ==
X-Gm-Message-State: ACrzQf0oo2XWoFmc1pHuQAg1oczsUQPi3G+KdgPzP5M1kz/9Wkh2GCVE
        bcLWw4oTOPVH16OpVcrUKtI=
X-Google-Smtp-Source: AMsMyM6kUy00xtx2umIT5gOPwcOwg9rhuDYGgVjP0ZymfYzghCkv5BH2dEwxm6nnoCc9VvAlSyy3Ag==
X-Received: by 2002:a5d:6481:0:b0:228:dc1f:4f95 with SMTP id o1-20020a5d6481000000b00228dc1f4f95mr4819035wri.298.1663929101394;
        Fri, 23 Sep 2022 03:31:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm2600840wmq.45.2022.09.23.03.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:31:40 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:31:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Easwar Hariharan <eahariha@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Message-ID: <Yy2LC8T9iyCfHzLm@liuwe-devbox-debian-v2>
References: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
 <1663625084-2518-2-git-send-email-eahariha@linux.microsoft.com>
 <BYAPR21MB1688949A28069BABBA50027DD74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB16884931135424DA3D67E497D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16884931135424DA3D67E497D74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 22, 2022 at 10:43:24PM +0000, Michael Kelley (LINUX) wrote:
> From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, September 22, 2022 3:39 PM
> > 
> > From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Monday, September
> > 19, 2022 3:05 PM
> > >
> > > pci_ids.h already defines PCI_VENDOR_ID_MICROSOFT, and is included via
> > > linux/pci.h. Use the define instead of the magic number.
> > >
> > > Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 3c833ea..f2efb74 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2052,7 +2052,7 @@ struct hv_device *vmbus_device_create(const guid_t
> > *type,
> > >  	child_device_obj->channel = channel;
> > >  	guid_copy(&child_device_obj->dev_type, type);
> > >  	guid_copy(&child_device_obj->dev_instance, instance);
> > > -	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
> > > +	child_device_obj->vendor_id = PCI_VENDOR_ID_MICROSOFT;
> > >
> > >  	return child_device_obj;
> > >  }
> > > --
> > > 1.8.3.1
> > 
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> Actually, a nit:  The short commit message should start with "Drivers: hv:" or
> "Drivers: hv: vmbus:".  Check the commit history on vmbus_drv.c and you'll
> see the standard usage.

I fixed up the commit message and applied it to hyperv-next. Thanks.

> 
> Michael
> 
