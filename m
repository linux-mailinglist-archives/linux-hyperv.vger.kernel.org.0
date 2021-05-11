Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0917637AE36
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 May 2021 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhEKSTe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 May 2021 14:19:34 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:36686 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhEKSTe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 May 2021 14:19:34 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d16 with ME
        id 3WJP2500n21Fzsu03WJQuW; Tue, 11 May 2021 20:18:25 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 11 May 2021 20:18:25 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, gregkh@linuxfoundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
 <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f0dca7cf-c737-0f06-34aa-e4759826a974@wanadoo.fr>
Date:   Tue, 11 May 2021 20:18:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Le 11/05/2021 à 11:52, Wei Liu a écrit :
>> Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
>> in 'hv_uio_cleanup()'.
>> So, another way for fixing the potential leak is to modify
>> 'hv_uio_cleanup()' and revert to the previous behavior.
>>
> 
> I think this is cleaner.

Agreed

> 
> Stephen, you authored cdfa835c6e5e. What do you think?
> 
> Christophe, OOI how did you discover these issues?

I use an ugly coccinelle script which tries to spot functions called in 
the .remove function of a driver, but which is not in the error handling 
path of the .probe

It is way to verbose and gives too much false positive, but I manage to 
spot a few things with it.
Here it is, should it be useful for someone, or if anyone want to 
improve it.

The idea is:
    - find the probe and remove function
    - find a function (f1) which is not the first of the remove function 
(the first is likely the last in the probe that doesn't need to be 
undone in the probe error handling path)
    - try to filter with likely false positive pattern
    - search in the probe if this function is also called
    - if not, then it is a candidate.

CJ

---------------------------------

// Find the probe and remove functions
@platform@
identifier type, p, probefn, removefn;
@@
struct type p = {
   .probe = probefn,
   .remove = removefn,
};


// In the remove function, find a function that is called
@rem depends on platform@
identifier platform.removefn, firstFct, lastFct;
identifier f1 !~ 
"(pr_.*|dev_.*|cancel_work.*|cancel_delayed_work.*|tasklet_kill|list_del|.*unregister.*|.*deregister.*|spin_.*|flush_.*|pm_runtime_.*)";
@@
removefn(...) {
(
   <+...
   firstFct(...);
   f1(...);
   ...+>
|
   <+...
   fXXX1(...);
   lastFct(...);
   ...+>
)
}


// Check if this function is also called in the probe error path
@prb depends on rem@
identifier platform.probefn, platform.removefn, rem.f1;
@@
probefn(...) {
(
   <+...
     f1(...);
   ...+>
|
   <+...
     removefn(...);
   ...+>
)
}


// If not, this function is likely missing from the probe error path
@prb3 depends on !prb@
identifier platform.removefn, rem.f1;
@@
*removefn(...) {
   <+...
*  f1(...);
   ...+>
}
