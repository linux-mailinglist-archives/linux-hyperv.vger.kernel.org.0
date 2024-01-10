Return-Path: <linux-hyperv+bounces-1403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FE829333
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 06:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C51C24113
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 05:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813FD50F;
	Wed, 10 Jan 2024 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gs2QXTZh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2069.outbound.protection.outlook.com [40.92.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C248BF7;
	Wed, 10 Jan 2024 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhZVl+42G+hrIne6JN+doHda4swuk8FnJNviJnbHgtzfpDAMDhZ1WNYRqc8cuUg6vwRxP++1zD0i5ZWQtBcTINKgF9zC8uQx3x3CpFtkRYogMfvJK2FjihZrJ+TC9KjB8RNdsEO9tECL28x20q739vHgNOqW9u3DRMWo+qs+kOCOB1eq6tCU2GK59UzMCARWo7DjpNsR5UUmsmtvzbxAPFWwqqJW7vcESO/ayP7tlbGi+65GCUbhFXxz3PBvTvX0ZTPhlIBuuVWtEGz7UndcvulD9L+xOyA7HGx84BNYJeLpOucjkNg19t3J/AST2AzXVBe1hK53SU+91hlS7qTJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiHhL2gkfLyNkU7NsrfzXauhRJs+V//SwRXlXKOlRbg=;
 b=PwV1Rov1PZDf9uBP2iNNZ0pI+olZeIvmR+AJOMy2AfB4w9dAJxO2PiXI79CemtRdbYWJf9Rgf3/TsBaHb5vCcUcA8KQEmHMIGT8MgQPp07Tz800qx4flTiqDMJiNDeOqV6tfT+p0Fwx3XAgsG9p+tQgSlBrR1zJ8LShroaFa7SmXeSoWdjUvKA44SFGFDJ0nX8Yf5YygDCb2VmaE6aHFSdysVXuWRLjbLvsegie2HjKECN9fsTcWfJ8eYoOEn9L8GwUQ+nqrly2q1PSb3c25yJ2+I6g+6k/W3SscQLVaGWnfUuFavNZ4gxyyccM5XqWQGnaAKz8lpRMSm+Sl7+ZU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiHhL2gkfLyNkU7NsrfzXauhRJs+V//SwRXlXKOlRbg=;
 b=gs2QXTZhup5fr3LXaSWTGlZvNTr6cr8x0RAdX5JDe2u4Py4MVrgUVhK/ZpZ0CwFbCEyowY3eic2R6Fl6T488CEP/Xh3YhF776byDWErwflF2z7gvZMkT86tWKdzr+k5aU7rgQThnOj0hZEttv8OIbNEpK+N4otZctx4dQ9fihR5Jx897pMtHSYZjo2xDv7L6KiDc54RQSZHztk3HEt4in3IdvuCcFPLwPs+ZrvCRQBj2EeQ5stTUWIzDIzJ1Lywnq/XyaOlXpBmlIxEcuY3MQu6Dm6CBf6RELDXJLGw9aMZR/T2T/NlHaJT1K4WkEE9BANn51828yst4UqRYuxhZxg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8561.namprd02.prod.outlook.com (2603:10b6:a03:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 05:10:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 05:10:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Thread-Topic: [PATCH] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Thread-Index: AQHaP8IdXpQMxQOq3EyxPvaEs1hvhLDShPQw
Date: Wed, 10 Jan 2024 05:10:47 +0000
Message-ID:
 <SN6PR02MB415740C3EE66618A37A658EED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1704450566-26576-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1704450566-26576-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [loTHMp+r8FO1u8f5sJjv1UX6ByBgMifN]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8561:EE_
x-ms-office365-filtering-correlation-id: 0a657a98-8c20-4444-36ba-08dc119a8191
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0ZKTpQ1ggf6IPbMRC5XB2EkNBH7kf5unkKpNT3Q2XB0uewrCROmtOgNd6n0KjSYSrjn+vynIGOO8uc1WIsI/n4Yo4Z2DfHOsyClj2W/rXWuRRRicyFYb1IBlIpVqxHqYFGIgLYBOCZI8Fx8fqEJlxogJUDKVdKsmJt3THaPgnVLvX8LY31g1tYHcdx5+mYx3aBHWRQ0t6n5silx+4chRsl1yD6HjNG4z1nTegPOKsjm5EHc0bEtK27lb1OZTmCxI4I6OX+39zsGzB4WdYJf/YnMbpbDe3+7Y26AWl4cFzPopRMwiW05Vrb/i99Lo0ayNCNTsNOHMlGvStNBzNcD/p79X2NEMh9JUXKwuZI3zoSh6EXEn0A7sktpAEXBEYj4/NxlYYOcm2HQ8x0yN6xXRjAARlTHo5caCrts/CIGbd78+xQBHLw4bdqf6gWO7d/nVHwWHvv9DuY95s+153UGUzlSdOBRDnxOYyaLaUihnYzSY1+wQMWk+OLv3TOz9ERUUn6025xqWhfQG4HZ7L1PDOjSTVa0KLQhY9dOPehQK3h+srHdeQiPpGAgIpKZ6OiaH
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IbBcD6h6n3KKoKUkJlggI6+A49YsfwfjXZNnoiETaYjcL0k18xyt7QCatXuO?=
 =?us-ascii?Q?1GtZNXRmDmkf4W562/EJNPCzVTmHCUeGQV1u/gZc/D6c4OnBIKU2/kl0ud2E?=
 =?us-ascii?Q?zJvuKF3IgEdG7f0G3fUOChs6WLt8tFWYebnoNqRZpLXXb2LadX0RLsnsIV6u?=
 =?us-ascii?Q?ET7SfQVHUkqpIiz0sNXGyjDMUlBZgrPFLyVI0EDBJFAGuToydgggXkExzUcz?=
 =?us-ascii?Q?rnLG8Y++8lol2Xo1ly4CVx/O9XPOdPZpCM5WOIh79q8I1E0qHIfrnbLCkrDj?=
 =?us-ascii?Q?DV4Zci8PGBGmLF1sFXum2IPz3tuV3QjW5JzNPCfjH3B7hDyzj0I24yQty8Nv?=
 =?us-ascii?Q?Dmu6yHGw6LneWAWZBAcggFiEQLY70Mdmtx5YLps4MoUszWGWgq2HpJbhigME?=
 =?us-ascii?Q?E5EW7fA5shaheC/5h4u4sC2K3UINlj9PYikl/bYnv7ZRW+V1DxFmXDRNfIl0?=
 =?us-ascii?Q?X3d5fw7CIKX/hIQ1K3PdozFRCuEdCpy1Rgm22CLqkGXT9wFO0mUK19wtsocX?=
 =?us-ascii?Q?opZa2Ha6ztltj1lkO+vFZY9Re73EeHq097t+D5Pky3kQ49IgB89YzOkGqlc1?=
 =?us-ascii?Q?Li07sBQoDRTEa4Kc3ttNey2jsvA7XphX/smTTqQyRGtqH4nn891Y6kZbd6sJ?=
 =?us-ascii?Q?b45Cndpjo/H9HCmYPdxTQW0Ohpu56HlyO+JQyLV8t5VzwOKyXren1OIpgH9E?=
 =?us-ascii?Q?5cw4QZlpdR6W7+qFl5YUT+AmN8Vk1+Lw3tiDbO6f224tIpZuWjhEvCkz/0U5?=
 =?us-ascii?Q?5nwZnrSBBFFutOuTMDQ7/gxagWkaFi6KrkvwDFqROxC1nSUiXT35ZobNsw2v?=
 =?us-ascii?Q?/fvkKkO7Ji+Hk+FuUKmRSk7+i0oTYjEMro15CxWD7wwFIxKZH+oCyTQW6xpx?=
 =?us-ascii?Q?6LAv8vSbxWsQ6c9q7xfF5VRZUxTdoYE4wNmntGT7HjopqQIJdDWqEeHC0p4B?=
 =?us-ascii?Q?dtf+dKLGoL3684dWYqk2kBQx600O8Gwp7omUw8d4OObvPPuOYH68VODfdlG2?=
 =?us-ascii?Q?LjLyIzg+h7ls1cwnFqKy6TeFSi1GE/GQWvgZFJe4peczI4+6R9nHgHW5uV78?=
 =?us-ascii?Q?uq8t6pslPo0TVT2V+6+xEvDxG1rdp2BXQ3vdCiQJ0/mL5/loDO30/eNvR2rO?=
 =?us-ascii?Q?L8vdBDtvRQKXO0Eovq/PS1FdB34JSDITy4TciI30kz45iZkl1D+yb6w5EcSa?=
 =?us-ascii?Q?OBDNdUpOgz3hQ5y0F19o1QdCEH+deWDNfe8BDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a657a98-8c20-4444-36ba-08dc119a8191
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:10:47.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8561

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, January 5,=
 2024 2:29 AM
>=20
> The current method for signaling the compatibility of a Hyper-V host
> with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
> However, for higher VTLs, this leaf is not reported, due to the absence
> of an IO-APIC.
>=20
> As an alternative, assume that when running at a high VTL, the host
> supports 15-bit APIC IDs. This assumption is now deemed safe, as no
> architectural MSIs are employed at higher VTLs.

I'm trying to fully understand this last sentence.  It has the words
"now" and "deemed" as qualifiers.  Can you say anything more about
why "now" (implying it wasn't safe at some point in the past)?
And what are the implications of "deemed"?  Or are both just
wordiness, and it would be just as good to say "This assumption is safe,
as Hyper-V does not employ any architectural MSIs at higher VTLs." ?

The code LGTM.

Michael

>=20
> This unblocks startup of VTL2 environments with more than 256 CPUs.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 539c7b5cfa2b..1c225362f88e 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -16,6 +16,11 @@
>  extern struct boot_params boot_params;
>  static struct real_mode_header hv_vtl_real_mode_header;
>=20
> +static bool __init hv_vtl_msi_ext_dest_id(void)
> +{
> +	return true;
> +}
> +
>  void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> @@ -39,6 +44,8 @@ void __init hv_vtl_init_platform(void)
>  	x86_platform.legacy.warm_reset =3D 0;
>  	x86_platform.legacy.reserve_bios_regions =3D 0;
>  	x86_platform.legacy.devices.pnpbios =3D 0;
> +
> +	x86_init.hyper.msi_ext_dest_id =3D hv_vtl_msi_ext_dest_id;
>  }
>=20
>  static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
> --
> 2.25.1
>=20


