Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D62CFEE6
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 21:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLEUly (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 15:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEUly (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 15:41:54 -0500
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Dec 2020 12:41:13 PST
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB6C0613D1;
        Sat,  5 Dec 2020 12:41:13 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CpLpk5NKYz1yth;
        Sat,  5 Dec 2020 21:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607200334; bh=AbA8ZXJqu5TM96CCyE5jL7V1IYodJ71rqmxAvdah4Jc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=BSgmOsu9O2Y2EVPYh1brrj4xh+Q3H55P+PcSXpZs89WZf2cjruoJcrMGlFicoIPYq
         ts4Rv+BrZ9gD3fgG8eo5cAl4SxiLJevV69eLDdP1VRj95EzTS6VlwwxWXfF7AWO28j
         QUpmZtRKAGH3leq1z7snJzawjuND+NJ7/JY8TlVRXmum7jIc+l3rBBc0P1+p2IJ6F4
         ThusamBLxxmv4WfPFrkwJQWU9icCkOZbwt021SOJDPKgv1e37Qvnl8TpcjVDIpsK0B
         9O+vWRSURjYFTmU0t6RiaxRmQaEG3ttDQvglAlZMEZecMhhygM3O9W1K7+AM4brjSi
         a1YgwfDRUfWlw==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:16b8:a0b5:2d00:304b:c7f:3c59:928c
Received: from [IPv6:2001:16b8:a0b5:2d00:304b:c7f:3c59:928c] (unknown [IPv6:2001:16b8:a0b5:2d00:304b:c7f:3c59:928c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18hvv5srgvnBwqu36GcyavqTYlgohHZSvI=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CpLpg6X4nz1xrk;
        Sat,  5 Dec 2020 21:32:11 +0100 (CET)
Subject: Re: [PATCH 0/3] drivers/hv: make max_num_channels_supported
 configurable
To:     Michael Kelley <mikelley@microsoft.com>,
        Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
 <MW2PR2101MB1052DC9416ABC1ECFE25E38DD7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Max Stolze <max.stolze@fau.de>
Message-ID: <1b2e2fce-7dd5-9ca2-840e-2c48ed087bc6@fau.de>
Date:   Sat, 5 Dec 2020 21:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052DC9416ABC1ECFE25E38DD7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 05/12/2020 19:27, Michael Kelley wrote:
> From: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
>>
>> According to the TODO comment in hyperv_vmbus.h the value in macro
>> MAX_NUM_CHANNELS_SUPPORTED should be configurable. The first patch
>> accomplishes that by introducting uint max_num_channels_supported as
>> module parameter.
>> Also macro MAX_NUM_CHANNELS_SUPPORTED_DEFAULT is introduced with
>> value 256, which is the currently used macro value.
>> MAX_NUM_CHANNELS_SUPPORTED was found and replaced in two locations.
>>
>> During module initialization sanity checks are applied which will result
>> in EINVAL or ERANGE if the given value is no multiple of 32 or larger than
>> MAX_NUM_CHANNELS.
>>
>> While testing, we found a misleading typo in the comment for the macro
>> MAX_NUM_CHANNELS which is fixed by the second patch.
>>
>> The third patch makes the added default macro configurable by
>> introduction and use of Kconfig parameter HYPERV_VMBUS_DEFAULT_CHANNELS.
>> Default value remains at 256.
>>
>> Two notes on these patches:
>> 1) With above patches it is valid to configure max_num_channels_supported
>> and MAX_NUM_CHANNELS_SUPPORTED_DEFAULT as 0. We simply don't know if that
>> is a valid value. Doing so while testing still left us with a working
>> Debian VM in Hyper-V on Windows 10.
>> 2) To set the Kconfig parameter the user currently has to divide the
>> desired default number of channels by 32 and enter the result of that
>> calculation. This way both known constraints we got from the comments in
>> the code are enforced. It feels a bit unintuitive though. We haven't found
>> Kconfig options to ensure that the value is a multiple of 32. So if you'd
>> like us to fix that we'd be happy for some input on how to settle it with
>> Kconfig.
>>
>> Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
>> Co-developed-by: Max Stolze <max.stolze@fau.de>
>> Signed-off-by: Max Stolze <max.stolze@fau.de>
>>
>> Stefan Eschenbacher (3):
>>   drivers/hv: make max_num_channels_supported configurable
>>   drivers/hv: fix misleading typo in comment
>>   drivers/hv: add default number of vmbus channels to Kconfig
>>
>>  drivers/hv/Kconfig        | 13 +++++++++++++
>>  drivers/hv/hyperv_vmbus.h |  8 ++++----
>>  drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++++-
>>  3 files changed, 36 insertions(+), 5 deletions(-)
>>
>> --
>> 2.20.1
> 
> Stefan -- this cover letter email came through, but it doesn't look like
> the individual patch emails did.  So you might want to check your
> patch sending process.
> 
> Thanks for your interest in this old "TODO" item.  But let me provide some
> additional background.  Starting in Windows 8 and Windows Server 2012,
> Hyper-V revised the mechanism by which channel interrupt notifications
> are made.  The MAX_NUM_CHANNELS_SUPPORTED value is only used
> with Windows 7 and Windows Server 2008 R2, neither of which is officially
> supported any longer.  See the code at the top of vmbus_chan_sched() where
> the VMBus protocol version is checked, and MAX_NUM_CHANNELS_SUPPORTED
> is used only when the protocol version indicates we're running on Windows 7
> (or the equivalent Windows Server 2008 R2).
> 
> Because the old mechanism was superseded, making the value configurable
> doesn't have any benefit.   At some point, we will remove this old code path
> entirely, including the #define MAX_NUM_CHANNELS_SUPPORTED.  The
> comment with the "TODO" could be removed, but other than that, I don't
> think we want to make these changes.
> 
> Michael
> 

Hi Michael, 
thanks for the insight and explanation.
It's a pity that the rest of the series did not make it trough.
However, given what you wrote it doesn't seem to be of 
utmost importance.

As irrelevant as it may be we'd still be glad to see the TODO gone.
Given that we found it by looking for things that can be done around
the kernel I don't see why somebody else would not find it while looking
for the same.

Max
