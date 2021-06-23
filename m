Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3450E3B22E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jun 2021 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWWHu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Jun 2021 18:07:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFWWHr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Jun 2021 18:07:47 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE18B20B7188;
        Wed, 23 Jun 2021 15:05:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE18B20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624485929;
        bh=0S1B3tajSDS4jZ66fuyQAE4asiaTTZT2KKBCT5RZ+Tg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dvmAR0/Ir1JwoS4pQw0LRF8HnuEJjCmvcHosMXmVGSiyVlVp3CgaglO+GIS1CbcRB
         ihIT/j0yy+Ws3DhSVymjaqW61bLl2aRoyQ6fIe5Nkcbl781IofmTyGb2RfvHlcB5Ma
         KDXqsl58OskEywKmdb4BIx8pCSABfSiP/iFiED2k=
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
 <MW4PR21MB2004EB3380731C8102DB7D16C03C9@MW4PR21MB2004.namprd21.prod.outlook.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <323bb12e-82db-d54c-1014-7f0b431ebdd7@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 15:05:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <MW4PR21MB2004EB3380731C8102DB7D16C03C9@MW4PR21MB2004.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/2/2021 6:28 PM, Sunil Muthuswamy wrote:
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 66c794d92391..d618b1fab2bb 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -27,4 +27,22 @@ config HYPERV_BALLOON
>>  	help
>>  	  Select this option to enable Hyper-V Balloon driver.
>>
>> +config HYPERV_ROOT_API
> 
> A more suitable place to put this would be under the "VIRTUALIZATION"
> config menu option, where we have the "KVM" option today.
> 

Is Xen also under "VIRTUALIZATION"?

>> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
>> +	depends on HYPERV
>> +	help
>> +	  Provides access to interfaces for managing guest virtual machines
>> +	  running under the Microsoft Hypervisor.
> 
> These are technically not "root" interfaces. As you say it too, these are
> interfaces to manage guest VMs. Calling it "HYPERV_ROOT_API" would
> be confusing. Something along the lines of "HYPERV_VMM_API" or
> "HYPERV_VM_API" seems more appropriate to me.
> 

Good point - HYPERV_VMM_API might be better.

>> new file mode 100644
>> index 000000000000..c68cc84fb983
>> --- /dev/null
>> +++ b/drivers/hv/mshv_main.c
> Why not in /virt/hv or something under /virt?
> 

We decided that all the non arch-specific hyperv code should live in drivers/hv.

>> +static int mshv_dev_open(struct inode *inode, struct file *filp);
>> +static int mshv_dev_release(struct inode *inode, struct file *filp);
>> +static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
> 
> Do we need to have both 'mshv' & 'dev' in the name? How about just
> calling these 'mshv_xyz'? Like you have for init/exit.
> 

I wanted a distinction between mshv_* the module, and mshv_dev_* the root device of the module,
but I guess it's effectively the same thing.

>> +
>> +static struct miscdevice mshv_dev = {
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.name = "mshv",
>> +	.fops = &mshv_dev_fops,
>> +	.mode = 600,
>> +};
> For the default mode, I think we want to keep it the same as that for 'kvm'.
> 

KVM doesn't specify a mode here. Not sure how it gets set.

> - Sunil
> 
