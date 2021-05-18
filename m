Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D8388194
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhERUrm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 16:47:42 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:44601 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhERUrl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 16:47:41 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d52 with ME
        id 6LmK2500421Fzsu03LmKQJ; Tue, 18 May 2021 22:46:20 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 May 2021 22:46:20 +0200
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
 <f0dca7cf-c737-0f06-34aa-e4759826a974@wanadoo.fr>
 <20210515160932.v4inlp5xlzokmmel@liuwe-devbox-debian-v2>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <dd8b09a6-ced1-3b96-4422-01219f5bbc7a@wanadoo.fr>
Date:   Tue, 18 May 2021 22:46:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515160932.v4inlp5xlzokmmel@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Le 15/05/2021 à 18:09, Wei Liu a écrit :
> On Tue, May 11, 2021 at 08:18:23PM +0200, Christophe JAILLET wrote:
>> Le 11/05/2021 à 11:52, Wei Liu a écrit :
>>>> Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
>>>> in 'hv_uio_cleanup()'.
>>>> So, another way for fixing the potential leak is to modify
>>>> 'hv_uio_cleanup()' and revert to the previous behavior.
>>>>
>>>
>>> I think this is cleaner.
>>
>> Agreed
> 
> Stephen, ping?
> 
> If I don't hear back from you, I think Christophe should move ahead with
> modifying hv_uio_cleanup.
> 
> Wei.
> 

Hi,
just for your information, it has already been picked by Greg KH (see [1]).
If the cleaner solution is preferred, it will be built on top of this patch.

CJ

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/uio/uio_hv_generic.c?id=3ee098f96b8b6c1a98f7f97915f8873164e6af9d
