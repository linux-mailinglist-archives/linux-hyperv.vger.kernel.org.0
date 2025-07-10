Return-Path: <linux-hyperv+bounces-6183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B229B00D1A
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B523B3E0B
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8A22FD883;
	Thu, 10 Jul 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YYNSOPBK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736842FCE11;
	Thu, 10 Jul 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179305; cv=fail; b=Mwm4v45hlnpGp1fLsDBOVFsPJT6r2xPMfAVAAdTX+kamLf7ulg1Q5h9xCETHZojwxOYYRVdhsMECYsN3tV0MPEpOmBxTuqdwzCa0D2LVU8EcasjOC8qWq3jUwOAbKf/JLVfSC2xwKhbWkCPA7BV0iJGPpmGmZ4gZXSu96ipkkhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179305; c=relaxed/simple;
	bh=ZEBj19Wwok2Lfugctxh+bFPvKc4ObYU3QLTX+i1I6UU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mePZ0xpGRysE8Xl9J4V+lW9hMcEnA+Da3Un1Ixc0y2zMmhmPFg1qO42i0tVxhK9z1dt/3Td2ufJ2SN3oUE6gxVWpAyTPc1udvSEXJL32nYrNODF2OS7hBOn1j8iNrDv0XwQZnkG0Wgnmz5VnkG5pFsmg0wQU9U1tqQ/kcggU4Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YYNSOPBK; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPOzeIClBfuHiUVtR0ITt6rshqhRLYuNkkvJWqc9ZC5ppBO9ZAvnZ53mrmOFIJH7V1UmJdVPSKZKdCDDjR8A9H55UipgSq/9f7oqcsDE8kvDwYpm4WKiylXaQPIZkPfnvBDXv0WFHCoKec8QPATHhEIJApVsKWdCOdxq1gNu8RLGxYf2GznoE/WFL3NE2eWvjaiNfbEwIeF/IpPnJzcYDT6ng4S3FWCi/z6YI4nPM/aoo0rp4WSR6nOQUm8/5qcyslYjtSniL3s5/t9GKFF7yed6UHOtGJXhi8eROyAk7xh4PylEl9clmojsD/3RHPjs0By6rYNDAyIH5cZo+OoBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwuVLz+DnivkdARmbd3f6bPHtGZwPKeFWIrctMzF5a4=;
 b=xlLs4r/lGCJ6sun4jgc80wxUxKihjJemrNkLIeNfwwPXRaExHLHiYVK7/pP7JcB9vvlzYJcMrvbzpQy7l0PFYKdtL33SuOJxCDcPsiHHBoBqUHudy3FPc+O/BUPqUXRaMaPxc8YbKHzW66jLaoRJ9rOQXj1ldJlQQoQwiDCVpmurIoH+r0yTyXEoxqYA3OWWitPP5SumGLTCbMboKq9GkQAvqgit3OB+ba2QPmRLTjGSZ4UY4XwSOlSzQwrjYSwtQ+ZTH+5WLfd0J1w3eUqgo2lTX5eiUcdYBlu/Wd05XtjUSbTp0eRQFB9b6p9xvDhjWAIpp+MCEYmuoZ4F0kG65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwuVLz+DnivkdARmbd3f6bPHtGZwPKeFWIrctMzF5a4=;
 b=YYNSOPBKuiIZNENV/KD4w5aXAbQfmMUbcBytV8we6QfLHsxHgtWKmgzuKgC7HcC7Yl+jRtUYGlhpS9jYUqSjWPioZ3PEDXLuawJUKpCSe3BxUeLhtIAeEBuVPlElyh/674iZlMJ8lGUFaAbs3eHS66N70hPRajhd8mIAx+sssM4=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by LV8PR21MB4109.namprd21.prod.outlook.com (2603:10b6:408:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.6; Thu, 10 Jul
 2025 20:28:20 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8922.017; Thu, 10 Jul 2025
 20:28:20 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Li Tian <litian@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Long Li
	<longli@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open  to prevent IPv6 addrconf
Thread-Topic: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open  to prevent IPv6 addrconf
Thread-Index: AQHb8UTQKz28xLpGTUyYQJQOnUq/tbQrzMdggAACgcA=
Date: Thu, 10 Jul 2025 20:28:20 +0000
Message-ID:
 <SN6PR2101MB094312939B1F3236FF099168CA48A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <20250710024603.10162-1-litian@redhat.com>
 <SN6PR2101MB09432681A39CCFACE2689BEBCA48A@SN6PR2101MB0943.namprd21.prod.outlook.com>
In-Reply-To:
 <SN6PR2101MB09432681A39CCFACE2689BEBCA48A@SN6PR2101MB0943.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f05b6ecc-ec16-4fac-a54a-05d73bdcf483;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T20:17:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|LV8PR21MB4109:EE_
x-ms-office365-filtering-correlation-id: 97c53b9e-6022-4fcb-27e8-08ddbff04f9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NUVki7EPumUE53Jj1b7xqZ9m6DiS6wQYvCqgs36G6zfLki8VNpfIftKLC2/v?=
 =?us-ascii?Q?OJmYnz6QXDV5VZaHJfOGQCnLWCKahTMrsjtVS6K4hrwz5eTXGoRLy6c7i5S6?=
 =?us-ascii?Q?Wyx34uaFzghbdxmUeCYbEoeR/gooKltNybHZGS/jIIjnapm6YdOEB8tRXWQv?=
 =?us-ascii?Q?nBtjfzPjwzI0/+eBSMuP6c5mKkcn8qafoBVAij7UoIzNsCGXaAuJ0tbzybx+?=
 =?us-ascii?Q?yTMIO+mvOsFdXAUq8lw7om+AjeFsUM2WCXGeVWatWj7vWyD5yB9XsFDdHOms?=
 =?us-ascii?Q?MLvPO/3b63SV0a7k1F0KTJlu3QfHzx+UryrKbDEhM0X7M+6i1nLzvTl8dMss?=
 =?us-ascii?Q?PJVG0SK+HM0/V8IaVdcl4KmB7i0ohTbnL+7b8fF2EMw29YmyXhU6MjHZpswa?=
 =?us-ascii?Q?Jj2hdVT/twCc3IW8om650g4bvugpSuVMW2/wbkb0KkKLuyZZZiNaHn66o0yr?=
 =?us-ascii?Q?SkTg/v42iBe5YBKm4nEnsOw2d305z26ssfhoUBZYYUchxTqVvqPzBeJ73Ayl?=
 =?us-ascii?Q?H9NtSPP4TYA+0wxTC2z0uLYmVD8pbsuc+R/ZSQasL8MSTOG03mLxxJo5h3s9?=
 =?us-ascii?Q?O9R2JwpOfcdEu40q+DNXCZrh7OOcfFlAALA3hQ7hZl+7trP54jEDWnT6o4bt?=
 =?us-ascii?Q?U05HZyQotfjmYp59Yo/Rl5i1YLGeFXUme2uq7pEmYQj/BsTTNOiBZziazsR4?=
 =?us-ascii?Q?qbAQdjJJHwSrlirUxvblyj3uzMaCGT/nPxm/N610z15cxJiI+W8MhF9B6qQx?=
 =?us-ascii?Q?VoiaqLh4R+r1mctJAwM0M5gkEOfUZYaLGAMcETeaJc44Sl4Ol8cLo3/6EgKP?=
 =?us-ascii?Q?+4jQebTv2Dp+6FNbBl6XDhArGs6kUlSMRefnmJJ9NujObmu3MXWo3ihPNjFU?=
 =?us-ascii?Q?D7+MMxg/KAamijN1YtOGJCfkxK0PjD345rNSoDdteCmeQzBOpe5ScX8bupy3?=
 =?us-ascii?Q?o0fpuxte5aVjS5XjfFJV8iHMTeaNVs/y0AiNkjK+9VFAFxiyaMCtPiyH9Oc6?=
 =?us-ascii?Q?odNk58zwqIWVUdOhD9NU6SQIrJr1FTv2QQQuEv5ccNQxxwSmd09rrnZu1T9P?=
 =?us-ascii?Q?hf2Zk/38UBJh4LJHLzhovDDz1DvxhKrbapHStJcJLDfz+/bd6mpmQExR4aHR?=
 =?us-ascii?Q?ox11a5RwVLSEmy7KgIW3ngoyccqsZt7ZnwUYCMH1Pb1uzUn0DJrh38Mb5r/k?=
 =?us-ascii?Q?xsDZgyAm27HKvSccCD2+erX9z4Y43Qkd4rvrh689yoeoYWoodXM1PS7OADqN?=
 =?us-ascii?Q?K+msUGugp2u/cK+SB/LusMT0xmYHdzuJImEcDiv0snTq6IA9GhOyLKbVp976?=
 =?us-ascii?Q?ZzI2NsNJ9r5YNNaoZdjfEFJ34IROpYSieWLQx/psZp9uLu5HG9XlCiwuTifI?=
 =?us-ascii?Q?s7CKa/JslIVFZdVh6oTd/ePwJ0BEvzv2eMlwzg8dyHrMiAe9kq1384LTUCEo?=
 =?us-ascii?Q?A0fXndjDEmb+KOtLWMmwzwqeTzzPDVn3oPDNa+kyCxNLSGrFLo6k7bU1jUG2?=
 =?us-ascii?Q?WYUSkmLosYA7Gpk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sZ6rHejO2/NnVdeKUzAIipk6/fUAsRAnDfKD/3EXQTCl3dIjN+V9k47d3jGP?=
 =?us-ascii?Q?8Bjw6kdI62IZ2a/mQ+GJGoJUuTYFi1BE6DY5ta0m+gthvMZriCMU7H8Eh8jt?=
 =?us-ascii?Q?LLIcdvAsOru8Q3W3FwCkqz+w5jmT2pnxIneEaCIQEmIJMvoBf3mbZkM/7b+p?=
 =?us-ascii?Q?wi5Dp7jyob7mKwBzSQCWaTNd8KmeRMyaRlG21f6+/ud03F2qE2OtxSrEJ0EU?=
 =?us-ascii?Q?qU18jy0X4/JOxkcM9qGduhhjUdZXLUNTEsPRLm6o5qPf3v/jPIsWj+WMzwDB?=
 =?us-ascii?Q?//SEaijjP6lwfEw4daoIMOYF2Wli2ENLTiYqSbHq6e+ioJHMiN5TrpJmGCQu?=
 =?us-ascii?Q?b0IDb4vfGRQZCXnxUHm0mzkoJKIBWzDovdWZYXMVRGyzljDg3GBYj28piRF5?=
 =?us-ascii?Q?XTt7ugTsMpU6p4VUc9R8sGwHzBMteLHCi5Bwiqmzq8yaH+DCcYtRBwyLvq4/?=
 =?us-ascii?Q?ceBZ/oZbSbHpocMmdqaM8rvsClFvVUjXA1jo7ja7Jf3PRN9aFulp38I8YaSR?=
 =?us-ascii?Q?sIgkZZ0mRHAttV78v0+uHqXbCbkebqxLXz75bJkmkG/sqRKcNkEDBWKNILRb?=
 =?us-ascii?Q?CZxazxIrM1XCXBd+3L/mDTMnSoeprsVhxuf+ihy1eobdc3l77se6KhQuH5Da?=
 =?us-ascii?Q?k8fIFBnM6qqZHQmJvpZ0FMhXCYGFG7b6k9BJM92/xkrAZfLopN7fOo8tG/RQ?=
 =?us-ascii?Q?5Fh9vddI3/n0RZF+Vo8v2QVuzLOTNWFKDkU5TbegHNYwRdzreGG/knB2gJ+b?=
 =?us-ascii?Q?cW5EPzPNOaPBvuIUe1TDcpqq33tpjKjwCz7gAK/iWw3qyRZ+xrKUnbciFuIh?=
 =?us-ascii?Q?5RMPHF08irfub0Jlsaa/bJASEIEvbRqpDvYkmmrb4eSADSvnAlSGmMsrIuYA?=
 =?us-ascii?Q?avc4dGx7DN7BVnEa7doiGHPGK/cXPfscN75b83BlxDN9h5+FiCKIaBE/QCJe?=
 =?us-ascii?Q?CxsYvVrKK3AF20cTXF/HTs4hkNxrKUfO1Tln8eHbureWqrhO9l4q1js8RMaR?=
 =?us-ascii?Q?vlNVEBRoEgmxcxSGfAwjxX2sRyAvdQBfhTXMps8ojDzwu6bBR25SNLh0ddJO?=
 =?us-ascii?Q?ESrQVoKdyreauMzW2AqpZDKWOIeiWFlZNWFmr+uSt37T1x05ekAXBOtMIef4?=
 =?us-ascii?Q?irJHTv3v2Nhd+g8klQTqfCYDeWYBxgTB092Z8WrPonGykeB097JzbJGUYfaO?=
 =?us-ascii?Q?hOHqL1vgAUCuyIOPtyB1HuhZeickjMq2WNBpphw/+boye3fOlzqR1aS0/A+f?=
 =?us-ascii?Q?OW4PbA/ZVvh86+jIpId9wB4w/HZG5UrLwMrdjP+ZLXS18hkEIVD2fR7SgnSA?=
 =?us-ascii?Q?vliYyF082L59YL2S3kxyYiooQhAliPVO8Lrd68RaSsJ3ADZXax8UjjfoOQZK?=
 =?us-ascii?Q?az0XMUm28iP3EVRsjOwamayxA+7WQGB7+pswO26hzjjQmyefJN5HhFQODvcN?=
 =?us-ascii?Q?+yWM421m3D8EtH582l/GluvueMlLZFoXEz68FPtYUFWHrr96wgEI2Vmbu6MS?=
 =?us-ascii?Q?NW0LSs3EXZbyVtLdHsoIdcT1Mnypvl7C24FBGeNT6b65jGxKNRm1TA1keSGl?=
 =?us-ascii?Q?zqCnM9soY6O4Y+0nb5lsjEnMrZZWOmBBVMDpY+HL?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c53b9e-6022-4fcb-27e8-08ddbff04f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 20:28:20.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZYMJ9A5ZsDNpZnAs3k3rk9kR5bbWm1o/NsbXSUJ4IMtCsuQHkhplBy+hblQ19S+XEHen3UAoJULPNBU2ow4Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4109



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Thursday, July 10, 2025 4:24 PM
> To: Li Tian <litian@redhat.com>; netdev@vger.kernel.org; linux-
> hyperv@vger.kernel.org; Long Li <longli@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; Dexuan Cui <decui@microsoft.com>
> Subject: RE: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
> IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
>=20
>=20
>=20
> > -----Original Message-----
> > From: Li Tian <litian@redhat.com>
> > Sent: Wednesday, July 9, 2025 10:46 PM
> > To: netdev@vger.kernel.org; linux-hyperv@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>;
> > Dexuan Cui <decui@microsoft.com>
> > Subject: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
> > IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
> >
> > The use of the IFF_SLAVE flag was replaced by IFF_NO_ADDRCONF to
> > prevent ipv6 addrconf.
> >
> > Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> > ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6
> > addrconf")
> >
> > This new flag change was not made to hv_netvsc resulting in the VF bein=
g
> > assinged an IPv6.
> >
> > Suggested-by: Cathy Avery <cavery@redhat.com>
> >
> > Signed-off-by: Li Tian <litian@redhat.com>
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> > b/drivers/net/hyperv/netvsc_drv.c
> > index c41a025c66f0..a31521f00681 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2317,8 +2317,8 @@ static int netvsc_prepare_bonding(struct
> net_device
> > *vf_netdev)
> >  	if (!ndev)
> >  		return NOTIFY_DONE;
> >
> > -	/* set slave flag before open to prevent IPv6 addrconf */
> > -	vf_netdev->flags |=3D IFF_SLAVE;
> > +	/* Set no addrconf flag before open to prevent IPv6 addrconf */
> > +	vf_netdev->priv_flags |=3D IFF_NO_ADDRCONF;
>=20
> The IFF_SLAVE flag is still needed for our user mode, and udev rules to
> work.
> So please keep it. (you may update the comment though).
>=20
> cc: Long Li <longli@microsoft.com>
> @Long Li
>=20

I mean, adding it's ok to add IFF_NO_ADDRCONF. And, please keep IFF_SLAVE t=
oo.

- Haiyang


