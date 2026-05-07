Return-Path: <linux-hyperv+bounces-10658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDiEJHbn+2kaHwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10658-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 03:14:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D14E1E60
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 03:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C52308DB97
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9442D060C;
	Thu,  7 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iSSFtoBV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F99238159;
	Thu,  7 May 2026 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116271; cv=fail; b=EOkW6t/eW2e5/IH2QZRUIlusjSGJuwekYQA0POF0tER0wsSUE3ODPOrEgxmqHZ8RayNYNO4KMNZlva6bi0j6BHMkaJp4z4nz0wflpyXiKWgkeNdI7DyQZQuNufnYkQgP4Jx6OdSyTdhDc+EjnqVMrpFgrsAum/IGDiQen1SwYfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116271; c=relaxed/simple;
	bh=V7u8in1s4iZoMXS3Vgc8+E713ymJjFt0akw7kY91jWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVrJ+J98owzQC1GteH0wf2RqsAPqPvlt3q9yk1IOjmAS/FyHFYCppNaF68danZpPFhF2KI+vH2ugzWyEYn65bTZYIvFCHB5f+PvAVYcv05uGW/aTRaGv3lDuLGdL2jAE/iPitgvHSJaS+UFljzPtHVBhxLva0X8uniISieTtVic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iSSFtoBV; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCJmMCj+H2g6pu7mzMG8auiGQQ6qZS/+2TueD99mkC2r7TIo+kAfEmzfEEbih6mMq/Ri/GRnevy+cAmp6Yme9qE92rcYEAba2oXxXgUyUPgV7jh/tm/yRi0u0VtfUNhVLuYVHGTTER8PsCH/Ua0zQiHzW/J3veja42hxzWXFEqA+6lOR6O9+SstJmKNRLnnblbQxp+CJmlpp71rMenZeX/4MfOOhXKmDAfOL9gLs5aBAaes50PxG7qvEWwENC/VtXVwM1vOYqIZIs1ZlnSU3HBCgtr9PzPAFNKeaQbDPQzn7SSH2achhcArIAxji7PViOtIcmMNWnckIROxo597daA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AevwZQjBZ9fFYB4M0OzDHKeyN8EXsmLKhRWMhThXj/U=;
 b=DA5V00j6DrCO4d49nLnC4aiY7Ci1fDpUzM0LNh6i/T5qI/xOiA1NrTFv2hnThfurBBbmhsethLWS9APnATL2kSUFVO0wxBlmXmZBmIPLM8swYORzP0L6rMrcGz9rwwh5G26U9NoRRmBLaCfMi9QKtD4DTEqqlQNg39XHd3Cp1F9t4YV3f6U4kZ6xMhcnCgq0GtNHgWkHdpcqZiqD8d/4N7I/fUaAWomkQ1ocSAqeMiaZJhNI/lV0MZBd7sp4j3/Wh7No7dvjhOaIEOsAX7po6kwhvJSjAF6T3TFCsyKDNVQ21733t5MBhBs6p8nquL607ft1/55S6zBGitkxYPjCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AevwZQjBZ9fFYB4M0OzDHKeyN8EXsmLKhRWMhThXj/U=;
 b=iSSFtoBVVf6WPh1XSqgaWFZDWlT5Kk83Y8wEj4elHKOZ7LGwTSNezQq3ZWvk21ul4DnSdmBUNCNVDfH0qlpIa2tP+pxbImIevaG0POm+VDxgc9lx4cDeL8G32ULoRqhNyXC4aBfYnXUsqStiEYB9IfjV8LV/2+GoWLeXoL76C/o=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6681.namprd21.prod.outlook.com (2603:10b6:806:4a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 01:11:04 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%7]) with mapi id 15.20.9913.002; Thu, 7 May 2026
 01:11:04 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHc3WroSYifASCvgUCkf4bDaRgCsrYBvvhw
Date: Thu, 7 May 2026 01:11:04 +0000
Message-ID:
 <SA1PR21MB69217F13193ADBD59430FB52BF3C2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260505004846.193441-1-decui@microsoft.com>
 <SN6PR02MB4157A5A68BDBC87995FCE85FD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157A5A68BDBC87995FCE85FD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9bd0f695-bec3-4a4a-bdbd-51792e2809c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-07T01:00:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6681:EE_
