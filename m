Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2E4CCED
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2019 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfFTLbN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jun 2019 07:31:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41673 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTLbM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jun 2019 07:31:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D30728053C; Thu, 20 Jun 2019 13:30:57 +0200 (CEST)
Date:   Thu, 20 Jun 2019 13:30:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Message-ID: <20190620113057.GA16460@atrey.karlin.mff.cuni.cz>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190617161454.GB27113@e121166-lin.cambridge.arm.com>
 <PU1P153MB016902786ABA34BD01430F83BFE50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB016902786ABA34BD01430F83BFE50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Lorenzo Pieralisi
> > Sent: Monday, June 17, 2019 9:15 AM
> > > ...
> > > + some ARM experts who worked on arch/arm/kernel/hibernate.c.
> > >
> > > drivers/acpi/sleep.c is only built if ACPI_SYSTEM_POWER_STATES_SUPPORT
> > > is defined, but it looks this option is not defined on ARM.
> > >
> > > It looks ARM does not support the ACPI S4 state, then how do we know
> > > if an ARM host supports hibernation or not?
> > 
> > Maybe we should start from understanding why you need to know whether
> > Hibernate is possible to answer your question ?
> > 
> > On ARM64 platforms system states are entered through PSCI firmware
> > interface that works for ACPI and device tree alike.
> > 
> > Lorenzo
> 
> Hi Lorenzo,
> It looks I may have confused you as I didn't realize the word "ARM" only means
> 32-bit ARM. It looks the "ARM" arch and the "ARM64" arch are very different.
> 
> As far as I know, Hyper-V only supports x86 and "ARM64", and it's unlikely to
> support 32-bit ARM in the future, so actually I don't really need to know if and
> how a 32-bit ARM machine supports hibernation.
> 
> When a Linux guest runs on Hyper-V (x86_32, x86_64, or ARM64) , we have a
> front-end balloon driver in the guest, which balloons up/down and
> hot adds/removes the guest's memory when the host requests that. The problem
> is: the back-end driver on the host can not really save and restore the states
> related to the front-end balloon driver on guest hibernation, so we made the
> decision that balloon up/down and hot-add/remove are not supported when
> we enable hibernation for a guest; BTW, we still want to load the front-end
> driver in the guest, because the dirver has a functionality of reporting the
> guest's memory pressure to the host, which we think is useful.
> 
> On x86_32 and x86_64, we enable hibernation for a guest by enabling
> the virtual ACPI S4 state for the guest; on ARM64, so far we don't have the
> host side changes required to support guest hibernation, so the details are
> still unclear.
> 
> After I discussed with Michael Kelley, it looks we don't really need to
> export drivers/acpi/sleep.c: acpi_sleep_state_supported(), but I think we do
> need to make it non-static.
> 
> Now I propose the below changes. I plan to submit a patch first for the
> changes made to drivers/acpi/sleep.c and include/acpi/acpi_bus.h in a few
> days, if there is no objection.
> 
> Please let me know how you think of this. Thanks!

No.

Hibernation should be always supported, no matter what firmware. If it
can powerdown, it can hibernate.

That is for x86-32/64, too.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
