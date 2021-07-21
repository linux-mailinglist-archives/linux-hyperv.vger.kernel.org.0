Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A663D07FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 06:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhGUEQ4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 00:16:56 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45728 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhGUEQe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 00:16:34 -0400
Received: by mail-ed1-f49.google.com with SMTP id x17so747539edd.12;
        Tue, 20 Jul 2021 21:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1CpyrlxbkQi8C3eKrGFY5ZV8sAO1WbnuAPLS/w9iyc=;
        b=jBAPrGNXTUYVryYWhW0yT82PbMHi6faQKRsQBZ69QIjwFn9LHNNOKiwdpXDgP8eODT
         mcjqoYgQVqE+/u2QizmTlciVzQ8XxSXZCQhaeMxhz0OVoU/CO8hro5tDPyt5buhTgBBr
         6D79fsPpebjzEq+fElrM5fuOBHPrfoJWU+lMHYl4vSsjG+Rq9/LJsDMeC47jozKdCksK
         MpfWnuK60gJsgIXBRWBVj/YVlx+VR3ZEUxX00Tl2Aq9gtvEAe+9lBlAhXm0+vOVxe/Xz
         la8a+ectMxcWTj2nGpGNVq1BVW2ICDFn0qnDPCv7AqIhncIffoIROj1JWooEUGN5M4v4
         s/vw==
X-Gm-Message-State: AOAM530kArH/FdYWpIgzF5A83swCItLPHIOntOwM4p+KN2cA88y/oJzO
        B+8Vnx7gJyJRzWlAodWS3pD0yToTnTkuYxn+
X-Google-Smtp-Source: ABdhPJxO2gHuT5k9dcnnZGNk0MGMbiLxVmvaik28q18dCpokHnuwiZzoDtkaMJ2BA5ylmY0hCGjwCw==
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr45104066edr.290.1626843430294;
        Tue, 20 Jul 2021 21:57:10 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id s18sm7979195ejh.12.2021.07.20.21.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 21:57:09 -0700 (PDT)
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
 <90ed52d3-5095-9789-53f0-477ba70edc3b@kernel.org>
 <BY5PR21MB15069D0519AD92773355FCF6CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5c5dd1e5-2639-b293-b2e0-d7cfd5ca3c0c@kernel.org>
Date:   Wed, 21 Jul 2021 06:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BY5PR21MB15069D0519AD92773355FCF6CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21. 07. 21, 0:12, Long Li wrote:
>> Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
>>
>> On 20. 07. 21, 5:31, longli@linuxonhyperv.com wrote:
>>> --- /dev/null
>>> +++ b/include/uapi/misc/hv_azure_blob.h
>>> @@ -0,0 +1,34 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>>> +/* Copyright (c) 2021 Microsoft Corporation. */
>>> +
>>> +#ifndef _AZ_BLOB_H
>>> +#define _AZ_BLOB_H
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/uuid.h>
>>
>> Quoting from
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
>> kernel.org%2Flinux-
>> doc%2FMWHPR21MB159375586D810EC5DCB66AF0D7039%40MWHPR21MB1
>> 593.namprd21.prod.outlook.com%2F&amp;data=04%7C01%7Clongli%40micr
>> osoft.com%7C7fdf2d6ed15d4d4122a308d94b6eeed0%7C72f988bf86f141af91
>> ab2d7cd011db47%7C1%7C0%7C637623762292949381%7CUnknown%7CTWFp
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
>> I6Mn0%3D%7C3000&amp;sdata=kv0ZkU1QL6TxlJJZEQEsT7aqLFL9lmP2SStz8k
>> U5sIs%3D&amp;reserved=0:
>> =====
>> Seems like a #include of asm/ioctl.h (or something similar) is needed so that
>> _IOWR is defined.  Also, a #include is needed for __u32, __aligned_u64,
>> guid_t, etc.
>> =====
> 
> The user-space code includes "sys/ioctl.h" for calling into ioctl(). "sys/ioctl.h"
> includes <linux/ioctl.h>, so it has no problem finding _IOWR.
> 
> guid_t is defined in <uapi/linux/uuid.h>, included from <linux/uuid.h> (in this file)
> __u32 and __aligned_u64 are defined in <uapi/linux/types.>, which is included from <linux/kernel.h> (in this file)

No, please don't rely on implicit include chains. Nor that userspace 
solves the includes for you.

thanks,
-- 
js
suse labs
