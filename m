Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC7615BD
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 Jul 2019 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGGRq3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 Jul 2019 13:46:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGRq3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 Jul 2019 13:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tsh1M3+YIkp/+slPl4drTdVgeXhFHnK+iRmBroB6M24=; b=JKG9FSVxwMXPED30sVVWKeoZN
        3T3+i/GVWvNpb6NrfWRfYiLy12PElmUZochO7zJlc9zxNE5ZsYdq29SARsHPCSb6Gdbd5+3jHev1M
        wUSQuBk/pPlNycIMehkFBKaRpwRc7zF8lJjJFfj/3aofrUDKStZnKWB4wEudVxfJu3y8qOjFNqwOg
        b6P4gbRUMp+DHYo9xbB+1Kh7UEDMZXCiy2OQjrKnp4nEvkORjhUqh6g0oHH0SSCDgswY3vJwmMifU
        IZe5fBUhG77ddg7ZWfOnET9G85hFI4ShWmRn1M4ToEVXD96TjzLw9a8FN1EGv6btJVn918LjbUQKV
        3EPTU6L+A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkBF1-0003m8-SC; Sun, 07 Jul 2019 17:46:23 +0000
Subject: Re: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Yuehaibing <yuehaibing@huawei.com>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <535f212f-e111-399d-4ad0-82d2ae505e48@infradead.org>
 <DM6PR21MB13373F2B76558930CC368E17CAFB0@DM6PR21MB1337.namprd21.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1261e6d-84c3-4874-5c32-a3988c5a85d6@infradead.org>
Date:   Sun, 7 Jul 2019 10:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <DM6PR21MB13373F2B76558930CC368E17CAFB0@DM6PR21MB1337.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 7/3/19 11:06 AM, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Wednesday, July 3, 2019 12:59 PM
>> To: LKML <linux-kernel@vger.kernel.org>; linux-pci <linux-
>> pci@vger.kernel.org>
>> Cc: Matthew Wilcox <willy@infradead.org>; Jake Oshins
>> <jakeo@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
>> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Bjorn
>> Helgaas <bhelgaas@google.com>; linux-hyperv@vger.kernel.org; Dexuan
>> Cui <decui@microsoft.com>; Yuehaibing <yuehaibing@huawei.com>
>> Subject: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
>>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build of drivers/pci/controller/pci-hyperv.o when
>> CONFIG_SYSFS is not set/enabled by adding stubs for
>> pci_create_slot() and pci_destroy_slot().
>>
>> Fixes these build errors:
>>
>> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
>>
>> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
>> information")
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Jake Oshins <jakeo@microsoft.com>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Sasha Levin <sashal@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-hyperv@vger.kernel.org
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Yuehaibing <yuehaibing@huawei.com>
>> ---
>> v2:
>> - provide non-CONFIG_SYSFS stubs for pci_create_slot() and
>>   pci_destroy_slot() [suggested by Matthew Wilcox <willy@infradead.org>]
>> - use the correct Fixes: tag [Dexuan Cui <decui@microsoft.com>]
>>
>>  include/linux/pci.h |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> --- lnx-52-rc7.orig/include/linux/pci.h
>> +++ lnx-52-rc7/include/linux/pci.h
>> @@ -25,6 +25,7 @@
>>  #include <linux/ioport.h>
>>  #include <linux/list.h>
>>  #include <linux/compiler.h>
>> +#include <linux/err.h>
>>  #include <linux/errno.h>
>>  #include <linux/kobject.h>
>>  #include <linux/atomic.h>
>> @@ -947,14 +948,21 @@ int pci_scan_root_bus_bridge(struct pci_
>>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev
>> *dev,
>>  				int busnr);
>>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
>> +#ifdef CONFIG_SYSFS
>> +void pci_dev_assign_slot(struct pci_dev *dev);
>>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>>  				 const char *name,
>>  				 struct hotplug_slot *hotplug);
>>  void pci_destroy_slot(struct pci_slot *slot);
>> -#ifdef CONFIG_SYSFS
>> -void pci_dev_assign_slot(struct pci_dev *dev);
>>  #else
>>  static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
>> +static inline struct pci_slot *pci_create_slot(struct pci_bus *parent,
>> +					       int slot_nr,
>> +					       const char *name,
>> +					       struct hotplug_slot *hotplug) {
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +static inline void pci_destroy_slot(struct pci_slot *slot) { }
>>  #endif
>>  int pci_scan_slot(struct pci_bus *bus, int devfn);
>>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>>
> 
> The serial number in slot info is used to match VF NIC with Synthetic NIC.
> Without selecting SYSFS, the SRIOV feature will fail on VM on Hyper-V and
> Azure. The first version of this patch should be used.
> 
> @Stephen Hemminger how do you think?
> 
> Thanks,
> - Haiyang


Hi Stephen,

Please comment on this patch or v1.
v1:  https://lore.kernel.org/lkml/69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org/


thanks.
-- 
~Randy
