Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0567DD2EBE
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Oct 2019 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfJJQpJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Oct 2019 12:45:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:23346 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJQpJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Oct 2019 12:45:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 09:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; 
   d="scan'208";a="395454754"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.147.245]) ([10.249.147.245])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2019 09:45:03 -0700
Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
References: <20191008195624.GA198287@google.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <b64aaaf0-7959-d429-2ee3-bfde07ed811e@intel.com>
Date:   Thu, 10 Oct 2019 18:45:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008195624.GA198287@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/8/2019 9:56 PM, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2019 at 07:32:27PM +0200, Rafael J. Wysocki wrote:
>> On 10/7/2019 8:57 PM, Dexuan Cui wrote:
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>> Sent: Monday, October 7, 2019 6:24 AM
>>>> To: Dexuan Cui <decui@microsoft.com>
>>>> Cc: lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; Michael Kelley
>>>> <mikelley@microsoft.com>; linux-hyperv@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Sasha
>>>> Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang
>>>> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>>>> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; vkuznets
>>>> <vkuznets@redhat.com>; marcelo.cerri@canonical.com; Stephen Hemminger
>>>> <sthemmin@microsoft.com>; jackm@mellanox.com
>>>> Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
>>>> pci_legacy_resume_early()
>>>>
>>>> On Wed, Aug 14, 2019 at 01:06:55AM +0000, Dexuan Cui wrote:
>>>>> In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
>>>>>
>>>>> In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
>>>>> but the current code misses the pci_legacy_resume_early() path, so the
>>>>> state remains in PCI_UNKNOWN in that path. As a result, in the resume
>>>>> phase of hibernation, this causes an error for the Mellanox VF driver,
>>>>> which fails to enable MSI-X because pci_msi_supported() is false due
>>>>> to dev->current_state != PCI_D0:
>>>>>
>>>>> mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
>>>>> mlx4_core a6d1:00:02.0: Sending reset
>>>>> mlx4_core a6d1:00:02.0: Sending vhcr0
>>>>> mlx4_core a6d1:00:02.0: HCA minimum page size:512
>>>>> mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
>>>>> mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode,
>>>> aborting
>>>>> PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
>>>>> PM: Device a6d1:00:02.0 failed to thaw: error -95
>>>>>
>>>>> To be more accurate, the "resume" phase means the "thaw" callbacks which
>>>>> run before the system enters hibernation: when the user runs the command
>>>>> "echo disk > /sys/power/state" for hibernation, first the kernel "freezes"
>>>>> all the devices and creates a hibernation image, then the kernel "thaws"
>>>>> the devices including the disk/NIC, writes the memory to the disk, and
>>>>> powers down. This patch fixes the error message for the Mellanox VF driver
>>>>> in this phase.
> Wordsmithing nit: what the patch does is not "fix the error message";
> what it does is fix the *problem*, i.e., the fact that we can't
> operate the device because we can't enable MSI-X.  The message is only
> a symptom.
>
> IIUC the relevant part of the system hibernation sequence is:
>
>    pci_pm_freeze_noirq
>    pci_pm_thaw_noirq
>    pci_pm_thaw
>
> And the execution flow is:
>
>    pci_pm_freeze_noirq
>      if (pci_has_legacy_pm_support(pci_dev)) # true for mlx4
>        pci_legacy_suspend_late(dev, PMSG_FREEZE)
> 	pci_pm_set_unknown_state
> 	  dev->current_state = PCI_UNKNOWN  # <---
>    pci_pm_thaw_noirq
>      if (pci_has_legacy_pm_support(pci_dev)) # true
>        pci_legacy_resume_early(dev)          # noop; mlx4 doesn't implement
>    pci_pm_thaw                               # returns -95 EOPNOTSUPP
>      if (pci_has_legacy_pm_support(pci_dev)) # true
>        pci_legacy_resume
> 	drv->resume
> 	  mlx4_resume                       # mlx4_driver.resume (legacy)
> 	    mlx4_load_one
> 	      mlx4_enable_msi_x
> 		pci_enable_msix_range
> 		  __pci_enable_msix_range
> 		    __pci_enable_msix
> 		      if (!pci_msi_supported())
> 			if (dev->current_state != PCI_D0)  # <---
> 			  return 0
> 			return -EINVAL
> 		err = -EOPNOTSUPP
> 		"INTx is not supported ..."
>
> (These are just my notes; you don't need to put them all into the
> commit message.  I'm just sharing them in case I'm not understanding
> correctly.)
>
>>>>> When the system starts again, a fresh kernel starts to run, and when the
>>>>> kernel detects that a hibernation image was saved, the kernel "quiesces"
>>>>> the devices, and then "restores" the devices from the saved image. In this
>>>>> path:
>>>>> device_resume_noirq() -> ... ->
>>>>>     pci_pm_restore_noirq() ->
>>>>>       pci_pm_default_resume_early() ->
>>>>>         pci_power_up() moves the device states back to PCI_D0. This path is
>>>>> not broken and doesn't need my patch.
>>>>>
> The cc list suggests that this might be a fix for a user-reported
> problem.  Is there a launchpad or similar link you could include here?
>
> Should this be marked for stable?
>
>>>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>>> This looks like a bugfix for 5839ee7389e8 ("PCI / PM: Force devices to
>>>> D0 in pci_pm_thaw_noirq()") so maybe it should be marked for stable as
>>>> 5839ee7389e8 was?
>>>>
>>>> Rafael, could you confirm?
>> No, it is not a bug fix for that commit.  The underlying issue would be
>> there without that commit too.
> Oh, right, I dunno what I was thinking, sorry.
>
>>>>> --- a/drivers/pci/pci-driver.c
>>>>> +++ b/drivers/pci/pci-driver.c
>>>>> @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device
>>>> *dev)
>>>>>    			return error;
>>>>>    	}
>>>>>
>>>>> -	if (pci_has_legacy_pm_support(pci_dev))
>>>>> -		return pci_legacy_resume_early(dev);
>>>>> -
>>>>>    	/*
>>>>>    	 * pci_restore_state() requires the device to be in D0 (because of MSI
>>>>>    	 * restoration among other things), so force it into D0 in case the
>>>>>    	 * driver's "freeze" callbacks put it into a low-power state directly.
>>>>>    	 */
>>>>>    	pci_set_power_state(pci_dev, PCI_D0);
>>>>> +
>>>>> +	if (pci_has_legacy_pm_support(pci_dev))
>>>>> +		return pci_legacy_resume_early(dev);
>>>>> +
>>>>>    	pci_restore_state(pci_dev);
>>>>>
>>>>>    	if (drv && drv->pm && drv->pm->thaw_noirq)
>>>>> --
>>>>> 2.19.1
>>>>>
>> The patch looks reasonable to me, but the comment above the
>> pci_set_power_state() call needs to be updated too IMO.
> Hmm.
>
> 1) pci_restore_state() mainly writes config space, which doesn't
> require the device to be in D0.  The only thing I see that would
> require D0 is the MSI-X MMIO space, so to be more specific, the
> comment could say "restoring the MSI-X *MMIO* state requires the
> device to be in D0".
>
> But I think you meant some other comment change.  Did you mean
> something along the lines of "a legacy drv->resume_early() callback
> and pci_restore_state() both require the device to be in D0"?

Yes, I did.


