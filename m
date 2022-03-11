Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29D4D646B
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Mar 2022 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348757AbiCKPVL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Mar 2022 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348754AbiCKPVL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Mar 2022 10:21:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF31C65FC;
        Fri, 11 Mar 2022 07:20:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bg10so19819734ejb.4;
        Fri, 11 Mar 2022 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ye4poFlqimWme3JzRC10+EfxoIGwS7g7DYQgKuH9c7s=;
        b=WPfrtv5uH1mp04VPqGW1UACEcS8/Uibpoc8lgWplk5z5WiOeesMQIKqwpEqY2Wd4k7
         StES0EC7YievGeobAdRKTeK6Wj86U6I/YuMWljBvtlHoaQOqy5WHsm/pruhV+stmzXB4
         Ie/G3SIZh7qTVDdax32QK1nxTmFuUabeFvYSYX8hph2DLti5zcKJFrCCV60lf/QsVQrP
         OwMMHAsK7+ypv6/DC8FtCGARi7QaEI0WOXrLsRLVsECMeE7b21zPEGnHBxj+vL8Ce2Hh
         FidQ9U81d4U+yJ7BAJvlID6dyPA9CfyxBRTMDKWqiIlIqfqIvHXcUQVC9LvXDxNuur9A
         hz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ye4poFlqimWme3JzRC10+EfxoIGwS7g7DYQgKuH9c7s=;
        b=iqkGFQRL3fqiUBn5eFKqN+fqj3WVjF5aS7/ApsQaFtkvQfrTnXAlvPQ+iYOuoaUXVn
         6V6REnS0t7BHkmZCsB3qCSx0DyJDxlS9l1Ol02JqIXCIHIP04HxdnMqaG2rnGUZ//j3K
         0FN7aHRMz0z9xDuSpZiF+xiRGWZhwDXkCXeVbUEygcDYaqsv0nxBGGeCSqW6jq5cgW9Y
         QyM5lPNnY/+n0IAzOrv11SHbhY+64Qw7MV1rvtg8iwWH0TUXDCF2aYAtCQsxuOAgubgP
         Zs7jq4tu+ttZkW/Rsak4PQccESdSzHDfUn8ZjPSGGT4ARsNBs5DVGVyi6DJVQB24/rAW
         yG/w==
X-Gm-Message-State: AOAM530/RN+W/rbYVaxXBHOVQBhKxix1YLX2Xt3sMexYiRk/FHpX++Xw
        srCoteeM/Zf8EX8ihOIcjqY=
X-Google-Smtp-Source: ABdhPJxZslcDJOqMzIDI4ATQjHKokD7W13eryZ/e5fR6It/m/aCm9jxc/N39whx9wJ/6L7pi9IBUJA==
X-Received: by 2002:a17:906:3913:b0:6da:b2dc:2278 with SMTP id f19-20020a170906391300b006dab2dc2278mr8841816eje.419.1647012005797;
        Fri, 11 Mar 2022 07:20:05 -0800 (PST)
Received: from anparri (host-79-27-67-85.retail.telecomitalia.it. [79.27.67.85])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b006c5ef0494besm3021225ejb.86.2022.03.11.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:20:05 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:19:57 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix initialization of device object
 in vmbus_device_register()
Message-ID: <20220311151957.GA39518@anparri>
References: <20220311133738.38649-1-parri.andrea@gmail.com>
 <BY3PR21MB303347BCA5C489AC8C5ABEF7D70C9@BY3PR21MB3033.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR21MB303347BCA5C489AC8C5ABEF7D70C9@BY3PR21MB3033.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > ---
> >  drivers/hv/vmbus_drv.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 12a2b37e87f30..65db5048b1763 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2097,6 +2097,9 @@ int vmbus_device_register(struct hv_device
> > *child_device_obj)
> >  	child_device_obj->device.parent = &hv_acpi_dev->dev;
> >  	child_device_obj->device.release = vmbus_device_release;
> > 
> > +	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> > +	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
> > +
> >  	/*
> >  	 * Register with the LDM. This will kick off the driver/device
> >  	 * binding...which will eventually call vmbus_match() and vmbus_probe()
> > @@ -2122,8 +2125,6 @@ int vmbus_device_register(struct hv_device
> > *child_device_obj)
> >  	}
> >  	hv_debug_add_dev_dir(child_device_obj);
> > 
> > -	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> > -	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
> >  	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> 
> Is there any reason to not move dma_set_mask() as well?  That call is
> closely related to the previous two lines, so it is unexpected to have
> them separated.

The only reason was "minimize diff"; sounds like I'll move it in v2.  ;-)

Thanks,
  Andrea 
