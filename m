Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1057D9BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 07:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiGVFSD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Jul 2022 01:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFSC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Jul 2022 01:18:02 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704AE2871D;
        Thu, 21 Jul 2022 22:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxrRZWVZO36BpcQzNSKoyfDjbXXltm1uuUh7N68G70FPwtrxS4vACOQ20fBv5iCzFA2zDDnT4yWegje6UNXUkRQ8pPAXnra0XDwUUc9OXd5hcIgfwkq/6S1pWjADoWpiXrNlc0gs1mr7LbvlZmvbyJJCG4iZQQHhRoR9rkuji7aYddtS4CIjwUFChm6ppTQY4pE1HFyHAXqlyqfgv8k1G3m5r1NqNRSXqEeN3WQ/qx38nxefm6IvxWb8ygSpnS+BPUzZUh39p+Q4TWj1rtyOIh2saib75eCPyMGT3bY/hyokxW3nLKoRE98RrTAlZ20ysN2wlsURIcG4eXM0Xz1ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZUeGROhrZFb2U0uN48FKYQKq6SyIp5WtTHElv8JmTI=;
 b=cupEX0pXEbZqyQHJN+bxlqEMW8+xh1/3yM+umCO7vUDgLpV5nV7UGogumJfkNzgwY8eWyhxyvVs+BFDcGRVTs8JW0x8B99X8rrYSPvNolmy0mF1lnkJnTCq+x0Vu4eHBQPccM3/VpBO8QmrIbtu6iIkbXStax1s0llpQenI/50Da35X4uMBAIrffYWRmrL9F9+c/DKl9920IW593uJpP5e91f4nvSam5GVz+EU0B0SUomkJQsi1gxNy2ZEgM+v+sJ7l5EbeiDZ/weGu0XFR+0mq0rMyxS0hP5tdrvIoXvG5ZZoyOGU7AaN3S9l49ySKE2apeMuqlBWT6c48ErVZQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZUeGROhrZFb2U0uN48FKYQKq6SyIp5WtTHElv8JmTI=;
 b=fxjdOWiH0f4LBMdv0bSwemnjPOGZfcMxyyGd+Otoqi7M7j/RrX8zbYOP2yHp5VmfBParLUJ1f+7rd0/GfkU2RrRet8pumhss05LCuwc10S5xt59mjBsxk62DUYLpCBf/gvvRNEhidH4DPMb4iZWlEEWIPDXJIJEe+MgVZMQfyBg=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BYAPR21MB1349.namprd21.prod.outlook.com (2603:10b6:a03:115::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Fri, 22 Jul
 2022 05:17:57 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 05:17:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Tianyu Lan <ltykernel@gmail.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Clean up some coding style and minor issues
Thread-Topic: [PATCH] swiotlb: Clean up some coding style and minor issues
Thread-Index: AQHYnXyTiNG67/0qI0uJ03DW/F3voq2JwffggAAUN4CAAAMi8A==
Date:   Fri, 22 Jul 2022 05:17:56 +0000
Message-ID: <PH0PR21MB3025314BCD4D8A5ECE8DCE5AD7909@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220722033846.950237-1-ltykernel@gmail.com>
 <PH0PR21MB3025A8991E4126A6B92126D9D7909@PH0PR21MB3025.namprd21.prod.outlook.com>
 <Ytov9VdwIv5HVsbr@infradead.org>
In-Reply-To: <Ytov9VdwIv5HVsbr@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56238966-2b47-4db6-a6d4-f276910fe4d2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-22T05:16:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a82b5c77-289a-47e4-a2a5-08da6ba18963
x-ms-traffictypediagnostic: BYAPR21MB1349:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtGspo3Ao91uAn0ZrTtZXtUWxs7AYoIyp6g45kOmjBKcr9e/1Wi3au0kQOVGNwdY/SeUN6S4/JruZ/p0vDS1Dw5AZ8a+cT3OamLXsUa9C12ALMmTw4YZPgMWoyGYxrILEhFzKq84krX2L5EBXSF0hJCmrCOZkiOFNv218TH8VT2vXb3YmA2FNCcitgzS2z+7umJXNNi70K8bCPTYdhVRb73YHG0c5R97A3iAN3J9bapx3yc7GfsTsmvIpj9HlELNAYHgLnzBWXa5EqSwpo2R8+xXFDeWaDlpVWASsu3PGFWbu7JaaOYTRfl3y/OOg77It1NJLhfA2bk4bw5uu9hxLBHGJVCn2esJXqRYXKfOv+HvOFmRVlrk2hNN/TBUl50YCdVLMdRrAKOoSC/MaTjKH5sN+3q791+mL/LDmRHFQo0qhEouVMQm48HC/MIon8h5VI0mSJIZXwmt37eo1WtCdQzYKCvOZfroXENH/5a3omeGkMhqKbP+jcaMSkNXI//QsLCYBPt0SE0AIIy2Z2UM4LfCdyzflPfKnUE0DfnvqYi90Qphku6fHxi9dXdvF5GYcepWUx4cHug2Ek2UiXa1cCGHvzf87Y7eW7PDlgEkK0XZP0caM0vq7ctnmThu8KkdlReQCbNDECJp7tn7yRL/suaE/gP2EGvUHt9lv7bZ+sYlx5KhIy9fg2oKoN5EcN3vhTd/B/QPErlORogNqy5lrO0d+wZj9AOfAli+KZYXp5TblndUG93Ty0ZR8GZzYxDvQN9egoL7hUauZem/MBfUqsBIe166xPn3aF7VUGvV/V1w13IMSCWLAnBrLFtOUteUXSeqx5DisASHfh2/cl+H7+1LG3VGaMln6mqhXmKIuAfrOuu72mbq0ihDOGQrIw3O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199009)(7696005)(41300700001)(52536014)(26005)(33656002)(6506007)(76116006)(8936002)(5660300002)(86362001)(9686003)(2906002)(83380400001)(478600001)(64756008)(8676002)(38100700002)(54906003)(966005)(66556008)(8990500004)(186003)(82950400001)(66446008)(316002)(38070700005)(71200400001)(122000001)(4326008)(55016003)(66476007)(82960400001)(66946007)(6916009)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pv75aF3tYYcYw/QGiVCwqXsiHBt0FUCVcFoTwvuKIJiufLvcCrgF8JuKH04p?=
 =?us-ascii?Q?btqOX2oYhVr9njk7No5dsi9IVnFqJHoqvJeDvZU5j7HH2XQMoe8MEVLcLE9n?=
 =?us-ascii?Q?FuWk3PNFvwUMMryqRFSxhB7JdviGXb+WsMa3FR1VquV43mqSlM8epJnzZ+0M?=
 =?us-ascii?Q?hyAHbTq6ELzg6pf3SR8fqpaRe0eXW68QSu+0J281E6u97hCZYufUrCCyLbky?=
 =?us-ascii?Q?uG/LZzbG/k1+NT1s+TdDlcLj2Eqv+aiYMgcwqe/y7LRKMnyvAeej7JACFPpM?=
 =?us-ascii?Q?QfdSrXv8RUIo2D0Z3ZrEzRaXJqdDvbkZ/wAxUuzrBtz3HLfZdHbXGFa6kNai?=
 =?us-ascii?Q?cfc0DdizVnlKFrbbm1j4fh0hTDe/vOhUYz6DY+kzrmXEUpqamkO0zIAZaVER?=
 =?us-ascii?Q?b0Ywwo1IkQv+bX1thqgQFiEteheB4hSNBz9TOUTOBw9SrQNrW1Tf2etJTVpp?=
 =?us-ascii?Q?sBVioZo1kCfAWFBlbY/grGQcErdU/N059fitZ017QROJTHxFvaRWa8qUP+CJ?=
 =?us-ascii?Q?w33pO8URntTpT0hPEnfTgXUGhBkwxElL22G1XCmOxxds/Ed2paY/eH16Qjc7?=
 =?us-ascii?Q?zKLzUrPiSwGdABufU55H43hZl2bMxqOtQh/caz/fpn19686piw74ocrY93vf?=
 =?us-ascii?Q?aOlVEO/x+u/HRyVKfYnToeL/whg/BU02uLWgj7PVeUHMWSfd1JlyFVcnS0on?=
 =?us-ascii?Q?dR6n4EKod/tbKoaT9E6vZovShTijFETPp20VOcS8hDzKA957sFgpIiMXmKbv?=
 =?us-ascii?Q?e/HHLiQe2L5gIymOs0fgwNNbwUyzJKcjA2ci6K3F8ZsCY6hZG7r4nAl9CsLN?=
 =?us-ascii?Q?Ty0a/1yoOL0dBi3WE1EMuZ7DOFH8cUFX+dAy4wn3xlguDCG8A0owlHb9G7GG?=
 =?us-ascii?Q?xg9n2WyULgKqWJT+FZUcgA5A5sK+/C3zptO7EtA1PD8w34a8ATrNS3tkdBqC?=
 =?us-ascii?Q?h9jXPuG1eEtGmP204zdjZ4RL/MRO1L+Gc0a037iOSFAnbjE7gRMhYG8pyEGg?=
 =?us-ascii?Q?FQscH1Y9UaRlehVuxEMpiMTNXMIGoZ6nr24u53BhvMFvWr4TOydSTdPGCxq6?=
 =?us-ascii?Q?2YzEgZGnw4UnuDelZo39bMGfKnUy/jjaSDjL/mw+2ROep4+k+adJz5lC1YQh?=
 =?us-ascii?Q?PuOpi9yHV1b0k+SCfI4RvqK8rSM64uK3ZZOSOs9pOeEil5f1mmc7x85koZLd?=
 =?us-ascii?Q?sGk2oXMWYr0CaVeCW5DZyKVX9+g/bOhZdESI0/nKLiVew74nfubsux582I+b?=
 =?us-ascii?Q?9PWtlU7b5SXqIDLkeQh8pxHZ/q8h3wI2S//i0RMOqVELTbaKLgidKyBGTxmu?=
 =?us-ascii?Q?mcWHzTipnrUm/fCd0FajdioOKyfGzPQ03jo4zSpaqExCVAEDOlBpL7+bkxvT?=
 =?us-ascii?Q?Uqt1qjUWoqTUGarSqXkw8arc4nXFFRrOO4RIhigp2BbS324CPJhRnGHu50lm?=
 =?us-ascii?Q?TPXrOjFOu7WQFjm3I0VU/nQSZ376XbGeN/nZCCzfu9hGrpIo3RkHLDNgzCAH?=
 =?us-ascii?Q?+mZXFss4urBIKodQ8D9JMvyHVxZghzUXQy54H0vUnQcpdDRT7+dKV+GPzTmm?=
 =?us-ascii?Q?0ESx/M6CQQgNq5BE+e66d5gaM5k4xmLrphEvokzNJx5VivIsqpCQGFWHFUd7?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82b5c77-289a-47e4-a2a5-08da6ba18963
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 05:17:56.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EZOF6kuCKQz4e8c19yhEVrOFdPtV7MCnEVJWM+h2+XfKgH39CWsC45H93RCOb/Zgb7OqU/5ZTJkR+xWhgq4Ph0wUbOBehIGH9/EeZp+prQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1349
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: hch@infradead.org <hch@infradead.org> Sent: Thursday, July 21, 2022 1=
0:05 PM
>=20
> On Fri, Jul 22, 2022 at 04:03:21AM +0000, Michael Kelley (LINUX) wrote:
> > I think you missed one of the bugs I pointed out in my previous
> > comments.  In the function rmem_swiotlb_device_init(), the two
> > calls to kfree() in the error path are in the wrong order.   It's a
> > path that will probably never happen, but it still should be fixed.
>=20
> That is already fixed in the dma-mapping tree:
>=20
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/4a97739474c=
402e0a14cf6a432f1920262f6811c

Indeed.

>=20
> > The other fixes look good to me.
>=20
> Can you make that a formal Reviewed-by?

Yes.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> >
> > Michael
> >
> > > Fixes: 26ffb91fa5e0 ("swiotlb: split up the global swiotlb lock")
> > > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         |  3 +-
> > >  kernel/dma/swiotlb.c                          | 42 ++++++++++++-----=
--
> > >  2 files changed, 30 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > b/Documentation/admin-guide/kernel-parameters.txt
> > > index 4a6ad177d4b8..ddca09550f76 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -5907,7 +5907,8 @@
> > >  			Format: { <int> [,<int>] | force | noforce }
> > >  			<int> -- Number of I/O TLB slabs
> > >  			<int> -- Second integer after comma. Number of swiotlb
> > > -				 areas with their own lock. Must be power of 2.
> > > +				 areas with their own lock. Will be rounded up
> > > +				 to a power of 2.
> > >  			force -- force using of bounce buffers even if they
> > >  			         wouldn't be automatically used by the kernel
> > >  			noforce -- Never use bounce buffers (for debugging)
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index c39483bf067d..5752db98a1f2 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -96,7 +96,13 @@ struct io_tlb_slot {
> > >
> > >  static void swiotlb_adjust_nareas(unsigned int nareas)
> > >  {
> > > -	if (!is_power_of_2(nareas))
> > > +	/*
> > > +	 * Set area number to 1 when input area number
> > > +	 * is zero.
> > > +	 */
> > > +	if (!nareas)
> > > +		nareas  =3D 1;
> > > +	else if (!is_power_of_2(nareas))
> > >  		nareas =3D roundup_pow_of_two(nareas);
> > >
> > >  	default_nareas =3D nareas;
> > > @@ -270,6 +276,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb=
_mem
> *mem,
> > > phys_addr_t start,
> > >  	for (i =3D 0; i < mem->nareas; i++) {
> > >  		spin_lock_init(&mem->areas[i].lock);
> > >  		mem->areas[i].index =3D 0;
> > > +		mem->areas[i].used =3D 0;
> > >  	}
> > >
> > >  	for (i =3D 0; i < mem->nslabs; i++) {
> > > @@ -353,8 +360,8 @@ void __init swiotlb_init_remap(bool addressing_li=
mit,
> unsigned
> > > int flags,
> > >  		panic("%s: Failed to allocate %zu bytes align=3D0x%lx\n",
> > >  		      __func__, alloc_size, PAGE_SIZE);
> > >
> > > -	mem->areas =3D memblock_alloc(sizeof(struct io_tlb_area) *
> > > -		default_nareas, SMP_CACHE_BYTES);
> > > +	mem->areas =3D memblock_alloc(array_size(sizeof(struct io_tlb_area)=
,
> > > +		default_nareas), SMP_CACHE_BYTES);
> > >  	if (!mem->areas)
> > >  		panic("%s: Failed to allocate mem->areas.\n", __func__);
> > >
> > > @@ -479,7 +486,7 @@ void __init swiotlb_exit(void)
> > >  		free_pages((unsigned long)mem->slots, get_order(slots_size));
> > >  	} else {
> > >  		memblock_free_late(__pa(mem->areas),
> > > -				   mem->nareas * sizeof(struct io_tlb_area));
> > > +				   array_size(sizeof(*mem->areas), mem->nareas));
> > >  		memblock_free_late(mem->start, tbl_size);
> > >  		memblock_free_late(__pa(mem->slots), slots_size);
> > >  	}
> > > @@ -593,11 +600,12 @@ static unsigned int wrap_area_index(struct io_t=
lb_mem
> > > *mem, unsigned int index)
> > >   * Find a suitable number of IO TLB entries size that will fit this =
request and
> > >   * allocate a buffer from that IO TLB pool.
> > >   */
> > > -static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> > > -		struct io_tlb_area *area, int area_index,
> > > -		struct device *dev, phys_addr_t orig_addr,
> > > +static int swiotlb_do_find_slots(struct device *dev,
> > > +		int area_index, phys_addr_t orig_addr,
> > >  		size_t alloc_size, unsigned int alloc_align_mask)
> > >  {
> > > +	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> > > +	struct io_tlb_area *area =3D mem->areas + area_index;
> > >  	unsigned long boundary_mask =3D dma_get_seg_boundary(dev);
> > >  	dma_addr_t tbl_dma_addr =3D
> > >  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> > > @@ -686,13 +694,12 @@ static int swiotlb_find_slots(struct device *de=
v,
> phys_addr_t
> > > orig_addr,
> > >  		size_t alloc_size, unsigned int alloc_align_mask)
> > >  {
> > >  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> > > -	int start =3D raw_smp_processor_id() & ((1U << __fls(mem->nareas)) =
- 1);
> > > +	int start =3D raw_smp_processor_id() & (mem->nareas - 1);
> > >  	int i =3D start, index;
> > >
> > >  	do {
> > > -		index =3D swiotlb_do_find_slots(mem, mem->areas + i, i,
> > > -					      dev, orig_addr, alloc_size,
> > > -					      alloc_align_mask);
> > > +		index =3D swiotlb_do_find_slots(dev, i, orig_addr,
> > > +					      alloc_size, alloc_align_mask);
> > >  		if (index >=3D 0)
> > >  			return index;
> > >  		if (++i >=3D mem->nareas)
> > > @@ -903,17 +910,24 @@ bool is_swiotlb_active(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(is_swiotlb_active);
> > >
> > > +static int io_tlb_used_get(void *data, u64 *val)
> > > +{
> > > +	*val =3D mem_used(&io_tlb_default_mem);
> > > +
> > > +	return 0;
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%=
llu\n");
> > > +
> > >  static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
> > >  					 const char *dirname)
> > >  {
> > > -	unsigned long used =3D mem_used(mem);
> > > -
> > >  	mem->debugfs =3D debugfs_create_dir(dirname, io_tlb_default_mem.deb=
ugfs);
> > >  	if (!mem->nslabs)
> > >  		return;
> > >
> > >  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nsl=
abs);
> > > -	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);
> > > +	debugfs_create_file_unsafe("io_tlb_used", 0400, mem->debugfs, NULL,
> > > +			&fops_io_tlb_used);
> > >  }
> > >
> > >  static int __init __maybe_unused swiotlb_create_default_debugfs(void=
)
> > > --
> > > 2.25.1
> >
> ---end quoted text---
