Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3B4C7978
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 21:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiB1UEL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 15:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiB1UEK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 15:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714B255AE;
        Mon, 28 Feb 2022 12:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC09B81642;
        Mon, 28 Feb 2022 20:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D75C340F2;
        Mon, 28 Feb 2022 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646078608;
        bh=mHHh973hMePN9wmM/jcpBb22Q6OGomp4QlydWc1Dh6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aCeGMO5xD8fsEhRGr4+eOr9z8MstaRRDVGhQ2JFOj5VttTy3IwU/54lJ+oouIG28u
         z81XCgIJowof9B0hR7N3AT4EL/cp1tR3vbL6RuXPasvJp4dShvWkyCbSLiUvoOUiy9
         Ch40bfT8hyQmBKmOBWB/wdlu+kbLkxch8hnE1YJuMD+DqGmnrqOp1buDYyiFRg9zyZ
         nZTjzG+1MPqyPE0xBXIt+SPfFuZFdVwk0yBkI7QA+0xdPnGZ8DjYwz0x7qT3uUHRRq
         N8JYHkY9orf+PL5YgJkzP9kJWMETh9P7vFNG2d7Sp1HIFzdd8vaKYbZBnn3S5kUq8h
         a4Caw+KYsuQwg==
Date:   Mon, 28 Feb 2022 14:03:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
Message-ID: <20220228200326.GA516164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227135214.145599-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 27, 2022 at 02:52:04PM +0100, Krzysztof Kozlowski wrote:
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.

> +int driver_set_override(struct device *dev, const char **override,
> +			const char *s, size_t len)
> +{
> +	const char *new, *old;
> +	char *cp;
> +
> +	if (!dev || !override || !s)
> +		return -EINVAL;
> +
> +	/* We need to keep extra room for a newline */

It would help a lot to extend this comment with a hint about where the
room for a newline is needed.  It was confusing even before, but it's
much more so now that the check is in a completely different file than
the "show" functions that need the space.

> +	if (len >= (PAGE_SIZE - 1))
> +		return -EINVAL;
