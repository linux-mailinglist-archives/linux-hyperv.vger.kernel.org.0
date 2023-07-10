Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242174CD23
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jul 2023 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGJGgE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jul 2023 02:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGJGfn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jul 2023 02:35:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32C122682;
        Sun,  9 Jul 2023 23:35:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxPOuTpqtkgfkCAA--.3463S3;
        Mon, 10 Jul 2023 14:34:59 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8x7pqtkJNomAA--.4871S3;
        Mon, 10 Jul 2023 14:34:56 +0800 (CST)
Message-ID: <f5006633-889b-9371-f5d9-8d5d6bb9ed4e@loongson.cn>
Date:   Mon, 10 Jul 2023 14:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/hyperv: Fix a compilation issue because of not
 including screen_info.h
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20230709100514.703759-1-suijingfeng@loongson.cn>
 <BYAPR21MB16887E35CE80D293DE2243E0D730A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <BYAPR21MB16887E35CE80D293DE2243E0D730A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF8x7pqtkJNomAA--.4871S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw15Wr4UKF4DZF17GryfuFX_yoW8urW5pF
        48AFy3ArW0yr43K39xAF1fAF1Ygws8Ja48uF9Fywn0934jya4UJFZrWr9FkrW5Jw1akF1F
        qryDJay5u3W7CabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

OK, thanks a lot,

done!

On 2023/7/10 13:20, Michael Kelley (LINUX) wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn> Sent: Sunday, July 9, 2023 3:05 AM
>>     drivers/video/fbdev/hyperv_fb.c: In function 'hvfb_getmem':
>>>> drivers/video/fbdev/hyperv_fb.c:1033:24: error: 'screen_info' undeclared (first use
>> in this function)
>>      1033 |                 base = screen_info.lfb_base;
>>           |                        ^~~~~~~~~~~
>>     drivers/video/fbdev/hyperv_fb.c:1033:24: note: each undeclared identifier is reported
>> only once for each function it appears in
>> --
>>     drivers/gpu/drm/hyperv/hyperv_drm_drv.c: In function 'hyperv_setup_vram':
>>>> drivers/gpu/drm/hyperv/hyperv_drm_drv.c:75:54: error: 'screen_info' undeclared
>> (first use in this function)
>>        75 |         drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
>>           |                                                      ^~~~~~~~~~~
>>     drivers/gpu/drm/hyperv/hyperv_drm_drv.c:75:54: note: each undeclared identifier is
>> reported only once for each function it appears in
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202307090823.nxnT8Kk5-lkp@intel.com/
>> Fixes: 81d2393485f0 ("fbdev/hyperv-fb: Do not set struct fb_info.apertures")
>> Fixes: 8b0d13545b09 ("efi: Do not include <linux/screen_info.h> from EFI header")
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> index a7d2c92d6c6a..8026118c6e03 100644
>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/hyperv.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/screen_info.h>
>>
>>   #include <drm/drm_aperture.h>
>>   #include <drm/drm_atomic_helper.h>
>> --
>> 2.25.1
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

