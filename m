Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE43155BC
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 19:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhBISTg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 13:19:36 -0500
Received: from foss.arm.com ([217.140.110.172]:55150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233175AbhBISRv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 13:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A251042;
        Tue,  9 Feb 2021 10:15:43 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E9B3F73B;
        Tue,  9 Feb 2021 10:15:29 -0800 (PST)
Subject: Re: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Leandro Pereira <Leandro.Pereira@microsoft.com>
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
 <CAJZ5v0jRgeAsyZXpm-XdL6GCKWk5=yVh1s4fZ3m0++NJK-gYBg@mail.gmail.com>
 <MW2PR2101MB1787B5253CAA640F8B7D2860BFB29@MW2PR2101MB1787.namprd21.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <204fa040-115e-552a-5fc1-5520f10bc402@arm.com>
Date:   Tue, 9 Feb 2021 18:15:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1787B5253CAA640F8B7D2860BFB29@MW2PR2101MB1787.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan,

On 05/02/2021 19:36, Dexuan Cui wrote:
>> From: Rafael J. Wysocki <rafael@kernel.org>
>> Sent: Friday, February 5, 2021 5:06 AM
>> To: Dexuan Cui <decui@microsoft.com>
>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-hyperv@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
>> Subject: Re: How can a userspace program tell if the system supports the ACPI
>> S4 state (Suspend-to-Disk)?
>>
>> On Sat, Dec 12, 2020 at 2:22 AM Dexuan Cui <decui@microsoft.com> wrote:
>>>
>>> Hi all,
>>> It looks like Linux can hibernate even if the system does not support the ACPI
>>> S4 state, as long as the system can shut down, so "cat /sys/power/state"
>>> always contains "disk", unless we specify the kernel parameter "nohibernate"
>>> or we use LOCKDOWN_HIBERNATION.

>>> In some scenarios IMO it can still be useful if the userspace is able to detect
>>> if the ACPI S4 state is supported or not, e.g. when a Linux guest runs on
>>> Hyper-V, Hyper-V uses the virtual ACPI S4 state as an indicator of the proper
>>> support of the tool stack on the host, i.e. the guest is discouraged from
>>> trying hibernation if the state is not supported.

What goes wrong? This sounds like a funny way of signalling hypervisor policy.


>>> I know we can check the S4 state by 'dmesg':
>>>
>>> # dmesg |grep ACPI: | grep support
>>> [    3.034134] ACPI: (supports S0 S4 S5)
>>>
>>> But this method is unreliable because the kernel msg buffer can be filled
>>> and overwritten. Is there any better method? If not, do you think if the
>>> below patch is appropriate? Thanks!
>>
>> Sorry for the delay.
>>
>> If ACPI S4 is supported, /sys/power/disk will list "platform" as one
>> of the options (and it will be the default one then).  Otherwise,
>> "platform" is not present in /sys/power/disk, because ACPI is the only
>> user of hibernation_ops.

> This works on x86. Thanks a lot!
> 
> BTW, does this also work on ARM64?

Not today. The S4/S5 stuff is part of 'ACPI_SYSTEM_POWER_STATES_SUPPORT', which arm64
doesn't enable as it has a firmware mechanism that covers this on both DT and ACPI
systems. That code is what calls hibernation_set_ops() to enable ACPI's platform mode.

Regardless: hibernate works fine. What does your hypervisor do that causes problems?
(I think all we expect from firmware is it doesn't randomise the placement of the ACPI
tables as they aren't necessarily part of the hibernate image)


Thanks,

James
