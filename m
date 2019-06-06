Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1B379D7
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFFQhs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 12:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFQhs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 12:37:48 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D882A206BB;
        Thu,  6 Jun 2019 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559839067;
        bh=SBlCYXjXf9Dmv/1zjLqy5l9A1C3/vFnxMgdVK5+kQww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieLpvDzWcm5ztonnfpaX04Bf5XtKdgUmixTRnLfue8zPzBFlHhb0bdxXJ0QUOI8hC
         m390QKwAJBsuYwTCBnC6dbDKIrWmrnCmIuIzIC6i23+8X0Jg2W9R3FozjfKP9deUz5
         OEpzhHSWIZ/ihC8lYmNu8MNLNJEYCpggsMCjdmw0=
Date:   Thu, 6 Jun 2019 12:37:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Message-ID: <20190606163745.GL29739@sasha-vm>
References: <1558969089-13204-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1558969089-13204-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 27, 2019 at 02:59:07PM +0000, Michael Kelley wrote:
>This patch series moves Hyper-V clock/timer code to a separate Hyper-V
>clocksource driver. Previously, Hyper-V clock/timer code and data
>structures were mixed in with other Hyper-V code in the ISA independent
>drivers/hv code as well as in arch dependent code. The new Hyper-V
>clocksource driver is ISA independent, with a just few dependencies on
>arch specific functions. The patch series does not change any behavior
>or functionality -- it only reorganizes the existing code and fixes up
>the linkages. A few places outside of Hyper-V code are fixed up to use
>the new #include file structure.
>
>This restructuring is in response to Marc Zyngier's review comments
>on supporting Hyper-V running on ARM64, and is a good idea in general.
>It increases the amount of code shared between the x86 and ARM64
>architectures, and reduces the size of the new code for supporting
>Hyper-V on ARM64. A new version of the Hyper-V on ARM64 patches will
>follow once this clocksource restructuring is accepted.
>
>The code is diff'ed against Linux 5.2.0-rc1-next-20190524.
>
>Changes in v3:
>* Removed boolean argument to hv_init_clocksource(). Always call
>sched_clock_register, which is needed on ARM64 but a no-op on x86.
>* Removed separate cpuhp setup in hv_stimer_alloc() and instead
>directly call hv_stimer_init() and hv_stimer_cleanup() from
>corresponding VMbus functions.  This more closely matches original
>code and avoids clocksource stop/restart problems on ARM64 when
>VMbus code denies CPU offlining request.
>
>Changes in v2:
>* Revised commit short descriptions so the distinction between
>the first and second patches is clearer [GregKH]
>* Renamed new clocksource driver files and functions to use
>existing "timer" and "stimer" names instead of introducing
>"syntimer". [Vitaly Kuznetsov]
>* Introduced CONFIG_HYPER_TIMER to fix build problem when
>CONFIG_HYPERV=m [Vitaly Kuznetsov]
>* Added "Suggested-by: Marc Zyngier"
>
>Michael Kelley (2):
>  Drivers: hv: Create Hyper-V clocksource driver from existing
>    clockevents code
>  Drivers: hv: Move Hyper-V clocksource code to new clocksource driver
>
> MAINTAINERS                          |   2 +
> arch/x86/entry/vdso/vclock_gettime.c |   1 +
> arch/x86/entry/vdso/vma.c            |   2 +-
> arch/x86/hyperv/hv_init.c            |  91 +---------
> arch/x86/include/asm/hyperv-tlfs.h   |   6 +
> arch/x86/include/asm/mshyperv.h      |  81 ++-------
> arch/x86/kernel/cpu/mshyperv.c       |   2 +
> arch/x86/kvm/x86.c                   |   1 +
> drivers/clocksource/Makefile         |   1 +
> drivers/clocksource/hyperv_timer.c   | 321 +++++++++++++++++++++++++++++++++++
> drivers/hv/Kconfig                   |   3 +
> drivers/hv/hv.c                      | 156 +----------------
> drivers/hv/hv_util.c                 |   1 +
> drivers/hv/hyperv_vmbus.h            |   3 -
> drivers/hv/vmbus_drv.c               |  42 ++---
> include/clocksource/hyperv_timer.h   | 105 ++++++++++++
> 16 files changed, 484 insertions(+), 334 deletions(-)
> create mode 100644 drivers/clocksource/hyperv_timer.c
> create mode 100644 include/clocksource/hyperv_timer.h

Queued for hyperv-next, thanks!

--
Thanks,
Sasha
