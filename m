Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786FFE7611
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbfJ1Q1i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Oct 2019 12:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbfJ1Q1h (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 12:27:37 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3680214E0;
        Mon, 28 Oct 2019 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572280057;
        bh=87V2MWqDlCCbrhdsVXEBFo+I8AOmCrxItTTuwv33jbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QDkZEp6d/vPMTHdg+fbYMN12R7tYmMvgoiA3Y+tVlZJPImcmFjOHo21RTvbTzhKX
         h3ucNoT3UB33LDMg2fxKiFrFA2OlG4y4CcVgJnLBb4TsYm47k11xIpM+SxfOZroJ+B
         2X2xanl98GhY1qKURwoJet5bjliTnk8XeoXQApp8=
Date:   Mon, 28 Oct 2019 12:27:34 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, vkuznets <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
Message-ID: <20191028162734.GI1554@sasha-vm>
References: <20191015103502.13156-1-parri.andrea@gmail.com>
 <DM5PR21MB01377F713A553FCF721EF99DD7930@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01377F713A553FCF721EF99DD7930@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 15, 2019 at 01:06:33PM +0000, Michael Kelley wrote:
>From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2019 3:35 AM
>>
>> Michael reported that the x86/hyperv initialization code printed the
>> following dmesg when running in a VM on Hyper-V:
>>
>>   [    0.000738] Booting paravirtualized kernel on bare hardware
>>
>> Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
>> with this addition, the dmesg read:
>>
>>   [    0.000172] Booting paravirtualized kernel on Hyper-V
>>
>> Reported-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thomas, will you be taking this? Would you rather have me deal with the
hyperv bits under arch/x86/?

-- 
Thanks,
Sasha
