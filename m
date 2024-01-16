Return-Path: <linux-hyperv+bounces-1444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8882F17A
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DEF1F21EA3
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CBB1C692;
	Tue, 16 Jan 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rOJJp+wY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2043.outbound.protection.outlook.com [40.92.42.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19361C69E;
	Tue, 16 Jan 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUDFUTQrn4bih4K0ge7Hf2VaGuAsHFCK9KLBfjGN5d+NxHmV34M+BSdUe3BtCd4X7Ook6YwwiAOzQu5rWHqun38LUb+/Kca5n8pmhmJTne+1vEVAHZJ2vaV3CvBVPEjEo0o7HcMw68JW4gvFkRbDeQLsm4LwTT7GozfCXvAVchtQ55l0zx56hLsuUlDxLWR4HUmthh3LKln6tgPvOzVjg34+LbimjFBrl0UJAUm5c8J6qreli8Z34z7T4Y13JegmSudMNYdCZJrDWka2Z+7t44zpGho3BUoqbX6lfOGH9syYTDZAZyp+JEEIh75DvvK4APeXHRICP0TNAol6jAAbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMcYAHQnV7aMT5t2KvEhsmslqIhXqzVMNT+/UUPWlOU=;
 b=XIBAB6PWERqxOirihOh0jaCN+72OcMBk202oUReEsSz4i8LevsECBrey5HPBrdKpffR7ypDYwBoRLjTMn7CkaKfdHx+ulCD/XbsZ4ErKmPNuo4RuHx07tF6AR91mqawjLkvMjrvibtMkcdNY1K0lfCJ2Uv1lwcXQUVL2/pMwIMrduBR2D1+FGQuxfRA8qajBTV4uCtv47DcTuYrlOdUan6FCIZfU3JFOQIUUXsu0DOd01VfeW2FdiRONYpyyjgw07rnfAcq+gAYdA5N8A+9E83KUpvbpv4ZmNuiSVrLQQcwIbC11MGBhPMzsh7MwrXyJTooVt5jWURQvuMVdJlQxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMcYAHQnV7aMT5t2KvEhsmslqIhXqzVMNT+/UUPWlOU=;
 b=rOJJp+wYrj6RbTC4x7d+Wn/AkOWDM0WAys9NK9ZgZcHn7+U4h2IRVvAJALnMMgrHuHZBz6RmXMjTG0FMmqUbsS2FXZyHd09FT4H34WsqD5fw9NLVdJ4asXSQFozm7100072nHFfR6VpfsmrZuTVTP5Wqc2cKJwUF3O4QK2kZOPkx5kd4cVxmNwTPTae+Tfa/VD955RWC0Th54BAiibALk8tRreTwbSs+kWOCAROCm2pHH1EG6k6LetlIHUw8/10e8uhXOqYRaJZ4hS4mdcdKLKrof3eSb9nBc6i7a9T7FAli30nch1QnWBAeaxyMWjcCYcL720L8ZDQKsmdmVwxCQw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9680.namprd02.prod.outlook.com (2603:10b6:208:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 15:25:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 15:25:48 +0000
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
Subject: RE: [PATCH v2] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Thread-Topic: [PATCH v2] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Thread-Index: AQHaR9x4xt+MPOiOn0agJrT81o7awLDckJpQ
Date: Tue, 16 Jan 2024 15:25:47 +0000
Message-ID:
 <SN6PR02MB4157732B9E1A0D4F209DD5B6D4732@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [amXqdJ4gTV7niHa6ixT1PCX9aeJm2EVG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9680:EE_
x-ms-office365-filtering-correlation-id: 4c4907c3-d7ab-4c52-d3b7-08dc16a76a4b
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmoPyh9MsvtGyMu5EJBVKrwxRTk+q2WU6B9D4Xu6WqUvUO92Kr2u8jNoDVgd6k4c5cvUyEMWb/9WsyAnbZAiVD8IYaSzlt18czLnyZP0U7RTeIqNFDA9xLSvQ+YfAxfQVhV8TMg/bggvyt5LJL+FVHsiK1R7yDoP9C8o4zqig/BLXqtj1vmXE01VdSNfMGssWHOpwSZfunHtbC8Bk5i8lTx7YDhJ4qsD6EjJ0CCH5BEYa7cCQi5Uu9pUkA3OoWWMpxeie/yUt+zxq/1LEevoh381tw10OWbUxo/XlNcjYBuEJKWdwbCZuinl/eFBVRUvmSuApCVXHxaf36LDn/UeTAN/5NhQ4c5GsQoZF2d4T8NVYEuJLWr0yPklrFGvxs/jvEcAdSVPd/8p1y9ziWSrIuZ/vfCzMXvE72iYa8tQ9DKsyxWtaLWFUIIhJCQpTZ/M626DiLlnqgksr+MAp0GzponPSxZHsgzd0+aGI1cRjzmpXwgWTfMsGofIRcoIXS4y7D7JlwG8EhqN87KOTFCcA4Fo31abvW3Id/JOxDmKU488eiO6qRiqxiYgxgOIF3VDFNQ+BQEFLd+ZBHOvBtjAj2+V23KjkqicJ2VsRBNnYQWzBm4TijkJIkWy3JDW+8XF/tSJ2YnsltKmQQWyntNJM0BCWwbDYZ6ZqUS4O46A061qte7bfYDyjrkchvm2urLF8ln0YZEEOsR0kGKmt33he4pdOFzMVUbbyeoVFgiDlgi+Tm0dj5zfr5465bwGxMa2KlE=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CgKMKXZbNLmazZfvb/1EOZ2beSXRTzCJPhUnFcPZsoDFkhqiLrYfwZPliQOthGawHd47P7QvjSgiPeSbQU2xkSGidjzp43HGuvM61IFB3Tm9HLRgkQMfoGJnfxoHijmWVPt5CqaIGjyncVcHN/79XqUGd+6UfTxJYaClEcvngmSNGVCrgSaRqzH7UmcwOpfeWC4baSQS63BvPNWh7CA66d0LfPo++XhysLz9DJIBKFh0sKBqZhXzstnJG0rIdxT9iNoR1EVoVVSnOoDjJvf6cCChAQbNA/A0U6cZ7nqHwxmKz6KxeqUga0ztqkD9FYzTufEEdc4ih06NKy8D2s8PggoxnZ356YlUoaA8mEpKg9XxL6+lFg1sC+4W2FFH6IwjHf3/Ym0NcPYuTQQ9zSwM8Ftb2AJXMzaqAQC7won+lOmUzc1SaO6jlPZ8Nb1Oe3t25VatKfo6i5dhuIlH7Th3EC/0G7fxEnOrGMwTUvYgyehbSD+MA0nlf/WnPhUvXbGHGpbh0+Ecr+i0IGN4IGJBnH8i33gMONfDFvbyirZsKnMXkHhUaE5W+X6TgupFjlv1
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YzLPz9XbsnrGkX+drsCqLODu1IC0FEJaFgrlYimb/KTGWBhPLn8oUtO374V4?=
 =?us-ascii?Q?hujTwnk6Ly6FWYSVZ1HMuf/m8g02gYiOq9hYWHQhPe+4tOaacvsm9ak94Ppa?=
 =?us-ascii?Q?m33rJE6Wh5xpq2S5xyaVtFisZ7u1TMWaQK8ir0TiFoWrhww5xVLFUumeZpTh?=
 =?us-ascii?Q?dA1a9DH3yy9A7hZ6SmGWI6UUUWAm0T8oAPsVNLKMp9/XZsyJx9NG+lsroWqp?=
 =?us-ascii?Q?4bhwk1EtZTYXkQBkELaavI+l/nChsFA0XfY1NcSy/F/iTB0RDTEUYXYh4CmT?=
 =?us-ascii?Q?BfY7jCGwdS5HSeRa+xXEM8AtBEHrxRu+Rh2E8Z3HP0FBAw2LUbYK3o9QIxYG?=
 =?us-ascii?Q?3aXhhpVe1JPOaH5dYcdNEg1kLgIMWZNJWv9GijBwzP+ocfbKD9uAZz2ah++I?=
 =?us-ascii?Q?bxrVO+VDM/nu7SJumpiaurN0l8KMCTMo1OvFBIsri9SolmAjqJzURSVI3Pql?=
 =?us-ascii?Q?C4qrKVer7NEoTxbwvUWKblZIneS9b4yuif5XKM1/xZDsHy3tTxKMJ2cgqyUw?=
 =?us-ascii?Q?eSCQxnf+ZqQmjNjPzZo2qa8ryoAxXv3meNLZPsWiP36TPjBjqJSjsTe9908/?=
 =?us-ascii?Q?18yFrjOUVY8vnBOcxhbHWIkBolwMDvr2ywXUtT/P2Wkz3ixiof61AGcc3YZK?=
 =?us-ascii?Q?f5GZDlQwY58efwXhIIqlQirv75kW0L4WO2p6mCXsu9tc59mWr3I7sTMWvtRm?=
 =?us-ascii?Q?MqCGg1SVXQqNZb1vUERw09eMMfMldd036NsmWxghJtZJ4XlcjNsvBSrjxKA7?=
 =?us-ascii?Q?25PdG9PDNx7dk1NdOW7E5Wj57Cv5LobHdREpdiiCINg+m5OVnLpz7TqHs98G?=
 =?us-ascii?Q?JsVuYbeE915/0Y9OMaJzuaF89Sw9Gzgc+OznlyBM+5leNd2aZ+9FCghGzJAp?=
 =?us-ascii?Q?yY3Ln4Z8iWAUjNzixCbxX4tiYTJw+1E/v64E71i+Gt7Ld63/U9DDnQj4Ml9B?=
 =?us-ascii?Q?o2Txq9md4Duzev4SlUXWKqqM9HSU/QSYmqgolvDdhAKQjp5nwuMK4MlRO5Ea?=
 =?us-ascii?Q?Qx7/AJZjbh4ux0SEM3t7cT+w2KMB9zHs9y06/H6vYm6i4yKDzeHHf/d68OSY?=
 =?us-ascii?Q?/Vmkuf44yICBnr7e6WuFapJrkVFy66YHP+cdBYXwnRNV3tBscssLpwqZQ3/a?=
 =?us-ascii?Q?G/Hb/Qp+y4Z16keHmem8UiGmwp3neUup8sHKE7yBR7Rs8j/nfC9cuQkzSmmV?=
 =?us-ascii?Q?NwOQq9GehODmsGxM/wr/M0/J86iCbClLUPH/9g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4907c3-d7ab-4c52-d3b7-08dc16a76a4b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 15:25:47.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9680

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, January 15=
, 2024 9:58 AM
>=20
> The current method for signaling the compatibility of a Hyper-V host
> with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
> However, for higher VTLs, this leaf is not reported, due to the absence
> of an IO-APIC.
>=20
> As an alternative, assume that when running at a high VTL, the host
> supports 15-bit APIC IDs. This assumption is safe, as Hyper-V does not
> employ any architectural MSIs at higher VTLs
>=20
> This unblocks startup of VTL2 environments with more than 256 CPUs.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
>  - Modify commit message
>=20
>  arch/x86/hyperv/hv_vtl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 96e6c51..cf1b78c 100644
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
> @@ -38,6 +43,8 @@ void __init hv_vtl_init_platform(void)
>  	x86_platform.legacy.warm_reset =3D 0;
>  	x86_platform.legacy.reserve_bios_regions =3D 0;
>  	x86_platform.legacy.devices.pnpbios =3D 0;
> +
> +	x86_init.hyper.msi_ext_dest_id =3D hv_vtl_msi_ext_dest_id;
>  }
>=20
>  static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
> --
> 1.8.3.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


