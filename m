Return-Path: <linux-hyperv+bounces-99-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9367A2062
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D881C20B93
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8C10979;
	Fri, 15 Sep 2023 14:03:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256110949
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 14:02:59 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FA1B1FD0;
	Fri, 15 Sep 2023 07:02:52 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
	by gateway (Coremail) with SMTP id _____8CxtPAKZARlTX4oAA--.13156S3;
	Fri, 15 Sep 2023 22:02:50 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxvdz9YwRl_WEHAA--.14359S3;
	Fri, 15 Sep 2023 22:02:48 +0800 (CST)
Message-ID: <743e062e-17e8-dec0-30ba-c7682ea3109e@loongson.cn>
Date: Fri, 15 Sep 2023 22:02:36 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com,
 alexander.deucher@amd.com, alexandre.belloni@bootlin.com,
 alison.wang@nxp.com, bbrezillon@kernel.org, christian.koenig@amd.com,
 claudiu.beznea@microchip.com, daniel@ffwll.ch, drawat.floss@gmail.com,
 javierm@redhat.com, jernej.skrabec@gmail.com, jfalempe@redhat.com,
 jstultz@google.com, kong.kongxinwei@hisilicon.com, kraxel@redhat.com,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, liviu.dudau@arm.com,
 nicolas.ferre@microchip.com, paul.kocialkowski@bootlin.com,
 sam@ravnborg.org, samuel@sholland.org, spice-devel@lists.freedesktop.org,
 stefan@agner.ch, sumit.semwal@linaro.org, tiantao6@hisilicon.com,
 tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de,
 virtualization@lists.linux-foundation.org, wens@csie.org,
 xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
References: <20230901234015.566018-1-dianders@chromium.org>
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
 <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
 <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
From: suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxvdz9YwRl_WEHAA--.14359S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4rGFWDKr43JrWxXr4DKFX_yoW5Kw4xpr
	W5Zas0krs8JrsrArn2qr17Wa4Syw4Sy34fXrsrKr1Uurs0gFW2qF4Fqr15Cas8W397Kr42
	yw42qwn8uFy5AacCm3ZEXasCq-sJn29KB7ZKAUJUUUjf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r4a6rW5M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU58cTP
	UUUUU==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,


On 2023/9/15 21:44, Doug Anderson wrote:
> Hi,
>
> On Fri, Sep 15, 2023 at 2:11 AM suijingfeng <suijingfeng@loongson.cn> wrote:
>> Hi,
>>
>>
>> On 2023/9/2 07:39, Douglas Anderson wrote:
>>> Based on grepping through the source code these drivers appear to be
>>> missing a call to drm_atomic_helper_shutdown() at system shutdown
>>> time. Among other things, this means that if a panel is in use that it
>>> won't be cleanly powered off at system shutdown time.
>>>
>>> The fact that we should call drm_atomic_helper_shutdown() in the case
>>> of OS shutdown/restart comes straight out of the kernel doc "driver
>>> instance overview" in drm_drv.c.
>>>
>>> All of the drivers in this patch were fairly straightforward to fix
>>> since they already had a call to drm_atomic_helper_shutdown() at
>>> remove/unbind time but were just lacking one at system shutdown. The
>>> only hitch is that some of these drivers use the component model to
>>> register/unregister their DRM devices. The shutdown callback is part
>>> of the original device. The typical solution here, based on how other
>>> DRM drivers do this, is to keep track of whether the device is bound
>>> based on drvdata. In most cases the drvdata is the drm_device, so we
>>> can just make sure it is NULL when the device is not bound. In some
>>> drivers, this required minor code changes. To make things simpler,
>>> drm_atomic_helper_shutdown() has been modified to consider a NULL
>>> drm_device as a noop in the patch ("drm/atomic-helper:
>>> drm_atomic_helper_shutdown(NULL) should be a noop").
>>>
>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>
>> I have just tested the whole series, thanks for the patch. For drm/loongson only:
>>
>>
>> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Thanks!
>
>
>> By the way, I add 'pr_info("lsdc_pci_shutdown\n");' into the lsdc_pci_shutdown() function,
>> And seeing that lsdc_pci_shutdown() will be called when reboot and shutdown the machine.
>> I did not witness something weird happen at present. As you have said, this is useful for
>> drm panels drivers. But for the rest(drm/hibmc, drm/ast, drm/mgag200 and drm/loongson etc)
>> drivers, you didn't mention what's the benefit for those drivers.
> I didn't mention it because I have no idea! I presume that for
> non-drm_panel use cases it's not a huge deal, otherwise it wouldn't
> have been missing from so many drivers. Thus, my "one sentence" reason
> for the non-drm_panel case is just "we should do this because the
> documentation of the API says we should", which is already in the
> commit message. ;-)
>

OK, this sound fine.

> If you have a specific other benefit you'd like me to list then I'm happy to.

You should think about the answer of this question yourself.
But I will not object if you can't find one. OK. :-)

>
>> Probably, you can
>> mention it with at least one sentence at the next version. I also prefer to alter the
>> lsdc_pci_shutdown() function as the following pattern:
>>
>>
>> static void lsdc_pci_shutdown(struct pci_dev *pdev)
>> {
>>
>>       struct drm_device *ddev = pci_get_drvdata(pdev);
>>
>>       drm_atomic_helper_shutdown(ddev);
>> }
> I was hoping to land this patch without spinning it unless there's a
> good reason. How strongly do you feel about needing to change the
> above?


Not very strong, this version looks just fine.
I will not object if you keep it as is.
But I will also hear what the others reviewers say.
Thanks for the patch.

>
> -Doug


