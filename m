Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90113A73F8
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jun 2021 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFOCbU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Jun 2021 22:31:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10057 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFOCbU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Jun 2021 22:31:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3sD16pGXzZdcf;
        Tue, 15 Jun 2021 10:08:01 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:10:56 +0800
Received: from [10.67.109.184] (10.67.109.184) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:10:56 +0800
Subject: Re: [PATCH -next] drm/hyperv: Remove unused variable
To:     Deepak Rawat <drawat.floss@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <zhangjinhao2@huawei.com>, <linux-hyperv@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20210609024940.34933-1-pulehui@huawei.com>
 <078d9bb5-e7af-4961-f4c1-cd3ab415cff4@suse.de>
 <2bf51ac723cb097685dd4c89926599d939d31765.camel@gmail.com>
From:   Pu Lehui <pulehui@huawei.com>
Message-ID: <5944abf7-7535-f425-fdc3-58e6bd032186@huawei.com>
Date:   Tue, 15 Jun 2021 10:10:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2bf51ac723cb097685dd4c89926599d939d31765.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 2021/6/14 22:01, Deepak Rawat wrote:
> On Wed, 2021-06-09 at 09:46 +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 09.06.21 um 04:49 schrieb Pu Lehui:
>>> Fixes gcc '-Wunused-const-variable' warning:
>>>     drivers/gpu/drm/hyperv/hyperv_drm_modeset.c:152:23: warning:
>>>       'hyperv_modifiers' defined but not used [-Wunused-const-
>>> variable=]
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>    drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
>>> b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
>>> index 02718e3e859e..3f83493909e6 100644
>>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
>>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
>>> @@ -149,11 +149,6 @@ static const uint32_t hyperv_formats[] = {
>>>          DRM_FORMAT_XRGB8888,
>>>    };
>>>    
>>> -static const uint64_t hyperv_modifiers[] = {
>>> -       DRM_FORMAT_MOD_LINEAR,
>>> -       DRM_FORMAT_MOD_INVALID
>>> -};
>>
>> This constant should rather be used in the call to
>> drm_simple_display_pipe_init(). [1]
>>
>> Best regards
>> Thomas
>>
>> [1]
>> https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c#n161
>>
>>
> 
> Hi Pu,
> 
> Thanks for the patch. Is it possible to send another patch as per
> suggestion by Thomas. There is a kernel test robot failure as well.
> 
> Deepak
> 
> .
> 
Hi Deepak,

Thanks for your reply, I will send v2 soon.

Best regards
Lehui
