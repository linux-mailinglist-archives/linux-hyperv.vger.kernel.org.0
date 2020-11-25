Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A342C36FD
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgKYC4T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 21:56:19 -0500
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:40964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgKYC4S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 21:56:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D91DD127F;
        Wed, 25 Nov 2020 02:56:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3874:4321:4385:5007:6117:7903:10004:10400:10848:11026:11658:11914:12043:12295:12296:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:13972:14659:14721:21080:21433:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: spy30_0f0529627373
X-Filterd-Recvd-Size: 2214
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Nov 2020 02:56:15 +0000 (UTC)
Message-ID: <60b60d026a0636090b1617c6fd9e7b3a88013a7f.camel@perches.com>
Subject: Re: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
From:   Joe Perches <joe@perches.com>
To:     Matheus Castello <matheus@castello.eng.br>,
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
Date:   Tue, 24 Nov 2020 18:56:14 -0800
In-Reply-To: <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
References: <20201115195734.8338-1-matheus@castello.eng.br>
         <20201115195734.8338-5-matheus@castello.eng.br>
         <MW2PR2101MB1052B329DFC5D54F4D7501E9D7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
         <ada0ef93-1443-49a0-914c-1ad03ffa024b@castello.eng.br>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2020-11-24 at 21:54 -0300, Matheus Castello wrote:
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
[]
> > The above would be marginally better if organized as follows so that the
> > main execution path isn't in an "if" clause.  Also reduces indentation.
> > 
> > 	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
> > 	if (!hv_panic_page) {
> > 		pr_err("Hyper-V: panic message page memory allocation failed");

And nicer to add a terminating newline to the format like the pr_err below.

> > 		return;
> > 	}
> > 	ret = kmsg_dump_register(&hv_kmsg_dumper);
> > 	if (ret) {
> > 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> > 		hv_free_hyperv_page((unsigned long)hv_panic_page);
> > 		hv_panic_page = NULL;
> > 	}


