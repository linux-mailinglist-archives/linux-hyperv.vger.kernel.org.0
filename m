Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65716D73FC
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 07:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbjDEFuw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 01:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjDEFun (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 01:50:43 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0F4C03;
        Tue,  4 Apr 2023 22:50:38 -0700 (PDT)
Received: from meshulam.tesarici.cz (unknown [213.235.133.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 95AAC146F42;
        Wed,  5 Apr 2023 07:50:35 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680673836; bh=C6IoX1lNnZuMQVKkhnCjrralN+LFGIlZN5OAc7rJaB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRgzo7h1wuQuX014pRD4WI6hBDhus4EADUwMUp/tp6AOU1W3Pxi4llJwYF4dIP5X2
         SQvmcDpXcJ/Hsu/C70o3uNuXktY8E3g+vwEVtiDZO+ZqaRi4kSzAxXNtyzP6fhNtKJ
         LSNVcaMbud89X8j367tlgvJO/OgHWNc9C271WjXt7vxPPNwNTOxrEu8gd71qDCo5c8
         U4cX3yPTR98SmE+zYoTR4R18oCL/dSVcF73S4KsxNf6f2u1wQbSOaA+7ju0xhAYDJi
         S8n4p4rfOlbCborvL4nnPKGLQHcmK6Z3qVXzlYgKk+K5a7UKXckauLOhqIdUOSxBpk
         Wt1gMEwTn/KMg==
Date:   Wed, 5 Apr 2023 07:50:34 +0200
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
Message-ID: <20230405075034.3c36bb77@meshulam.tesarici.cz>
In-Reply-To: <20230405072801.05bb94ef@meshulam.tesarici.cz>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
        <20230405064019.6258ebb3@meshulam.tesarici.cz>
        <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230405072801.05bb94ef@meshulam.tesarici.cz>
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

On Wed, 5 Apr 2023 07:32:06 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Wed, 5 Apr 2023 05:11:42 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
>=20
> > > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Sent: Tuesday, April 4, 2023 9:40 PM   =20
> > > > > ...
> > > > > Hi Petr, this patch has gone into the mainline:
> > > > > 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> > > > >
> > > > > Somehow it breaks Linux VMs on Hyper-V: a regular VM with
> > > > > swiotlb=3Dforce or a confidential VM (which uses swiotlb) fails t=
o boot.
> > > > > If I revert this patch, everything works fine. =20
> > > >
> > > > The log is pasted below. Looks like the SCSI driver hv_storvsc fail=
s to
> > > > detect the disk capacity:   =20
> > >=20
> > > The first thing I can imagine is that there are in fact no (free) slo=
ts
> > > in the SWIOTLB which match the alignment constraints, so the map
> > > operation fails. However, this would result in a "swiotlb buffer is
> > > full" message in the log, and I can see no such message in the log
> > > excerpt you have posted.
> > >=20
> > > Please, can you check if there are any "swiotlb" messages preceding t=
he
> > > first error message?
> > >=20
> > > Petr T   =20
> >=20
> > There is no "swiotlb buffer is full" error.
> >=20
> > The hv_storvsc driver (drivers/scsi/storvsc_drv.c) calls scsi_dma_map(),
> > which doesn't return -ENOMEM when the failure happens. =20
>=20
> I see...
>=20
> Argh, you're right. This is a braino. The alignment mask is in fact an
> INVERTED mask, i.e. it masks off bits that are not relevant for the
> alignment. The more strict alignment needed the more bits must be set,
> so the individual alignment constraints must be combined with an OR
> instead of an AND.
>=20
> Can you apply the following change and check if it fixes the issue?

Actually, this will not work either. The mask is used to mask off both
high address bits and low address bits (below swiotlb slot granularity).

What should help is this:

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5b919ef832b6..c924e53d679e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -622,8 +622,7 @@ static int swiotlb_do_find_slots(struct device *dev, in=
t area_index,
 	dma_addr_t tbl_dma_addr =3D
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
 	unsigned long max_slots =3D get_max_slots(boundary_mask);
-	unsigned int iotlb_align_mask =3D
-		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
+	unsigned int iotlb_align_mask;
 	unsigned int nslots =3D nr_slots(alloc_size), stride;
 	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count =3D 0, i;
@@ -639,8 +638,9 @@ static int swiotlb_do_find_slots(struct device *dev, in=
t area_index,
 	 * allocations.
 	 */
 	if (alloc_size >=3D PAGE_SIZE)
-		iotlb_align_mask &=3D PAGE_MASK;
-	iotlb_align_mask &=3D alloc_align_mask;
+		iotlb_align_mask |=3D ~PAGE_MASK;
+	iotlb_align_mask |=3D alloc_align_mask | dma_get_min_align_mask(dev);
+	iotlb_align_mask &=3D ~(IO_TLB_SIZE - 1);
=20
 	/*
 	 * For mappings with an alignment requirement don't bother looping to

Petr T
