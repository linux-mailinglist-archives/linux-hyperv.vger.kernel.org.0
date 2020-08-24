Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F6250ABB
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHXVV0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHXVVX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 17:21:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AEFC061574;
        Mon, 24 Aug 2020 14:21:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598304080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6NJ+kPKGl5Nf3jE9xklx6hH03TKpnofr8g96HAw8Ck=;
        b=Pv4WTzw87H6NCx71gJqPiRampyZmRAAfWJrVk0KJysnfqzFan/ccSk8LSOb7qVVuPkbB8z
        tGoDrp+2ju8a/cTr5MMPgifcmaB8n9M75wctO+lZ606ZWdfd053SzbNlGzcK9jw30ur2mH
        TDbLQHXk1Dh9ueKmK3Go6nRfjv8zoHatFiZuH0z15JhWa7zd1dbxSJs0yBdpWRdSBTq9V2
        X9XEPWc+RvXUBns4bi7L9OdG3sThW5qDimMJb9E+VvYLGZjxixChT1oUzdf/dlLTqSoUaU
        EspLZ6f4CF2x6Rx5EjvdF4GfJ2iyzgouZQbm5KkIt6/C6cpdCkAuu4GovEYy3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598304080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6NJ+kPKGl5Nf3jE9xklx6hH03TKpnofr8g96HAw8Ck=;
        b=cN6eYBnyeUaRAodJ5n9Kq1Of1A3DDOOMFul6xvKSp6P4/ZL9J+JfpPUvxxWGcEA5BgckeU
        I2Edk8IuxDhtxSCg==
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
        xen-devel@lists.xenproject.org,
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
Subject: Re: [patch RFC 24/38] x86/xen: Consolidate XEN-MSI init
In-Reply-To: <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
References: <20200821002424.119492231@linutronix.de> <20200821002947.667887608@linutronix.de> <5caec213-8f56-9f12-34db-a29de8326f95@suse.com>
Date:   Mon, 24 Aug 2020 23:21:19 +0200
Message-ID: <87tuwr68q8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 24 2020 at 06:59, J=C3=BCrgen Gro=C3=9F wrote:
> On 21.08.20 02:24, Thomas Gleixner wrote:
>> +static __init void xen_setup_pci_msi(void)
>> +{
>> +	if (xen_initial_domain()) {
>> +		x86_msi.setup_msi_irqs =3D xen_initdom_setup_msi_irqs;
>> +		x86_msi.teardown_msi_irqs =3D xen_teardown_msi_irqs;
>> +		x86_msi.restore_msi_irqs =3D xen_initdom_restore_msi_irqs;
>> +		pci_msi_ignore_mask =3D 1;
>
> This is wrong, as a PVH initial domain shouldn't do the pv settings.
>
> The "if (xen_initial_domain())" should be inside the pv case, like:
>
> if (xen_pv_domain()) {
> 	if (xen_initial_domain()) {
> 		...
> 	} else {
> 		...
> 	}
> } else if (xen_hvm_domain()) {
> 	...

I still think it does the right thing depending on the place it is
called from, but even if so, it's completely unreadable gunk. I'll fix
that proper.

Thanks,

        tglx
