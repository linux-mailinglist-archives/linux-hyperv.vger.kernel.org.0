Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AEDACC92
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Sep 2019 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfIHMNc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 8 Sep 2019 08:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfIHMNc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 8 Sep 2019 08:13:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A18218AC;
        Sun,  8 Sep 2019 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944811;
        bh=b9en/9rG4wcN1G6wUTo8gNUs67YXhaBqqvg54OuV+Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlVE1kQUukPZGmwUhyYUD+88EyRdY6CgRLIA9KX91jmDmhBvDLM5RVuEQpVddv56G
         TIct7dWy2WDm7N4twMfGK4/MawAhyvsjPK7gMF6tvUsMzooYK45gFrRyA2Yb2dibWq
         7irPoQ+oFCpVeWbU1b3oEbdGp+w9ACGhSyHGjT+s=
Date:   Sun, 8 Sep 2019 08:13:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/9] Enhance the hv_vmbus driver to support hibernation
Message-ID: <20190908121329.GD2012@sasha-vm>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
 <20190906200325.GD1528@sasha-vm>
 <PU1P153MB01697512A097B489E0440E13BFBA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB01697512A097B489E0440E13BFBA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 06, 2019 at 10:45:31PM +0000, Dexuan Cui wrote:
>> From: Sasha Levin <sashal@kernel.org>
>> Sent: Friday, September 6, 2019 1:03 PM
>> On Thu, Sep 05, 2019 at 11:01:14PM +0000, Dexuan Cui wrote:
>> >This patchset (consisting of 9 patches) was part of the v4 patchset (consisting
>> >of 12 patches):
>> >
>> >The other 3 patches in v4 are posted in another patchset, which will go
>> >through the tip.git tree.
>> >
>> >All the 9 patches here are now rebased to the hyperv tree's hyperv-next
>> branch, and all the 9 patches have Michael Kelley's Signed-off-by's.
>> >
>> >Please review.
>>
>> Given that these two series depend on each other, I'd much prefer for
>> them to go through one tree.
>
>Hi Sasha,
>Yeah, that would be ideal. The problem here is: the other patchset conflicts
>with the existing patches in the tip.git tree's timers/core branch, so IMO
>the 3 patches have to go through the tip tree:
>
>[PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
>[PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported()
>[PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V clocksource for hibernation
>
>> But, I may be wrong, and I'm going to see if a scenario such as this
>> make sense. I've queued this one to the hyperv-next, but I'll wait for
>> the x86 folks to send their pull request to Linus first before I do it
>> for these patches.
>
>Actually IMHO you don't need to wait, because there is not a build
>dependency, so either patchset can go into the Linus's tree first.

It'll build, sure. But did anyone actually test one without the other?
What happens if Thomas doesn't send his batch at all during the merge
window?

--
Thanks,
Sasha
