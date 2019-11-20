Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB7104385
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfKTSjG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 13:39:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42387 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfKTSfN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 13:35:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so136358pgt.9
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Nov 2019 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SguOXdXD06UvXlpJTQF3X/gOJzOdybHb3TZxh+LFCwE=;
        b=M/k0aGFFVeGdcEMo7ik+UWlR4SsoP7CucR9U2FHwRbjsoS6Jxqcz+93aeJIKZnBOzz
         Pc2jMYjAyvzMe3GuRy2XS+vsHKuraV6vaRry8HP7s2ycXSVK14bhkWt0MHSY9/CrZrdK
         lqj5Uq3IVc1Ruu12WucILWSR/ZVulbvVir963Af99szrifaRyz40CQxsJreqUZ2NW7tt
         BKXdpeVpeahKlUXC1lcurEuXhuKmhgK4D48SlaAxPptv067Vwgdtd8/EG2o9CrfnSEwT
         NOo3JtRemeRmdsJLTsEbcx7959y1TZcjFUgLWdAojE5jZX7AqeRishMiOyM+3npTA7DT
         iLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SguOXdXD06UvXlpJTQF3X/gOJzOdybHb3TZxh+LFCwE=;
        b=DG3AoYu0h+wHkLoDCZRLyWZkFR8Pnb4oTDIH73dGDWB09zGsPNBJmmshBgvaMFl2M9
         /HP9fUTNoFaUU1uMik5sBUMwNCcGBWj8rRGE9w0tG0BCpD67t1T6rFvHV0F5Q9eM7Onq
         4hglvOJki9Ro1YML24qTJpBO3yAiasFrfjiOVtdK/HuwZ2QuKEd11cH4ymJFjq0qS1cW
         bNrpF9DEJ8jXuLHt2IF5BtjPyJ/AlnOG0DokoFM0dzK0dz1dGkkfiHUjYxDqhV8mwBv2
         4L7KlWt6Tzx46lJuVtHIc9JIkxFCfGMLhQHEKRulyLnVljnQq/A6O0o7elQgSBZ+EIgw
         AvVQ==
X-Gm-Message-State: APjAAAVSL8LL9Ald95RkR643NwZYQzhOQK2KbYw7nO6iU/VSEdukAvTK
        I9B6oMZ20tm0/nyHfLoyz7kPDA==
X-Google-Smtp-Source: APXvYqxyYAth7L1wiJL1kecEmScQt3Ogum8pKto+OQyv1LHRbY3avm8XD4YP/3EEZhm/qCZxoniQDg==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr4749669pgj.147.1574274912209;
        Wed, 20 Nov 2019 10:35:12 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p123sm78577pfg.30.2019.11.20.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:35:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:35:03 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Alex Williamson" <alex.williamson@redhat.com>
Cc:     <lantianyu1986@gmail.com>, <cohuck@redhat.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <paulmck@linux.ibm.com>,
        "Michael Kelley" <mikelley@microsoft.com>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, "vkuznets" <vkuznets@redhat.com>
Subject: Re: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Message-ID: <20191120103503.5f7bd7c4@hermes.lan>
In-Reply-To: <20191119165620.0f42e5ba@x1.home>
References: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
        <20191119165620.0f42e5ba@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 19 Nov 2019 15:56:20 -0800
"Alex Williamson" <alex.williamson@redhat.com> wrote:

> On Mon, 11 Nov 2019 16:45:07 +0800
> lantianyu1986@gmail.com wrote:
> 
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > This patch is to add VFIO VMBUS driver support in order to expose
> > VMBUS devices to user space drivers(Reference Hyper-V UIO driver).
> > DPDK now has netvsc PMD driver support and it may get VMBUS resources
> > via VFIO interface with new driver support.
> > 
> > So far, Hyper-V doesn't provide virtual IOMMU support and so this
> > driver needs to be used with VFIO noiommu mode.  
> 
> Let's be clear here, vfio no-iommu mode taints the kernel and was a
> compromise that we can re-use vfio-pci in its entirety, so it had a
> high code reuse value for minimal code and maintenance investment.  It
> was certainly not intended to provoke new drivers that rely on this mode
> of operation.  In fact, no-iommu should be discouraged as it provides
> absolutely no isolation.  I'd therefore ask, why should this be in the
> kernel versus any other unsupportable out of tree driver?  It appears
> almost entirely self contained.  Thanks,
> 
> Alex

The current VMBUS access from userspace is from uio_hv_generic
there is (and will not be) any out of tree driver for this.

The new driver from Tianyu is to make VMBUS behave like PCI.
This simplifies the code for DPDK and other usermode device drivers
because it can use the same API's for VMBus as is done for PCI.

Unfortunately, since Hyper-V does not support virtual IOMMU yet,
the only usage modle is with no-iommu taint.
