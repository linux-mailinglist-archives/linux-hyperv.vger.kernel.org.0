Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA16CFFF0
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJHRcd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 13:32:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:64562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJHRcd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 13:32:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 10:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="193439247"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.147.52]) ([10.249.147.52])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2019 10:32:28 -0700
Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
To:     Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
References: <KU1P153MB016637CAEAD346F0AA8E3801BFAD0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <20191007132414.GA19294@google.com>
 <PU1P153MB016996765F9BB827256D05DEBF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <a2d8ad9f-b59d-57e4-f014-645e7b796cc4@intel.com>
Date:   Tue, 8 Oct 2019 19:32:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <PU1P153MB016996765F9BB827256D05DEBF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/7/2019 8:57 PM, Dexuan Cui wrote:
>> -----Original Message-----
>> From: Bjorn Helgaas <helgaas@kernel.org>
>> Sent: Monday, October 7, 2019 6:24 AM
>> To: Dexuan Cui <decui@microsoft.com>
>> Cc: lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; Michael Kelley
>> <mikelley@microsoft.com>; linux-hyperv@vger.kernel.org;
>> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Sasha
>> Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; vkuznets
>> <vkuznets@redhat.com>; marcelo.cerri@canonical.com; Stephen Hemminger
>> <sthemmin@microsoft.com>; jackm@mellanox.com
>> Subject: Re: [PATCH v2] PCI: PM: Move to D0 before calling
>> pci_legacy_resume_early()
>>
>> On Wed, Aug 14, 2019 at 01:06:55AM +0000, Dexuan Cui wrote:
>>> In pci_legacy_suspend_late(), the device state is moved to PCI_UNKNOWN.
>>>
>>> In pci_pm_thaw_noirq(), the state is supposed to be moved back to PCI_D0,
>>> but the current code misses the pci_legacy_resume_early() path, so the
>>> state remains in PCI_UNKNOWN in that path. As a result, in the resume
>>> phase of hibernation, this causes an error for the Mellanox VF driver,
>>> which fails to enable MSI-X because pci_msi_supported() is false due
>>> to dev->current_state != PCI_D0:
>>>
>>> mlx4_core a6d1:00:02.0: Detected virtual function - running in slave mode
>>> mlx4_core a6d1:00:02.0: Sending reset
>>> mlx4_core a6d1:00:02.0: Sending vhcr0
>>> mlx4_core a6d1:00:02.0: HCA minimum page size:512
>>> mlx4_core a6d1:00:02.0: Timestamping is not supported in slave mode
>>> mlx4_core a6d1:00:02.0: INTx is not supported in multi-function mode,
>> aborting
>>> PM: dpm_run_callback(): pci_pm_thaw+0x0/0xd7 returns -95
>>> PM: Device a6d1:00:02.0 failed to thaw: error -95
>>>
>>> To be more accurate, the "resume" phase means the "thaw" callbacks which
>>> run before the system enters hibernation: when the user runs the command
>>> "echo disk > /sys/power/state" for hibernation, first the kernel "freezes"
>>> all the devices and creates a hibernation image, then the kernel "thaws"
>>> the devices including the disk/NIC, writes the memory to the disk, and
>>> powers down. This patch fixes the error message for the Mellanox VF driver
>>> in this phase.
>>>
>>> When the system starts again, a fresh kernel starts to run, and when the
>>> kernel detects that a hibernation image was saved, the kernel "quiesces"
>>> the devices, and then "restores" the devices from the saved image. In this
>>> path:
>>> device_resume_noirq() -> ... ->
>>>    pci_pm_restore_noirq() ->
>>>      pci_pm_default_resume_early() ->
>>>        pci_power_up() moves the device states back to PCI_D0. This path is
>>> not broken and doesn't need my patch.
>>>
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> This looks like a bugfix for 5839ee7389e8 ("PCI / PM: Force devices to
>> D0 in pci_pm_thaw_noirq()") so maybe it should be marked for stable as
>> 5839ee7389e8 was?
>>
>> Rafael, could you confirm?

No, it is not a bug fix for that commit.  The underlying issue would be 
there without that commit too.


>>> ---
>>>
>>> changes in v2:
>>> 	Updated the changelog with more details.
>>>
>>>   drivers/pci/pci-driver.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index 36dbe960306b..27dfc68db9e7 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct device
>> *dev)
>>>   			return error;
>>>   	}
>>>
>>> -	if (pci_has_legacy_pm_support(pci_dev))
>>> -		return pci_legacy_resume_early(dev);
>>> -
>>>   	/*
>>>   	 * pci_restore_state() requires the device to be in D0 (because of MSI
>>>   	 * restoration among other things), so force it into D0 in case the
>>>   	 * driver's "freeze" callbacks put it into a low-power state directly.
>>>   	 */
>>>   	pci_set_power_state(pci_dev, PCI_D0);
>>> +
>>> +	if (pci_has_legacy_pm_support(pci_dev))
>>> +		return pci_legacy_resume_early(dev);
>>> +
>>>   	pci_restore_state(pci_dev);
>>>
>>>   	if (drv && drv->pm && drv->pm->thaw_noirq)
>>> --
>>> 2.19.1
>>>
The patch looks reasonable to me, but the comment above the 
pci_set_power_state() call needs to be updated too IMO.


