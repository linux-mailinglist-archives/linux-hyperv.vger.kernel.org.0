Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BC7912CF
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjIDH65 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDH64 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 03:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E72100;
        Mon,  4 Sep 2023 00:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5103961321;
        Mon,  4 Sep 2023 07:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303E8C433C8;
        Mon,  4 Sep 2023 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814309;
        bh=pKUbMJ7O8Os+Ar2FZmAgeHqSU7CTw0TYRCnkJDIg7I0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=LDjgR2toWSyxM6eaNf5MclGQkx8j8Rs9pbSyMxrEwR3b7inYlQ1n2Gzk5SRTcP1/4
         LjJiylmv2BkNCopbGUdOtGxoLEN4vrn9lqUKG9V0taLDeu3PqxiDdWu8nyFZ1Y7kqv
         /iAt1WXEzE7UMIKIx8gaI91nDPNgUln6bX79+pmOgaOyDYjSRRyoaJj5wu4CAlJRaC
         esUVjTO5ScwUV2thH+4kor1+Br+0yl4w0tczWPI/YBxVxc0zTQfka7Ote4t0asnQGm
         1PT9bT54FwQeUHtbuVe3D+4h7pelxn2r2/TfunUWt+zGq4Ix1UD7O8KKZQWtj+d+xc
         MeKI0z7FqL8eg==
Message-ID: <37ab52defccfc95d726451853227bd91.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:58:27 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
In-Reply-To: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
References: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
Cc:     airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com,
        alexander.deucher@amd.com, alexandre.belloni@bootlin.com,
        alison.wang@nxp.com, bbrezillon@kernel.org,
        christian.koenig@amd.com, claudiu.beznea@microchip.com,
        daniel@ffwll.ch, drawat.floss@gmail.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        jernej.skrabec@gmail.com, jfalempe@redhat.com, jstultz@google.com,
        kong.kongxinwei@hisilicon.com, kraxel@redhat.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, liviu.dudau@arm.com,
        nicolas.ferre@microchip.com, paul.kocialkowski@bootlin.com,
        sam@ravnborg.org, samuel@sholland.org,
        spice-devel@lists.freedesktop.org, stefan@agner.ch,
        suijingfeng@loongson.cn, sumit.semwal@linaro.org,
        tiantao6@hisilicon.com, tomi.valkeinen@ideasonboard.com,
        tzimmermann@suse.de, virtualization@lists.linux-foundation.org,
        wens@csie.org, xinliang.liu@linaro.org, yongqin.liu@linaro.org,
        zackr@vmware.com, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 1 Sep 2023 16:39:53 -0700, Douglas Anderson wrote:
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
