Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C661BCBFAB
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2019 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbfJDPqS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Oct 2019 11:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbfJDPqS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 11:46:18 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C0620830;
        Fri,  4 Oct 2019 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570203977;
        bh=RtSEgS9Ir5OhXsBQuEonT/del/hDREk1xI0g6Q4VtDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZVxQVRpDReG0V6jQUbrt9ODsMJ7hGNR1UpN39oTXrVtvT70zLAw7bDg89/C8wa8e
         Q5wKW2ggEuEoE9rmgkQ+E70WEy40QxCIbhIFAchIWO9qdn0jnVN8g694FQzMxe5vd+
         iVyXu0GmxSGV93WkricbtkNeTGePfp4aE7QVwlp8=
Date:   Fri, 4 Oct 2019 11:46:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH] Drivers: hv: balloon: Remove dependencies on guest page
 size
Message-ID: <20191004154615.GK17454@sasha-vm>
References: <20190817040850.4812-1-himadri18.07@gmail.com>
 <DM5PR21MB01379A15CEBBABFB0B165EDDD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01379A15CEBBABFB0B165EDDD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 04, 2019 at 11:37:12PM +0000, Michael Kelley wrote:
>From: Himadri Pandya <himadrispandya@gmail.com> Sent: Friday, August 16, 2019 9:09 PM
>>
>> Hyper-V assumes page size to be 4K. This might not be the case for
>> ARM64 architecture. Hence use hyper-v specific page size and page
>> shift definitions to avoid conflicts between different host and guest
>> page sizes on ARM64.
>>
>> Also, remove some old and incorrect comments and redefine ballooning
>> granularities to handle larger page sizes correctly.
>>
>> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
>> ---
>>  drivers/hv/hv_balloon.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
>Thomas -- can you pick up this patch in the x86/hyperv branch of your
>tip tree along with the other patches to fix wrong page size assumptions?

I've queued this for hyperv-next, thanks!

--
Thanks,
Sasha
