Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA158F079
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Aug 2022 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiHJQeD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Aug 2022 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJQeC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Aug 2022 12:34:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD182773;
        Wed, 10 Aug 2022 09:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3265B81D4B;
        Wed, 10 Aug 2022 16:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F52C433C1;
        Wed, 10 Aug 2022 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660149239;
        bh=TRHMkHy9TA2+R7Xo/cWt/GmZaVkYtJda3sygZr6n63E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSqQDDuiRdorik9Pb/NCrx0oD2vlusIm0ixMcVKD77THj9qllEU6gMdB/rlZFKxQQ
         1Y84PCd6G6/7azkAfGdqfXgZzJND6/e58nAYqDyze40HJN1++ciHIcfRGJyQBAYuRW
         6C1oabpSKxGzXSH5QSw6SARyENrzNOAaYPdknnBcv+QKEN++KIEGoP0RR770PAqTO5
         9d8jAGGh68yTeeux7Cm/nL71Im6g4uuE5CmShu8fZ2SYjddUgdjId4DQte/DzZ1qnz
         pnZtzkHZEmCzy0Z54lVQP6EydD/q1GdGE4oq9kx+/kr8okcbgl4QiLKtvM3Rfl9NEL
         MFbx0aVJuS5Tg==
Date:   Wed, 10 Aug 2022 17:33:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 5/5][RFT] ACPI: Drop parent field from struct
 acpi_device
Message-ID: <YvPd8ewNOKdwMmR4@sirena.org.uk>
References: <12036348.O9o76ZdvQC@kreacher>
 <2196460.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Da0Ami2fDuAHDI9p"
Content-Disposition: inline
In-Reply-To: <2196460.iZASKD2KPV@kreacher>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--Da0Ami2fDuAHDI9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 06:23:05PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The parent field in struct acpi_device is, in fact, redundant,
> because the dev.parent field in it effectively points to the same
> object and it is used by the driver core.

Acked-by: Mark Brown <broonie@kernel.org>

--Da0Ami2fDuAHDI9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLz3fAACgkQJNaLcl1U
h9B8rQf/XtDVCaLNgxkwWhsW926hQ9+EvneuFPFiVGjVW+lbegON2gRrPeUWs8sS
sC4GBIsaf1GiG5D6xQGh5Iq36TE60sjclNLk2WTG6eHppigATRVgiTwiwOnVDn4h
IBqOYP3xauYkNpiX1QK91vc5Lh90Lh+W/B81A1RqbDaJIlNrihrFgezUZQ9Klwlm
9lsOupKTe9TeDOdtv8xgq8fuHk9K+K28SmkPEDEg49UVhCUbx05BuPDoyOtmn+RP
/+hKik8ajLZUd2qUg0VmM0dRNX3GnQiGQC5dAmLnF63o9XIWcu4x3XYQPHEAwy5L
Aj0k8+2YrOgVHxyNIrsVmg01YaZIWg==
=2BJY
-----END PGP SIGNATURE-----

--Da0Ami2fDuAHDI9p--
