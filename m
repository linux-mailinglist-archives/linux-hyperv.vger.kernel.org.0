Return-Path: <linux-hyperv+bounces-6068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA62AF0BB2
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D231712BD
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 06:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC01531C1;
	Wed,  2 Jul 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CvEOnAxS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023135.outbound.protection.outlook.com [52.101.44.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC524C98
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Jul 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437955; cv=fail; b=l8YCJYVy+bytaTYKDy8MaRQSOi/AsHZY7CPf4y5Z7gXCP9vXNVJG51b4yus33K4Q95WUnHK76juhMBurYtumDJNuMe5Or1Pp7o4QaOBD0l4mFS5OUk3xxJ0HJF5DWVYFvqnE264+OOzH3anqczdve5ppZ/DdFrLCs9ZpFhF5ehs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437955; c=relaxed/simple;
	bh=HzqV9Nv3kI0yCaseemQhOp8tM4wzH+EMoMykhbjqg/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IyTjRU1YXLxSxhASTWUURj/oIdWY0p94GBtHSv2l9tt214F8bX91Zf5ZPL70WE8VatTKUV2uNV4iMWruw99soaHjlxeUAfgPbsixVgyjfMMB/9VdJ7cPBEM/28ZFGVZMzOaKeMtAK7NbF0+o2UNvy9Kd088oo2qCshnhHhM0p0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CvEOnAxS; arc=fail smtp.client-ip=52.101.44.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnqDscYAxTFMngXveMlu6YnEUYWZaRhF2krtl/hfgk1HdA8hjzYlcBcoowFd+iuUIuoRgzL45r6OHs4OTHAyGg1BPtUyYtEP41b/wvD8TFQIDMxEzUTcjGGw+eDva8EUarcOjgKGjwOr/KeIZlOZdVjGQdPSr78OUKTlDur+ZFdNmyjio1BfpCeEmvakyT10SE+1FwnGwnm49drG3zKE9zLUiGRtG9jeTKJ4q5pt6KaejCqADHL8Qe9+zmYv2k53xyH+XFQTkjppTbtBceVRqTRm1K6fTEgJPQaR5MIg8cwLym6cbg0ewu1gzVJX9s1D21DckEWcOJvO9EnWBUpWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFUFQGjHnoad92SCdbeYKx9MalNM/Adk9AhCbfmnTb0=;
 b=ZcI/0R4Sd3qzfBKdSX9+nOp1eoYOBaTiJKozt4Cf1/m0mfQph7NflDmGjQIM3gX9n50q+Yn5fCwThm6L1hIZ8dq3L8DK7xYprVnpMySmujJSIHXhlCHZThVxXwzP2jyXDZlkSI+9eVrMNFpUSwgpHqVUgJV7KoW3FASZovQFJx4MfUmZLcHWNMI8Kp4RwimkZBbHTzAbxzRjFmQFO2w0Jf8kBjXThqDgs2AHHQ5W/rKXOhe57eKxF+F+Mk5G2jL97RMCJZFaG/0iyyMGdYj1vnQuB89S7bZb2zQoGoRXzTSWKLWZ++QKqm+b8+Nsb9Xx2VCnXGfOmhtHj2nbqSNJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFUFQGjHnoad92SCdbeYKx9MalNM/Adk9AhCbfmnTb0=;
 b=CvEOnAxSBwnxwOumwoU5eRSq555DbVinGzXsU6HFfwI2hP7x32s4lwrpO5lgTlmRQPZ55wrQYSB1BHY1nD6CNdY6UlZTf1Rko+Cbba8oXT/MFtDqm2n1t1pjqPat/XK8YB9TRoc8OQrK2UnvGr/1cFHs/vXDAauf8bSgeF6fOEg=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS2PR21MB4965.namprd21.prod.outlook.com (2603:10b6:8:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.10; Wed, 2 Jul
 2025 06:32:31 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d%4]) with mapi id 15.20.8901.009; Wed, 2 Jul 2025
 06:32:31 +0000
From: Long Li <longli@microsoft.com>
To: Olaf Hering <olaf@aepfle.de>, Naman Jain <namjain@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Michael
 Kelley <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] tools/hv: fcopy: Fix irregularities
 with size of ring buffer
Thread-Topic: [EXTERNAL] Re: [PATCH v2] tools/hv: fcopy: Fix irregularities
 with size of ring buffer
Thread-Index: AQHb6nW9a7ihZZTYAEK2/sEozzC1ArQdHf8AgAFDFNA=
Date: Wed, 2 Jul 2025 06:32:31 +0000
Message-ID:
 <DS2PR21MB51813681D55C8833729D6954CE40A@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <20250701104837.3006-1-namjain@linux.microsoft.com>
 <20250701131532.125b960c.olaf@aepfle.de>
In-Reply-To: <20250701131532.125b960c.olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9e6ea7c3-b394-40b0-b9fe-646718488d37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-02T06:31:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS2PR21MB4965:EE_
x-ms-office365-filtering-correlation-id: 04a7020c-c936-4c5c-6d5a-08ddb932390d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FOsStJZkor2uENKwQiTPYM2/lJha9UlNeoM0YEevnpB8ljErF45oTALgzX2r?=
 =?us-ascii?Q?zzqTeSbUxUIMBQotJz+eAqkmBFyjT8wi9aAF6JdjKPR5El5hKZDe+X6GqhEU?=
 =?us-ascii?Q?mysaV6kxTnF7pUnWdOwxmnEiWR8bb2zvqh2YOjMETp6lPtaCjxhHaajC3RnT?=
 =?us-ascii?Q?gllptW4GUIII4mL7Y/9xY5Sf1BkinWwf/6kvlmjVyA6tKTrmRn8bd+1298li?=
 =?us-ascii?Q?C6zkegbAaTZZ7MqwXb8s2LGl8wTZAqSC2STJKCZSCWVf1s9eh1zMNSmF74ib?=
 =?us-ascii?Q?6dHS0a/7ITeWlaJ3j8dmDaqvFD3pS580m3E1jpx/3Ptv8+gzAnt/0sUZNy+t?=
 =?us-ascii?Q?7M+SsTMT4xBNEBYs0WEe+XW5opRlxQOhsUVu2yrKHmfLcYugvn0/lLmhSpaK?=
 =?us-ascii?Q?ymLLx+47e/DNaXzLYvKQL37AkGc24tuNVAD4QfJkNz9joYBQBZ8+/cpis25Y?=
 =?us-ascii?Q?XybgQGJEjJSvpqp6DgRebrxeZZX+FA3UFzZuSok6O3acuCoOnCWntTZu0958?=
 =?us-ascii?Q?abc+abqgy+3IiWBnYOreJbP9dmcx09I3pR6HNIk4Q7iFHxf4WNcxrPpcYfPO?=
 =?us-ascii?Q?5brwdQG6hIS1jP3/59HYlLqHEmEwzQMoZzOtxlTO+lLLQrcQEAAJhTPaJqop?=
 =?us-ascii?Q?xaTHuaMakF2sLdbYBDcu/WfS/ejl+1e6xFQcc24bdIbdQU7W2AQmu495u9P3?=
 =?us-ascii?Q?tgHTay5ReqcKp/rG2rIlHLrjgNp8WsXcLambMFyfIORoJ9p1ODv/cBx0671Q?=
 =?us-ascii?Q?RmgL8A6+RaQ4KRzklE/EuqSQr09P66CfINgely4tA+87kigvZQCYcx0CFhIu?=
 =?us-ascii?Q?Hm3WF+n3Y2ZkU+aKzF3E1RcmhrfxLpZ2DpfNevLvmdxNAd5/IJf+56LkFq7R?=
 =?us-ascii?Q?JTerNGfWRjF+YvC9zC8gkCRzJcjZsrhd+oL/Fc3pXPP8+2iKA73i6a3rAxPO?=
 =?us-ascii?Q?9k5cbkU9dJQyC+cWmxESKGkM/dy8i46SGU1Iy0BC1Oo+dqKumBgKQWuJh/Du?=
 =?us-ascii?Q?Xyk+nqgtZdJDElOxvBAbmHZ20Ne6KK8KuK4KLE0KqJY+IP/x+HUU4X7BtquE?=
 =?us-ascii?Q?ZCZnAdB2vqCr9YSZQqJ3IQlKjQwN3H2NgonHOWVXIhbdSZUVZ/20v83mMaPv?=
 =?us-ascii?Q?8SbizgBGGQweaHfCt89pyQ5e+knHXfOoo2clIC8053CZ00AjlxD+K/2Zs8UG?=
 =?us-ascii?Q?7p0cMCRFf2Phn9saoE9teSQHduB4MkmaQIi/BQmeBfSboxM/90tM9PUXTX8M?=
 =?us-ascii?Q?UP5wtUhC98gBWrqrQfb9j12AVJ+/jgveSWvlUjuTSPMJBxoEGiqMF1IGtaSj?=
 =?us-ascii?Q?bqxrpVO/j8AkQKb112u+2xUGN24f+IrCcNbitPkbllVblfguK7aSCeA3lC6a?=
 =?us-ascii?Q?J3cidfWvV5akUgME24PrO1i5Sk1gmEHgsnTVMRHPqT24GE+h35AOSxstelLo?=
 =?us-ascii?Q?JsqlZkZYmNii22u74JJ4gpfbRMe8L21oggO2d0uEMkE1lksTET6jqNKtgdBN?=
 =?us-ascii?Q?hBSBqHzjYqOIDyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR21MB5181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?foJLFiFPXA68As2OXmoUBBKQgZlcbAnz09W7YzQhkTSpq+wQ1lYmINgSHVM6?=
 =?us-ascii?Q?BvqY+OWcvfEhqB8cfeCMPe4D4Z7+iXElIg4EwNWtcdqeMbaIw1Zb4Ei78AwP?=
 =?us-ascii?Q?Yo2mY8iYFSnz39LpPcoE5in7YBgacUJcYYmffkiJkPbC6G/MCy33wVWFApIc?=
 =?us-ascii?Q?oEGpV5s17tdPIkUtWMaD5Vvf/xcBGlzHHApL52NPXixE0Uli8+/Ozq5UuBiB?=
 =?us-ascii?Q?S54fJne0qUSl3ml0ChlBPwc0Lv4+cUCluu52a4TUOMQcb666CidVPTxXDahq?=
 =?us-ascii?Q?I+4JCJPir1FU8LLCOerUguep76bRG1+Dxgb02SQyc/k/l279Umg9zeYvRGw/?=
 =?us-ascii?Q?XATDjUhicg9szDLZiCn9EV1DtNwoDO6Pv7QiuPLJvkhlw7BOD3BrDCbuiGFj?=
 =?us-ascii?Q?Kn3Is6I9DQjY21R8PYV7k5SsjM1JgpnpxlQ6087QiHoBFUpahxkshZFx7WD9?=
 =?us-ascii?Q?TfkyG4pCFn+yySPSaeKe9iJ+tMkaW29u8ELjhubU0REroZG5VwDgavy9ROLe?=
 =?us-ascii?Q?qd2omN7Ru11t+GJXRjGUW8mXie5BhGyfsff7L+f0TlcW6GZbZpxIOOvAzlmn?=
 =?us-ascii?Q?BfT4iA7fsVqKEuXgqJaTibLLDgyuJLztRTlu4eBqUXbaP2BKa4svxRIt9n0V?=
 =?us-ascii?Q?IU9g3IykshpqLImcpYjI6xbzD7kwnmpPFw/AsDI5iM2Y7Wy+Jwuw87oWP4WA?=
 =?us-ascii?Q?OuWCTAhuUAnyz4KIBDaKHH8eRYpdO5enweNSS6BxZvq52Z8D+mxRuJVwvSPd?=
 =?us-ascii?Q?p0qxmvCT0CTZbzPXKfgdrNuZSbgdeKbqKx1eNbJyMdskxQdJ61hkw5fgh8HW?=
 =?us-ascii?Q?D4vtmt+8p+g5P5TqbKigPiz/4r1OkJy4gw3fl0dveHG9H3ttFDXotXA0UnY3?=
 =?us-ascii?Q?mzKT/jR9RHvUDpxzzl7Zrvv41Z6C0vKFHiQamZlWu2SnfM7Ps3XT4b7ZrsKU?=
 =?us-ascii?Q?6S1i17qMWoNNz8WSBogtbKRmzi0a5sSn9tL9GC7sZyoEwyHKLAIFkKvdZIro?=
 =?us-ascii?Q?KZJn4rWVurJrJZ4AHi6a+l6ruwXgEtH4sGVQVUmXlXN+KQQ11WXbvWA6CE6F?=
 =?us-ascii?Q?btqRixcaeXnkMsaD3Ty0qR4jScNax7h7Xp+SiQ/yZrk0/ieHEKb2SZGJVoD7?=
 =?us-ascii?Q?cTyvQh8PAKkU4ww4XR03lMiKfFaZnweLWYOl4m0Np/KU8Ua8+QmcjpGZMVtd?=
 =?us-ascii?Q?zqgqMnkbiqF+Nwz+2nO9Zh8jGefp+BkMSNx/VYOkSFE6o5XhtMrT1qWOECZO?=
 =?us-ascii?Q?c2BgKMupASh3qv6CrfsXkvzLiu+N1UynOH3bhrLGNjapDMqCdURyH5Msg03F?=
 =?us-ascii?Q?+V/eEGx8zP62bUth0ZqqfsVBbEna9fR+DxpLZIjyrBS7B3fb/IIJ8Q7MJ3v8?=
 =?us-ascii?Q?GQd7TYgyESeeVWVl6Sgbt1aWQWe15XeqQguIjRVFT2u9/EzdpGsnfxY8aAri?=
 =?us-ascii?Q?mWzJVqd9B0kDd71kCKCmhUupUhjXfUWFyX6hwsfGA0n2lQRtQthySqv5HU7R?=
 =?us-ascii?Q?ygOYg5NQJ326cgevp/ZqzyFS6KrV2LdIsDDr6QtQdIhtJIS2b6bVInAcIxUW?=
 =?us-ascii?Q?lyDbNk1JAK2egjzDFMWg2ip+6vof+sQj7MaKftev?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS2PR21MB5181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a7020c-c936-4c5c-6d5a-08ddb932390d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 06:32:31.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RozF2YMMo0MrMoLSIE7lF56sv1V4Yk9gf28PxNMXK1HV6gK0QWhUxQkrs0BrA7ElOBFgVTb/tK+WS2UbyE94jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4965

> Subject: [EXTERNAL] Re: [PATCH v2] tools/hv: fcopy: Fix irregularities wi=
th size of
> ring buffer
>=20
> Tue,  1 Jul 2025 16:18:37 +0530 Naman Jain <namjain@linux.microsoft.com>:
>=20
> > +		syslog(LOG_ERR, "Could not determine ring size, using
> default: %u bytes",
> > +		       HV_RING_SIZE_DEFAULT);
>=20
> I think this is not an actionable error.
> Maybe use the default just silently?
>=20

How about just fail fcopy?

This will have a consistent behavior.

Long

