Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7134C1CC3
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 21:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiBWUFZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 15:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBWUFY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 15:05:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2C40E63;
        Wed, 23 Feb 2022 12:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 448A1B821A3;
        Wed, 23 Feb 2022 20:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3349C340E7;
        Wed, 23 Feb 2022 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645646693;
        bh=M0+mVIZ0Lc26AANZRRAz4t6SzyvF92PylFUdbqphFSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htHMZ4ejkmVw5UZH147OWWvzPaFhKffm1si8PWKoQ3tnFx1yOLEVU9zQwxK66D03d
         wplmLYlyIr1r52XdFqTtlesPjts/kWIf+iN1ATyktMdKEcaUJvlYonZ1V6H/8HPLI/
         jMTrjWGhifOrhupEC9mn93Sk6u/MBMyXLCtr0HLQ/nz2PeL0MlAZGOz+uRBQ2dNQP+
         1Ic12cGDQBffBc1oiHIM2JMAZUrS567iuIBAS786fIZ1Fhesjvllp4NBTINXzKcMxj
         GOt37pF22BkcR2HDO2jvs15Y7ID8CBJEsV/Q3gpu+i821dkJIfTeyhhFcFWSUe12Qd
         deVfLFRokXTYQ==
Date:   Wed, 23 Feb 2022 20:04:42 +0000
From:   Mark Brown <broonie@kernel.org>
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
Subject: Re: [PATCH v2 07/11] spi: use helper for safer setting of
 driver_override
Message-ID: <YhaTWiSQl6pTVxqC@sirena.org.uk>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PaAAhqOBo3hBuacY"
Content-Disposition: inline
In-Reply-To: <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--PaAAhqOBo3hBuacY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 23, 2022 at 08:14:37PM +0100, Krzysztof Kozlowski wrote:

> Remove also "const" from the definition of spi_device.driver_override,
> because it is not correct.  The SPI driver already treats it as
> dynamic, not const, memory.

We don't modify the string do we, we just allocate a new one?

--PaAAhqOBo3hBuacY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIWk1kACgkQJNaLcl1U
h9DKugf+JTJnnQWx+6mOA4DxLKfWqeASwwB38nUbBFMpWAEhjMvez2XAp0h33Cp9
bH+dZ5NjHjeUoLGkWBHxWiyuu1r4QrqL7E32x/mV1JsG7I2svj0l0XyCx7Xw7lqT
QIFJxxSknnL1YtmnB53Rz55GDGQhIg4ewuv/ayCjk0oBDS6G2WBS2UAx2FWJQg2l
0ALu1QKfCU2DfjLPbmMqLoJb9anvSLyPxe38+Q2dqLx6kUl1WqVWz/Af6dJp9YWY
UDYfURm/JqyzEo/wiM5ZS39VO9Kv8M7EO9MFJvwxdkmM1evQah6crAugVx/WeCQy
4Tv/1RJYx8DyQ53XSPVEVcgh9tSx9w==
=g4g9
-----END PGP SIGNATURE-----

--PaAAhqOBo3hBuacY--
