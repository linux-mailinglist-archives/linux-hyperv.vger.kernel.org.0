Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949035603C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 02:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhDGAVk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Apr 2021 20:21:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54108 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbhDGAVk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Apr 2021 20:21:40 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 752F720B5682;
        Tue,  6 Apr 2021 17:21:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 752F720B5682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617754887;
        bh=dsWjuwSWS1UbNmop4Q0TErGKiSBFlt9sxSWUWoAXk5Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y9dDC+zKbA0Qia4922TP03JxYihnTrj6OAnpvMQTkFO0O86r/nZqnBV0uSVWCLWmH
         4ByNLsPG60wF38HkrDHWm27Kp5LLLeh4lZ2RfDBqfZCKdi5T7vjw99wwagA0FK1StI
         lBHWCNEYDcDzrx+R21tknoU1BC+JbD/dgkfgrX4g=
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
Date:   Tue, 6 Apr 2021 17:21:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87eeguc61d.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/5/2021 1:18 AM, Vitaly Kuznetsov wrote:
> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> 
>> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
>>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>>>
> ...
>>>> +
>>>> +3.1 MSHV_REQUEST_VERSION
>>>> +------------------------
>>>> +:Type: /dev/mshv ioctl
>>>> +:Parameters: pointer to a u32
>>>> +:Returns: 0 on success
>>>> +
>>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
>>>> +establish the interface version with the kernel module.
>>>> +
>>>> +The caller should pass the MSHV_VERSION as an argument.
>>>> +
>>>> +The kernel module will check which interface versions it supports and return 0
>>>> +if one of them matches.
>>>> +
>>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>>> +it is open - this ioctl can only be called once per open.
>>>> +
>>>
>>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
>>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
>>> instead.
>>>
>>
>> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
>> When we add new features/ioctls beyond the core we can use an extension/capability
>> approach like KVM.
>>
> 
> Driver versions is a very bad idea from distribution/stable kernel point
> of view as it presumes that the history is linear. It is not.
> 
> Imagine you have the following history upstream:
> 
> MSHV_REQUEST_VERSION = 1
> <100 commits with features/fixes>
> MSHV_REQUEST_VERSION = 2
> <another 100 commits with features/fixes>
> MSHV_REQUEST_VERSION = 2
> 
> Now I'm a linux distribution / stable kernel maintainer. My kernel is at
> MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
> VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
> history now looks like
> 
> MSHV_REQUEST_VERSION = 1
> <5 commits from between VER=1 and VER=2>
>    Which version should I declare here???? 
> <5 commits from between VER=2 and VER=3>
>    Which version should I declare here???? 
> 
> If I keep VER=1 then userspace will think that I don't have any extra
> features added and just won't use them. If I change VER to 2/3, it'll
> think I have *all* features from between these versions.
> 
> The only reasonable way to manage this is to attach a "capability" to
> every ABI change and expose this capability *in the same commit which
> introduces the change to the ABI*. This way userspace will now exactly
> which ioctls are available and what are their interfaces.
> 
> Also, trying to define "core set" is hard but you don't really need
> to.
> 

We've had some internal discussion on this.

There is bound to be some iteration before this ABI is stable, since even the
underlying Microsoft hypervisor interfaces aren't stable just yet.

It might make more sense to just have an IOCTL to check if the API is stable yet.
This would be analogous to checking if kVM_GET_API_VERSION returns 12.

How does this sound as a proposal?
An MSHV_CHECK_EXTENSION ioctl to query extensions to the core /dev/mshv API.

It takes a single argument, an integer named MSHV_CAP_* corresponding to
the extension to check the existence of.

The ioctl will return 0 if the extension is unsupported, or a positive integer
if supported.

We can initially include a capability called MSHV_CAP_CORE_API_STABLE.
If supported, the core APIs are stable.
