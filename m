Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A035F35658D
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDGHif (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 03:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhDGHif (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617781105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F/RC/fvqCURdl1YYUj40I8I1hZvQBl3Hi/4LGAyDow=;
        b=gx84uPm06MR9UriepQ5AFT0G8lFsIndfdd14gxMqZnVCHo6eLIyndbMoRIlp311RWR1FzS
        bTjP1IhiRraH9q9QUghbtBD6W91WEQD/ABGRu81MXyLlvt6mwM0Yb8m2gMf4idLhZO6dB2
        rFTZZAtve+3MqDtRd9jTHl75LBzuMm4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-i8RfJ-DjPsOTLmPdF5oFeA-1; Wed, 07 Apr 2021 03:38:24 -0400
X-MC-Unique: i8RfJ-DjPsOTLmPdF5oFeA-1
Received: by mail-ed1-f70.google.com with SMTP id l22so305860edt.8
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Apr 2021 00:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3F/RC/fvqCURdl1YYUj40I8I1hZvQBl3Hi/4LGAyDow=;
        b=BZBw1w8E1Nnv/o1EiP9bn/2dJqWd/U1BoyLoBZhOcThgRKEqh8K+3TvzeQ9+WOms5n
         45TE00oiL9R9HbnD/D5krjY1VmF01ozHeoXDjzSIhuBZqBWrjgYTharXrYmVC/SlBIN4
         yaraWHu3qQSrgFzgt3fMBJnOcpeGfVy7ti6puQudxvWucft7lIZITlrBcBKAO3xxHTKZ
         3D/96k9xJxleHcOXjwgQsHIvNovLN8uYDbA4sv87xRMP2L3Gb+kzPgOMiHUeAACUqPyp
         Ic5LBN7GQ32qIEO8uyTfv/tyMxTkY4AZx8CDLP3oy+YBRNkCjQBrtf0J1EuELe3CySP/
         WEWA==
X-Gm-Message-State: AOAM531+VcxVu4a5QoDgCHCOfxM8Bx84gzl0JJzSQUDK+/WO6HpZLUnp
        IgP9fNiWAYPVUd54Mbeo1Al3xDmuPWisnRono9kge74TnmdXlQMcd52fwd3ursyzcW83XojMslG
        isuD8WjbjPlsMdorsCXGWYnY+
X-Received: by 2002:a17:907:9611:: with SMTP id gb17mr2237666ejc.325.1617781102975;
        Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWJdCKOu9XXc7E7scSIAweJhXQCEIOBw2LgfiKIY6UeG+NZrHwNBKvBNLJ+ltcbeg03BcDgQ==
X-Received: by 2002:a17:907:9611:: with SMTP id gb17mr2237651ejc.325.1617781102784;
        Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bo19sm8418004edb.17.2021.04.07.00.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:38:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
Date:   Wed, 07 Apr 2021 09:38:21 +0200
Message-ID: <87eefmczo2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> On 3/5/2021 1:18 AM, Vitaly Kuznetsov wrote:
>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>> 
>>> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
>>>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>>>>
>> ...
>>>>> +
>>>>> +3.1 MSHV_REQUEST_VERSION
>>>>> +------------------------
>>>>> +:Type: /dev/mshv ioctl
>>>>> +:Parameters: pointer to a u32
>>>>> +:Returns: 0 on success
>>>>> +
>>>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
>>>>> +establish the interface version with the kernel module.
>>>>> +
>>>>> +The caller should pass the MSHV_VERSION as an argument.
>>>>> +
>>>>> +The kernel module will check which interface versions it supports and return 0
>>>>> +if one of them matches.
>>>>> +
>>>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>>>> +it is open - this ioctl can only be called once per open.
>>>>> +
>>>>
>>>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
>>>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
>>>> instead.
>>>>
>>>
>>> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
>>> When we add new features/ioctls beyond the core we can use an extension/capability
>>> approach like KVM.
>>>
>> 
>> Driver versions is a very bad idea from distribution/stable kernel point
>> of view as it presumes that the history is linear. It is not.
>> 
>> Imagine you have the following history upstream:
>> 
>> MSHV_REQUEST_VERSION = 1
>> <100 commits with features/fixes>
>> MSHV_REQUEST_VERSION = 2
>> <another 100 commits with features/fixes>
>> MSHV_REQUEST_VERSION = 2
>> 
>> Now I'm a linux distribution / stable kernel maintainer. My kernel is at
>> MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
>> VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
>> history now looks like
>> 
>> MSHV_REQUEST_VERSION = 1
>> <5 commits from between VER=1 and VER=2>
>>    Which version should I declare here???? 
>> <5 commits from between VER=2 and VER=3>
>>    Which version should I declare here???? 
>> 
>> If I keep VER=1 then userspace will think that I don't have any extra
>> features added and just won't use them. If I change VER to 2/3, it'll
>> think I have *all* features from between these versions.
>> 
>> The only reasonable way to manage this is to attach a "capability" to
>> every ABI change and expose this capability *in the same commit which
>> introduces the change to the ABI*. This way userspace will now exactly
>> which ioctls are available and what are their interfaces.
>> 
>> Also, trying to define "core set" is hard but you don't really need
>> to.
>> 
>
> We've had some internal discussion on this.
>
> There is bound to be some iteration before this ABI is stable, since even the
> underlying Microsoft hypervisor interfaces aren't stable just yet.
>
> It might make more sense to just have an IOCTL to check if the API is stable yet.
> This would be analogous to checking if kVM_GET_API_VERSION returns 12.
>
> How does this sound as a proposal?
> An MSHV_CHECK_EXTENSION ioctl to query extensions to the core /dev/mshv API.
>
> It takes a single argument, an integer named MSHV_CAP_* corresponding to
> the extension to check the existence of.
>
> The ioctl will return 0 if the extension is unsupported, or a positive integer
> if supported.
>
> We can initially include a capability called MSHV_CAP_CORE_API_STABLE.
> If supported, the core APIs are stable.

This sounds reasonable, I'd suggest you reserve MSHV_CAP_CORE_API_STABLE
right away but don't expose it yet so it's clear the API is not yet
stable. Test userspace you have may always assume it's running with the
latest kernel.

Also, please be clear about the fact that /dev/mshv doesn't
provide a stable API yet so nobody builds an application on top of
it.

One more though: it is probably a good idea to introduce selftests for
/dev/mshv (similar to KVM's selftests in
/tools/testing/selftests/kvm). Selftests don't really need a stable ABI
as they live in the same linux.git and can be updated in the same patch
series which changes /dev/mshv behavior. Selftests are very useful for
checking there are no regressions, especially in the situation when
there's no publicly available userspace for /dev/mshv.

-- 
Vitaly

