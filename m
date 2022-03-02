Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B44CAFF5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 21:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCBUf2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 15:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiCBUf2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 15:35:28 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6D5AA73;
        Wed,  2 Mar 2022 12:34:44 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id m6so4601304wrr.10;
        Wed, 02 Mar 2022 12:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9E1Gw4+rs3O1SDqvrlAIeVXWi4IR/tSpwpoKpax7Rfo=;
        b=i1GS/q5DuakYgNxrzDPFiAlgjHvyTjPS5+aDE36hZaMxjvIBQIiCn49VKe+arJT3Yh
         /QA8n5tAqAn+Wiu3VwLxCXMA7mlKfHXhFrxUCao1ZaUltOFYjdJIpwoMICWx11F+1qPG
         X2kUQGfYFFTBHqfoxmxoL21PuMTUJp7i+gSrmwtd5SQuBTOQ46rnKmmnROy6DqQK/03t
         zGG7D9ckenKAh4Jq8IqlrziPGMs0mXNysmhF4jFeWeeb5nEVVlQDZXcpZkGPh/xkJBBj
         A2ms1pMPEXG+0D5YEb9a8d/66nmStINsAzrC4re4RoqDqQeurbJrJa/pmpM5a74LcfPa
         bxQQ==
X-Gm-Message-State: AOAM532WjQnUaZbQKZPVzwnk0lBvGFVnKb9ij8zkCvhbaMYWxD31SD/0
        GMfglv9Wq+vdUoquuxvLp0c=
X-Google-Smtp-Source: ABdhPJxiHpcBYXTzhl1QAXBe6qiGYiDETVvLNqNe4BXPTQREY5EVhtRPyir85t8G8YMQW4rCh91Mvw==
X-Received: by 2002:a5d:68c6:0:b0:1ed:e119:23e6 with SMTP id p6-20020a5d68c6000000b001ede11923e6mr24063358wrw.654.1646253282698;
        Wed, 02 Mar 2022 12:34:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d6d8c000000b001efd2c071dbsm55423wrs.20.2022.03.02.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:34:42 -0800 (PST)
Date:   Wed, 2 Mar 2022 20:34:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <20220302203440.inzt6z6mxhs56wab@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
 <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>
 <6ac1dd87-3c78-66ca-c526-d1f6cf253400@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ac1dd87-3c78-66ca-c526-d1f6cf253400@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 10:49:15AM -0800, Iouri Tarassov wrote:
> On 3/2/2022 3:53 AM, Wei Liu wrote:
> > On Wed, Mar 02, 2022 at 08:53:15AM +0100, Greg KH wrote:
> > > On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > > > +struct dxgglobal *dxgglobal;
> > > > > 
> > > > > No, make this per-device, NEVER have a single device for your driver.
> > > > > The Linux driver model makes it harder to do it this way than to do it
> > > > > correctly.  Do it correctly please and have no global structures like
> > > > > this.
> > > > > 
> > > > 
> > > > This may not be as big an issue as you thought. The device discovery is
> > > > still done via the normal VMBus probing routine. For all intents and
> > > > purposes the dxgglobal structure can be broken down into per device
> > > > fields and a global structure which contains the protocol versioning
> > > > information -- my understanding is there will always be a global
> > > > structure to hold information related to the backend, regardless of how
> > > > many devices there are.
> > > 
> > > Then that is wrong and needs to be fixed.  Drivers should almost never
> > > have any global data, that is not how Linux drivers work.  What happens
> > > when you get a second device in your system for this?  Major rework
> > > would have to happen and the code will break.  Handle that all now as it
> > > takes less work to make this per-device than it does to have a global
> > > variable.
> > > 
> >
> > It is perhaps easier to draw parallel from an existing driver. I feel
> > like we're talking past each other.
> >
> > Let's look at drivers/iommu/intel/iommu.c. There are a bunch of lists
> > like `static LIST_HEAD(dmar_rmrr_units)`. During the probing phase, new
> > units will be added to the list. I this the current code is following
> > this model. dxgglobal fulfills the role of a list.
> >
> > Setting aside the question of whether it makes sense to keep a copy of
> > the per-VM state in each device instance, I can see the code be changed
> > to:
> >
> >     struct mutex device_mutex; /* split out from dxgglobal */
> >     static LIST_HEAD(dxglist);
> >     
> >     /* Rename struct dxgglobal to struct dxgstate */
> >     struct dxgstate {
> >        struct list_head dxglist; /* link for dxglist */
> >        /* ... original fields sans device_mutex */
> >     }
> >
> >     /*
> >      * Provide a bunch of helpers manipulate the list. Called in probe /
> >      * remove etc.
> >      */
> >     struct dxgstate *find_dxgstate(...);
> >     void remove_dxgstate(...);
> >     int add_dxgstate(...);
> >
> > This model is well understood and used in tree. It is just that it
> > doesn't provide much value in doing this now since the list will only
> > contain one element. I hope that you're not saying we cannot even use a
> > per-module pointer to quickly get the data structure we want to use,
> > right?
> >
> > Are you suggesting Iouri use dev_set_drvdata to stash the dxgstate
> > into the device object? I think that can be done too.
> >
> > The code can be changed as:
> >
> >     /* Rename struct dxgglobal to dxgstate and remove unneeded fields */
> >     struct dxgstate { ... };
> >
> >     static int dxg_probe_vmbus(...) {
> >
> >         /* probe successfully */
> >
> > 	struct dxgstate *state = kmalloc(...);
> > 	/* Fill in dxgstate with information from backend */
> >
> > 	/* hdev->dev is the device object from the core driver framework */
> > 	dev_set_drvdata(&hdev->dev, state);
> >     }
> >
> >     static int dxg_remove_vmbus(...) {
> >         /* Normal stuff here ...*/
> >
> > 	struct dxgstate *state = dev_get_drvdata(...);
> > 	dev_set_drvdata(..., NULL);
> > 	kfree(state);
> >     }
> >
> >     /* In all other functions */
> >     void do_things(...) {
> >         struct dxgstate *state = dev_get_drvdata(...);
> >
> > 	/* Use state in place of where dxgglobal was needed */
> >
> >     }
> >
> > Iouri, notice this doesn't change anything regarding how userspace is
> > designed. This is about how kernel organises its data.
> >
> > I hope what I wrote above can bring our understanding closer.
> >
> > Thanks,
> > Wei.
> 
> 
> I can certainly remove dxgglobal and keep the  pointer to the global
> state in the device object.
> 

No, no more global pointer needed. You just call dev_drv_setdata in the
place that you assign to the global pointer.

> This will require passing of the global pointer to all functions, which
> need to access it.
> 

And in the place you need the global pointer, call dev_drv_getdata.

> 
> Maybe my understanding of the Greg's suggestion was not correct. I
> thought the suggestion was
> 
> to have multiple /dev/dxgN devices (one per virtual compute device).
> This would change how the user mode
> 

No. You still have only one /dev/dxg here.

Wei.
