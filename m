Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F93252AC7
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHZJxT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgHZJxS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 05:53:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C5C061574;
        Wed, 26 Aug 2020 02:53:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598435595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mv4TqayOvYT1PZy4IB6XdyAxCqLJFuyrG/iBXdVvDGo=;
        b=gry5Gqjf5XbHVcJKaDXMPK4boPx5u/IEBob5D9Wn36xeFWifKRFQGrLYl80/EuQiMfzysE
        R0d4KWtrjVjHsKfDbzzjWDT5squtWA8CAJmXu6ssTTvFAl1Dp0Qb/5Gseu91lYmL0/YUjO
        NbsGg1x1qsfcwMmq40s6f8QzME/wE8mMh0jkO28671y+OSXzdMJAa+d/pRnJ+IIBJUer6F
        myfzP6CTQbmP/AgP0sGex0XapaKloSSKztkVFL6Agugb80R0gctiC6HeZ9PqzrabjLNIkQ
        pAIkMvt8UaWwzx1EMmCW7rVmlO3SHuNH8U5WRqRwrLaG8IAQqyASWZnve1tyYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598435595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mv4TqayOvYT1PZy4IB6XdyAxCqLJFuyrG/iBXdVvDGo=;
        b=T18EHlogGsekmXEOkS3bdJRDQU5OgZArZ4psx/80SWGB5Jkvh72YqFLOhYbYkZrSz/1STi
        ppR6UR793IwPtlAg==
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, linux-hyperv@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: Re: [patch RFC 10/38] x86/ioapic: Consolidate IOAPIC allocation
In-Reply-To: <20200826084019.GA6174@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200821002424.119492231@linutronix.de> <20200821002946.297823391@linutronix.de> <20200826084019.GA6174@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Date:   Wed, 26 Aug 2020 11:53:15 +0200
Message-ID: <871rjtwx6c.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 16:40, Boqun Feng wrote:
> I hit a compiler error while I was trying to compile this patchset:
>
> arch/x86/kernel/devicetree.c: In function =E2=80=98dt_irqdomain_alloc=E2=
=80=99:
> arch/x86/kernel/devicetree.c:232:6: error: =E2=80=98struct irq_alloc_info=
=E2=80=99 has no member named =E2=80=98ioapic_id=E2=80=99; did you mean =E2=
=80=98ioapic=E2=80=99?
>   232 |  tmp.ioapic_id =3D mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));

Yeah, noticed myself already and 0day complained as well :)

