Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9D46C62
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNWdY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 18:33:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44554 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNWdX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 18:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rhGH8vXrbfkTpqfy9SG7tV3FRuGTSRoQ0FXi9YN+f4E=; b=ijB5goFFdS+erFs2GYvxqE7Iv
        oSwFh7xFBAsh9tpJyjt2A7G2wU5AVJnwvUd84S2unF9MbSZi5foK2S3PEREOFfgym9J3u4dn9bPQi
        MWso1gcq4O2HW7lIgeuk/nyVJke55kSSlWJGzCZCTpd6nyjtv473J8/6rrLQjDg0Wj2pxy3SS33Ee
        4GQ+IlMnDM2325lUhbweMDAjaoVT6vP0LSOsXm5mA2GSCRPqwsuA1+c9aN9TbP1T7/nJbx+4IN0qW
        ZdQFKiyS7xfJ04RmJSrWxG/r+Q/uGbHTnjmOPl/5iQf71qutrsDgxhibUlkZSaT5MPo0ynMy9R5pq
        cMYSw9lyA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38712)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hbul4-0004DD-OZ; Fri, 14 Jun 2019 23:33:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hbukw-0002YP-RD; Fri, 14 Jun 2019 23:33:10 +0100
Date:   Fri, 14 Jun 2019 23:33:10 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20190614223310.pwwoefu5qdvcuaiy@shell.armlinux.org.uk>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

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

Don't forget that Linux does not support ACPI on 32-bit ARM, which is
quite different from the situation on 64-bit ARM.

arch/arm/kernel/hibernate.c is only for 32-bit ARM, and is written with
the assumption that there is no interaction required with any firmware
to save state, and later restore state upon resuming.

Or am I missing something?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
