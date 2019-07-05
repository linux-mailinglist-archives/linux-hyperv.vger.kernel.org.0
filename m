Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D56033C
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jul 2019 11:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGEJkh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Jul 2019 05:40:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49389 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGEJkh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Jul 2019 05:40:37 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id c1519e1ec2a27edb; Fri, 5 Jul 2019 11:40:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH] ACPI: PM: Make acpi_sleep_state_supported() non-static
Date:   Fri, 05 Jul 2019 11:40:33 +0200
Message-ID: <1656981.zhPPi4nNQI@kreacher>
In-Reply-To: <PU1P153MB0169A260911AACDA861F0029BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169A260911AACDA861F0029BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thursday, July 4, 2019 4:43:32 AM CEST Dexuan Cui wrote:
> 
> With some upcoming patches to save/restore the Hyper-V drivers related
> states, a Linux VM running on Hyper-V will be able to hibernate. When
> a Linux VM hibernates, unluckily we must disable the memory hot-add/remove
> and balloon up/down capabilities in the hv_balloon driver
> (drivers/hv/hv_balloon.c), because these can not really work according to
> the design of the related back-end driver on the host.
> 
> By default, Hyper-V does not enable the virtual ACPI S4 state for a VM;
> on recent Hyper-V hosts, the administrator is able to enable the virtual
> ACPI S4 state for a VM, so we hope to use the presence of the virtual ACPI
> S4 state as a hint for hv_balloon to disable the aforementioned
> capabilities. In this way, hibernation will work more reliably, from the
> user's perspective.
> 
> By marking acpi_sleep_state_supported() non-static, we'll be able to
> implement a hv_is_hibernation_supported() API in the always-built-in
> module arch/x86/hyperv/hv_init.c, and the API will be called by hv_balloon.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Previously I posted a version that tries to export the function:
> https://lkml.org/lkml/2019/6/14/1077, which may be an overkill.
> 
> So I proposed a second patch (which covers this patch and shows how this
> patch will be used): https://lkml.org/lkml/2019/6/19/861
> 
> I explained the situation in detail here: https://lkml.org/lkml/2019/6/21/63
> (a correction: old Hyper-V hosts can support guest hibernation, but some
> important functionalities in the host's management tool stack are missing).
> 
> There is no further reply in that discussion, so I'm sending this patch to
> draw people's attention again. :-)
> 
>  drivers/acpi/sleep.c    | 2 +-
>  include/acpi/acpi_bus.h | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 8ff08e531443..d1ff303a857a 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -77,7 +77,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
>  	return 0;
>  }
>  
> -static bool acpi_sleep_state_supported(u8 sleep_state)
> +bool acpi_sleep_state_supported(u8 sleep_state)
>  {
>  	acpi_status status;
>  	u8 type_a, type_b;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 31b6c87d6240..3e6563e1a2c0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -651,6 +651,12 @@ static inline int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
> +bool acpi_sleep_state_supported(u8 sleep_state);
> +#else
> +bool acpi_sleep_state_supported(u8 sleep_state) { return false; }
> +#endif
> +
>  #ifdef CONFIG_ACPI_SLEEP
>  u32 acpi_target_system_state(void);
>  #else
> 

Applied, thanks!