x-ms-office365-filtering-correlation-id: 4bc95648-3044-4382-fe06-08deabd582f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|921020|13003099007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 jYgefhyY1uTdv+tvQ+t1AISQ4BU2WQgevCDyPnA7cZnxSyZYZyD78lxxnQFZO5Css0MLlkS/H9UJAWIa1WQ8IfjWDK+V4g3VAhe+2ouo3hiSA8N0qN2D1jLds1zRTlgHvOiI68USQCTSzV2Yj/Tx9LlgfYQWfuq5Ty1U+jYeJVP1Z66vF2cB7RjdrS9yS5DKbHITAL1JHd243x83uU1p3TTpoSP+Copmo+wiKimM9LEmrbUy414PYMz+60cmAReJ9tA4qoHxhZYWtw/VIPykQxcdS7PQcWAn8UIS8BhjvZKg3MZ5TYqE7LRsnbQfLg2ZgiY8cdyqyZz3B/K15BWkMt3+DrEB+JpNV2pk8jssfLS7PkQn2dEcY7ikXlTxQQachsNAtoYq61TXvwqfgbt9ncXdrrpEKho6Y5e3MozgRak4DIBJE2f3wGTKt2zU4zArJqJusVtZqBHYnr5Ql2A83KPYEASfSLpOJhB52mm+fMkNv2iCiXN8hlWzz3u0wYZqMNTclD9yCbGzataHLmYXHVyazUs7Pq4H39ehwkryY3lhCbgVw6VuahkPH+vCcU+aEj7BI1aFV4AvfL5xhbrxDZ3WcIN4voJ5cbMZYKlhDfFodTgeEYRLjPJo8hyIBj3fYUD69Vq7o45RAdg8aQjlfLamUzNlkmZBl0TNlv6mQKmFj7CPMpKZMyqj4K1QworFkIkt8HGtP7ouhTGyC+FZdNexhkcipRSaRrESKQmTM3f6lCTGF1bdW9/k6V8TTxNz40J/lINJB2L/JwFeD7bCkQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jJKf3cDFxb4a6SDtz3zsqMyCVYt22mmDP0BVg8W92PHs448hC4vcGTI3Ra9K?=
 =?us-ascii?Q?CQIFFd56Kn833VrnJSRON9dpKTQojrZhjavlPfj+snNAgd62Fq/F8PiXBChG?=
 =?us-ascii?Q?JqgAF2X1D3zl7wEubAfH5aD0h4o4ccT3s7Bp1YVtln/Jj1MfZTi8cpFDsCvy?=
 =?us-ascii?Q?ohVKx1mL1tlo4ysQlCiDlIu+WS4nJsiyM9ZXQSpOpMUgpEsNC0beP/TjpN4v?=
 =?us-ascii?Q?2qypCLxjF33Iseqyy0sWQiNWAg6LmkxkBFcEW2Tr+TxKkA9HHrnRCL4A6xNr?=
 =?us-ascii?Q?gAK1WqkccKccRgXd5Eel9SD4I9Xw3uvawWQ1uan4z22wTNZa/XN7yQJA/5QZ?=
 =?us-ascii?Q?JgTFUkNo+jP9rt8ziiccqQmkpQG1tdGB4B79Zv1kMBy10POriLKHHbfP80+i?=
 =?us-ascii?Q?aMUkmT5meg0U88x1ZjAPLXH6ZJOv1KgD0gx6DfFS43WtAn8DNeSFfmbZOQxM?=
 =?us-ascii?Q?C/GbuLy1kHKG6R9WsxMjUwDTJfYUuqQfNtEro6fehit2KQ8W8PENmuJvzqV2?=
 =?us-ascii?Q?lskozMn47eQ2WwWuHzwe2EKeqFNl14FxR+kufVEvIoV5T5en078NBC1b2LYZ?=
 =?us-ascii?Q?UxdG7d/r9e1gMy8fIIKu5C5/83jI6ND2zynEFNwzSDASs2NcDP3+5ng5d8QJ?=
 =?us-ascii?Q?t7auZ3M8D0ayvu0gRb61+VlDbl8BCg8e8zFERT3CKEYCWCRaqoN6XmVLFm/+?=
 =?us-ascii?Q?V+ByJxCb6H9Gpw3keW7fYmWxIItsUYNRbbzI3bfubG+7Y9e0eWunsPoXc9ke?=
 =?us-ascii?Q?rsLI1E238/ugkkPqAJ3E360TtZwabD+ZEEfdFK9TFp9jbFzCmE6ZpwYeLYVv?=
 =?us-ascii?Q?9HOeMG1XSUGib3o8dS5edCrvEC7n0zO/eMutCkNGcYRMNE1SFP2jOsBOd6UF?=
 =?us-ascii?Q?bPxYybV2b7z64I6Vs0tWEW0ZKke29F5TLiVcA0+0c/FRWdfA/2vbz9ZipSa9?=
 =?us-ascii?Q?z8R+9/1Dy0Vj+JUTNbnVUyEesPmHeaTpnHAfD2l7P1LKpk/d0GiO2nXszXHQ?=
 =?us-ascii?Q?c7WybvrhdXBdqJoeHxWoE/SxglWFi68e8bYw6IKhqo0rHBez6e2DyVzYWYGK?=
 =?us-ascii?Q?CV2+Bv1U9boGol9AbLqX7Q0jS4V40RyYVWZdXMK9b9uGf75w66GZ2wiPawzx?=
 =?us-ascii?Q?VPHQEN2xmq2GU9gbZ1F0b6PBSVD1NxeqM+SDCupEcNoefiKS+3tKfSJ0AeW1?=
 =?us-ascii?Q?0yJ3GH1A0rfa2gSYPoZ0TLh4hwybMnF3TOqzdKEzOH2QySLiw0RfHPRm257T?=
 =?us-ascii?Q?L+465qQKSRaAsvK/lVq6jEIQmSgt116d870fW01XFGCarxATn/MiJHquwd/7?=
 =?us-ascii?Q?v2uzA6aNqpo8n9Ao3mZs/zzd4YOQR4NRQe9zxJuX5OVO/ach3eBvvIHNwiqj?=
 =?us-ascii?Q?UwmAS/KxtcpY4WmgPZ/4rdxnXxtbAk4tetKZKVQKP890yFocneY0TlDHj+Is?=
 =?us-ascii?Q?5+hpq6a/sKNgu19QnhdzQhgK6hFdhpWr3pBU1clBLmr8YrCrpmY/R1TDkSmY?=
 =?us-ascii?Q?xFcy/Sdq1zUy2H/JKhPfqYoMpHepu6cUjFkyGjIsU8RRd/D3M1UoL3HsGV1C?=
 =?us-ascii?Q?/G8X8UXD9LwTqYiWR27pS9Am+GIc/b15A/cT5gYKvWp+EAunUGny5QwDO8sj?=
 =?us-ascii?Q?EMhSEuWUdDLmylDmlJxKG4cxnBV2INNmHNW2S7495m7XNCsc2amh7UArn2oX?=
 =?us-ascii?Q?gSdoNHSzcVhxqMePGr4J57FqDDJ5ygzAPyalFfLWqriAyltQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc95648-3044-4382-fe06-08deabd582f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 01:11:04.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imQI8hMsRvh+yJRAAvz43KLlUkT1cLB+vXX+fB8jtQn5a3ecW4xi1ktykUM8wc6eG8Y0zI1DtNC4axAoBXA5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6681
