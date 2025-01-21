Return-Path: <linux-hyperv+bounces-3738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562BA1767B
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2025 05:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D921888034
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2025 04:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2E41891AB;
	Tue, 21 Jan 2025 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BVe3D/CO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010019.outbound.protection.outlook.com [52.103.2.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4A15C0;
	Tue, 21 Jan 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737433343; cv=fail; b=QVvGPAfey97MExoZd4ftkIG2V02Uv6iQRqZHWpG48eJit0MH6LDsg7walv/ltZO6seSPREKTMqVnd4DF5nRSj1Wh6bletrfkkWZdkQHQblc9RvyGj8TIqIcJYlm7T9SxJrfbDMRf37mefTY/eQazXwWli5YU9PB/O6+JOA9LNHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737433343; c=relaxed/simple;
	bh=BZhYApmQkA8a2XRwdcsZnI0SkQeKAi1CovvNfjAOIOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbanJAIjHr8jqdnCUb6lqjFxFciw6megnGPsJDFIqV+14Azho09shKIizEfNTateq6EwBCACm8YohqtBaW3eG5/mfJEt3IypIHzKLYqV8kHPjmSB8LfNRl29qXxQ+g0xWgbc1JHMEuP6mf0gGIBV4S5x3IA+SIGfyC4N0D0Rw9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BVe3D/CO; arc=fail smtp.client-ip=52.103.2.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNZWE6FaeMeGZtA7gW/xxVbYXl+4tGom2jqy9Y9h+hYufCiX29PGp480GRRkijhThDFUkr0v5hu0KvkSIgW4OGnvDk45Xrg8kXq2/eiZIv+qpzXfIoFK4y5zu2JgCxgWDoFgyg2WysHab9QV/k/Juox1ZweXwQUQeOM55Y6euO1LX3Ix8FZWMt4eO6AhiUzc7915XMVngWVenwgGNDVvx9nm/KqCZhYWlS0A336o3l+5Q0uB0cuSW7fLb4VGombyb25WDsfCb6OpFQGDg+YN40iQIJcs0SKs2GURz740gJoECidt2oClJ3tUIdXP1q9BX2pvJ0NpyD3WDRTeYqK/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMW71yNyyzVHDd20BGJpMR7nyeM9ApMdUKe2G2IsX5A=;
 b=hJBKswYpfJ1iG5d+QNSF0DAAn6qrhg0jydJfbD+7a1MOpcUYXI1zklEWZnRxPJw9MA+whz4g2oP8ni+r8KvGEw2RJjeCY8z5qWkxrG3/6Pvszi4PGWPo0rguo6NLY4gM628vUSymT2GderClhcv8j+qCZBNiFeCkq81Z6Uml2QeDVckqqtaa3mrSRGEWliHRdDfkEBVN7aISVu1YGzBP0/mEGUhPxkvWFmiYH3OW+rQPaQvnE4zecR/lpLw46YdeC58gSRGlkAG3/ak3pUv1kF8Bf/S/WRS8eV/YJ8Rb9u4M+MsYIyWe3Q97uy/IupFOnmvSgeQTsKBaMCi+3SKwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMW71yNyyzVHDd20BGJpMR7nyeM9ApMdUKe2G2IsX5A=;
 b=BVe3D/COj3HoDt4NZfz/M0XsGNKTnDZTrxr/MmsZEnjZ9td9vDGsnxXwJDncaeZ0X13ED+G1DjV7TYGO25wMrVbSUdy1gnkRKwI0p/NSUzKEQq+OSUC9CFbQMpnGHiCcuyXjwju6e2iyZjfwLj4bW32UIGOar0s9ZnUU0w7PYYn27mH6sJtqAzTMHnFS1sBDQKCbxqqLguMSUba1QFHYxBf8rPNA6TxNsag24A+QS4rJC6r6xS5j+3c1wkVf8RmxvUmlPIK/qNn6zyTqk54/5zfzkJFV8H9xL/TK+KcYpIomf1qeu2woiFpFm61D07MqkugI+N5XlBFHSpoYbVNpOA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9719.namprd02.prod.outlook.com (2603:10b6:303:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Tue, 21 Jan
 2025 04:22:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 04:22:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Topic: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Index: AQHbaHLRzkYQZ+EqJE6PNc5JdE6XVLMdMCTwgAMi2oCAAE46EA==
Date: Tue, 21 Jan 2025 04:22:16 +0000
Message-ID:
 <SN6PR02MB415751506B4B116CFD081939D4E62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
 <MW4PR21MB1857121CA82F0CE544F245BFCEE72@MW4PR21MB1857.namprd21.prod.outlook.com>
In-Reply-To:
 <MW4PR21MB1857121CA82F0CE544F245BFCEE72@MW4PR21MB1857.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=563ecf69-e157-4f2e-b3a3-9ba714c38af2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-20T22:51:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9719:EE_
x-ms-office365-filtering-correlation-id: 62093f08-4d6e-4550-78d3-08dd39d33044
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwU46ctkesNAQSdI89rGQphJZj1DBGJMoCIbh4qCrHhmpKQomuIS3nInt5tcaU4dbxN9H8tQM7R0xf0SkxLVCL1pNwC8gcDX8g5lCU2Yl3Gdh6vgqhv/unu8pM8Wq+BiH+rZqCS8T1TL63kYmminTkDUj9fKcFLr50LcXYU4X8nd1xDRfUGXFcSai23j7gKe080/7Yw8mODsy7TA0F2/+XfPV+riD0KJLaw4FEUiuq46oO/YxGHOEjE57FWScAdUtVOr6r0YIMa5wJ0rxmpd1yVyf3OWSq8V5sjM8dLWSUNEbVMrUJ80lSITs+AA4HXrKgEeh0DmnW8PMY3TJHO8ASzJQ6+qlN8iNTle1qXyWKQqLLWWyPGG8DPFgHhoJ0qq4Hb2OA2SPSLA/FnhxsgQMPUkazkPOQk6Kfug1mzGByVMuMyXf7mi5g6fGZBKmsHAkjp34eCndflYGXhzNHwdlAxPG69vHkG0C7wuNf6vMHv+8ygTWwOlS1j3JuQfbrmGuycTwS2JxNJUrKZDP7jGUKQjPj8pzIx5KHYW7voEJix0wnzi1ZYUtcKgwIOrwSt/r99SNLYUlr+JS4jeIUm1KVLwsux44PWXPpugOf399qtumCcfSusbzL3Kl4R4MqrFy0UBwyhedj5Ch9fTomANPBs+HiqQ4qYUkYxWlm2M1DTMMEuCGM4wV8rla1u+HwkMacReNwthq9RY9C1SLBLpxfTzw4Xkz1S9ibN6gvKeQx8CC+4OnEOvmph1DVkVkX8Zkmc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hLZj01B99ebQ8WiqWSGsd16I5AiUajOG/G7phl8XwR2OlYjgZ2vVtJRM0zZN?=
 =?us-ascii?Q?Ga+KNq8tKgYy2+YaTJdO2WUF4WhyjaJslG/rwE9opi0eG9B27+WTmZCE+w7u?=
 =?us-ascii?Q?kTI4Y1pYzORkuhvLNEiNBPcQ2+6dVXRZGYSVRA5TfzhZsTaoE3iGnfyjrt6q?=
 =?us-ascii?Q?MzPBuBwq+y5/bNSiNkLv3QOfQG8EACZrBYAztuQeYqYNQRYMVrixFcd773ob?=
 =?us-ascii?Q?58YWSG7A9p/c4Avvuki7Z+qT4bax8sBQ7ZgRG7kkoV4X2HCD0M3Va/sQG760?=
 =?us-ascii?Q?XgXnFuL4dwiPdolqnCSEa61b/LLA6/OSqMRifq8h9XxF+4+8G6oGRDV5SS5g?=
 =?us-ascii?Q?nQ10ib2DSsRbYSxa9xdtTuGoc3U4726wbTXAnPtR98YIwkovo3IPGslJqBic?=
 =?us-ascii?Q?nQsnN1l0YehhoAH8RsJH4Jhu6c6P5D54hWweQAa+VLaIaSoOfKKEOg3QfnfP?=
 =?us-ascii?Q?tEUKWewLA89881ucTpmv3vG3Cr6XoT5tGPnAUL/g+HIJAk6dKuhBZkfTNnd4?=
 =?us-ascii?Q?ajrK8TEJhoiRQNaxX/GfCi6LCJKj+zSVarE2vllSCV7uz03wecty7ZmgILe7?=
 =?us-ascii?Q?M15T3KzBUYUhNM85u4qgELZPIDMK+KgD5+tlxIg8lK/ma5ccU6VwhSeh3u8U?=
 =?us-ascii?Q?4MIy+ETOKwl4GAYmVBXF9+iHygJlvcXD5QvtFfx+VgtRXF5FMYLbBIpaoMjn?=
 =?us-ascii?Q?pZ0Ke/0BlDXnJz2cGeI31dCSe0U9Os+cRjx66rV1BwCwo1DtTR3wjmfc/Pli?=
 =?us-ascii?Q?ejcF5i7XQbjp2r06cQyq4ojbII8Y+ti4co5m5H0cytrwndvRbZQ9Yr6Pttpi?=
 =?us-ascii?Q?6iq9rzUIR4c4EaG0ag1N2kozf95C8a4AGvQ79rVt6IPHBjQdQ6arNCvQCATm?=
 =?us-ascii?Q?Gz/GLKHy86uwXIcfp8FqwaVUy6ay4LxqPwFa5zrdLS0PBUrY2Sjl4m/5uCvN?=
 =?us-ascii?Q?arBCVRa0KYPWd+/A6NlDMda5BDPRoHlc5zoPxLDWmavlgL09vQ8HTXscbOnh?=
 =?us-ascii?Q?VM4nFu+6MRmHPIfY2NA09jktADya0dftiUdGjY4xECx6fuk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NDCt4gCng1O26QrSCQSndX+R5sa6sr0y05wiRDiF4TcbkWarjiKm5VzTOk33?=
 =?us-ascii?Q?+n4TEIPofbpuOLX1PeK7cFs9pJ3opg9Ay7S3vD3qhz1vwbJxcN0kSWfnplMY?=
 =?us-ascii?Q?NJ92qYmyCvDUpdw2VgahowGALsyCZJgwwkPEZWgyF8TASxGMlQjMsA58DMqY?=
 =?us-ascii?Q?WgbMUHSbPvTsuLvtHarUgNV3zhwigizKPxuH9oQbq3OC4gM6DWMfRfmeAaIp?=
 =?us-ascii?Q?z/DoD9/CJPmSSg8pNBlfkh2YjPhrG/MYkjx6vOb+yFygyImr3oq5v+OrkUIV?=
 =?us-ascii?Q?cQsxAEhVc+uHlW3sO6OmgAp79N1+yyswjJbobTOeKVj6DS1VgJsM3ckQloOP?=
 =?us-ascii?Q?R4I8DGFjoU/nURfhIsxmTBYBIJDhjOnjkX+m1itWeG65ZQZwwjJkC2u7ZB9b?=
 =?us-ascii?Q?/ybtzJCiOq0RPowd1zgitP2NGNtGP5ev3756g+4cbMFDX8prJeZVTWeSetYm?=
 =?us-ascii?Q?Fq5kN4ycI1flZRncnWMLqQTtIH/F8FIaSmK3kZmwxZ/BhtyRlQMal1efKnLu?=
 =?us-ascii?Q?Ocamb2OBOKc2sQjhbhpbBqSvBEPC/ytpFaeLOxK908oKpZv+0zHihmsQppk/?=
 =?us-ascii?Q?9I+seIXhKH+MfdNxZUdj145x+bwZAu9iWeN+jlE3eJtL4FAES9rXAqHUYhNV?=
 =?us-ascii?Q?jo0DLAJfX4nOBFuJXCyys9TYseJN6cwpM/PNO0qQcEXHAUmbjNknuhLFuNcE?=
 =?us-ascii?Q?5byajaYBh7x8Ip8xrVacG+AEMALb8ZA6FBJY2y92OGK5rcl4OwL6CJIn6Vzr?=
 =?us-ascii?Q?0jPxfwvyLVbCI2ZZIFocquZ7oLQwR097HrTPolOi54q0zY/UQuezy9ZtzIwx?=
 =?us-ascii?Q?H2lMMctEXsdKxKtpc/tR6vjUMfzPZLpsoSPffWZaoUQfF97yFzGCf020f7t4?=
 =?us-ascii?Q?LGEYnH5kifO0SEw+LOHUhHMogNSaIwYeQkh1ktn92qWoV1s86QY9NEih0cTy?=
 =?us-ascii?Q?RAnDyMZ3fPD7iSK8ZFVcpGf/PuptWipb07NZKZmCln2/zD2HqKrlLTPReLWs?=
 =?us-ascii?Q?pxkST6Alwmo/lFRBHjLZDsl6HxqhhnYeZEzlCBUY8Xc2NzGgLAeRk5fWy7ns?=
 =?us-ascii?Q?dRVBrOkM22wbz+BYCycjtB2JXWsODjxkHJXuiMsyMjeTC74cr6gIgfjNxlX8?=
 =?us-ascii?Q?1z7ogO5Z0TbAwbshWhYbaXFd94S/ngpX8obElBhXnroFrRJ9p7NhDsDvrbK1?=
 =?us-ascii?Q?OsGSDqft3VV8esoQ9nCKKbWCk3Gynh1THcxnxNvH+9BxUeB/FyZ11cxSySo?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62093f08-4d6e-4550-78d3-08dd39d33044
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 04:22:16.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9719

From: Long Li <longli@microsoft.com> Sent: Monday, January 20, 2025 3:21 PM
>=20
> > > In StorVSC, payload->range.len is used to indicate if this SCSI
> > > command carries payload. This data is allocated as part of the privat=
e
> > > driver data by the upper layer and may get passed to lower driver uni=
nitialized.
> >
> > I had always thought the private driver data *is* initialized to zero b=
y the
> > upper layer. Indeed, scsi_queue_rq() calls scsi_prepare_cmd(), which ze=
ros the
> > private driver data as long as the driver does not specify a custom fun=
ction to
> > do the initialization (and storvsc does not).  So I'm curious -- what's=
 the
> > execution path where this initialization doesn't happen?
> >
> > Michael
>=20
> SCSI mid layer may send commands to lower driver without initializing pri=
vate data.
> For example, scsi_send_eh_cmnd() may send TEST_UNIT_READY and REQUEST_SEN=
SE
> to lower layer driver without initializing private data.

Right. Thanks for pointing out this path that I wasn't aware of. My
suggestion would be to add a little more detail in the commit message,
including identifying this path where the private data isn't zero'ed. Some
future developer will wonder what's going on and appreciate having
the specific reason provided.

>=20
> I don't know if there are other places doing similar things outside scsi_=
error.c, but
> storvsc is already calling memset() on its private data:
> (in storvsc_queuecommand)
> memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
>=20
> The assumption is that private data is not guaranteed to be 0.
>=20

That memset() was added relatively recently (in 2020) when doing the driver
hardening for Confidential VMs. At the time, I was thinking it was needed
because the private data isn't zero'ed, but later discovered what
scsi_prepare_cmd() does. Then I was thinking the memset() is duplicative
and wasteful, but didn't ever go back and remove it.

It seems like the SCSI subsystem has a generic inconsistency here in that
scsi_prepare_cmd() *does* zero the private data. In an attempt to give the
low level driver a clean slate, that zero'ing is done when a command is fir=
st
assigned to a request. But in the error case, the command can be re-used,
or "hijacked" per the comment for scsi_send_eh_cmnd(), and the private
data does not get zero'ed again. If the low level driver isn't guaranteed a
clean slate, then the zero'ing in scsi_prepare_cmd() is arguably not needed=
.

But that generic inconsistency is a different problem for another day. I'm
good with your fix in storvsc.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>



