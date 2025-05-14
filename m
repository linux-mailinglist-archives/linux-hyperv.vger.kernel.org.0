Return-Path: <linux-hyperv+bounces-5501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2ABAB62A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 07:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16B9189F0D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D41F5838;
	Wed, 14 May 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OhKEJrFo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590421F540F;
	Wed, 14 May 2025 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202329; cv=none; b=Uh3TLx6E3l3awQE/yo2P6QRCB0tN7P0NZ7fOJubSZV65Hdhi/Nu55idSTOAZJ8qisH6UwGRDy+O7iD58RdjcHPQtwVtpqEBs8H4snTHstyXKYVFTDbeKeWpUNcwkhdmljZKNdRYnY/AMN5MDKdLttByaP2jqz/axhhm/U9kjG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202329; c=relaxed/simple;
	bh=cGmg9cheAxyFryRoC6Te8wackXslJx7ED00nYuEEQz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNIMcNqkX6V2h7Dn5BF9e7xzPWLI4Oe8WKoc1kDzHBur23Ct2LyNfcQQrsbZhQI8pQ647wAK16s2zmH0VkRr8wfo3UgKzwTfRir6EksK/YzXO30m8ZEw5Oo5dw9F621CBjEOXGVkO33I3LS9jZBypYEkoRnr3ebRLA0jLaRfFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OhKEJrFo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.86])
	by linux.microsoft.com (Postfix) with ESMTPSA id D55FC211B7B1;
	Tue, 13 May 2025 22:58:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D55FC211B7B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747202322;
	bh=NnYKdj3ij2iXDDIUiNCnIIXurGumqUl4LPz/Efn66s4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OhKEJrFoRDYaAiZrAMIMFPehgT2RWrcL7qV5C0ZFrJdW2ThNZpmJoazm9tDaFraMJ
	 plq8adzfh++mMZeIY+0tsTJNPylkVvJriqVLGb76sY8FQCuZzWg6jOj84cFjFk2Z+I
	 dab00ShXuanzDnR9rZdN/EZ3ZyZVCKj/UmD7bV6A=
Message-ID: <b72e2e4d-b66f-4cba-8e8e-0afc605fa082@linux.microsoft.com>
Date: Wed, 14 May 2025 11:28:38 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Drivers: hv: Introduce mshv_vtl driver
To: ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20250512140432.2387503-1-namjain@linux.microsoft.com>
 <20250512140432.2387503-3-namjain@linux.microsoft.com>
 <82cf1c07-026b-470e-b093-018dcfced5aa@oracle.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <82cf1c07-026b-470e-b093-018dcfced5aa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/14/2025 2:04 AM, ALOK TIWARI wrote:
> 
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Microsoft Corporation.
>> + *
>> + * Author:
>> + *   Roman Kisel <romank@linux.microsoft.com>
>> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
>> + *   Naman Jain <namjain@linux.microsoft.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/anon_inodes.h>
>> +#include <linux/pfn_t.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/count_zeros.h>
>> +#include <linux/eventfd.h>
>> +#include <linux/poll.h>
>> +#include <linux/file.h>
>> +#include <linux/vmalloc.h>
>> +#include <asm/debugreg.h>
>> +#include <asm/mshyperv.h>
>> +#include <trace/events/ipi.h>
>> +#include <uapi/asm/mtrr.h>
>> +#include <uapi/linux/mshv.h>
>> +#include <hyperv/hvhdk.h>
>> +
>> +#include "../../kernel/fpu/legacy.h"
>> +#include "mshv.h"
>> +#include "mshv_vtl.h"
>> +#include "hyperv_vmbus.h"
>> +
>> +MODULE_AUTHOR("Microsoft");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
>> +
>> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
>> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
>> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
>> +
>> +#define MAX_GUEST_MEM_SIZE    BIT_ULL(40)
>> +#define MSHV_PG_OFF_CPU_MASK    0xFFFF
>> +#define MSHV_REAL_OFF_SHIFT    16
>> +#define MSHV_RUN_PAGE_OFFSET    0
>> +#define MSHV_REG_PAGE_OFFSET    1
>> +#define VTL2_VMBUS_SINT_INDEX    7
>> +
>> +static struct device *mem_dev;
>> +
>> +static struct tasklet_struct msg_dpc;
>> +static wait_queue_head_t fd_wait_queue;
>> +static bool has_message;
>> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
>> +static DEFINE_MUTEX(flag_lock);
>> +static bool __read_mostly mshv_has_reg_page;
>> +
>> +struct mshv_vtl_hvcall_fd {
>> +    u64 allow_bitmap[2 * PAGE_SIZE];
>> +    bool allow_map_intialized;
> 
> typo allow_map_intialized -> allow_map_initialized
> 

Noted. Will change it here and at other places. Thanks.

>> +    /*
>> +     * Used to protect hvcall setup in IOCTLs
>> +     */
>> +    struct mutex init_mutex;
>> +    struct miscdevice *dev;
>> +};
>> +
>> +struct mshv_vtl_poll_file {
>> +    struct file *file;
>> +    wait_queue_entry_t wait;
>> +    wait_queue_head_t *wqh;
>> +    poll_table pt;
>> +    int cpu;
>> +};
>> +
> [clip]
>> +
>> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
>> +                 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
>> +{
>> +    int ret = 0;
>> +    struct mshv_vtl_hvcall_setup hvcall_setup;
>> +
>> +    mutex_lock(&fd->init_mutex);
>> +
>> +    if (fd->allow_map_intialized) {
>> +        dev_err(fd->dev->this_device,
>> +            "Hypercall allow map has already been set, pid %d\n",
>> +            current->pid);
>> +        ret = -EINVAL;
>> +        goto exit;
>> +    }
>> +
>> +    if (copy_from_user(&hvcall_setup, hvcall_setup_user,
>> +               sizeof(struct mshv_vtl_hvcall_setup))) {
>> +        ret = -EFAULT;
>> +        goto exit;
>> +    }
>> +    if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
>> +        ret = -EINVAL;
>> +        goto exit;
>> +    }
> 
> is this valid case if hvcall_setup.bitmap_size == 0 ?

If bitmap_size is 0, then nothing will be copied in copy_from_user()
to .allow_bitmap and then mshv_vtl_hvcall_is_allowed() will start
returning 0/false for further hvcalls . This sounds reasonable
to me.

> 
>> +    if (copy_from_user(&fd->allow_bitmap,
>> +               (void __user *)hvcall_setup.allow_bitmap_ptr,
>> +               hvcall_setup.bitmap_size)) {
>> +        ret = -EFAULT;
>> +        goto exit;
>> +    }
>> +
> [clip]
> 
> 
> 
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> Thanks,
> Alok

Thanks again for reviewing.

Regards,
Naman

