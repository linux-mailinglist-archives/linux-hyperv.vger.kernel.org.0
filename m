Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE757D921
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Jul 2022 06:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiGVED2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 Jul 2022 00:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiGVED1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 Jul 2022 00:03:27 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F8491D2;
        Thu, 21 Jul 2022 21:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsTXHb14zSp1ODiKJHvvTSgWJk8aGm0yAls1Z6SxHekGyR4lK3iwMz5GE7Bw+vfQk83MjXKZ7pRRtwz88mM8/jDgHVxz1pghAR3sR85YIcmsC8+3EAfXjm1Eh6tbH6i7L2VHJNREz4WqH5LWuhGqf84qh7hmXMCwz5jhj3CataOxJrYfmBPIeyKduE8UwBw9y9qLfk440z3pd34+Qdipo8Ul8lOMNhrykoh+EywUcRwRhRrcbw6A3QtYOtxMyayRle5WHHQb3jbL+E5CJ5DwHpBNfB1FKO6RlTEmETzDLSF3WkJ7SWpGFvdVCneluXAhU/LrsoTmqRm30bwR0D2igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYVBr3eIR0gv1BgdAduIbKBCz9DkEfjaofstgG+Hmjw=;
 b=dyWGS4aBLa23SG0vROuMpiUAuY3/CVidFnTYkyN8kJsEWxXSU06GNikROxrrCRI/K5FD8E/viGPBOh8d4MvL5U19M+oSqsgCPdMKf67Q7iXJPpml48YU+dN0lOCU7jzdOwFxspnCw7v3S27nCZtUZyLciAAls6V7H8igOlFWh3Dhh2fxt9OTBUc0UqHs7/T3S7qVb2mJzBuJSL0drYPa+2w/1b3xzGvKFLw7S9NedvlgFzOWkaRzCIEqxF6gPg6kz+B/NyDK+S1Fk8vd89IavzO2gMdgy4VWfyUgpd2TwO7XluJCG85u/2chQATZSLY20WHyzm8js4iIYr/3MTCxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYVBr3eIR0gv1BgdAduIbKBCz9DkEfjaofstgG+Hmjw=;
 b=Uy1lcL3iiRgdEYFP13foUXB7D4aiIYZg37A5bxnkKv7UPYhZVUI4BJMmbeFp4VBzBEMB9ThIurmqa9EKst/3g3pWHKWiBb2nZqRYQKKppvE0T4Ln/7dcy3Po0B5iMCxHousu23ebwbx6VXyRZR8ePvYU5wfNDnzq3LDQlOQDAQg=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3257.namprd21.prod.outlook.com (2603:10b6:208:399::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.2; Fri, 22 Jul
 2022 04:03:21 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 04:03:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Clean up some coding style and minor issues
Thread-Topic: [PATCH] swiotlb: Clean up some coding style and minor issues
Thread-Index: AQHYnXyTiNG67/0qI0uJ03DW/F3voq2Jwffg
Date:   Fri, 22 Jul 2022 04:03:21 +0000
Message-ID: <PH0PR21MB3025A8991E4126A6B92126D9D7909@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220722033846.950237-1-ltykernel@gmail.com>
In-Reply-To: <20220722033846.950237-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1eeff37d-28e8-4faf-9b30-cdfe73dfdb7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-22T03:52:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 648be3b1-6962-4692-46f1-08da6b971e24
x-ms-traffictypediagnostic: BL1PR21MB3257:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odgn/zYk3Yy9b3m0gqLCdZIdyfbxfdxuL59a9nFV9zQA1Qsd4hOhSLq0Y6EibNcr02yVixLmBiwXUAq+ZDP/zizR6HU7Wqiw3d6v7nbye8R7sdwoXnLG6cqzACdqeRNpe2smEqOPra6DXpEBB7hU62R5H9fJDfhBWRpqnHIYnOJ/+mNbliIRFJV7dWbHKRQjOZTdRjT895MWRlZxSyahQZ4aB2LUbVl+V1/5GxYJJA01byPDW2ZWw2YU7s9uK40OVInJmogXajnPJZG9ewdJSTY/EztdvOTD1c+/UTjA9A/IhgNXumdFkO3dqO/JLmtD5FkchJZZZulT0EVgUfJbU5pv/OQ5BlVUBFb88Dap5z01zpACaOuJBeuy4Z814qcVExx5qImmLEqSde9lZJRpOGLyZ6R7B5Ot4B7yZ5CyqXQa0Foyb5AMCoK5cuLkUUuctqqOsx6PUXS41MvEBYSC311GbSpbrMa3ajhIs4KZOJgnJBCRheQgdxwWPOD215x8OWYqPGcYlrxG3Q5bShYjOsJPxR1zMvXWXpzamnPFhBBoin7XGTkB45ID4cSDCm8zlkddkyiQVqwV8H1Zn4yq7gdhVXCiit0nOuMZBXc+CPPyF93YrgCfroJfkWVsHvVW1lyfw/yZ+xBGcC6R/9amK199xVFQNaAEzBt0kPgsCZmp5S06zZJXKjRG4l3gqaWHJDsjDR/HptvjmRr/VnguBO9R8KdEbqpRIMjAnxv5UBJJ3wVrwIVHvfzA06YPGqZ7mC0BNaVA/a8CNM390Sw/mBdxOcyNPyh4u76VvqVPKkgCzVd+M7kjUfZ9pOdbR3K+tQ/wqTOaQrAek9mnq9mHQqba/E6w+CtCSqoO7oVrmQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199009)(38100700002)(76116006)(66946007)(66446008)(66476007)(66556008)(5660300002)(71200400001)(41300700001)(64756008)(83380400001)(52536014)(8936002)(316002)(54906003)(110136005)(10290500003)(8676002)(4326008)(33656002)(478600001)(82950400001)(82960400001)(6506007)(7696005)(9686003)(86362001)(186003)(55016003)(8990500004)(122000001)(2906002)(26005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g20gWqS97cxBi3y1bB351gSlz00bFLSNRywoE+ZaHAciVLq1Rx91IYLS47tZ?=
 =?us-ascii?Q?AxkKL7YtrXjbdNGClrCzjDR0F7YGhKnYnoJHM3OiGQcc60HirLfhb2thyQcl?=
 =?us-ascii?Q?hwXmmllJWFI34Emne5VsalQWzRLALYxl/ih1rze+Q0/XbQjOawfqP0e5YmA8?=
 =?us-ascii?Q?gtZTu9oTjUQ9zWCbwMrqSoxVpS8BoK4Z/WTtRYm+38c5hDVJ3rXKLLlKoXjq?=
 =?us-ascii?Q?TS1cankT5L8iR6EJzgjyyZ9A7vCeeGR5gIgD07iWQDXfErOc/o7oTLrKrEm+?=
 =?us-ascii?Q?sYxxk4KSMjJLr3Gl+QgBx+yYg+oY9mcQJpHvTMdbmSgEaQlkiJhfspbLoPps?=
 =?us-ascii?Q?i05JjSyqoS1LgJS3Rin7ZoBG6kGJjhhBFXsKUIBMZzJNadhZco8wLXtSQ7l2?=
 =?us-ascii?Q?RwNtvUEz6tlbEVjQDbpjlR6i5U4aUZdgCSO+GyhJ49Tg5sZ1rnSZ5FehRJ4d?=
 =?us-ascii?Q?7fqARYRkifiSrBzTdyVL6GXjyRN1bV+C+AMynS1N2xEb6lQo3Cs4LEA05SMn?=
 =?us-ascii?Q?kWAFOICszenvkL6PDOxxmDMGhNHR0ZdxQ0Qf/TAbUS6It2OXja5QV1A8MHRr?=
 =?us-ascii?Q?iyKQ3l3FgI8yn6rT9wRxps+4PxdMCtM4DzFrILIHvGOaWqI1rJXbe9WVGnWX?=
 =?us-ascii?Q?eCz7biyuSw2IF3DkhIkuMuPSDuuHuNTqFJhztzUwtefp2LTKiOIm31DeQTQ8?=
 =?us-ascii?Q?gnw/cWMhNVKd8sabEF0LwSQNhxpPybe7i+sem4RSi01nqkqbEzJaxAumygXy?=
 =?us-ascii?Q?lXbwktwByDmbIHrdTK3fXe9tGi2rjQES2v6Krj+zIgWwG32DSLx+fl+ES5hH?=
 =?us-ascii?Q?XvTTzSdC7OsHBLcn8ocjjGsGm2PSioZlRvy0cUrN9kQ3EdkcczHu/08TgpzN?=
 =?us-ascii?Q?OeZJSsnsMl8/Muf70PaUkNvOpfxVHNfio9gfDJtmWkJe2BFg2W+zbtcvSmUa?=
 =?us-ascii?Q?3NYlmN8UcWIgpozmvlF8Nmw/4HitOU9RyIYcVZHmyuEvgpvEKoLej4a9YBek?=
 =?us-ascii?Q?qINOBoRTmy+pNcWhjOucge5jIAahhX89+YHLOT1dKslbY5+OlxWZ+GinAIqQ?=
 =?us-ascii?Q?NaGx3mlauJ2Vz2t+6cdsaXWHbbzPwPZlUIauT+9jWGSVDLipc7kzRCrxsPgy?=
 =?us-ascii?Q?fbgVeA4l/o1U09Fi5/HRdUOT6WmeEfQ411QcowHxbKdnE9yvORhKPgkiHhje?=
 =?us-ascii?Q?AlevnuGfmGAJIb+8kQ8hDXLlaZWsKUl2Ku9M+Cv8O9801LbBmy04pGhUgweK?=
 =?us-ascii?Q?ay4mhZ7sId5ADh7hd8zdo2jhYVdUQ9cRaLfEZqBkzsFRaOg4/YSBul94lEgj?=
 =?us-ascii?Q?EXPvhk+WmYvTmiUjYHB/udgbknFtAgulMyYgoHlI3txWgNNfKHXC9yr1Ef2F?=
 =?us-ascii?Q?w8tRVPIm4x90v/ZX4EtsOyeVhJ4xa7Y8XzDEyhPLeWry9miGAiH48Tew/Isd?=
 =?us-ascii?Q?C7kpsXEReD6nnplRLMNEJzlgo4bNQPSUJiOkzOTLKH2MHKrBTF+3wd5Nq6DN?=
 =?us-ascii?Q?zvk6oS/2O9g7LUMQKX1/qQ/d6mmjDfFNz/rCQ/OCAFtX0bNI0KAuqYV1Z78P?=
 =?us-ascii?Q?hMWTow26oMXdfD3qUMitAVjZ3zDmutEbp/PKs8TigbsymdYMMF/uBPmCgL1j?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648be3b1-6962-4692-46f1-08da6b971e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 04:03:21.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlBBK7+ar1+04YaPKHlqrAs7M1bviUUPrjbV/TKUQzsnkV8No7N60Cffo0uHJVcKpsuNPYzv5lg7J3x4SpBBTRW7MMfx5iXmamJxcI+jABI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3257
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, July 21, 2022 8:39 P=
M
>=20
> - Fix the used field of struct io_tlb_area wasn't initialized
> - Set area number to be 0 if input area number parameter is 0
> - Use array_size() to calculate io_tlb_area array size
> - Fix error handle of io_tlb_used debugfs node and introduce
>   fops_io_tlb_used attribute
> - Make parameters of swiotlb_do_find_slots() more reasonable
>=20

I think you missed one of the bugs I pointed out in my previous
comments.  In the function rmem_swiotlb_device_init(), the two
calls to kfree() in the error path are in the wrong order.   It's a
path that will probably never happen, but it still should be fixed.

The other fixes look good to me.

Michael

> Fixes: 26ffb91fa5e0 ("swiotlb: split up the global swiotlb lock")
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +-
>  kernel/dma/swiotlb.c                          | 42 ++++++++++++-------
>  2 files changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 4a6ad177d4b8..ddca09550f76 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5907,7 +5907,8 @@
>  			Format: { <int> [,<int>] | force | noforce }
>  			<int> -- Number of I/O TLB slabs
>  			<int> -- Second integer after comma. Number of swiotlb
> -				 areas with their own lock. Must be power of 2.
> +				 areas with their own lock. Will be rounded up
> +				 to a power of 2.
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c39483bf067d..5752db98a1f2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -96,7 +96,13 @@ struct io_tlb_slot {
>=20
>  static void swiotlb_adjust_nareas(unsigned int nareas)
>  {
> -	if (!is_power_of_2(nareas))
> +	/*
> +	 * Set area number to 1 when input area number
> +	 * is zero.
> +	 */
> +	if (!nareas)
> +		nareas  =3D 1;
> +	else if (!is_power_of_2(nareas))
>  		nareas =3D roundup_pow_of_two(nareas);
>=20
>  	default_nareas =3D nareas;
> @@ -270,6 +276,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem=
 *mem,
> phys_addr_t start,
>  	for (i =3D 0; i < mem->nareas; i++) {
>  		spin_lock_init(&mem->areas[i].lock);
>  		mem->areas[i].index =3D 0;
> +		mem->areas[i].used =3D 0;
>  	}
>=20
>  	for (i =3D 0; i < mem->nslabs; i++) {
> @@ -353,8 +360,8 @@ void __init swiotlb_init_remap(bool addressing_limit,=
 unsigned
> int flags,
>  		panic("%s: Failed to allocate %zu bytes align=3D0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
>=20
> -	mem->areas =3D memblock_alloc(sizeof(struct io_tlb_area) *
> -		default_nareas, SMP_CACHE_BYTES);
> +	mem->areas =3D memblock_alloc(array_size(sizeof(struct io_tlb_area),
> +		default_nareas), SMP_CACHE_BYTES);
>  	if (!mem->areas)
>  		panic("%s: Failed to allocate mem->areas.\n", __func__);
>=20
> @@ -479,7 +486,7 @@ void __init swiotlb_exit(void)
>  		free_pages((unsigned long)mem->slots, get_order(slots_size));
>  	} else {
>  		memblock_free_late(__pa(mem->areas),
> -				   mem->nareas * sizeof(struct io_tlb_area));
> +				   array_size(sizeof(*mem->areas), mem->nareas));
>  		memblock_free_late(mem->start, tbl_size);
>  		memblock_free_late(__pa(mem->slots), slots_size);
>  	}
> @@ -593,11 +600,12 @@ static unsigned int wrap_area_index(struct io_tlb_m=
em
> *mem, unsigned int index)
>   * Find a suitable number of IO TLB entries size that will fit this requ=
est and
>   * allocate a buffer from that IO TLB pool.
>   */
> -static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
> -		struct io_tlb_area *area, int area_index,
> -		struct device *dev, phys_addr_t orig_addr,
> +static int swiotlb_do_find_slots(struct device *dev,
> +		int area_index, phys_addr_t orig_addr,
>  		size_t alloc_size, unsigned int alloc_align_mask)
>  {
> +	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> +	struct io_tlb_area *area =3D mem->areas + area_index;
>  	unsigned long boundary_mask =3D dma_get_seg_boundary(dev);
>  	dma_addr_t tbl_dma_addr =3D
>  		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> @@ -686,13 +694,12 @@ static int swiotlb_find_slots(struct device *dev, p=
hys_addr_t
> orig_addr,
>  		size_t alloc_size, unsigned int alloc_align_mask)
>  {
>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> -	int start =3D raw_smp_processor_id() & ((1U << __fls(mem->nareas)) - 1)=
;
> +	int start =3D raw_smp_processor_id() & (mem->nareas - 1);
>  	int i =3D start, index;
>=20
>  	do {
> -		index =3D swiotlb_do_find_slots(mem, mem->areas + i, i,
> -					      dev, orig_addr, alloc_size,
> -					      alloc_align_mask);
> +		index =3D swiotlb_do_find_slots(dev, i, orig_addr,
> +					      alloc_size, alloc_align_mask);
>  		if (index >=3D 0)
>  			return index;
>  		if (++i >=3D mem->nareas)
> @@ -903,17 +910,24 @@ bool is_swiotlb_active(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(is_swiotlb_active);
>=20
> +static int io_tlb_used_get(void *data, u64 *val)
> +{
> +	*val =3D mem_used(&io_tlb_default_mem);
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\=
n");
> +
>  static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
>  					 const char *dirname)
>  {
> -	unsigned long used =3D mem_used(mem);
> -
>  	mem->debugfs =3D debugfs_create_dir(dirname, io_tlb_default_mem.debugfs=
);
>  	if (!mem->nslabs)
>  		return;
>=20
>  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs)=
;
> -	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &used);
> +	debugfs_create_file_unsafe("io_tlb_used", 0400, mem->debugfs, NULL,
> +			&fops_io_tlb_used);
>  }
>=20
>  static int __init __maybe_unused swiotlb_create_default_debugfs(void)
> --
> 2.25.1

