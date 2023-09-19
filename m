Return-Path: <linux-hyperv+bounces-114-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF117A5AE9
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 09:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2E282189
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6E328D3;
	Tue, 19 Sep 2023 07:31:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2E328A4
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 07:31:14 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09462FC;
	Tue, 19 Sep 2023 00:31:13 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57854FA2;
	Tue, 19 Sep 2023 09:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1695108574;
	bh=DQnS4aIKIh13ovdc7BzfWH9E6TxBe1gPiyTE4ZjyNYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BOesDxxoV/01VlAhluf7YLPC/1LY5v6DUSAmbryylQA/UVNncmcoPm89AX/9XYQ6d
	 nW4D4fbSVh5QAPCRVAPFeL6NrYodQDHDg4hKu5ZyPB9+abblvv6BOZXW80KLAK5An8
	 zKVe1L0FDrNX/uErlZKXCnkz1zj3Og7O87huezYg=
Message-ID: <06ac6d3b-e82e-dd25-ab21-90db76f3a5fd@ideasonboard.com>
Date: Tue, 19 Sep 2023 10:31:05 +0300
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
 stefan@agner.ch, suijingfeng@loongson.cn, sumit.semwal@linaro.org,
 tiantao6@hisilicon.com, tzimmermann@suse.de,
 virtualization@lists.linux-foundation.org, wens@csie.org,
 xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
References: <20230901234015.566018-1-dianders@chromium.org>
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/09/2023 02:39, Douglas Anderson wrote:
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

For omapdrm:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi


