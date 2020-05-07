Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551B1C86FF
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGKgy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 06:36:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37186 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgEGKgy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 06:36:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so5746678wrx.4;
        Thu, 07 May 2020 03:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZWSW47Hk4klmt87hcwPwkObImlcY95sKfRd0toBmJU=;
        b=BM6KlitUUSwniQpF6oHPboIZ1ud2xgLUzW/fQKM7H02kxBwdzKFl4IBHDVGq6OYAJ3
         lF5pw49L5MlzamO/1A3atkNm1EJ3oyJ/SBtXNUVsvcWmaPty07nZf6HY5Fr9P+DGfYw9
         Tp1ZqbE7sLTdoMnGSJeJsKYNi4DV2A5/d3s7Up48fVXi0kX1JXSGE9FGZ7C7yxA2hygW
         coBt2FOrH1mvv5ylnOZE7ROHwEzLA98FmTrCRWa8fXTOZLISaj0fwZ1juLHsYTi+qZR2
         GsFF1oAAH0u+o1xwgWuxg6HFKZOceY7eTbXX4i2e6XXOUl8YfvyGPB0+awzK+gJqwhyx
         pXjQ==
X-Gm-Message-State: AGi0PuayocxuR6QHXERAthds5Aukyrq9UZU+nTFZQySEPszQitKXrGTF
        f/X5KROFvBrI3MTGzUUPWd8=
X-Google-Smtp-Source: APiQypIXZ8cyeDfG9MrMePCnKlqUwdk30xTLpNPdN0Gi3zShoVWkDEsSVasl9emIKqgn4HGITIH1Lg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr10842806wrm.406.1588847812425;
        Thu, 07 May 2020 03:36:52 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id i17sm7538752wml.23.2020.05.07.03.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 03:36:51 -0700 (PDT)
Date:   Thu, 7 May 2020 11:36:49 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] Driver: hv: vmbus: drop a no long applicable comment
Message-ID: <20200507103649.qyz6x2wr6yodpmbe@debian>
References: <20200506160806.118965-1-wei.liu@kernel.org>
 <MW2PR2101MB10521E94593C54B9E806CCBDD7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10521E94593C54B9E806CCBDD7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 06, 2020 at 05:49:05PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, May 6, 2020 9:08 AM
> > 
> > None of the things mentioned in the comment is initialized in hv_init.
> > They've been moved elsewhere.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/hv/vmbus_drv.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3a27f6c5f3de..7efdcadc335e 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1396,7 +1396,6 @@ static int vmbus_bus_init(void)
> >  {
> >  	int ret;
> > 
> > -	/* Hypervisor initialization...setup hypercall page..etc */
> >  	ret = hv_init();
> >  	if (ret != 0) {
> >  		pr_err("Unable to initialize the hypervisor - 0x%x\n", ret);
> > --
> > 2.20.1
> 
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 

Thanks.

Applied to hyperv-next.
