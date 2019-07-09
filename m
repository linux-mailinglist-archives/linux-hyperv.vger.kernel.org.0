Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7015E62D18
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 02:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGIAih (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Jul 2019 20:38:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIAih (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Jul 2019 20:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MMu2G/Jp8Uc0MtYvN5XmfJEHDoE9/Hc5PZa+Nl8Du9M=; b=UT4qMhgc1vrAFKWZSprLbEmZDx
        mCd8bqJi3z+8f9EVAq4Kw8ZTDF6fiR5QqFj02mopaU05OnYPtdmgVeWGFcZwnhiOY6zePgekHqKTS
        l2c41O34G6zMbVMEwsXtapKKL4L8wkjhbGicYbntff3jOWTfl5fUYrK/eePEifyYV0NlUZ/5Yp3bl
        OsSDZqxto+tFBs0rgy7SlWFV77iwIaQWVPUlTUFLA09JJ3hEsz/ndVJemgv54g8os6o6HmH/HEC2e
        1joq6xKH1KZRZ3GV01ZkfVI5bZ7Hjk94YKdTq1RZqokrWVEtYZA3VUCDTBDiHUEuxm6nmAKB5dxVR
        btTff9FA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hke9L-0003ER-RQ; Tue, 09 Jul 2019 00:38:28 +0000
Subject: Re: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Yuehaibing <yuehaibing@huawei.com>
References: <535f212f-e111-399d-4ad0-82d2ae505e48@infradead.org>
 <DM6PR21MB13373F2B76558930CC368E17CAFB0@DM6PR21MB1337.namprd21.prod.outlook.com>
 <c1261e6d-84c3-4874-5c32-a3988c5a85d6@infradead.org>
 <20190708080527.138e18e9@hermes.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4ce4f00-eaf6-51ef-4b97-89ef37a6dd38@infradead.org>
Date:   Mon, 8 Jul 2019 17:38:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708080527.138e18e9@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/8/19 8:05 AM, Stephen Hemminger wrote:
> On Sun, 7 Jul 2019 10:46:22 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 7/3/19 11:06 AM, Haiyang Zhang wrote:
>>>
>>>   
>>>> -----Original Message-----
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>> Sent: Wednesday, July 3, 2019 12:59 PM
>>>> To: LKML <linux-kernel@vger.kernel.org>; linux-pci <linux-  
>>>> pci@vger.kernel.org>  
>>>> Cc: Matthew Wilcox <willy@infradead.org>; Jake Oshins
>>>> <jakeo@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
>>>> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
>>>> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Bjorn
>>>> Helgaas <bhelgaas@google.com>; linux-hyperv@vger.kernel.org; Dexuan
>>>> Cui <decui@microsoft.com>; Yuehaibing <yuehaibing@huawei.com>
>>>> Subject: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
>>>>
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Fix build of drivers/pci/controller/pci-hyperv.o when
>>>> CONFIG_SYSFS is not set/enabled by adding stubs for
>>>> pci_create_slot() and pci_destroy_slot().
>>>>
>>>> Fixes these build errors:
>>>>
>>>> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>>> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>>>
>>>> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
>>>> information")
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Jake Oshins <jakeo@microsoft.com>
>>>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>>>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>>>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>>>> Cc: Sasha Levin <sashal@kernel.org>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: linux-pci@vger.kernel.org
>>>> Cc: linux-hyperv@vger.kernel.org
>>>> Cc: Dexuan Cui <decui@microsoft.com>
>>>> Cc: Yuehaibing <yuehaibing@huawei.com>
>>>> ---
>>>> v2:
>>>> - provide non-CONFIG_SYSFS stubs for pci_create_slot() and
>>>>   pci_destroy_slot() [suggested by Matthew Wilcox <willy@infradead.org>]
>>>> - use the correct Fixes: tag [Dexuan Cui <decui@microsoft.com>]
>>>>
>>>>  include/linux/pci.h |   12 ++++++++++--
>>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> --- lnx-52-rc7.orig/include/linux/pci.h
>>>> +++ lnx-52-rc7/include/linux/pci.h
>>>> @@ -25,6 +25,7 @@
>>>>  #include <linux/ioport.h>
>>>>  #include <linux/list.h>
>>>>  #include <linux/compiler.h>
>>>> +#include <linux/err.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/kobject.h>
>>>>  #include <linux/atomic.h>
>>>> @@ -947,14 +948,21 @@ int pci_scan_root_bus_bridge(struct pci_
>>>>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev
>>>> *dev,
>>>>  				int busnr);
>>>>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
>>>> +#ifdef CONFIG_SYSFS
>>>> +void pci_dev_assign_slot(struct pci_dev *dev);
>>>>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>>>  				 const char *name,
>>>>  				 struct hotplug_slot *hotplug);
>>>>  void pci_destroy_slot(struct pci_slot *slot);
>>>> -#ifdef CONFIG_SYSFS
>>>> -void pci_dev_assign_slot(struct pci_dev *dev);
>>>>  #else
>>>>  static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
>>>> +static inline struct pci_slot *pci_create_slot(struct pci_bus *parent,
>>>> +					       int slot_nr,
>>>> +					       const char *name,
>>>> +					       struct hotplug_slot *hotplug) {
>>>> +	return ERR_PTR(-EINVAL);
>>>> +}
>>>> +static inline void pci_destroy_slot(struct pci_slot *slot) { }
>>>>  #endif
>>>>  int pci_scan_slot(struct pci_bus *bus, int devfn);
>>>>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>>>>  
>>>
>>> The serial number in slot info is used to match VF NIC with Synthetic NIC.
>>> Without selecting SYSFS, the SRIOV feature will fail on VM on Hyper-V and
>>> Azure. The first version of this patch should be used.
>>>
>>> @Stephen Hemminger how do you think?
> 
> Haiyang is right, accelerated networking won't work if slot is not recorded.
> 
> So the original patch (to depend on SYSFS) or using "select SYSFS" is
> are necessary.

Thanks, I'll resend that one with the corrected Fixes: tag.

> The whole thing is a bit of "angels dancing on the head of a pin" because
> there is no good reason to build kernel without SYSFS in real world.
> It would just be looking for trouble. As far as I can tell it is all
> about getting "make randconfig" to work in more cases.

You could submit a patch to remove the SYSFS kconfig entry.  :)

cheers.

-- 
~Randy
