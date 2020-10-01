Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A627FB67
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgJAIWh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 04:22:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAIWh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 04:22:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601540555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONHqAv4qT+OTc2BgimstCJPvlJyn9PqWstJJf6uzEpc=;
        b=NgazHTI+SJGDs8egXRGtdo+QGi3xh0JlmycrGchBYrODbgZTjUWPuqO6ut+FnIDPq/gdSJ
        vByj+411k82ifrt2BEVuNPgqX27Y3wm+6Dmn4KcscKE05+QXauqWGac/+IkXdSlflKGPVQ
        gqO3sNFZEbbRG+38SCAe6Uy+7ikGtCs4oqeZOia8yJeiTw1hywgKpiq12HtknxenkgKzRe
        OJrPufOitZDre5pRXFtSqz9yo9w/AoYjWbk8swkUhUsvsq/Dr/oz8+/DUOp6P8ZPNkir9G
        eIp6uHls/G0PP4zrn3niGbMtU2e4Jej+7XYXpi+l/7lKt0TktRFbV900KLGnEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601540555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONHqAv4qT+OTc2BgimstCJPvlJyn9PqWstJJf6uzEpc=;
        b=IOZyUThnP0eFdoTtp5uGay28riwQzj9H86PK6wCN00tcNvQN7l480emm6WUDFykV9hpp72
        zqYBI/TNYKqiSDAg==
To:     Zi Yan <ziy@nvidia.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: Boot crash due to "x86/msi: Consolidate MSI allocation"
In-Reply-To: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com>
References: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com>
Date:   Thu, 01 Oct 2020 10:22:35 +0200
Message-ID: <874knegxtg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Yan,

On Wed, Sep 30 2020 at 21:29, Zi Yan wrote:
> I am running linux-next on my Dell R630 and the system crashed at boot
> time. I bisected linux-next and got to your commit:
>
>     x86/msi: Consolidate MSI allocation
>
> The crash log is below and my .config is attached.
>
> [   11.840905]  intel_get_irq_domain+0x24/0xb0
> [   11.840905]  native_setup_msi_irqs+0x3b/0x90

This is not really helpful because that's in the middle of the queue and
that code is gone at the very end. Yes, it's unfortunate that this
breaks bisection.

Can you please test:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq

which contains fixes and if it still crashes provide the dmesg of it.

Thanks,

        tglx

