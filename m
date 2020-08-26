Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81900253730
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHZScE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 14:32:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZScD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 14:32:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598466720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcTYQk36xBHukMp+WJuA1pj5lQ7N0s5iLLvD6sbf4dI=;
        b=fpQJ5YLBnvP7eAvuuPZvNlzVE1yTFcC3m3p/OK2mKng6MKzf3xJQ97zpjk50GBCGR++Mre
        +pgDtjis/z2lxl0mueMP/XNS2M2nPBkot5+qPqiVJCBQ/W9GT2KLQsWzsblyXqI7xk9Y8J
        roh1ow11MUTyUeBFLCHpFkeHlpyiJXB8f/ujjD+ENJKWULtVlh++5rPVPYIdNBW5xJzjAU
        xedCxtQd/w/Z7ftQZGGv+P6MRtuQ1A/w2yA7RqrxqjzWO3u1m3+x5VkFhOgAd7OyZmLGfU
        8pUhoxzbcQe/wCfP728HKYhDmfO5rY17aQ6x1+J8OjTq+KXAReAUeZfIxeDzdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598466720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcTYQk36xBHukMp+WJuA1pj5lQ7N0s5iLLvD6sbf4dI=;
        b=pkoroG5YpMQGTbQ7l7+BLWF/OnpZqytmtTgmIbXHObF2YG1hspbzv/wff3q1nSoqlXa6Ac
        WfvFdMD10A4T26DQ==
To:     "Dey\, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 15/46] x86/irq: Consolidate DMAR irq allocation
In-Reply-To: <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
References: <20200826111628.794979401@linutronix.de> <20200826112332.163462706@linutronix.de> <812d9647-ad2e-95e9-aa99-b54ff7ebc52d@intel.com>
Date:   Wed, 26 Aug 2020 20:32:00 +0200
Message-ID: <878se1uulb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 09:50, Megha Dey wrote:
>> @@ -329,15 +329,15 @@ static struct irq_chip dmar_msi_controll
>>   static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
>>   					  msi_alloc_info_t *arg)
>>   {
>> -	return arg->dmar_id;
>> +	return arg->hwirq;
>
> Shouldn't this return the arg->devid which gets set in dmar_alloc_hwirq?

Indeed.
