Return-Path: <linux-hyperv+bounces-468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B87B8875
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8F6DE1C203BF
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27581D68D;
	Wed,  4 Oct 2023 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hQ5yb0Z3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7C1D6A2
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Oct 2023 18:16:49 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E076A7;
	Wed,  4 Oct 2023 11:16:48 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id D440620B74C2;
	Wed,  4 Oct 2023 11:16:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D440620B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696443407;
	bh=cb3Cn5uFmmhvezEjsgPr/7TAsXnOt8mw0WVyDVVkoNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hQ5yb0Z3u+VTo0KbZX//PdVbLhCSFC3mhN67YsPEJy0IakC7G13dj12ECZ/+iFXKL
	 5RmIamHk1JCosfQJxlUOL/PeHl/M+f68XzUQyqtoNaGuXMdH370qibhMf07jSTguq9
	 WauZnyAwIRzLwbbRJO2zePDtjT9w415VjegYCqqo=
Message-ID: <e960ffec-f367-4180-b857-4aceedb7cd89@linux.microsoft.com>
Date: Wed, 4 Oct 2023 11:16:46 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 MUKESH RATHOR <mukeshrathor@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 vkuznets <vkuznets@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "will@kernel.org" <will@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
 <2023100443-wrinkly-romp-79d9@gregkh>
 <SA1PR21MB1335F5145ACB0ED4F378105ABFCBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <2023100415-diving-clapper-a2a7@gregkh>
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2023100415-diving-clapper-a2a7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/2023 10:50 AM, Greg KH wrote:
> On Wed, Oct 04, 2023 at 05:36:32PM +0000, Dexuan Cui wrote:
>>> From: Greg KH <gregkh@linuxfoundation.org>
>>> Sent: Tuesday, October 3, 2023 11:10 PM
>>> [...]
>>> On Tue, Oct 03, 2023 at 04:37:01PM -0700, Nuno Das Neves wrote:
>>>> On 9/30/2023 11:19 PM, Greg KH wrote:
>>>>> On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
>>>>>> On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
>>>>>>> On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
>>>>>>>> +/* Define connection identifier type. */
>>>>>>>> +union hv_connection_id {
>>>>>>>> +   __u32 asu32;
>>>>>>>> +   struct {
>>>>>>>> +           __u32 id:24;
>>>>>>>> +           __u32 reserved:8;
>>>>>>>> +   } __packed u;
>>
>> IMO the "__packed" is unnecessary.
>>
>>>>>>> bitfields will not work properly in uapi .h files, please never do that.
>>>>>>
>>>>>> Can you clarify a bit more why it wouldn't work? Endianess? Alignment?
>>>>>
>>>>> Yes to both.
>>>>>
>>>>> Did you all read the documentation for how to write a kernel api?  If
>>>>> not, please do so.  I think it mentions bitfields, but it not, it really
>>>>> should as of course, this will not work properly with different endian
>>>>> systems or many compilers.
>>>>
>>>> Yes, in
>>> https://docs.k/
>>> ernel.org%2Fdriver-
>>> api%2Fioctl.html&data=05%7C01%7Cdecui%40microsoft.com%7Ce404769e0f
>>> 85493f0aa108dbc4a08a27%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C
>>> 0%7C638319966071263290%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>>> 7C%7C&sdata=RiLNA5DRviWBQK6XXhxC4m77raSDBb%2F0BB6BDpFPUJY%3D
>>> &reserved=0 it says that it is
>>>> "better to avoid" bitfields.
>>>>
>>>> Unfortunately bitfields are used in the definition of the hypervisor
>>>> ABI. We import these definitions directly from the hypervisor code.
>>>
>>> So why do you feel you have to use this specific format for your
>>> user/kernel api?  That is not what is going to the hypervisor.
>>
These *are* going to the hypervisor - we use these same definitions in
our driver for the kernel/hypervisor API. This is so we don't have to
maintain two separate definitions for user/kernel and kernel/hypervisor
APIs.

>> If it's hard to avoid bitfield here, maybe we can refer to the definition of
>> struct iphdr in include/uapi/linux/ip.h
> 
> It is not hard to avoid using bitfields, just use the proper definitions
> to make this portable for all compilers.  And ick, ip.h is not a good
> thing to follow :)
> 
Greg, there is nothing making us use bitfields. It just makes the work
of porting the hypervisor definitions to Linux easier - aided by the
fact that in practice, all the compilers in our stack produce the same
code for these.

If that stops being true, or we need to support some other scenario,
then I can see the value in changing it. Right now it just feels like
pointless work.

Just a reminder - we are the only consumers of this code right now; no
one else can meaningfully use this interface yet.

That all said, if you really insist on changing it, then please say so.
And please point to an example of how it should be done so there is no
confusion on the best path forward.

Thanks,
Nuno

> thanks,
> 
> greg k-h


