Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB45F3B2380
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jun 2021 00:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWWUb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Jun 2021 18:20:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32940 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWUa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Jun 2021 18:20:30 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5291820B7188;
        Wed, 23 Jun 2021 15:18:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5291820B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624486692;
        bh=QJRsqVQodqC2XLeNiwxcQB17F9aTuiBRP/T+vIefllI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s8CQjC3mf4cteJ+bYbmXlp8NkRSiNRHs3L00eMp7DRlwSOSpOcguv+LtOsz2jvIOT
         x0TVVde6JJ0hZuFH76f21bYZ8ev5V5JBiAuVQaaDB9mu/J0yogajjk1lSlPGOf13pj
         A5fex4loPUoHY4U4V1ToiUz0dV2dNKM9CPzUIrDw=
Subject: Re: [PATCH 00/19] Microsoft Hypervisor root partition ioctl interface
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <87bl8eyszj.fsf@vitty.brq.redhat.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <81498149-f47a-fb27-827d-a9510ffee373@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 15:18:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87bl8eyszj.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 6/10/2021 2:22 AM, Vitaly Kuznetsov wrote:
> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> 
>> This patch series provides a userspace interface for creating and running guest
>> virtual machines while running on the Microsoft Hypervisor [0].
>>
>> Since managing guest machines can only be done when Linux is the root partition,
>> this series depends on Wei Liu's patch series merged in 5.12:
>> https://lore.kernel.org/linux-hyperv/20210203150435.27941-1-wei.liu@kernel.org/
>>
>> The first two patches provide some helpers for converting hypervisor status
>> codes to linux error codes, and printing hypervisor status codes to dmesg for
>> debugging.
>>
>> Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
>> split into uapi and non-uapi. The uapi versions contain structures used in both
>> the ioctl interface and the kernel.
>>
>> The mshv API is introduced in drivers/hv/mshv_main.c. As each interface is
>> introduced, documentation is added in Documentation/virt/mshv/api.rst.
>> The API is file-desciptor based, like KVM. The entry point is /dev/mshv.
>>
>> /dev/mshv ioctls:
>> MSHV_CHECK_EXTENSION
>> MSHV_CREATE_PARTITION
>>
>> Partition (vm) ioctls:
>> MSHV_MAP_GUEST_MEMORY, MSHV_UNMAP_GUEST_MEMORY
>> MSHV_INSTALL_INTERCEPT
>> MSHV_ASSERT_INTERRUPT
>> MSHV_GET_PARTITION_PROPERTY, MSHV_SET_PARTITION_PROPERTY
>> MSHV_CREATE_VP
>>
>> Vp (vcpu) ioctls:
>> MSHV_GET_VP_REGISTERS, MSHV_SET_VP_REGISTERS
>> MSHV_RUN_VP
>> MSHV_GET_VP_STATE, MSHV_SET_VP_STATE
>> MSHV_TRANSLATE_GVA
>> mmap() (register page)
>>
>> [0] Hyper-V is more well-known, but it really refers to the whole stack
>>     including the hypervisor and other components that run in Windows kernel
>>     and userspace.
>>
>> Changes since RFC:
>> 1. Moved code from virt/mshv to drivers/hv
>> 2. Split hypercall helper functions and synic code to hv_call.c and hv_synic.c
>> 3. MSHV_REQUEST_VERSION ioctl replaced with MSHV_CHECK_EXTENSION
>> 3. Numerous suggestions, fixes, style changes, etc from Michael Kelley, Vitaly
>>    Kuznetsov, Wei Liu, and Vineeth Pillai
>> 4. Added patch to enable hypervisor enlightenments on partition creation
>> 5. Added Wei Liu's patch for GVA to GPA translation
>>
> 
> Thank you for addressing these!
> 
> One nitpick though: could you please run your next submission through
> 'scripts/checkpatch.pl'? It reports a number of issues here, mostly
> minor but still worth addressing, i.e.:
> 

Whoops! Yes, I will fix these. Thank you

