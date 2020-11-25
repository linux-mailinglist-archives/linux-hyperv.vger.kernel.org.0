Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CF2C37A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgKYDfQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 22:35:16 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.222]:37200 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgKYDfP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 22:35:15 -0500
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 22:35:15 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id F274A13454
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 21:14:30 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hlGIk6LL7svw9hlGIkkjMk; Tue, 24 Nov 2020 21:14:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AuQ5LHVenT9NhVg4zxvlu9vnC9I7Jc0vaVgfBXpQC7w=; b=XezM7wfysdhBowRbF40sPS4PsW
        G7keS0tsTgFGYlQ97hCu+8mi84WK5pCl+5Tgyj8OXKkobqGWFAki7JMtwTvNAxSJpQjnBbWwy8iPf
        HAhsoKjSqhFs2cb+6r87OAbcuEHfZ7ZRB7hiWHM/lvvJm4BOnXqe5pRm/lIZcLTTMWJs9pTn44/Dk
        7ivT6i/2AWJVARccSGyKAFvaJuPb7b4JEObjUEhPt1TppWq07qieqcJYAZahw/yENBJb4XiQEIomf
        Njus1ilkP5zSkIAZy87JTMWp46CrMHto7fiUc0UQIPwa1pndJ8oQouMfj9heCLLvTD3ioZFrz6Rp2
        bhzobqeg==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:60601 helo=[192.168.1.69])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khlGI-0031Q2-K1; Wed, 25 Nov 2020 00:14:30 -0300
Subject: Re: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
To:     Joe Perches <joe@perches.com>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-5-matheus@castello.eng.br>
 <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
 <60b60d026a0636090b1617c6fd9e7b3a88013a7f.camel@perches.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <9be574bf-570d-c813-f18f-9ba5214021e1@castello.eng.br>
Date:   Wed, 25 Nov 2020 00:14:28 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <60b60d026a0636090b1617c6fd9e7b3a88013a7f.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1khlGI-0031Q2-K1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br ([192.168.1.69]) [179.197.124.241]:60601
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 7
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Em 11/24/2020 11:56 PM, Joe Perches escreveu:
> On Tue, 2020-11-24 at 21:54 -0300, Matheus Castello wrote:
>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> []
>>> The above would be marginally better if organized as follows so that the
>>> main execution path isn't in an "if" clause.  Also reduces indentation.
>>>
>>> 	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
>>> 	if (!hv_panic_page) {
>>> 		pr_err("Hyper-V: panic message page memory allocation failed");
> 
> And nicer to add a terminating newline to the format like the pr_err below.
>

Oops, sending v3. Thanks Joe Perches!

>>> 		return;
>>> 	}
>>> 	ret = kmsg_dump_register(&hv_kmsg_dumper);
>>> 	if (ret) {
>>> 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
>>> 		hv_free_hyperv_page((unsigned long)hv_panic_page);
>>> 		hv_panic_page = NULL;
>>> 	}
> 
> 
