Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DAA2C3627
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgKYBPe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 20:15:34 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:42475 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbgKYBPd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 20:15:33 -0500
X-Greylist: delayed 1346 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 20:15:32 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 75458400CC4CF
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 18:53:06 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hj3Skv9PziQiZhj3SkYsAT; Tue, 24 Nov 2020 18:53:06 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MxORzjlO72uZqTeguhpQkxswvX4GXgrdmsDvVWCxCnE=; b=lxT0gK8mJ1q8//EAAhGu9JQAuC
        xcKSjeMqEm0sxzIKF2J8sE1rm8vTX+08nEsptRGSQdklWxhfhoOGwKHBQJE0S8Gv1KPXlbNLk+pjs
        xEcIGrFL6tD/zzv914HF1BvxQncp9wXKuMwuPrrQCRe/DHvcQ2XI3rEIXXEdcYVMD5MnV5yhwPDdR
        vPxsJe3NqvX8ghhX0pGFn62vfAGScWOFXnGI/oNSpaWRYTYiIurtsJqMnYHAHOdY7RA+2oWLHds95
        4Uk6Lxo/oLEBFfxj2U1GKmHD5FZX50WVmBrOHnlsmaJu4LrvZZ0In8vZ6oOap/7MPuGj/Rm5uDmVq
        ESWpDMwA==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:58875 helo=[192.168.1.69])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khj3S-002E1n-30; Tue, 24 Nov 2020 21:53:06 -0300
Subject: Re: [PATCH 0/6] Add improvements suggested by checkpatch for
 vmbus_drv
To:     Wei Liu <wei.liu@kernel.org>, mikelley@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201117105843.ijvulc7cx3ac2zng@liuwe-devbox-debian-v2>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <0870858d-7f92-28f0-e9ca-a2e6f23bcc2a@castello.eng.br>
Date:   Tue, 24 Nov 2020 21:53:02 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117105843.ijvulc7cx3ac2zng@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1khj3S-002E1n-30
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br ([192.168.1.69]) [179.197.124.241]:58875
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Wei,

Em 11/17/2020 7:58 AM, Wei Liu escreveu:
> On Sun, Nov 15, 2020 at 04:57:28PM -0300, Matheus Castello wrote:
>> This series fixes some warnings edmited by the checkpatch in the file
>> vmbus_drv.c. I thought it would be good to split each fix into a commit to
>> help with the review.
>>
>> Matheus Castello (6):
>>    drivers: hv: Fix hyperv_record_panic_msg path on comment
>>    drivers: hv: vmbus: Replace symbolic permissions by octal permissions
>>    drivers: hv: vmbus: Fix checkpatch LINE_SPACING
>>    drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
>>    drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
>>    drivers: hv: vmbus: Fix call msleep using < 20ms
> 
> I've pushed patch 1-3 and 6 to hyperv-next.
> 
> Patch 4 has a pending comment from Michael. Patch 5 can be dropped.
>

Thanks for the review, got it and I agree with the drop of patch 5 
thanks to point it. I will send the v2 for the patch 4.

> Wei.
> 
