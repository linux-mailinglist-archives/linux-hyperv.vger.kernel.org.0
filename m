Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9A261F75
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgIHUDg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 16:03:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51488 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgIHPXz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id w2so17693821wmi.1;
        Tue, 08 Sep 2020 08:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+q7scp9xjjgch+ap+Le4uzp4lwNvS0O3pZwHfl5AC4=;
        b=tmA+634E5YkOWEfNDeCec7ORyfIxkRpTZbpYL9p7hS5nE6UnopNeqxeYH482NovN4g
         VgnUBhKs6y+LTLBCuekyCWzveDJT6xbqNJb9jHYlsO6TL2Xiu6ck8YDGXWeKHd623lad
         uk9JYIFEWKF9g1LO2kZu2Rt/O+/36k+r+5RGvTFavkp4B7M1rwA3/kbj7tgdIKrWB52d
         rNi6n47N4KO2fwXTW3wTyMzYYEMvy2erREkYnIju7pIyNSTiEiVJqyu1GphTtU/kGtWX
         wlj1Wqx/GFyZvMp84rdYsi3PEfTnq0G4+sgn2Y8r7//mG3VNPcXdNuC7rIhY3O1IFCB6
         BLyQ==
X-Gm-Message-State: AOAM533YerPP5eS68P0QmHB71Kvuj9vCZF8IT9ReaTH/Sk927FUAnVGp
        OXP9xTB38wUPrT77tmkrVCmqD8sURpqsrQ==
X-Google-Smtp-Source: ABdhPJzYi9ehfaPBVSXymEhhuH1GTRlLQTD8B0hsU4d7EUccdQ6mwISG5Qg1ixAsK4hgy2OnnuC5uw==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr4463133wmk.86.1599572119661;
        Tue, 08 Sep 2020 06:35:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p18sm14414596wrx.47.2020.09.08.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:35:18 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:35:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 14/46] x86/ioapic: Consolidate IOAPIC allocation
Message-ID: <20200908133517.nrqweaycr2erqscd@liuwe-devbox-debian-v2>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.054367732@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826112332.054367732@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:42PM +0200, Thomas Gleixner wrote:
...
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -101,7 +101,7 @@ static int hyperv_irq_remapping_alloc(st
>  	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
>  	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
>  	 */
> -	irq_data->chip_data = info->ioapic_entry;
> +	irq_data->chip_data = info->ioapic.entry;

Not sure if it is required for such a trivial change but here you go:

Acked-by: Wei Liu <wei.liu@kernel.org>
