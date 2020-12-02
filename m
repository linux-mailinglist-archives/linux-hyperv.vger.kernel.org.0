Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62D2CC091
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 16:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgLBPR5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 10:17:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:17872 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLBPR5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 10:17:57 -0500
IronPort-SDR: 6ga+xZjdBOBHsuJQtaOfcu6YVPSB43Sv8CacLLYJNoe82tgo8No1HFy8BoLBmHSMoGpB0vYGio
 YsLiHOOihIIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="172248150"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="172248150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:17:16 -0800
IronPort-SDR: lQjhoa4rlFFBhKMBX7uKfJeK3w1ffejEELjEVz36IdY+vd5HEezdP9lCjZSbo80pcNKKTWu79z
 lWZYmP6Kw1Rg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550096338"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:17:01 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kkTtK-00BXLU-L0; Wed, 02 Dec 2020 17:18:02 +0200
Date:   Wed, 2 Dec 2020 17:18:02 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
Message-ID: <20201202151802.GI4077@smile.fi.intel.com>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-17-wei.liu@kernel.org>
 <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
 <20201202141107.covsx4ugipuyl6he@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202141107.covsx4ugipuyl6he@liuwe-devbox-debian-v2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 02:11:07PM +0000, Wei Liu wrote:
> On Wed, Nov 25, 2020 at 12:26:12PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 1:46 AM Wei Liu <wei.liu@kernel.org> wrote:
> > >
> > > We are about to implement an irqchip for IO-APIC when Linux runs as root
> > > on Microsoft Hypervisor. At the same time we would like to reuse
> > > existing code as much as possible.
> > >
> > > Move mp_chip_data to io_apic.h and make a few helper functions
> > > non-static.
> > 
> > > +struct mp_chip_data {
> > > +       struct list_head irq_2_pin;
> > > +       struct IO_APIC_route_entry entry;
> > > +       int trigger;
> > > +       int polarity;
> > > +       u32 count;
> > > +       bool isa_irq;
> > > +};
> > 
> > Since I see only this patch I am puzzled why you need to have this in
> > the header?
> > Maybe a couple of words in the commit message to elaborate?
> 
> Andy, does the following answer your question?
> 
> "The chip_data stashed in IO-APIC's irq chip is mp_chip_data.  The
> implementation of Microsoft Hypevisor's IO-APIC irqdomain would like to
> manipulate that data structure, so move it to io_apic.h as well."

At least it sheds some light, thanks.

> If that's good enough, I can add it to the commit message.

It's good for a starter, but I think you have to wait for what Thomas and other
related people can say.


-- 
With Best Regards,
Andy Shevchenko


