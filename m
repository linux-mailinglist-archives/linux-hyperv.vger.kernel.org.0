Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CA46E91
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 08:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbfFOGSn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 Jun 2019 02:18:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18581 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfFOGSn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 Jun 2019 02:18:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 67AD2C45D52F06B7FBEE;
        Sat, 15 Jun 2019 14:18:40 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 14:18:36 +0800
Subject: Re: [PATCH] PCI: hv: Fix build error without CONFIG_SYSFS
To:     Michael Kelley <mikelley@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20190531150923.12376-1-yuehaibing@huawei.com>
 <BYAPR21MB12211EEA95200F437C8E37ECD71A0@BYAPR21MB1221.namprd21.prod.outlook.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <7d8ca05e-7519-45d8-e694-d31e221696d5@huawei.com>
Date:   Sat, 15 Jun 2019 14:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB12211EEA95200F437C8E37ECD71A0@BYAPR21MB1221.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2019/6/2 6:59, Michael Kelley wrote:
> From: YueHaibing <yuehaibing@huawei.com>  Sent: Friday, May 31, 2019 8:09 AM
>>
>> while building without CONFIG_SYSFS, fails as below:
>>
>> drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_assign_slots':
>> pci-hyperv.c:(.text+0x40a): undefined reference to 'pci_create_slot'
>> drivers/pci/controller/pci-hyperv.o: In function 'pci_devices_present_work':
>> pci-hyperv.c:(.text+0xc02): undefined reference to 'pci_destroy_slot'
>> drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_remove':
>> pci-hyperv.c:(.text+0xe50): undefined reference to 'pci_destroy_slot'
>> drivers/pci/controller/pci-hyperv.o: In function 'hv_eject_device_work':
>> pci-hyperv.c:(.text+0x11f9): undefined reference to 'pci_destroy_slot'
>>
>> Select SYSFS while PCI_HYPERV is set to fix this.
>>
> 
> I'm wondering if is the right way to fix the problem.  Conceptually
> is it possible to setup & operate virtual PCI devices like 
> pci-hyperv.c does, even if sysfs is not present?  Or is it right to
> always required sysfs?
> 
> The function pci_dev_assign_slot() in slot.c has a null implementation
> in include/linux/pci.h when CONFIG_SYSFS is not defined, which
> seems to be trying to solve the same problem for that function.  And
> if CONFIG_HOTPLUG_PCI is defined but CONFIG_SYSFS is not,
> pci_hp_create_module_link() and pci_hp_remove_module_link()
> look like they would have the same problem.  Maybe there should
> be degenerate implementations of pci_create_slot() and
> pci_destroy_slot() for cases when CONFIG_SYSFS is not defined?
> 
> But I'll admit I don't know the full story behind how PCI slots
> are represented and used, so maybe I'm off base.  I just noticed
> the inconsistency in how other functions in slot.c are handled.
> 
> Thoughts?

268a03a42d33 ("PCI: drivers/pci/slot.c should depend on CONFIG_SYSFS")

make slot.o depends CONFIG_SYSFS

commit 268a03a42d3377d5fb41e6e7cbdec4e0b65cab2e
Author: Alex Chiang <achiang@hp.com>
Date:   Wed Jun 17 19:03:57 2009 -0600

    PCI: drivers/pci/slot.c should depend on CONFIG_SYSFS

    There is no way to interact with a physical PCI slot without
    sysfs, so encode the dependency and prevent this build error:

        drivers/pci/slot.c: In function 'pci_hp_create_module_link':
        drivers/pci/slot.c:327: error: 'module_kset' undeclared

    This patch _should_ make pci-sysfs.o depend on CONFIG_SYSFS too,
    but we cannot (yet) because the PCI core merrily assumes the
    existence of sysfs:

        drivers/built-in.o: In function `pci_bus_add_device':
        drivers/pci/bus.c:89: undefined reference to `pci_create_sysfs_dev_files'
        drivers/built-in.o: In function `pci_stop_dev':
        drivers/pci/remove.c:24: undefined reference to `pci_remove_sysfs_dev_files'

    So do the minimal bit for now and figure out how to untangle it
    later.

If No CONFIG_SYSFS, slot.o is not build

> 
> Michael
> 
> 

