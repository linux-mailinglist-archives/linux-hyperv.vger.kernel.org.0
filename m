Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688154CA442
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 12:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiCBLyW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 06:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiCBLyV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 06:54:21 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143AB0EBD;
        Wed,  2 Mar 2022 03:53:38 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id bk29so2375307wrb.4;
        Wed, 02 Mar 2022 03:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XY6dOIHv3yCkAU7WwLMsImSV4WkNa/CQsBsSl28qGtg=;
        b=jmQfEq/vpDxAe+EHUS0Q4YvyMIAMxzXJGmQ8+32/z9l0DJH9KNW+pSkF8WZ83dYx+H
         /qGMTFo3Drzq7ew/h2OWJjEI+mdqUNROhkMGonsPEOrPcucWsFK+80WtFiZcE1plI78n
         tfNqeqCQsBMh3c/l5rh9sz5CjuDUDwj17Wn1W4M43YGKcT6Osh1Ud9h7l6Vm8m9fa1pG
         BjzfhEaakZYcPk2NzfNNuMKpskMqWzSe9osPJUFeiQnFU4EsKmdHzxXEC/lJMCrgxGA4
         gFoyiqPQp8mznjWjISqmKjdd3zbENk1Lsnm6T+cYCHjti0RN9NOpgPh7Ib6orV3+/Ido
         2Cjw==
X-Gm-Message-State: AOAM531YEpGfwKWdHBePzaTHlJDJLjb7p2AZ1HWUjY8cJJmZ4u1154/a
        KV0mEVc5epheoFvkCn8Vl2I=
X-Google-Smtp-Source: ABdhPJwIDUbYiY4aCi4VVrdNo3TXYAZ5KxSeI6sokMU1uNP1Mg9Shsv6w5X4RG7chrs+dwf72qUK2w==
X-Received: by 2002:a05:6000:18ab:b0:1f0:1581:fdcf with SMTP id b11-20020a05600018ab00b001f01581fdcfmr5492711wri.490.1646222016686;
        Wed, 02 Mar 2022 03:53:36 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm16481386wrw.57.2022.03.02.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 03:53:36 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:53:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <20220302115334.wemdkznokszlzcpe@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh8ia7nJNN7ISR1l@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 08:53:15AM +0100, Greg KH wrote:
> On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > +struct dxgglobal *dxgglobal;
> > > 
> > > No, make this per-device, NEVER have a single device for your driver.
> > > The Linux driver model makes it harder to do it this way than to do it
> > > correctly.  Do it correctly please and have no global structures like
> > > this.
> > > 
> > 
> > This may not be as big an issue as you thought. The device discovery is
> > still done via the normal VMBus probing routine. For all intents and
> > purposes the dxgglobal structure can be broken down into per device
> > fields and a global structure which contains the protocol versioning
> > information -- my understanding is there will always be a global
> > structure to hold information related to the backend, regardless of how
> > many devices there are.
> 
> Then that is wrong and needs to be fixed.  Drivers should almost never
> have any global data, that is not how Linux drivers work.  What happens
> when you get a second device in your system for this?  Major rework
> would have to happen and the code will break.  Handle that all now as it
> takes less work to make this per-device than it does to have a global
> variable.
> 

It is perhaps easier to draw parallel from an existing driver. I feel
like we're talking past each other.

Let's look at drivers/iommu/intel/iommu.c. There are a bunch of lists
like `static LIST_HEAD(dmar_rmrr_units)`. During the probing phase, new
units will be added to the list. I this the current code is following
this model. dxgglobal fulfills the role of a list.

Setting aside the question of whether it makes sense to keep a copy of
the per-VM state in each device instance, I can see the code be changed
to:

    struct mutex device_mutex; /* split out from dxgglobal */
    static LIST_HEAD(dxglist);
    
    /* Rename struct dxgglobal to struct dxgstate */
    struct dxgstate {
       struct list_head dxglist; /* link for dxglist */
       /* ... original fields sans device_mutex */
    }

    /*
     * Provide a bunch of helpers manipulate the list. Called in probe /
     * remove etc.
     */
    struct dxgstate *find_dxgstate(...);
    void remove_dxgstate(...);
    int add_dxgstate(...);

This model is well understood and used in tree. It is just that it
doesn't provide much value in doing this now since the list will only
contain one element. I hope that you're not saying we cannot even use a
per-module pointer to quickly get the data structure we want to use,
right?

Are you suggesting Iouri use dev_set_drvdata to stash the dxgstate
into the device object? I think that can be done too.

The code can be changed as:

    /* Rename struct dxgglobal to dxgstate and remove unneeded fields */
    struct dxgstate { ... };

    static int dxg_probe_vmbus(...) {

        /* probe successfully */

	struct dxgstate *state = kmalloc(...);
	/* Fill in dxgstate with information from backend */

	/* hdev->dev is the device object from the core driver framework */
	dev_set_drvdata(&hdev->dev, state);
    }

    static int dxg_remove_vmbus(...) {
        /* Normal stuff here ...*/

	struct dxgstate *state = dev_get_drvdata(...);
	dev_set_drvdata(..., NULL);
	kfree(state);
    }

    /* In all other functions */
    void do_things(...) {
        struct dxgstate *state = dev_get_drvdata(...);

	/* Use state in place of where dxgglobal was needed */

    }

Iouri, notice this doesn't change anything regarding how userspace is
designed. This is about how kernel organises its data.

I hope what I wrote above can bring our understanding closer.

Thanks,
Wei.
