Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A946D737D
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjDEEqa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 00:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjDEEq3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 00:46:29 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 21:46:28 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05591BDF
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Apr 2023 21:46:28 -0700 (PDT)
Received: from meshulam.tesarici.cz (unknown [213.235.133.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6D8B41476CB;
        Wed,  5 Apr 2023 06:40:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680669629; bh=mghipZ7KjYeZ0FTGp7Tk3ekEFHhrukqRx9uoxJv7lJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n50aFp0ah0fQMPX/2Sf2WckMc09pbxAOz+P3m6LKnYxwdBq4381+4sVswaKJyA/j7
         +4b+C/OJJXdKWyZYy0d4f3jO9P/eTWjtOppiVYH/HPOmrx551zsjyKSz8mmALo0daL
         2+wjF6EKMPj3FvZ2/fStmwXiGayjo5pi1j1hjZ7lC9qpxJghFf9hCBseR0KKsplmUk
         zkzc+S1FZ4owdLbGYzPBH7uGIMSmZqrKQCDvWn5fi2kmdyk9M1NuEbckVJkuEsn0EL
         5ST9lOSqLzklpEYV2G9txpH+gY7oveKHdaKca6ThPqvlY1bADcwqks9SqbLqSCAFJp
         E/aQsaT8YQPdg==
Date:   Wed, 5 Apr 2023 06:40:19 +0200
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
Message-ID: <20230405064019.6258ebb3@meshulam.tesarici.cz>
In-Reply-To: <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
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

Hi Dexuan,

On Tue, 4 Apr 2023 20:11:18 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Dexuan-Linux Cui <dexuan.linux@gmail.com>
> > Sent: Tuesday, April 4, 2023 12:55 PM
> >=20
> > On Tue, Mar 21, 2023 at 1:37=E2=80=AFAM Petr Tesarik
> > <petrtesarik@huaweicloud.com> wrote:
> > ...
> >=20
> > Hi Petr, this patch has gone into the mainline:
> > 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> >=20
> > Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> > swiotlb=3Dforce or a confidential VM (which uses swiotlb) fails to boot.
> > If I revert this patch, everything works fine. =20
>=20
> The log is pasted below. Looks like the SCSI driver hv_storvsc fails to
> detect the disk capacity:

The first thing I can imagine is that there are in fact no (free) slots
in the SWIOTLB which match the alignment constraints, so the map
operation fails. However, this would result in a "swiotlb buffer is
full" message in the log, and I can see no such message in the log
excerpt you have posted.

Please, can you check if there are any "swiotlb" messages preceding the
first error message?

Petr T
