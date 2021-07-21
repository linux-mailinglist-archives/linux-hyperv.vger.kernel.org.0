Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFC3D097E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhGUGdI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 02:33:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40348 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhGUGc3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 02:32:29 -0400
Received: from [192.168.1.96] (unknown [223.226.82.147])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6E7CB20B7178;
        Wed, 21 Jul 2021 00:12:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E7CB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626851581;
        bh=MO7guIxHpjUQocmNc1KOQe8WT2YeXONIF9Q39UtiGI4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jy3C9M7d1CI71cZ2Gp4zrWil21i8NFLW0u5gL4HPqrXf6tGM/ev32wYNrUB+EH75u
         EHtEwieBOuPlIHfEuvptBtOrIAdyDou36L4pBUKaiAwsQNCBTixTAd6JaZOHtYrDKP
         X8qC9CLOne2eZF5ixqtKwauh6CEile+33Q/zxLa8=
Subject: Re: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
To:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
 <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
 <MWHPR21MB159302588AD32CA605192398D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <d8bd9c00-4eb5-187f-e31b-cba2ecec565b@linux.microsoft.com>
Date:   Wed, 21 Jul 2021 12:42:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159302588AD32CA605192398D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 21-07-2021 09:40, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 9:29 AM
>>
>> On Tue, Jul 20, 2021 at 04:20:44PM +0000, Michael Kelley wrote:
>>> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 6:35 AM
>>>>
>>>> On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
>>>> [...]
>>>>>>
>>>>>>> +	if (hv_root_partition &&
>>>>>>> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
>>>>>>
>>>>>> Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-root
>>>>>> kernel check this too?
>>>>>
>>>>> Yes, you are right. Will update this in v2. thanks.
>>>>
>>>> Please split adding this check to its own patch.
>>>>
>>>> Ideally one patch only does one thing.
>>>>
>>>> Wei.
>>>>
>>>
>>> I was just looking around in the Hyper-V TLFS, and I didn't see
>>> anywhere that the ability to set up a VP Assist page is dependent
>>> on HV_MSR_APIC_ACCESS_AVAILABLE.  Or did I just miss it?
>>
>> The feature bit Praveen used is wrong and should be fixed.
>>
>> Per internal discussion this is gated by the AccessIntrCtrlRegs bit.
>>
>> Wei.
>>
> 
> The AccessIntrCtrlRegs bit *is* HV_MSR_APIC_ACCESS_AVAILABLE.
> Both are defined as bit 4 of the Partition Privilege flags.  :-)   I don't
> know why the names don't line up.   Even so, it's not clear to me that
> AccessIntrCtrlRegs has any bearing on the VP Assist page.  I see this
> description of AccessIntrCtrlRegs:
> 

Yup, what I understood as well, this is the one required one for Partition Privilege Flags (4th bit), however, cannot comment on the naming convention.

     5 /* Virtual APIC assist and VP assist page registers available */
     4 #define HV_MSR_APIC_ACCESS_AVAILABLE            BIT(4)

> The partition has access to the synthetic MSRs associated with the
> APIC (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR).
> If this flag is cleared, accesses to these MSRs results in a #GP fault if
> the MSR intercept is not installed.
> 

As per what I also understood from the TLFS doc,that we let partition access the MSR and do a fault.
However, the point is, does it make sense to allocate page for vp assist and perform action which is meant to fail when the flag is cleared ?

> But maybe you have additional info that applies to the root
> partition that is not in the TLFS.
> 

As per what discussed internally and I understood, the root partition shares the vp assist page provided by hypervisor and its read only for Root kernel.

> Michael
> 

Regards,

~Praveen.
