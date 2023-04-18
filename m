Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98866E6A8C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRRHG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRRHG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 13:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C06A6A;
        Tue, 18 Apr 2023 10:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7886370F;
        Tue, 18 Apr 2023 17:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52624C433EF;
        Tue, 18 Apr 2023 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681837623;
        bh=cjDOGy9mRS/IQRhejUt0CG3MrZQ8HgwD9cSdExxajSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ju4sbssJwYSPz7NN9pFdpj7K+1kY7ty1G26bv8AVpx+4DBvqeJTiBHCbbiIWPBdcb
         kXkZ2b0Xv5L+F0PARaF4UaiY5/6oBpBfE7NsXW+i/XNfXEwOFTWLji7bz+8xuVgUgB
         3UGq9BBG9rdb9vAs+vAxLFrzcxH3tcbTOfA2H+mD7uMmMrFaUiugyjfXU2Deaviel1
         a1FFEslUUxsApp5lC2M6So1d56h2271O0L7uV8ALgLuOINhc2YaYWES8EkWEC/ftLu
         IRud1gM3WMeSZNf3pH8jrI7VDcRfmrnOWGiD4NujeDyjRoW28KliMvMTIC1/SSZ8vs
         QcJKXiMSK9uIA==
Date:   Tue, 18 Apr 2023 18:06:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tianyu Lan <tiala@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <e8780a61-96e9-4050-b0d5-8e6be43e2e27@sirena.org.uk>
References: <20230418170021.90280-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BfhUdUKcuBpSWMRS"
Content-Disposition: inline
In-Reply-To: <20230418170021.90280-1-broonie@kernel.org>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--BfhUdUKcuBpSWMRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 06:00:21PM +0100, broonie@kernel.org wrote:
> Hi all,
>=20
> After merging the hyperv tree, today's linux-next build (x86 allmodconfig)
> failed like this:

Adding more Hyper-V CCs, sorry the capitialisation in MAINTAINERS
confused my search.

>=20
> /tmp/next/build/arch/x86/kernel/x86_init.c:36:12: error: static declarati=
on of 'set_rtc_noop' follows non-static declaration
>    36 | static int set_rtc_noop(const struct timespec64 *now) { return -E=
INVAL; }
>       |            ^~~~~~~~~~~~
> In file included from /tmp/next/build/arch/x86/include/asm/mpspec.h:7,
>                  from /tmp/next/build/arch/x86/include/asm/topology.h:38,
>                  from /tmp/next/build/include/linux/topology.h:36,
>                  from /tmp/next/build/include/linux/gfp.h:8,
>                  from /tmp/next/build/include/linux/xarray.h:15,
>                  from /tmp/next/build/include/linux/radix-tree.h:21,
>                  from /tmp/next/build/include/linux/idr.h:15,
>                  from /tmp/next/build/include/linux/kernfs.h:12,
>                  from /tmp/next/build/include/linux/sysfs.h:16,
>                  from /tmp/next/build/include/linux/kobject.h:20,
>                  from /tmp/next/build/include/linux/pci.h:35,
>                  from /tmp/next/build/arch/x86/kernel/x86_init.c:9:
> /tmp/next/build/arch/x86/include/asm/x86_init.h:333:12: note: previous de=
claration of 'set_rtc_noop' with type 'int(const struct timespec64 *)'
>   333 | extern int set_rtc_noop(const struct timespec64 *now);
>       |            ^~~~~~~~~~~~
> /tmp/next/build/arch/x86/kernel/x86_init.c:37:13: error: static declarati=
on of 'get_rtc_noop' follows non-static declaration
>    37 | static void get_rtc_noop(struct timespec64 *now) { }
>       |             ^~~~~~~~~~~~
> In file included from /tmp/next/build/arch/x86/include/asm/mpspec.h:7,
>                  from /tmp/next/build/arch/x86/include/asm/topology.h:38,
>                  from /tmp/next/build/include/linux/topology.h:36,
>                  from /tmp/next/build/include/linux/gfp.h:8,
>                  from /tmp/next/build/include/linux/xarray.h:15,
>                  from /tmp/next/build/include/linux/radix-tree.h:21,
>                  from /tmp/next/build/include/linux/idr.h:15,
>                  from /tmp/next/build/include/linux/kernfs.h:12,
>                  from /tmp/next/build/include/linux/sysfs.h:16,
>                  from /tmp/next/build/include/linux/kobject.h:20,
>                  from /tmp/next/build/include/linux/pci.h:35,
>                  from /tmp/next/build/arch/x86/kernel/x86_init.c:9:
> /tmp/next/build/arch/x86/include/asm/x86_init.h:334:13: note: previous de=
claration of 'get_rtc_noop' with type 'void(struct timespec64 *)'
>   334 | extern void get_rtc_noop(struct timespec64 *now);
>       |             ^~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   25dcc7316ef7def25c ("x86/init: Make get/set_rtc_noop() public")
>=20
> I will use the hyperv tree from yesterday instead.

--BfhUdUKcuBpSWMRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+zjEACgkQJNaLcl1U
h9CYMgf/UOaM9RAEXjfrOVL/Vgv5zJ8bGxAiPKw7lvWgOuQtCrBwMQOteDW0juQ2
p/ZZTtamf7Ee+W6pB9O3bhjLSHegOrMw3SpYBgVq/8KatbOlZPUFlX076lHqqx/H
CvMOIKdRlPjZXvlzZDiezESx8UEQqvi1xRVyyzVC+iyJgROOdGi6G3XLvxt6Lzqd
E492XDSjxmEc2stVNY8IU6fiHQDJjyy4D8oi2UTWrCCtUhDhB1luw/e1o+jnKKVI
f607YfxjWyJigYTkzhc0sFBbntMo2VYJ5Y5kTIojTmkYeE3jxTjINZ9Dz1KloDis
/uvoNaVNkldH3/eGr6LQy0REeFGwkQ==
=Zn3r
-----END PGP SIGNATURE-----

--BfhUdUKcuBpSWMRS--
