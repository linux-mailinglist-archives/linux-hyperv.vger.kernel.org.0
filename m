Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B95965AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfHTP5m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 11:57:42 -0400
Received: from rp02.intra2net.com ([62.75.181.28]:51568 "EHLO
        rp02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTP5m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 11:57:42 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 11:57:41 EDT
Received: from mail.m.i2n (unknown [172.17.128.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by rp02.intra2net.com (Postfix) with ESMTPS id 5E67810011A;
        Tue, 20 Aug 2019 17:51:41 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id 3608D860;
        Tue, 20 Aug 2019 17:51:41 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.54.80,VDF=8.16.21.116)
X-Spam-Status: 
X-Spam-Level: 0
Received: from rocinante.m.i2n (rocinante.m.i2n [172.16.1.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp-auth-user)
        by mail.m.i2n (Postfix) with ESMTPSA id 9D7C1819;
        Tue, 20 Aug 2019 17:51:39 +0200 (CEST)
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE
To:     Sasha Levin <sashal@kernel.org>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1557215147-89776-1-git-send-email-decui@microsoft.com>
 <DM5PR2101MB09188A7DB0777CD50333F94ED7310@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190509010600.GQ1747@sasha-vm>
From:   Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Message-ID: <06e0ae5e-2fb0-5dac-a1a5-5583fdda334f@intra2net.com>
Date:   Tue, 20 Aug 2019 17:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190509010600.GQ1747@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Sasha.

I haven't spotted the following patch in the hyperv-fixes branch.

Did I look in the wrong place or it was not applied?

Thanks,
Juliana.

On 5/9/19 3:06 AM, Sasha Levin wrote:
> On Tue, May 07, 2019 at 12:51:51PM +0000, Michael Kelley wrote:
>> From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, May 7, 2019 
>> 12:47 AM
>>>
>>> In the case of X86_PAE, unsigned long is u32, but the physical 
>>> address type
>>> should be u64. Due to the bug here, the netvsc driver can not load
>>> successfully, and sometimes the VM can panic due to memory corruption 
>>> (the
>>> hypervisor writes data to the wrong location).
>>>
>>> Fixes: 6ba34171bcbd ("Drivers: hv: vmbus: Remove use of 
>>> slow_virt_to_phys()")
>>> Cc: stable@vger.kernel.org
>>> Cc: Michael Kelley <mikelley@microsoft.com>
>>> Reported-and-tested-by: Juliana Rodrigueiro 
>>> <juliana.rodrigueiro@intra2net.com>
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>
>> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 
> Queued for hyperv-fixes, thanks!
> 
> -- 
> Thanks,
> Sasha
