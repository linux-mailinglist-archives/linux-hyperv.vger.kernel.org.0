Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088449FFBB
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347377AbiA1RpA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 12:45:00 -0500
Received: from mail-eus2azon11020015.outbound.protection.outlook.com ([52.101.56.15]:10732
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235029AbiA1Ro5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 12:44:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzIWLMfP22X/I6SWsFMfRvn+HqNQB04T1Fk8o5DGMoxJd8w/x1UsYNV3GwnVt/+NrK+09OSQkMY5Et1ht1Mf1HGX6jWNhR0tPoCA7A5xzRe5KBoyxR1zFjLqXBn8qBpgcvVuUWFNF8BLNqhN4dIQoRSYgL09IpfS91p3iEknYlBhFKCS9VUnzGx5tnBGZUygCFicGH05YqXenxRXgm6pVx1l8QYH/AVmV5cF/TmMWJy2GmuGwsJlIMeNq60s9EiNApI5CCUhHJPzf/sSOF8bPzcQDCzqIN+k7gGBV4ZnUYN8mvz+55HilEmodjVCU8WhL32tWFC9CRiE54VHu/lczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wDO3Z4QOHUFEXogoVML389xDBqXIZHT7mqYpVGs6RA=;
 b=LVsDtq8UgiUWMhJXN4OGAA7ujOiOW+n57NgSlZ2V8Cb1OygpL1vGyB6tYqPYETkR46FfqnYQDZ3ccMaqCyEPSffBckp9DR2JvMoFBQBB4SQztGX8kIEMdgEVvONVDdfpe9RpzDsm8cdArFq6eN1abE14OKKRM+jivk8JI4rSoT68NBnn2bDdvaMtjmWf6ug4ZMoTpTYZb7V8PRvm5+HxpRprectouFC5CSqcdsP3IeXbkGGAao9BtrEZD+wCqd9YNBkysR2PrqKw1nq7N7dCxAKCxFaZhO0VQLcdGzKMgOB+b0GM3WWuYCmnTYCSYezEpA7YQj7UBkKFyuLp+OzdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wDO3Z4QOHUFEXogoVML389xDBqXIZHT7mqYpVGs6RA=;
 b=LUEvc19NN6YDK5AH06DtrrOSn+tDpeV3MziQAgb5oUYgmzgFluxWWUJ767gZP0yb27kY/RTkS69wkgDPXls/uz10YUd3RYvNvIbFMTK8GU6QtmuhgaMI9742LlQHtDx9Q6PR5LynFhp9jsqOTGwulOu49HdwKGOCO3Mbn3HwBGQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR21MB2108.namprd21.prod.outlook.com (2603:10b6:3:ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 17:44:54 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 17:44:54 +0000
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
Subject: RE: [PATCH 2/2] x86/hyperv: Set swiotlb_alloc_from_low_pages to false
Thread-Topic: [PATCH 2/2] x86/hyperv: Set swiotlb_alloc_from_low_pages to
 false
Thread-Index: AQHYEs9YhKUTn8cbZ0e7UpyxV1riwax4t70Q
Date:   Fri, 28 Jan 2022 17:44:54 +0000
Message-ID: <MWHPR21MB1593E33B5300F38A201CD523D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <20220126161053.297386-3-ltykernel@gmail.com>
In-Reply-To: <20220126161053.297386-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a204df9-826d-42b3-a83b-5cd92774331c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-28T17:44:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edfb67f6-a25b-4391-5875-08d9e285e4d1
x-ms-traffictypediagnostic: DM5PR21MB2108:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB2108C4D8E140BBE64A246F33D7229@DM5PR21MB2108.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2iSpkbcXhBx5rerYKnGIBE35N6pWqMfh+K9TLye61EV9+MtV1ueOwAwA0muUk1w8QIxrxDjCeiYtp8HpoSFqFz2yRimsOqw07mIymExnQcj9Bhc3ZmgUngPpgtZy77FLQ97e69t2h/IUjfROxp/A81Y4taf+TGvNVMNn/SeAkoxORJzamaWYS3huA4IqVyQqJdGrmry1oIXDT2lLsDOkc5AWiqGGW8EXREk9oeDRKzwzBwnzjShiUQzyux8ckbW4HoXKVtopCv6manyh9MTTf+VKp46iJSDP/MNxfz0upiOf4Mjnk8PwI04ySh2HszfXLltgZM+/GCMpftnalABjg2yEPTlwOTinbteMqOEvjKtFm5f/ZvQJPkQgiKO9LBeFQDK9CvneKctPtJNZ0c4bqT5Oip1IY1xM5mTc9EmcGIox1rpztStWz3EBws8GMQ7xv7rndC9Fvs4xU/9qsUD2tARjYedRoJ9y4mUsMTK9/sS6zWNHl3Fjd3ZtPfhgPH5iD9ey0RP61FCPLcqgxu0epmQFeFPUGx3gLAzL2Lw6bwCz1C5ZcIyITAGFn/2VIu7UxBQsDKfk+sCMrcI2QTNEKyOYnpHRW7NLM4r5G9241cReacW7uPoQFAbab6wlXi1ymM0RssB1wVTwqDoPboX7H1P5jo9gGatdKlCpizuI7mp9V/L4QnGHjEsCh4ZOFK6BdauXPNK2jHscfKmQtZqJsFfb/rtyAjx14CZctQMiDSQgrD0nXctwyobE2VYaHiXEawwaWoAOj2xyLxQfDgjpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(64756008)(66556008)(76116006)(54906003)(52536014)(33656002)(186003)(26005)(38070700005)(82950400001)(4326008)(82960400001)(316002)(66476007)(86362001)(8990500004)(66946007)(66446008)(110136005)(4744005)(71200400001)(7416002)(7696005)(9686003)(6506007)(2906002)(5660300002)(38100700002)(508600001)(55016003)(921005)(122000001)(10290500003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/AH6sQ2oIk00Pi+ysgro+ReI+qRJ2tOU9ieNVp6O2hb2Vmmt0gzxIWTMOd4?=
 =?us-ascii?Q?EGRE5tj8OsffBU+Lcrq9rSqW3PCLGij0LO6K29WmNSgbJxQod8vk2BfBEpNT?=
 =?us-ascii?Q?RHId6H057ef1wzp/bTL9LVSTkwkr7U7M57tJdli9UD7ikzFOUh+UDICb9k8x?=
 =?us-ascii?Q?0NGbotcPE+LoD4UAQlpyIe/Vk0WWVqKz9l6ZiDsjN4OU5OAiiNeVm2PQMvDt?=
 =?us-ascii?Q?9FYMpUlH0xBXTzDfpp77V5SNqip/tVan7mIDFyNl79HsTcMyr+2NYoBc3Y05?=
 =?us-ascii?Q?/NXAgRjjoShvoxgzMFYXT+p297e9yUzCTYmBI2tpTLRq93crKM2bYs6HVlnJ?=
 =?us-ascii?Q?dwTf0JuZEXu/n6OzLZgQEVeKNHaQbDVsR9SGBoo4bj+VCEyn/hyGhTOy4AlT?=
 =?us-ascii?Q?xLNdAnrEyfXQGg8126hVve2soPmpVXz2ei5W3HC5f4WP0Fh7r4R470iiGTm8?=
 =?us-ascii?Q?gNmaYlXRp4rlwsiZ0vvQ8ayi9O2ri4BdT8vEPOh7CRZCBnhtTHdWBT33AOJ2?=
 =?us-ascii?Q?itw5e4nx3Mk2JlzlUFU9VhtwdsAZMf6eZ0iwwTxcBT8M8uizqtugmlE/FcZE?=
 =?us-ascii?Q?YFxzfdeIoOsAL4i3j5N4sY78B5SHIvASd32jJ9KZxs11Xux9hZ63oLGk1W7A?=
 =?us-ascii?Q?8QbgUA7A2u4NVU7QgeGgAybDOCKhofccKpkKLoU730ch8Pi6lMhpcqMvUCBh?=
 =?us-ascii?Q?BOfwD3H+reEVx7P5cDlUb71CYsw7XUnM119ZdjVbSoHkd7zAvoKp+PT4jA0Y?=
 =?us-ascii?Q?fOjj8ouNzCp0BTicZtIK/uMMJ71WgsI0NHY4j8T0SO5ZESLwd9lSsoD6c6sX?=
 =?us-ascii?Q?CEnhgMpP6ywW/11luVEAYvwFH5h56nbUKWz+x2RaAXGB23kzDsJ4/6L8DJt/?=
 =?us-ascii?Q?lK7k4YQOKt6ggEMd9HnjAy39M3+zGaXgpx7SsDjyw3BdDG0NwS1mFPzttthn?=
 =?us-ascii?Q?VWzqAzZnx5qH7+dlksN9ux/xDbiQ2lsa+yfJOx+G2Naf55CEJiEXt2WyfQuL?=
 =?us-ascii?Q?nIDttxTtzxrrTangy09St92fVZfqPyNpEA4ShrsloppVfQGmkFz5k60uxiim?=
 =?us-ascii?Q?3fy7k5OW2R+L4MIYHx2QtG27xrsy1R3DkmDYKY2y6Q7RUlg/F/p2A5FoxD1J?=
 =?us-ascii?Q?nGdDTWePWhcaM5L8MpFaV+kLy5s1CDhguTB+tF8BXlVtyMvGKcCTuLEioNwZ?=
 =?us-ascii?Q?0g6/qd7o+5MWOa3yXIBr0b+o78sU5Kbo4bkriDrI1mxlERxsZnYncYnlHimG?=
 =?us-ascii?Q?HdTreN5uNEIPIa3ihmV1KC35T5rgAB8GLwVagFuSr6D09CejQRewzY6MG9r+?=
 =?us-ascii?Q?YPG3NjL9m3DbQpknIjMef+w5UgLtHTIIYSSinpJbY3P7A7kGYCj+VCVG/eK+?=
 =?us-ascii?Q?5omYMysTq8APx9EM+aiqZgvecbZHl37W83fc2FmiZjD7UVTuLcNBcWfpJKH4?=
 =?us-ascii?Q?3/bkuwc7MJ0/9l8Qn04X3PeXDGya+KxvcZtQzuztjRFbIy1iG9B+y3kW0vbt?=
 =?us-ascii?Q?jn+KNZBA7V4JeMRZVA3K5cBHtOPjgIzLH9+QiusNasiB/xNziBw514QBjkzi?=
 =?us-ascii?Q?CZrItKmcfPUxt3Rqis1XJVTMUHLU+lQqXhOOGmjbxAsWy2dczshfIVRl5cEN?=
 =?us-ascii?Q?rIkyGzgzVcHwsxxSe/FKPHUUwFikjk8IR2zmImWqZpSqMOeGNfrreh3VoPmy?=
 =?us-ascii?Q?NHKDRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfb67f6-a25b-4391-5875-08d9e285e4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 17:44:54.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDzbUjN2iqLSMzYq71u8K0T+35OKGcBEOiMTYJ3W+mXTcXqpwl5LH8MNcxSw+CeMGsjbAq07lDPgoUtrDO42qKo9zMW3SL5FbcC7BNJAGjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB2108
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, January 26, 2022 8:=
11 AM
>=20
> In Hyper-V Isolation VM, swiotlb bnounce buffer size maybe 1G at most
> and there maybe no enough memory from 0 to 4G according to memory layout.
> Devices in Isolation VM can use memory above 4G as DMA memory. Set swiotl=
b_
> alloc_from_low_pages to false in Isolation VM.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 5a99f993e639..80a0423ac75d 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -343,6 +343,7 @@ static void __init ms_hyperv_init_platform(void)
>  		 * use swiotlb bounce buffer for dma transaction.
>  		 */
>  		swiotlb_force =3D SWIOTLB_FORCE;
> +		swiotlb_alloc_from_low_pages =3D false;
>  #endif
>  	}
>=20
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

