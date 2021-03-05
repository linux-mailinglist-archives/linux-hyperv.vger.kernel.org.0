Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A532E49B
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Mar 2021 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEJTC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Mar 2021 04:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhCEJSn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Mar 2021 04:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614935923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAq6+R4omWqyip9PJ9aVfNyoU1PYQDYL/jyjusPSWNI=;
        b=eN9FtNDPlwxvEd6mwpuLPMmSE9IOA2t8krKUE2tmIz1YWKAM2YUzesN43lHqW/1wL3U5Tr
        SeREi5rzsy4LFI83c4uCzQVra1poUdFgZTcMETPJMNIuw81FGsECGaKFZOc/jJfBfuZEEi
        YmnjBgJkp8+sGkf+PkjxxAx20z2fjao=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-o69c9amTNNi6c3i1_CYsiA-1; Fri, 05 Mar 2021 04:18:41 -0500
X-MC-Unique: o69c9amTNNi6c3i1_CYsiA-1
Received: by mail-ed1-f69.google.com with SMTP id q2so625656edt.16
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Mar 2021 01:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cAq6+R4omWqyip9PJ9aVfNyoU1PYQDYL/jyjusPSWNI=;
        b=A4p9afH2etLKtHHuwuQ34j1T6EHaURiHuzZNZwCVnKbmu+wHEgrTJ0xOZLNCgq30Gx
         Hbt3naZq5hLh2kz9XxRLHoETLjeYeMqI8GhXyWZCroDvfHR+BGWoNKU3oSc8hCx7kEhI
         aDTqdiQaap2xfc/hQcpm2qmCRsoOx3s1fVegsB7zuG+DRvPxcNh32Y1Bkb+eXX0fnW5j
         ny4UABdnBUpYvgNvAyAbOJ2jzhHsZDQHWBAhAXXPb/kXKZR7hPYMqdNkAfsX6i/Of7Oe
         d/kt7GzYr32Jv0G3r6CYIbJqjsJnFgtetKe4OFy0w6VZ0XIDx9J3Zhr9phRdwEWC3y4+
         Iwew==
X-Gm-Message-State: AOAM531uj2KD77RRVb9s2PWG+KoDNQ33K2CamrbdcEZIIs5SJCwJiiH3
        w4Lap1SIKMKyr8fTY3MdN7rdHRM5HcnmTEEzdii+szB+kWiD/W6ns2Pg+6VKStb7AGDm22Casfd
        ylw0nC0WgAdUOFkrVz9gV/8eI
X-Received: by 2002:a05:6402:b48:: with SMTP id bx8mr8583605edb.162.1614935920335;
        Fri, 05 Mar 2021 01:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXVfX0PnPVQKsPe9R9YUW7n4rJt0Uylzj8NB5VS7T55LlPe5QcWAL5+fw4IFfKrx7bsdqrHg==
X-Received: by 2002:a05:6402:b48:: with SMTP id bx8mr8583591edb.162.1614935920177;
        Fri, 05 Mar 2021 01:18:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t17sm1220844edr.36.2021.03.05.01.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:18:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
Date:   Fri, 05 Mar 2021 10:18:38 +0100
Message-ID: <87eeguc61d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>> 
...
>>> +
>>> +3.1 MSHV_REQUEST_VERSION
>>> +------------------------
>>> +:Type: /dev/mshv ioctl
>>> +:Parameters: pointer to a u32
>>> +:Returns: 0 on success
>>> +
>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
>>> +establish the interface version with the kernel module.
>>> +
>>> +The caller should pass the MSHV_VERSION as an argument.
>>> +
>>> +The kernel module will check which interface versions it supports and return 0
>>> +if one of them matches.
>>> +
>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>> +it is open - this ioctl can only be called once per open.
>>> +
>> 
>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
>> instead.
>> 
>
> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
> When we add new features/ioctls beyond the core we can use an extension/capability
> approach like KVM.
>

Driver versions is a very bad idea from distribution/stable kernel point
of view as it presumes that the history is linear. It is not.

Imagine you have the following history upstream:

MSHV_REQUEST_VERSION = 1
<100 commits with features/fixes>
MSHV_REQUEST_VERSION = 2
<another 100 commits with features/fixes>
MSHV_REQUEST_VERSION = 2

Now I'm a linux distribution / stable kernel maintainer. My kernel is at
MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
history now looks like

MSHV_REQUEST_VERSION = 1
<5 commits from between VER=1 and VER=2>
   Which version should I declare here???? 
<5 commits from between VER=2 and VER=3>
   Which version should I declare here???? 

If I keep VER=1 then userspace will think that I don't have any extra
features added and just won't use them. If I change VER to 2/3, it'll
think I have *all* features from between these versions.

The only reasonable way to manage this is to attach a "capability" to
every ABI change and expose this capability *in the same commit which
introduces the change to the ABI*. This way userspace will now exactly
which ioctls are available and what are their interfaces.

Also, trying to define "core set" is hard but you don't really need
to.

-- 
Vitaly

