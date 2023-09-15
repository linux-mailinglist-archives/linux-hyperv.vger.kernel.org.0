Return-Path: <linux-hyperv+bounces-95-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD37A1A0F
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 11:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3A11C20B43
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7ECD534;
	Fri, 15 Sep 2023 09:12:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463A2F38
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 09:12:03 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 857612D67;
	Fri, 15 Sep 2023 02:11:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
	by gateway (Coremail) with SMTP id _____8BxY_C+HwRlnkkoAA--.12083S3;
	Fri, 15 Sep 2023 17:11:26 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxS9yvHwRlTucGAA--.13502S3;
	Fri, 15 Sep 2023 17:11:24 +0800 (CST)
Message-ID: <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
Date: Fri, 15 Sep 2023 17:11:11 +0800
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
To: Douglas Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc: airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com,
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
Content-Language: en-US
From: suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxS9yvHwRlTucGAA--.13502S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1kJFWfKr4kCrWDAFy3WrX_yoW5JF45pr
	WfZ3s0yrs0qrsrtwn3Jw17Wa4fta1fA34aqrsrKw4ruws8GFWIqF4Fqr1Ygw4UW3yvgr47
	tw4avw15C3W5A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUjf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVW8ZVWrXwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5-18P
	UUUUU==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,


On 2023/9/2 07:39, Douglas Anderson wrote:
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> All of the drivers in this patch were fairly straightforward to fix
> since they already had a call to drm_atomic_helper_shutdown() at
> remove/unbind time but were just lacking one at system shutdown. The
> only hitch is that some of these drivers use the component model to
> register/unregister their DRM devices. The shutdown callback is part
> of the original device. The typical solution here, based on how other
> DRM drivers do this, is to keep track of whether the device is bound
> based on drvdata. In most cases the drvdata is the drm_device, so we
> can just make sure it is NULL when the device is not bound. In some
> drivers, this required minor code changes. To make things simpler,
> drm_atomic_helper_shutdown() has been modified to consider a NULL
> drm_device as a noop in the patch ("drm/atomic-helper:
> drm_atomic_helper_shutdown(NULL) should be a noop").
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---


I have just tested the whole series, thanks for the patch. For drm/loongson only:


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>



By the way, I add 'pr_info("lsdc_pci_shutdown\n");' into the lsdc_pci_shutdown() function,
And seeing that lsdc_pci_shutdown() will be called when reboot and shutdown the machine.
I did not witness something weird happen at present. As you have said, this is useful for
drm panels drivers. But for the rest(drm/hibmc, drm/ast, drm/mgag200 and drm/loongson etc)
drivers, you didn't mention what's the benefit for those drivers. Probably, you can
mention it with at least one sentence at the next version. I also prefer to alter the
lsdc_pci_shutdown() function as the following pattern:


static void lsdc_pci_shutdown(struct pci_dev *pdev)
{

     struct drm_device *ddev = pci_get_drvdata(pdev);

     drm_atomic_helper_shutdown(ddev);
}