> $ scripts/checkpatch.pl *.patch
> ...
> ---------------------------------------------------------------
> 0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch
> ---------------------------------------------------------------
> ERROR: Macros with complex values should be enclosed in parentheses
> #95: FILE: include/asm-generic/hyperv-tlfs.h:192:
> +#define __HV_STATUS_DEF(OP) \
> +	OP(HV_STATUS_SUCCESS,				0x0) \
> ...
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #119: FILE: include/asm-generic/hyperv-tlfs.h:216:
> +#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #120: FILE: include/asm-generic/hyperv-tlfs.h:217:
> +#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
> 
> WARNING: Macros with flow control statements should be avoided
> #120: FILE: include/asm-generic/hyperv-tlfs.h:217:
> +#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
> 
> WARNING: macros should not use a trailing semicolon
> #120: FILE: include/asm-generic/hyperv-tlfs.h:217:
> +#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
> 
> total: 3 errors, 2 warnings, 108 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch has
> style problems, please review.
> ...
> -------------------------------------------
> 0004-drivers-hv-check-extension-ioctl.patch
> -------------------------------------------
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #36: 
> new file mode 100644
> 
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #131: FILE: drivers/hv/mshv_main.c:52:
> +	return -ENOTSUPP;
> 
> total: 0 errors, 2 warnings, 137 lines checked
> 
> ...
> 
> WARNING: Improper SPDX comment style for 'drivers/hv/hv_call.c', please use '//' instead
> #94: FILE: drivers/hv/hv_call.c:1:
> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #94: FILE: drivers/hv/hv_call.c:1:
> +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> ERROR: "(foo*)" should be "(foo *)"
> #178: FILE: drivers/hv/hv_call.c:85:
> +				*(u64*)&input);
> 
> ERROR: "(foo*)" should be "(foo *)"
> #201: FILE: drivers/hv/hv_call.c:108:
> +			*(u64*)&input);
> 
> ERROR: "(foo*)" should be "(foo *)"
> #215: FILE: drivers/hv/hv_call.c:122:
> +	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64*)&input);
> 
> total: 3 errors, 3 warnings, 330 lines checked
> 
> ...
> ------------------------------------------------
> 0008-drivers-hv-map-and-unmap-guest-memory.patch
> ------------------------------------------------
> ERROR: code indent should use tabs where possible
> #101: FILE: drivers/hv/hv_call.c:222:
> +                                                    HV_MAP_GPA_DEPOSIT_PAGES);$
> 
> WARNING: please, no spaces at the start of a line
> #101: FILE: drivers/hv/hv_call.c:222:
> +                                                    HV_MAP_GPA_DEPOSIT_PAGES);$
> 
> ERROR: code indent should use tabs where possible
> #469: FILE: include/asm-generic/hyperv-tlfs.h:895:
> +        u32 padding;$
> 
> WARNING: please, no spaces at the start of a line
> #469: FILE: include/asm-generic/hyperv-tlfs.h:895:
> +        u32 padding;$
> 
> ERROR: code indent should use tabs where possible
> #477: FILE: include/asm-generic/hyperv-tlfs.h:903:
> +        u32 padding;$
> 
> WARNING: please, no spaces at the start of a line
> #477: FILE: include/asm-generic/hyperv-tlfs.h:903:
> +        u32 padding;$
> 
> total: 3 errors, 3 warnings, 487 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 0008-drivers-hv-map-and-unmap-guest-memory.patch has style problems, please review.
> ---------------------------------------
> 0009-drivers-hv-create-vcpu-ioctl.patch
> ---------------------------------------
> WARNING: Missing a blank line after declarations
> #76: FILE: drivers/hv/mshv_main.c:75:
> +	struct mshv_vp *vp = filp->private_data;
> +	mshv_partition_put(vp->partition);
> 
> ERROR: trailing whitespace
> #180: FILE: drivers/hv/mshv_main.c:376:
> +^I$
> 
> total: 1 errors, 1 warnings, 210 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 0009-drivers-hv-create-vcpu-ioctl.patch has style problems, please review.
> -------------------------------------------------------
> 0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch
> -------------------------------------------------------
> WARNING: braces {} are not necessary for single statement blocks
> #690: FILE: drivers/hv/hv_call.c:326:
> +		for (i = 0; i < rep_count; ++i) {
> +			input_page->names[i] = registers[i].name;
> +		}
> 
> WARNING: braces {} are not necessary for single statement blocks
> #704: FILE: drivers/hv/hv_call.c:340:
> +		for (i = 0; i < completed; ++i) {
> +			registers[i].value = output_page[i];
> +		}
> 
> WARNING: braces {} are not necessary for single statement blocks
> #859: FILE: drivers/hv/mshv_main.c:121:
> +	if (!registers) {
> +		return -ENOMEM;
> +	}
> 
> total: 0 errors, 3 warnings, 965 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch has style problems, please review.
> ---------------------------------------------------------------
> 0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch
> ---------------------------------------------------------------
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #274: 
> new file mode 100644
> 
> ERROR: code indent should use tabs where possible
> #310: FILE: drivers/hv/hv_synic.c:32:
> +                             MEMREMAP_WB);$
> 
> WARNING: please, no spaces at the start of a line
> #310: FILE: drivers/hv/hv_synic.c:32:
> +                             MEMREMAP_WB);$
> 
> total: 1 errors, 2 warnings, 574 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch has style problems, please review.
> ------------------------------------------
> 0012-drivers-hv-run-vp-ioctl-and-isr.patch
> ------------------------------------------
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #86: FILE: arch/x86/kernel/cpu/mshyperv.c:77:
> +EXPORT_SYMBOL_GPL(hv_remove_mshv_irq);
> 
> WARNING: consider using a completion
> #410: FILE: drivers/hv/mshv_main.c:344:
> +	sema_init(&vp->run.sem, 0);
> 
> total: 0 errors, 2 warnings, 435 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0012-drivers-hv-run-vp-ioctl-and-isr.patch has style problems, please review.
> ---------------------------------------------
> ...
> -------------------------------------------
> 0016-drivers-hv-mmap-vp-register-page.patch
> -------------------------------------------
> WARNING: Missing a blank line after declarations
> #222: FILE: drivers/hv/mshv_main.c:441:
> +	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
> +	vmf->page = vp->register_page;
> 
> total: 0 errors, 1 warnings, 257 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0016-drivers-hv-mmap-vp-register-page.patch has style problems, please review.
> -----------------------------------------------------------
> 0017-drivers-hv-get-and-set-partition-property-ioctls.patch
> -----------------------------------------------------------
> ERROR: code indent should use tabs where possible
> #205: FILE: include/asm-generic/hyperv-tlfs.h:890:
> +        u32 padding;$
> 
> WARNING: please, no spaces at the start of a line
> #205: FILE: include/asm-generic/hyperv-tlfs.h:890:
> +        u32 padding;$
> 
> ERROR: code indent should use tabs where possible
> #215: FILE: include/asm-generic/hyperv-tlfs.h:900:
> +        u32 padding;$
> 
> WARNING: please, no spaces at the start of a line
> #215: FILE: include/asm-generic/hyperv-tlfs.h:900:
> +        u32 padding;$
> 
> total: 2 errors, 2 warnings, 258 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 
