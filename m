Return-Path: <linux-hyperv+bounces-7823-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 731EBC879B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 01:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 225494E1506
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E414F112;
	Wed, 26 Nov 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LvwSktpG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021136.outbound.protection.outlook.com [40.93.194.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73E2AE8E;
	Wed, 26 Nov 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117613; cv=fail; b=YK63CT7GTQ9JBKbjz14yfSXMooDm/hYJTv0jrh+8eb/PDpX8RxmJ2lzePDuoLgJ6zpSeY8JMAUTHi13JI/xMKlRkSQ8FjockgfL3istFaAOgFKFsVu4Vh2tmBVCzH3sGe00UWoj84iQEtAm4I0rhG0rPF/sLtnZ9gOiq7/+hf0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117613; c=relaxed/simple;
	bh=Zs9M+/CUYuAYmSojjMBfK4E3W8R3touV/mKV/msh02k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQCphcEB75KZ7+9WJEV72q9IpKD8D2ti61vcqM24uqCJKUnPROjqaSOCvT0OluVVZygknZ03d2y+uD9t+Dlcj/lVQmwT8U5Vqdv1cvb3iV1B0wwg67bU7XoP7Swfae8J849ruVpZ+Z5wKvkNuac41srywxzgvfIhHpe0X/vYsi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LvwSktpG; arc=fail smtp.client-ip=40.93.194.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkL6psqZsfueQVPQmc8cNgb6l5bsyt7ZRK1I81ixgTKcrFo1RNMsNkQYZIIFH7+9WXBwsoRB3YfBT0UFw3JlIcN7xLl/alFiljF4iHsNQOvUeINN5Axkxr1cKR9k5jP2B91SYZrEpouhKx26nilL//AygV17QwzN/KidWN3cMpRnD77VJVgm9JIBlolVEFb657JTKnbHQJ9HcB3sWRp/izgVmPEMZrvY5KtPJ6LGhHqDUm3RpAY06kBeorLJrXlYjx33uHVPLToxcctkdMFDIzu+9nZucdiuKYi7Y+Zgq8nad8x38MpQIU9I6RihuYoqfiUrTPOjOKw9Sr1irOst9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB3eku3oW/44cQ0rNT44pMB5MchbnpR5vO/uv9wGly4=;
 b=oU7+WNF5/QafH3QuL6lzjNwOVgsWnVC69vwC+npEBerNSp3q07EaRuFMejGl0nbW+yC+VueNX2LrcOeBJ7cO+yrXxMbrlIfeYA4WEcqEhLckd9a1P4n3unZ/qwO6kRdbwrYsaHImaTLsg+Tiwom+aBgmDKzOFcbpqfpYXlWZu/7cyvZ0cwsjUatxum8Ssjag1u7sGg0GHqTdF/Z8mOXrpXaE7pEhNjB6+DKgi1JphmQTRzy8Djv73GX8EDjrHkfqJDj0NqF88rv1XR4g5a24oaBFWfKGEPZXDmI0PnwSoow4IKCEb2rlJtnbn5Y+Tlt+VAcK0jx27u6MM10yIBcBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB3eku3oW/44cQ0rNT44pMB5MchbnpR5vO/uv9wGly4=;
 b=LvwSktpGUE7ZD8aJWkELH22XFfjkS6j9kBgaIE95MONUfkKQ+Xwk0sp3PAMvX5OGIGMF7wjOCswlcaCnG/GV7gufLftkq1HLdvuSw/iJzICijdIFTvvETxOPvQRGPQraQ0lbc2F+ICjN/Va9O+I1iz+4z7ubDw7CyJXbQukHEao=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB6050.namprd21.prod.outlook.com (2603:10b6:8:2f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.3; Wed, 26 Nov
 2025 00:40:08 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%6]) with mapi id 15.20.9388.002; Wed, 26 Nov 2025
 00:40:08 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
 recovery events when probing the device
Thread-Topic: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
 recovery events when probing the device
Thread-Index: AQHcWnJxBK4mddwuFE6X/SkYC8/etrUDPf6AgADm1gA=
Date: Wed, 26 Nov 2025 00:40:08 +0000
Message-ID:
 <DS3PR21MB5735CC21A800623D2DB5D144CEDEA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1763680033-5835-1-git-send-email-longli@linux.microsoft.com>
 <aSWKLefd_mhycGDv@horms.kernel.org>
In-Reply-To: <aSWKLefd_mhycGDv@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06e6a858-a405-48d7-bf0a-c679db3963e3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-26T00:37:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB6050:EE_
x-ms-office365-filtering-correlation-id: 70f68844-de34-4907-7d3e-08de2c8459ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WLTN/xV+8yjj45cD74dIjd4o8WVIYzvLxEuKmu8wVYfYwUPLiyzvorulw+xF?=
 =?us-ascii?Q?+w0YmCqMK3QaSd5gJ0AYEFVxvmdIi2BCcHCe4TjdpIpKIehSjaVcmeM0Sm1y?=
 =?us-ascii?Q?6PJXePNYMvnGrck23Hf+ht6jsW1sUjZDSRtF9xownFv+y6N47ZiPJeL30RUM?=
 =?us-ascii?Q?Ji/lJJY34VNBU4PKJTjv9u+yJ+MLDzKNE77fmoUbOwkGHQjgF/BLGqxCdzbh?=
 =?us-ascii?Q?MLcejPIHpkoyOiE6SNCoHuLxRgkiP/Zi2WRbJN52IbSeN6LK8jnjiuWEx5jY?=
 =?us-ascii?Q?bPKqYyzDogpQZyp2aHEdCXksemhGPUurQD9+ErJ+a44wyIteXj8ljdXXV9WO?=
 =?us-ascii?Q?EGdld9LChjwhLlZfww+BoHqqSmiKoTbzQ4zUPAM5TQlXyQTi28e+k+kA0rVq?=
 =?us-ascii?Q?Km9cM/oF9T00dL1QGUsjPlFO7yOMChL43f+iiyUGHnP2LlPR2723ejKCVdnU?=
 =?us-ascii?Q?g8KL9BGOY5cQtgK4CivqIHeNYzmBhqL21FQ5mjVK2rTLStJlxyYHXW2dVw/n?=
 =?us-ascii?Q?i6lHsCWD9Sl5V17N8Yv4Buq1Oa6ffbc4JzPAORb4yAvWn+GsfjZFow4dsAUV?=
 =?us-ascii?Q?czGSJLDuVVprkXDRIPkw/z6K6eI0CLfUIDq8MxlJpskQr8JohNQTMtWgeWnc?=
 =?us-ascii?Q?VsJA5SFb+48PzgxMCSm7bLLGWkIgh7CrKw6RToTYiXbmE9+mpJcyt7w2CgLs?=
 =?us-ascii?Q?LHjCQOpJpKnxA/hmfTPmRlMcv5VF6BV2C07K0IdXBKq3h601vWHa9W4tOZVt?=
 =?us-ascii?Q?BcnT824lhoYVmehMNjwDaTXxcvmRTzUVCAURfv6jUFjeLB3utFcDdEDvbYNm?=
 =?us-ascii?Q?f4WTpkYNj8ibn0DCj3T5gZlGQdX+T3qSkSZHMoXufXgxZXhpgSPvfeWJnix5?=
 =?us-ascii?Q?tZrWv4K6WlnOGYE5WiKbjgaEGRaX1v25bPk2YFTrNFYCC0Ih3DDY155Mt7DZ?=
 =?us-ascii?Q?X6WqGb+2tQO/CfWmCUTcN3J0l4HD86Mf6hfsSkgPKgXAmor7zZyaz2KNu4Yv?=
 =?us-ascii?Q?o8DKkR/fvvp6vPp3aV/N8KLLQsY7OIZFNh6PXdp0mVdPSKERDeL6BRAjvhk3?=
 =?us-ascii?Q?nUpemb8B6XFwezaa9s1LQNnsTcO4PCmdo3dyVFWlV4zHN4LADDd8/3eeE5pS?=
 =?us-ascii?Q?iEEo5MU/adulWWYSKl/TmBQ2rgtmG3EqiQascZK+1dmnc+2brKNsTMFj8qdQ?=
 =?us-ascii?Q?fMuj0ihvgMPa94U+hVHvaJmZg4GFGtqMf6fK5rgl1hdL8Cg/332oYzmx9ds9?=
 =?us-ascii?Q?TWDwzGI1yrMIi+h8x5wTOn1ZT+NJVJhxgLRXnLcJes6gvkWNw/e9/rg9xCUu?=
 =?us-ascii?Q?ZbjC7hLoxAXAHI405T5xgn734JXb82GboxESMLtIKml2UWeqXTQVU3vzLfer?=
 =?us-ascii?Q?9RXDaJg7MV9ikMdHnXGY8VYBmw5ByDc25vJdFbK9aLG6JuhiBxVMPfwfykzQ?=
 =?us-ascii?Q?tF6n2V3fRHbKfgTFagISwiGcgmJUcT4yskBzdNLpw24c1ud0cnFvoA8j7V+l?=
 =?us-ascii?Q?m0Fyj1Rn6V4EfxceAO/7Mvu02qPBaiLk9tix?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j1P7s2CZwZWiT5/xBfb3tZM9/xcEGj1vuHMZ2t3Cci5NqXZY+AmvaBAzt8c3?=
 =?us-ascii?Q?tFJjW9RvaSIVcV+s7vumAEy6QozrzlAwsXqIp/CtIRx5j1B6oHHhOQDtnoOo?=
 =?us-ascii?Q?GZ0fBscxQaTFzGPfyITagJQVLpGYK7L71+06AEx6eM4d/YG5R0Ch3neo8WFr?=
 =?us-ascii?Q?SoM1kpxvcB94g2L7M43QD24wX+btvqd8iEOgJE9LcnOSyialqwWGiXi5aaWP?=
 =?us-ascii?Q?QY3r0CwrZU6V5nz2BX4yNnleeWtJZnitszE8UABlh1F7m/CC9LGaKBo+rrZM?=
 =?us-ascii?Q?2NBdTsqXUW7QXIdQdlEm5Eh9rHmrOQXgWbm6jATX9hkhJu3UVpCAGkFSK788?=
 =?us-ascii?Q?GCEluEHz/UDJ22B3zIp6LZowCMeaS2rCs4fIPMY41R0vZeFXfXDVD5O8jxpj?=
 =?us-ascii?Q?4KsFAPCCb44tVlNZvKJnH+wAo+WvdAPoDuiix5THsfDlhM7mh75hrxleih3f?=
 =?us-ascii?Q?lwHOpkB8AwAtatHb0fK7Wb5XuDY74Flh+PhJlWuED6j4p3s0QH0rISWJWDXd?=
 =?us-ascii?Q?tOeCLN/22LyM7ifTJf4nuNpJuXGsrP46Zcmlwz+7ycu0SDj3aUTrX+tv/mCE?=
 =?us-ascii?Q?0JLiXRFXGcNeleuZ5lzh79pIsW2rjECNuzvm1qd6rRotzvXEXlHSlDZucFQR?=
 =?us-ascii?Q?oKJlGHyB9fm2ce2rJO5zsq+dl9Sa8gaGCzbPZlO/2VCpWugUBj5VAozil5sc?=
 =?us-ascii?Q?nhaZoGHk2h6dWQUSaaO8dMSZPuTlzEWn5bgYiSYk0oJ2GGtK5hKNr7jYJfAO?=
 =?us-ascii?Q?MuaN9k9+3Ms5l9MIl7CKZoMjwCT30r12CX2zyhJvNrggDFWfEEiYL4GsMQj4?=
 =?us-ascii?Q?QcoPVlkB+Pz0/YCRzbtxL4IY+vH/O4SvtfnRn0Tj8QNnv7Ni2Vk4kx1JNl7a?=
 =?us-ascii?Q?zm4Cz40+6YRVuh3OKkrqef07vQGHoMNV6nVbTu8i9acF3WHcXlXOTOfqIRbo?=
 =?us-ascii?Q?FD5gYf+5xq+62M/D0o81SbMeLDgUSG+mR48b6qGnmu2jflDcltJpwcOtSpJJ?=
 =?us-ascii?Q?YgLyxigdwiWn4r9kCTxZUIhXhUumBS9qdxNxh14aZiH5EAJK8sPhOewzpfRi?=
 =?us-ascii?Q?FzlO7uqm42wKvjhF1wrbFVYvR5+xp0ufFH/VXacIzSd3Uu1PIEXzV6WcVMlL?=
 =?us-ascii?Q?K0IwN/fQkG2m0HdcGtQwKo9hioHFLOnbILBuklaW6fSa4nSglQ26uMs5Wh7L?=
 =?us-ascii?Q?kkC+ARjPl54iY4p5Zgtuk8o40su7XXRzFts53mzWcd/V23dlRyFGMdauTb3z?=
 =?us-ascii?Q?hRu3oV094sxuviU3yBsVoQT+5l6V6pAlvGh7R8PgSgRgLhF5vJCWy9S6YF7y?=
 =?us-ascii?Q?ARxYaWfyZzx5MAkbHbMNLeelBVs1nlkAmZaf/nmlr+T3BGjxyRBVHYLuqorm?=
 =?us-ascii?Q?mYHtqsJVA1MIKBZWySlQE07+7JP2G6aJZIsJiWrpPTeYlNn+Ft9LiSmnhMwb?=
 =?us-ascii?Q?/aAHCQdDhGA2O1KIH8N3tVObRmFCwPJ0HadJ1nFfkk/7KGWyaS9hlDlvg6/a?=
 =?us-ascii?Q?zusammxD51lN/LprHBJzhIW3ec6C+hySklFkBeCrrFM2jtAQyolrfFmsbrbC?=
 =?us-ascii?Q?tWofoXewlJfaMRt13fQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f68844-de34-4907-7d3e-08de2c8459ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 00:40:08.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeShuBG6YI60glGp4sxIB+0ZSQ2cONu5BG45CjJmE3qjkH2+oLjmvTUx/7sPFOKctSInbSg/MuZ80VZ6Zm5I8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6050

> Subject: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
> recovery events when probing the device
>=20
> On Thu, Nov 20, 2025 at 03:07:13PM -0800, longli@linux.microsoft.com
> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When MANA is being probed, it's possible that hardware is in recovery
> > mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC
> in the
> > middle of the probe. Detect such condition and go through the recovery
> > service procedure.
> >
> > Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
>=20
> If this is a fix, should it be targeted at net rather than net-next?
>=20
> Alternatively, if it is not a fix for net, then I suggest dropping the Fi=
xes tag and
> adding something about commit fbe346ce9d62 ("net: mana:
> Handle Reset Request from MANA NIC") to the patch description, above the
> tags (with a blank line in between).

Can we keep the "Fixes" tag and queue the patch to net-next?

There are other MANA patches pending in net-next and they will conflict wit=
h each other when merging.

Thank you,
Long

>=20
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> > Changes
> > v2: Use a list for handling multiple devices.
> >     Use disable_delayed_work_sync() on driver exit.
> >     Replace atomic_t with flags to detect if interrupt happens before
> > probe finishes
> >
> > v3: Rebase to latest net-next. Change list_for_each_entry_safe() to
> while(!list_empty()).
>=20
> Code changes look good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


