Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13B4C9851
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiCAWYI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 17:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiCAWYH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 17:24:07 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307285F242;
        Tue,  1 Mar 2022 14:23:25 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so1610218wmj.1;
        Tue, 01 Mar 2022 14:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvNGycVsJjcf4fBsCAloIuAMggMr8Wty2PzvRts0y4Y=;
        b=lFe9KwlkZRB+zgf7mFIo2V0Ol1e3CpJHk2iQfw/TzBGWcs7WjiN4PqpQFtKp7uxzfb
         LZygAXtRMsr/TXc2/ct7gX+ZW3e0qEL9FfysbShh35QJ6QzH0DrgoXEyapaP6wseIbsZ
         NUICSLZV+iAT3HK2W8w71dOvAY53InboRSy0W872ZWCJn+OjQPaFdsDxRLuhdhQWsBjW
         EA1OLntKTgDHI+WsFPyjJxh/zcelOob7DIQXUyprP/+nUNyWqsPAnqHRoC1rLVpjwICj
         xa4nMTsFroi+9byl3XOAJhLkS56jtwxkFCOpZFVQIPSXC7OipuSufCXfIh5hHE6scSbP
         stZg==
X-Gm-Message-State: AOAM531CuCe+eamexWRF5O3qn5Xasvan8Y2sXAb+w8OU0LVZC4ECRpw+
        THO1tdKZ5GkOHStx/aU3Ncg=
X-Google-Smtp-Source: ABdhPJww7HnrJPFXg3knY1k9h4mdjgCpNymAS/ERoIVDDk8Gnvw3yMPHOBER6BYQX4yRbAd76i/7cg==
X-Received: by 2002:a05:600c:384c:b0:37b:c771:499c with SMTP id s12-20020a05600c384c00b0037bc771499cmr18420892wmr.141.1646173403787;
        Tue, 01 Mar 2022 14:23:23 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0033383cdeea1sm4258668wmq.10.2022.03.01.14.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:23:23 -0800 (PST)
Date:   Tue, 1 Mar 2022 22:23:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh6F9cG6/SV6Fq8Q@kroah.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 09:45:41PM +0100, Greg KH wrote:
> On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > - Create skeleton and add basic functionality for the
> > hyper-v compute device driver (dxgkrnl).
> > 
> > - Register for PCI and VM bus driver notifications and
> > handle initialization of VM bus channels.
> > 
> > - Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig
> > 
> > - Create a MAINTAINERS entry
> > 
> > A VM bus channel is a communication interface between the hyper-v guest
> > and the host. The are two type of VM bus channels, used in the driver:
> >   - the global channel
> >   - per virtual compute device channel
> > 
> > A PCI device is created for each virtual compute device, projected
> > by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> > id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> > arrival of such devices. The PCI config space of the virtual compute
> > device has luid of the corresponding virtual compute device VM
> > bus channel. This is how the compute device adapter objects are
> > linked to VM bus channels.
> > 
> > VM bus interface version is exchanged by reading/writing the PCI config
> > space of the virtual compute device.
> > 
> > The IO space is used to handle CPU accessible compute device
> > allocations. Hyper-v allocates IO space for the global VM bus channel.
> > 
> > Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> 
> Please work with internal developers to get reviews from them first,
> before requiring the kernel community to point out basic issues.  It
> will save you a lot of time and stop us from feeling like we are having
> our time wasted.
> 
> Some simple examples below that your coworkers should have caught:
> 
> > --- /dev/null
> > +++ b/drivers/hv/dxgkrnl/dxgkrnl.h
> > @@ -0,0 +1,119 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2019, Microsoft Corporation.
> 
> It is now 2022 :)
> 
> > +void init_ioctls(void);
> 
> That is a horrible global function name you just added to the kernel's
> namespace for a single driver :(
> 
> > +long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
> > +
> > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > +{
> > +	*luid = *(struct winluid *)&guid->b[0];
> 
> Why is the cast needed?  Shouldn't you use real types in your
> structures?
> 
> > +/*
> > + * The interface version is used to ensure that the host and the guest use the
> > + * same VM bus protocol. It needs to be incremented every time the VM bus
> > + * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
> > + * incremented each time the earlier versions of the interface are no longer
> > + * compatible with the current version.
> > + */
> > +#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
> > +#define DXGK_VMBUS_INTERFACE_VERSION			40
> > +#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
> 
> Where do these numbers come from, the hypervisor specification?
> 
> > +/*
> > + * Pointer to the global device data. By design
> > + * there is a single vGPU device on the VM bus and a single /dev/dxg device
> > + * is created.
> > + */
> > +struct dxgglobal *dxgglobal;
> 
> No, make this per-device, NEVER have a single device for your driver.
> The Linux driver model makes it harder to do it this way than to do it
> correctly.  Do it correctly please and have no global structures like
> this.
> 

This may not be as big an issue as you thought. The device discovery is
still done via the normal VMBus probing routine. For all intents and
purposes the dxgglobal structure can be broken down into per device
fields and a global structure which contains the protocol versioning
information -- my understanding is there will always be a global
structure to hold information related to the backend, regardless of how
many devices there are.

I definitely think splitting is doable, but I also understand why Iouri
does not want to do it _now_ given there is no such a model for multiple
devices yet, so anything we put into the per-device structure could be
incomplete and it requires further changing when such a model arrives
later.

Iouri, please correct me if I have the wrong mental model here.

All in all, I hope this is not going to be a deal breaker for the
acceptance of this driver.

Thanks,
Wei.
