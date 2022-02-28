Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD754C6D6F
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Feb 2022 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiB1NIn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Feb 2022 08:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiB1NIn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Feb 2022 08:08:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994BCC2;
        Mon, 28 Feb 2022 05:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440AD612D7;
        Mon, 28 Feb 2022 13:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4116C340EE;
        Mon, 28 Feb 2022 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646053683;
        bh=xwpZD4gZhTKAz2WFv6X6JMrNMSyputHa5miIKZ7mnV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDHaYinVMNM6kACb7E2Qy0TXd85azTDlvzFKosdq2q5aXpNxj4+0bCHnUOyq7qvCX
         SdYowwLghSSD7m9p89L9IHLNURvZvuumE6Vu3Y7iNzNocmQHWUzg83s0qB+weG5HB0
         +kvmS/aLHNI/6Nqh49ZcJOvFivLCHBHTVfK80/WeRhDxjAD3RPcXkp71y1CkrubPcT
         TYf9kmUe4enaJ9QLuu5EOG9nUHW7bKk6BlwMqnVjYo83gCrxYJUvbhawoVypGiHk6k
         f1g5of4zmfYtpdOQJOHVTh9uxD0U5bue4hdKW1TR99VKgbXAKo0qKyQa7hTJW5HG6p
         WxhALj7z+X8eQ==
Date:   Mon, 28 Feb 2022 13:07:52 +0000
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
Subject: Re: [PATCH v3 07/11] spi: Use helper for safer setting of
 driver_override
Message-ID: <YhzJKKCxnx9DvliT@sirena.org.uk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IskqWBy0ijhzVzPO"
Content-Disposition: inline
In-Reply-To: <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--IskqWBy0ijhzVzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 27, 2022 at 02:53:25PM +0100, Krzysztof Kozlowski wrote:
> Use a helper for seting driver_override to reduce amount of duplicated
> code.

Reviwed-by: Mark Brown <broonie@kernel.org>

--IskqWBy0ijhzVzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIcyScACgkQJNaLcl1U
h9Ao0gf+JDpig6VFnyylTAGyA+EFJ7fmHFbvWhVF0t9hjFi5sLRAs8Z3+hLLKVej
zLVg+PMT7lEK9f1Cya6K7+gCq6ukWeVmmFBvuEA5Mn++s0vTXTuvx7VPQ8I7paXG
iePQNfdjxSxtdDUM+zinbF3mL8p4PcKUzqKlYEGeYvhxM2KxJx8a01GSsgKU1rNC
8ynKO/iKprh+dyGZOBcXM/m3OJDmQ0YEQi9uVQFGaznJ/yE4YjoBnCc7gj7uF2gB
3VAYxVi8Uj4ZMLOq0HPkR6QYxtneVT0Gly46I5Mg5BJZHdJ4yGkOOhaqZ0E4gwXI
YsZPSj+FAaJ1fM7xBMDL23NN8cHicw==
=Gb02
-----END PGP SIGNATURE-----

--IskqWBy0ijhzVzPO--
