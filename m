Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1824F49FFB9
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 18:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245087AbiA1RoW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 12:44:22 -0500
Received: from mail-eus2azon11020025.outbound.protection.outlook.com ([52.101.56.25]:51381
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235029AbiA1RoW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 12:44:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/lo+xmQFdLim+Imd+wQva8/QBf35zYm4Lwt+F9P3j5WHCplRTl/ajn092k5lRwSp5zdZgUi/4uKomZ1p5DK1fi8UnHDhWjSGXMoM7Y/Bl0lo6GU2KbbinaksGL+MmGrLSjvQQDcNn1+z6G5/qqNGbm2w4h2RYSZ+Lz+laNqrSo+A2pf+RjzD0+P7trpe1nMa/LRzoGdRn6AePAhPsobw1TIB/aTz3VxiDkdvkYH++vlC7cd+VGbSmHlKOAw62pxTxzswdj/YN88QTA963/HcRP5QDc349XjlnKKXdYaW2KQPaAhGikNMCkbJFAXSeksTl8dY8LNG3qascchl7YeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W+VVW14npTPWLXtUDFN6uK5LEXh5tUIUkLTyhF5H6k=;
 b=dTyYqhkjCeaoP2Vma6Mt+jQmu3zQ9F0Zzab/n6TieAQOOTEEbg396uv4ofxOoiG2wOzFc9vLzOdcgJB74ZnGnamVXVSjLpy4jeuGe620qJo58xpDWNd4o9HAQDaTMxORhZA242mKtzJmHC+Y4SAHHclpU5XnVbcNlD4dHboeBkakd72oXnSwHewbjpHewkWQGwNZlyjwb1NWUCGBRyBflh3fR7eCyjQs+to1Q5eGsP1RpnGUrPGM3BfaSm3GStskFvGZvSYx1YvpUiruwhWAg9ROaa3yoGwMojoYuNkhcd9QCtvofNdhC5KRQPoYnNT7BGKWLUB8gw8r2kNmXQD6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W+VVW14npTPWLXtUDFN6uK5LEXh5tUIUkLTyhF5H6k=;
 b=GJIX7HaUcZb3ZW5EPbLYlZ/1vXhbemaYdOQ/vvQAXCCRmFnL/7NmlNa9t64xQl/guXGOH/VnxKFk5PSkllTob6IyFPodbjP/LwSl0BjcoUfXvw45oOdBFEDU20XJ/nh5r3YSywpfUM31Sf9OgZio3YhEqsicCPjkIk0djlzpKI0=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR21MB2108.namprd21.prod.outlook.com (2603:10b6:3:ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 17:44:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 17:44:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: RE: [PATCH 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Thread-Topic: [PATCH 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Thread-Index: AQHYEs9ZKhA1GepvzkGaq0JAlGCncqx4t4Nw
Date:   Fri, 28 Jan 2022 17:44:19 +0000
Message-ID: <MWHPR21MB1593E755B8AEB371795263B3D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <20220126161053.297386-2-ltykernel@gmail.com>
In-Reply-To: <20220126161053.297386-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6aab57e-d3af-4319-a8f4-fc5e30b62063;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-28T17:43:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24695ad4-9190-4dae-51f0-08d9e285cfd0
x-ms-traffictypediagnostic: DM5PR21MB2108:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB2108B2C515E72E1140761DC8D7229@DM5PR21MB2108.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97zSMTPQe3PU0GO6d2CHW6q12vookJci+styr6erFRCyXpNeKUZ3GCx8F35q07glCzdk53M5Da+5zPxC+x9QiO+M334iJ0o8Kc/UuN/Gg4z+R9rAzdkn/T3hP7zVL6dJ7BygXY7pvxjK3+/GYv6dKr7JLpzING0dTbuSuF5MwXbBcydWeFBPuGD5M/EIx9ggTIhQZR+IFam5bVPlYyk79z80av9VexqauOpdiE8mO3eFckC76BSAqFEiFCDdkImtuJO+Ar3lk8S7TfU6hYCHpmC2US1HjE+PpRpZPA1b/j/Ald8QqhM4UgRSLG7W2+gMpsjuaUNn4wF5GSI9Knu9Pu6G9z0XvlnvzUv+05rR70wS+VbbmxLxpRnRALL4CtKy1mbppoenQbjYo4vgQxIjzmAkYj/PPT4eZpja+89Xcl7rdFqrYhmNYLYqUd5j7ashWRJ8P2Z4GYEWOeSnInGDHm4yYWo3knLrdniqT6BlGWQMwl15kpNZu28HqwuZg4rdvQK8b42LCUeVwYs8R1WpzD3MOdhBlPt3c/KV5URevqefpWEQnuwCwfDs321ACdT+qQCshSNhwdO24NVrL+OevMyDegfbMmWJdUnxy+86hkvs/E4rN0OAnAQioA1vkT+uSBTC7VbRD+1iGWW94tMiXxqwpC7ODVZUjUY4G/+Kb+6LWzvnX6VzvtTLsXfbQxCSQaEbY691SEdh4yRCgQjN1w40CPys3Xm9GBqIv1Kb9MIWy2Bmv3TbB7iCXghrlM2IU8nV9rivPkrd94mK8B9zQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(64756008)(66556008)(76116006)(54906003)(52536014)(33656002)(186003)(26005)(38070700005)(82950400001)(4326008)(82960400001)(316002)(66476007)(86362001)(8990500004)(66946007)(83380400001)(66446008)(110136005)(71200400001)(7416002)(7696005)(9686003)(6506007)(2906002)(5660300002)(38100700002)(508600001)(55016003)(921005)(122000001)(10290500003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNYVz3+iHjdHQaGOLQ8S1wvtv7Vfj8fz4k7REbXfU5LwsiaK2yZ5rw9nwMrv?=
 =?us-ascii?Q?HHzv3eG4Otbcf6Ugo5h/IUCsmX8uebaPMA1WXjl2voUi9HSI+uY8lgRAxowf?=
 =?us-ascii?Q?n0BJz0YKTmRRe97xg6Aj9BWc+ew4EbyUebH1EZevysB4uQhywQvx6UUzKYZ9?=
 =?us-ascii?Q?MZ6VNpk1UA3k1DphjF7vqLd+ko5KX426KGjky6R8Ujjbbj1MnoGYgXxDkn8x?=
 =?us-ascii?Q?Z5RYpFojXkmA4bhEqZJFuW5OXhdJlSRKusuZYDyqukuKFwdSn63FAqMZ8sAW?=
 =?us-ascii?Q?fP0zyRpCjhF1KW5PGFHDCykDV9oZZIiA00jgINGBzWKgi4BgJno5/6faH3Oq?=
 =?us-ascii?Q?5yPNhsjNA/oitYdTiGQEs0e5CEoM0NkhSX4yv/6kcsXcIzKrIHYkG0FGCFO6?=
 =?us-ascii?Q?19k59C++pEERgfSJwpR/p/NAcz73ft4q7wvBx5pAkzd3/49laUv15UpEH7Q0?=
 =?us-ascii?Q?3j7ZcasgpL9NEnm+5L7nWpWv0BUpQuoRNnWr04oFWHv+nYXm09pDTT2BIwV5?=
 =?us-ascii?Q?URdbiVxw1RcTJ601TnJQ5gRN6QethIaQn/OoWJZUKeyS0QSpgiPY5wHYsCQt?=
 =?us-ascii?Q?X0EKhEsgX06ubgHd+a6/nFV5cATh2FCf8ZfmFlcxVsP04aPKKJbfbjmX+S6p?=
 =?us-ascii?Q?wflaNGbFvR5FSB6Pz83q2BsvfL6sx8LWQhA8wK3y3jclAF9J+Cyi3Bugm002?=
 =?us-ascii?Q?F3QinC0s0HrEkxBqgyh85wDCAuZTfyOpsQZdKF4EPshuFDGLIwgBifjVqNv2?=
 =?us-ascii?Q?YU8MU7zTd/ndQz1P736B5jtT2SpmH+DdIo0lD5YEctRHIZhNcsPPEhakSkMJ?=
 =?us-ascii?Q?91ShnXUb/+q1iJT4aFTna84eicWVfjEPk0wGCqCk0OTSzX4h9V0LoUSh0SY3?=
 =?us-ascii?Q?7GQRacyf+I2JqicGehAjbXlo8wZL7x2qpli7LVms7UUufl2zoYgApFNqfLfb?=
 =?us-ascii?Q?iLXTD9vjh+dDSUH0siNKe65q6QHDvQx4xqwWyGZyHKmNipIki4MouMdpI+/n?=
 =?us-ascii?Q?XFYd/oDUrg36CZgwCLyqb8wEupJ2/nRbnWvXw8y8xedis7O+uf8Y5ubK+i8r?=
 =?us-ascii?Q?hynIALAORMprWyDqGxjtZ6cZEKmHOpsGLMC10KPEKPu0jWaSfvYxtl0C055W?=
 =?us-ascii?Q?8m4A0W43bWfxooZCsijb1H1avDe+tlqTGWwlDAGNvk8VWDpL0wCr37/VZt0P?=
 =?us-ascii?Q?kUJUVIT/LV9MHG0vIsvzhveRCikMXlriTft+e9QYFY6KaeqPrHi/ISjsTRci?=
 =?us-ascii?Q?3ApXUKTjCO2b5iIlT1tVb8vxV21IKRuW9aFE22rsdazhvXpd4Gkn+IFgeCVp?=
 =?us-ascii?Q?YgsQ5rmrSn60ctTuUsYtkqWJsRIfQI6s8xp4zSsk8RjGWCqcZbUcd1F35IyK?=
 =?us-ascii?Q?uJSapoWh5JRi2zrR5UMNLNH/9mtfJbU9veZvTbgG6kLeHp2YSggapKPe77mj?=
 =?us-ascii?Q?JbrAq44wNdWud6G1brQRSusMII6umw7RgO1ezkCFDFs4NnVJApX2us8rnxfC?=
 =?us-ascii?Q?hR6Txf/naokU35u3Mv3rkKqyw4CUGg5OIpYNqzuJDEGxMLpOGVsYkzPm5UM3?=
 =?us-ascii?Q?RzLNRgVs/gm13o0gi14lqzVxC90FUI/2k75g5yxY+7LA6KOxIw46FUgZrI3m?=
 =?us-ascii?Q?hlbSM2oTTBOFxrFu2hSpENVap2INdA11qPhd7s9bZRXJwP61UiSyXAbMO1h2?=
 =?us-ascii?Q?tCWZYw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24695ad4-9190-4dae-51f0-08d9e285cfd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 17:44:19.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALELMMqrpoMRAlP2csuFJp3BQyTN06cLvcycrWBe/drFDM6VH6/hTeKhiHPB6PCJgegGzCo8kQR0mUHT1hSV0M+vU+eDxu8HiDiDm+ct4oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB2108
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, January 26, 2022 8:=
11 AM
>=20
> Hyper-V Isolation VM and AMD SEV VM uses swiotlb bounce buffer to
> share memory with hypervisor. Current swiotlb bounce buffer is only
> allocated from 0 to ARCH_LOW_ADDRESS_LIMIT which is default to
> 0xffffffffUL. Isolation VM and AMD SEV VM needs 1G bounce buffer at most.
> This will fail when there is not enough contiguous memory from 0 to 4G
> address space and devices also may use memory above 4G address space as
> DMA memory. Expose swiotlb_alloc_from_low_pages and platform mey set it
> to false when it's not necessary to limit bounce buffer from 0 to 4G memo=
ry.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  include/linux/swiotlb.h |  1 +
>  kernel/dma/swiotlb.c    | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index f6c3638255d5..55c178e8eee0 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -191,5 +191,6 @@ static inline bool is_swiotlb_for_alloc(struct device=
 *dev)
>  #endif /* CONFIG_DMA_RESTRICTED_POOL */
>=20
>  extern phys_addr_t swiotlb_unencrypted_base;
> +extern bool swiotlb_alloc_from_low_pages;
>=20
>  #endif /* __LINUX_SWIOTLB_H */
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f1e7ea160b43..159fef80f3db 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -73,6 +73,12 @@ enum swiotlb_force swiotlb_force;
>=20
>  struct io_tlb_mem io_tlb_default_mem;
>=20
> +/*
> + * Get IO TLB memory from the low pages if swiotlb_alloc_from_low_pages
> + * is set.
> + */
> +bool swiotlb_alloc_from_low_pages =3D true;
> +
>  phys_addr_t swiotlb_unencrypted_base;
>=20
>  /*
> @@ -284,8 +290,11 @@ swiotlb_init(int verbose)
>  	if (swiotlb_force =3D=3D SWIOTLB_NO_FORCE)
>  		return;
>=20
> -	/* Get IO TLB memory from the low pages */
> -	tlb =3D memblock_alloc_low(bytes, PAGE_SIZE);
> +	if (swiotlb_alloc_from_low_pages)
> +		tlb =3D memblock_alloc_low(bytes, PAGE_SIZE);
> +	else
> +		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
> +
>  	if (!tlb)
>  		goto fail;
>  	if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

