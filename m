Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3956D741C
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjDEGHL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEGHK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 02:07:10 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3955173A;
        Tue,  4 Apr 2023 23:07:07 -0700 (PDT)
Received: from meshulam.tesarici.cz (unknown [213.235.133.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 930E71488AE;
        Wed,  5 Apr 2023 08:07:04 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680674825; bh=E47lcGeX7oRDxZbyOSFg0jGNPGzor2gT02CjEeXUgmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMtq3AFXTTmDJx+MKXTAwJMv2djOS0e94inGODa70g4Yqfl72zlkQBBta/TKqIQol
         xa8ZSfSi0QbAEjnm6YAyzrDwLFe30Fhh8hfcxozIWw6wroUNoaa5CEopVBa1V5trZn
         hm37zZTyw4QBJUgvkzFKQW1Smer3o6p8HDJ+1JoxKW+7T8diWqCF663QDDx1akkagl
         4jQIELn20eP9it18itCfTGcc97jsSdsDmNVrD+RnvpBAMaqhYWk1WJE5b79m/TeDz5
         QqaEQQYi+2IKEQJ9TmjmxoG0phbVpkdXUlTiy8ZA/9FxhrPwWwi+6LTfNpH4MculWS
         SbRWQNAyqhfUw==
Date:   Wed, 5 Apr 2023 08:07:03 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Message-ID: <20230405080703.61c6d60a@meshulam.tesarici.cz>
In-Reply-To: <SA1PR21MB1335CF4B7E9B1EC61B84AA03BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
        <20230405064019.6258ebb3@meshulam.tesarici.cz>
        <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230405072801.05bb94ef@meshulam.tesarici.cz>
        <20230405075034.3c36bb77@meshulam.tesarici.cz>
        <SA1PR21MB1335CF4B7E9B1EC61B84AA03BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 5 Apr 2023 06:00:13 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > Sent: Tuesday, April 4, 2023 10:51 PM =20
> > > ...
> > > Argh, you're right. This is a braino. The alignment mask is in fact an
> > > INVERTED mask, i.e. it masks off bits that are not relevant for the
> > > alignment. The more strict alignment needed the more bits must be set,
> > > so the individual alignment constraints must be combined with an OR
> > > instead of an AND.
> > >
> > > Can you apply the following change and check if it fixes the issue? =
=20
> >=20
> > Actually, this will not work either. The mask is used to mask off both =
=20
> It works for me.

Yes, as long as the original (non-bounced) address is aligned at least
to a 2K boundary, it appears to work. ;-)

> > high address bits and low address bits (below swiotlb slot granularity).
> >=20
> > What should help is this:
> > ... =20
> This also works for me.
>=20
> Thanks, *either* version can resolve the issue for me :-)

Thank you for testing! I will write a proper commit message and submit
a fix. Embarassing... *sigh*

Can I add your Tested-by?

Petr T
