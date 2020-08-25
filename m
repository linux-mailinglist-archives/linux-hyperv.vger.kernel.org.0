Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C602515B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgHYJwB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgHYJwB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 05:52:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4AC061574;
        Tue, 25 Aug 2020 02:52:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598349119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi88rJ2mAeMyhee0eT9kDZfffU9Q0nWkBLlAEntSw8w=;
        b=saPe2SMHs4fxaHPtIfmZINCVtmade/IUdScDTrTE56bKhbWhWWPmlrhyuwQwbPnFdv02n1
        qRKHY6+Fao2onQFOAz/d63P6+2VnSYMbUC+pcft0s0SMwT2vV9us/1npGja2X+2tYSpscB
        iPJsYuS2FMf/1nMuwC8vtsuYf/y0bjbBwKrk2/0oTU5egQm1Ek/7EUMyQDShnlbtAcdbLe
        JE09lOMIrym7gVQeJa9rILtA3RsQfKKlIKniu0Z45R81ceeja+uMDPulnSnTEjTA49o3W7
        SMaqJJyWq0AnhRrTNSiWKeKyPcK0S21cZa7G3cB+Y0b9eRpBKdLEAoz+GdDGSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598349119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi88rJ2mAeMyhee0eT9kDZfffU9Q0nWkBLlAEntSw8w=;
        b=OlmbOjhDdhkNmF8xd3M7JINOojGOBGj4UhpScwvT1dHOdNPkfP2dB8Acep6NLHMEEgMoKl
        YoToi1lJLBSp6rDQ==
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
In-Reply-To: <fb4e3d13-18c8-a425-19a8-975fda80d411@suse.com>
References: <20200821002424.119492231@linutronix.de> <20200821002947.667887608@linutronix.de> <5caec213-8f56-9f12-34db-a29de8326f95@suse.com> <87tuwr68q8.fsf@nanos.tec.linutronix.de> <fb4e3d13-18c8-a425-19a8-975fda80d411@suse.com>
Date:   Tue, 25 Aug 2020 11:51:58 +0200
Message-ID: <87d03f59z5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 06:21, J=C3=BCrgen Gro=C3=9F wrote:
> On 24.08.20 23:21, Thomas Gleixner wrote:
>> I still think it does the right thing depending on the place it is
>> called from, but even if so, it's completely unreadable gunk. I'll fix
>> that proper.
>
> The main issue is that xen_initial_domain() and xen_pv_domain() are
> orthogonal to each other. So xen_initial_domain() can either be true
> for xen_pv_domain() (the "classic" pv dom0) or for xen_hvm_domain()
> (the new PVH dom0).

Fair enough. My limited XENology striked again.
