Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458577AF40
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 03:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHNB4j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 13 Aug 2023 21:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHNB4P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 13 Aug 2023 21:56:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEFE54;
        Sun, 13 Aug 2023 18:56:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPHXG1HjyzrSWm;
        Mon, 14 Aug 2023 09:54:54 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 09:56:11 +0800
Message-ID: <d7a6c71a-98a6-64cd-8118-2b0f89189177@huawei.com>
Date:   Mon, 14 Aug 2023 09:56:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] hv_netvsc: Remove duplicated include
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230810115148.21332-1-guozihua@huawei.com>
 <ZNX8CyvnsP0zhmbA@vergenet.net>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <ZNX8CyvnsP0zhmbA@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2023/8/11 17:14, Simon Horman wrote:
> On Thu, Aug 10, 2023 at 07:51:48PM +0800, GUO Zihua wrote:
>> Remove duplicated include of linux/slab.h.  Resolves checkincludes message.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> The patch looks fine, but for reference, I do have some feedback
> from a process point of view. It's probably not necessary to
> repost because of these. But do keep them in mind if you have
> to post a v2 for some other reason, and for future patch submissions.
> 
> * As a non bugfix for Networking code this should likely be targeted
>   at the net-next tree - the net tree is used for bug fixes.
>   And the target tree should be noted in the subject.
> 
>   Subject: [PATCH net-next] ...
> 
> * Please use the following command to generate the
>   CC list for Networking patches
> 
>   ./scripts/get_maintainer.pl --git-min-percent 2 this.patch
> 
>   In this case, the following, now CCed, should be included:
> 
>   - Jakub Kicinski <kuba@kernel.org>
>   - Eric Dumazet <edumazet@google.com>
>   - "David S. Miller" <davem@davemloft.net>
>   - Paolo Abeni <pabeni@redhat.com>
> 
> * Please do read the process guide
> 
>   https://kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> The above notwithstanding,
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

Thanks for the info and the review-by! Will keep that in mind.

-- 
Best
GUO Zihua

