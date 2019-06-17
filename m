Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5248883
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQQPA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 12:15:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFQQPA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 12:15:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92C4B28;
        Mon, 17 Jun 2019 09:14:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F353F718;
        Mon, 17 Jun 2019 09:14:56 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:14:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
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
Message-ID: <20190617161454.GB27113@e121166-lin.cambridge.arm.com>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 14, 2019 at 10:19:02PM +0000, Dexuan Cui wrote:
> > -----Original Message-----
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Friday, June 14, 2019 1:48 PM
> > To: Dexuan Cui <decui@microsoft.com>; linux-acpi@vger.kernel.org;
> > rjw@rjwysocki.net; lenb@kernel.org; robert.moore@intel.com;
> > erik.schmauss@intel.com
> > Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; Sasha Levin
> > <Alexander.Levin@microsoft.com>; olaf@aepfle.de; apw@canonical.com;
> > jasowang@redhat.com; vkuznets <vkuznets@redhat.com>;
> > marcelo.cerri@canonical.com
> > Subject: RE: [PATCH] ACPI: PM: Export the function
> > acpi_sleep_state_supported()
> > 
> > From: Dexuan Cui <decui@microsoft.com>  Sent: Friday, June 14, 2019 11:19
> > AM
> > >
> > > In a Linux VM running on Hyper-V, when ACPI S4 is enabled, the balloon
> > > driver (drivers/hv/hv_balloon.c) needs to ask the host not to do memory
> > > hot-add/remove.
> > >
> > > So let's export acpi_sleep_state_supported() for the hv_balloon driver.
> > > This might also be useful to the other drivers in the future.
> > >
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > ---
> > >  drivers/acpi/sleep.c    | 3 ++-
> > >  include/acpi/acpi_bus.h | 2 ++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index a34deccd7317..69755411e008 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -79,7 +79,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
> > >  	return 0;
> > >  }
> > >
> > > -static bool acpi_sleep_state_supported(u8 sleep_state)
> > > +bool acpi_sleep_state_supported(u8 sleep_state)
> > >  {
> > >  	acpi_status status;
> > >  	u8 type_a, type_b;
> > > @@ -89,6 +89,7 @@ static bool acpi_sleep_state_supported(u8 sleep_state)
> > >  		|| (acpi_gbl_FADT.sleep_control.address
> > >  			&& acpi_gbl_FADT.sleep_status.address));
> > >  }
> > > +EXPORT_SYMBOL_GPL(acpi_sleep_state_supported);
> > >
> > >  #ifdef CONFIG_ACPI_SLEEP
> > >  static u32 acpi_target_sleep_state = ACPI_STATE_S0;
> > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > index 31b6c87d6240..5b102e7bbf25 100644
> > > --- a/include/acpi/acpi_bus.h
> > > +++ b/include/acpi/acpi_bus.h
> > > @@ -651,6 +651,8 @@ static inline int acpi_pm_set_bridge_wakeup(struct
> > device *dev,
> > > bool enable)
> > >  }
> > >  #endif
> > >
> > > +bool acpi_sleep_state_supported(u8 sleep_state);
> > > +
> > >  #ifdef CONFIG_ACPI_SLEEP
> > >  u32 acpi_target_system_state(void);
> > >  #else
> > > --
> > > 2.19.1
> > 
> > It seems that sleep.c isn't built when on the ARM64 architecture.  Using
> > acpi_sleep_state_supported() directly in hv_balloon.c will be problematic
> > since hv_balloon.c needs to be architecture independent when the
> > Hyper-V ARM64 support is added.  If that doesn't change, a per-architecture
> > wrapper will be needed to give hv_balloon.c the correct information.  This
> > may affect whether acpi_sleep_state_supported() needs to be exported vs.
> > just removing the "static".   I'm not sure what the best approach is.
> > 
> > Michael
> 
> + some ARM experts who worked on arch/arm/kernel/hibernate.c.
> 
> drivers/acpi/sleep.c is only built if ACPI_SYSTEM_POWER_STATES_SUPPORT
> is defined, but it looks this option is not defined on ARM.
> 
> It looks ARM does not support the ACPI S4 state, then how do we know 
> if an ARM host supports hibernation or not?

Maybe we should start from understanding why you need to know whether
Hibernate is possible to answer your question ?

On ARM64 platforms system states are entered through PSCI firmware
interface that works for ACPI and device tree alike.

Lorenzo