X-Rspamd-Queue-Id: 0A3D14E1E60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10658-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org,canonical.com,templeofstupid.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, May 6, 2026 8:14 AM
> > ...
> > +				/*
> > +				 * If the kdump kernel's lfb_base is 0,
>=20
> Nit:  The case of lfb_base is 0 applies to kexec and kdump kernels, and a=
lso to
> CVMs.

Thanks for catching this! I'm going to post this v3 later today.

--- v2-0001-Drivers-hv-vmbus-Improve-the-logic-of-reserving-fb_m.patch  202=
6-05-04 17:48:23.486911073 -0700
+++ v3-0001-Drivers-hv-vmbus-Improve-the-logic-of-reserving-fb_m.patch  202=
6-05-06 18:03:42.922469286 -0700
@@ -1,15 +1,15 @@
 From 5d817788d65febdc0451e8a88277778794fe87b2 Mon Sep 17 00:00:00 2001
 From: Dexuan Cui <decui@microsoft.com>
 Date: Thu, 16 Apr 2026 04:30:21 +0000
-Subject: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving fb_=
mmio on
+Subject: [PATCH v3] Drivers: hv: vmbus: Improve the logic of reserving fb_=
mmio on
  Gen2 VMs

 If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
 the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
 screen.lfb_base being zero [1], there is an MMIO conflict between the
 drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
-hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a
-32-bit MMIO range, it may get an MMIO range that overlaps with the
+hv_allocate_config_window() calls vmbus_allocate_mmio() to get an
+MMIO range, typically it gets a 32-bit MMIO range that overlaps with the
 framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
 error message "PCI Pass-through VSP failed D0 Entry with status" since
 the host thinks that PCI devices must not use MMIO space that the
@@ -31,7 +31,7 @@
 Azure. I checked with the Hyper-V team and they said the statement should
 continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
 is not 0; if the user specifies a very high resolution, it's not enough
-to only reserve 8MB: in this case, reserve half of the space below 4GB,
+to only reserve 8MB: let's always reserve half of the space below 4GB,
 but cap the reservation to 128MB, which is the required framebuffer size
 of the highest resolution 7680*4320 supported by Hyper-V.

@@ -42,7 +42,7 @@
 Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
 of the low MMIO range on CVMs, which have no framebuffers (the
 'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
-host might treat the beginning of the low MMIO range specially [4]. BTW,
+host might treat the beginning of the low MMIO range specially [3]. BTW,
 the OpenHCL kernel is not affected by the change, because that kernel
 boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
 there), and there is no framebuffer device for that kernel.
@@ -55,18 +55,20 @@
 and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
 isn't a typical configuration by users), the hyperv-drm driver may need to
 allocate an MMIO range above 4GB and change the framebuffer MMIO location
-to the allocated MMIO range -- in this case, there can still be issues [3]
+to the allocated MMIO range -- in this case, there can still be issues [4]
 which can't be easily fixed: any possible affected Gen1 users would have
 to use a resolution whose framebuffer size is <=3D 64MB, or switch to Gen2
 VMs.

 [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1=
PR21MB6921.namprd21.prod.outlook.com/
 [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1=
PR21MB6921.namprd21.prod.outlook.com/
-[3] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1=
PR21MB6921.namprd21.prod.outlook.com/
-[4] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6=
PR02MB4157.namprd02.prod.outlook.com/
+[3] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6=
PR02MB4157.namprd02.prod.outlook.com/
+[4] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1=
PR21MB6921.namprd21.prod.outlook.com/

 Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft=
 Hyper-V VMs")
 CC: stable@vger.kernel.org
+Reviewed-by: Michael Kelley <mhklinux@outlook.com>
+Tested-by: Krister Johansen <kjlx@templeofstupid.com>
 Signed-off-by: Dexuan Cui <decui@microsoft.com>
 ---

@@ -104,6 +106,18 @@
 Hi Hardik, I'm not adding your Reviewed-by since the patch changed.
 Please review the v2.

+
+Changes since v2:
+    Fixed the commit message:
+        hv_pci_allocate_bridge_windows() -> hv_allocate_config_window()
+
+    Changed the "kdump" in the comment to "kdump/kexec or CVM" [Michael Ke=
lley]
+
+    Fixed the order of the "[3]" and "[4]" in the commit message.
+
+    Added Krister's Tested-by.
+    Added Michael's Reviewed-by.
+
  drivers/hv/vmbus_drv.c | 29 ++++++++++++++++++++++++++---
  1 file changed, 26 insertions(+), 3 deletions(-)

@@ -141,8 +155,8 @@
 +                              pr_warn("Unexpected low mmio base %pa\n", &=
low_mmio_base);
 +                      } else {
 +                              /*
-+                               * If the kdump kernel's lfb_base is 0,
-+                               * fall back to the low mmio base.
++                               * If the kdump/kexec or CVM kernel's lfb_b=
ase
++                               * is 0, fall back to the low mmio base.
 +                               */
 +                              if (!start)
 +                                      start =3D low_mmio_base;


> Modulo my nit about the comment,
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks a lot!

