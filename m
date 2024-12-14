Return-Path: <linux-hyperv+bounces-3480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529999F1E74
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Dec 2024 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A154A188875A
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Dec 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74B18FC72;
	Sat, 14 Dec 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b="dLkgvLBw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8E155A2F;
	Sat, 14 Dec 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177980; cv=fail; b=b0D2RJFj1k7hR25BPg2jCwUSrWgfIobEPyBXSDjJteqg54x8bnLC8x+TDf5M/wutg7x0bdzWlrV7Op1gAppyaBJtbpQR9DiW5aewF0HwjkaXW+oLR4HHeK9Wln53D9KKlM1AQ5aIvMt8ukGlwWQvmt1EaPlVLnUv54kqfZYGTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177980; c=relaxed/simple;
	bh=qEOPrH8cISY+xcV5OTEhnpWwf+Ss+e1eKV2XyMG/9I4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJ4hsVJliwPBScjsZgYYv8ZGF2bV/V+tj8j7nzr4HwQP7+Z5CJjC3SOT5b6pgiEDMEKO4nIkctTpi/cxIiQBE4emIPJUS38efhM2CgM8KsGKvXtMcMzvyLxDwNAdKtmsWIbcHXO61kheAdO0MxAVoMQr3Osw443jso6YY7msVRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=pass smtp.mailfrom=cloudbasesolutions.com; dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b=dLkgvLBw; arc=fail smtp.client-ip=40.107.20.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngvgs278DeRxjrqI72znDka9O3Nv9xY09KL0x3Inx0xThSMzof+GOq2HVqTElnOk35wSLJ4oTls0lnKDFzJIEMb/m5sWyLzuFuQvh4/qdZ8XppiXM61hDqrP4EPoFc2qRBpSMtM+yeHxLip8AW/wVgi3MfoKT2t9MBGL0ttGqh9XrXV6jBVZ6HfhiWglvHiiNjlC2mP2z0D4LpMty/exFyjTmry5plW1a24zC59cZRHzUTSEMMZW4BLXDI8lrGgkHsxAqeUu5ymcZyBqZ98BEpt7eJ4QIZ5WhvQdzQKnHIy2o7rROMwKRLlWQww7/2odmJux1N393cHYR3OJk2vTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEOPrH8cISY+xcV5OTEhnpWwf+Ss+e1eKV2XyMG/9I4=;
 b=pot1lgJm6lXU95gRhy5TYzRM0l5QhNYNo/1AHjEu7egt4umSwDtOvW/6IE/Dz98MiakbZbC3UHdmw/g4d8yKOIfpbO7jmXMIjEfFJuS6ZDj2CxHLQQ5m38+hEZWTtSzRkYoNkS5G8ARLiqb3TlJbbfTdk3rCa0/j5czqXfsPmhYXmr9sS7GD6EV69XYmq+4v+HAi9CKg2cGQGBFYvJAvy87XTfBXgg6ZxVMuQqJsYD8Fwi86VDTKcdLYhBsUaTJWJ2dg9AZ3ryyepPn8fIJdRASKbY8FOkp+tCZbcLhDxg6qSyDYaAwE5PMi+f/AebTSBmCDTy1cTiOdVR7xeu6yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEOPrH8cISY+xcV5OTEhnpWwf+Ss+e1eKV2XyMG/9I4=;
 b=dLkgvLBws9T8rMn5cj4y4U+NQqpERi14ExPpL023U024gLKznI1ISIkzQglCg8MJ7YDrMUtpge64VxtjTF/EsPTkCeZEWsK0ZpGKnzVcfSDxGpL2Tm6mIn7S9Sn/nSeK+V6fDj9KvXBQD3CmEi8owXxS9mb8PZtVe/qNtSXOrLw=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by AS8PR09MB5401.eurprd09.prod.outlook.com (2603:10a6:20b:37a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Sat, 14 Dec
 2024 12:06:13 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc%7]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 12:06:13 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH] tools: hv: Fix cross-compilation
Thread-Topic: [PATCH] tools: hv: Fix cross-compilation
Thread-Index: AQHbTG/a1raMAEzCgEqnFkePb4bJTLLkfAcAgAEri4E=
Date: Sat, 14 Dec 2024 12:06:13 +0000
Message-ID:
 <PR3PR09MB5411DC88FF320011562BA32CB0392@PR3PR09MB5411.eurprd09.prod.outlook.com>
References: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
 <08380797-4dea-4dc3-9312-7e4c69090cdc@linux.microsoft.com>
In-Reply-To: <08380797-4dea-4dc3-9312-7e4c69090cdc@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|AS8PR09MB5401:EE_
x-ms-office365-filtering-correlation-id: 0cd660bb-945d-41a9-76d9-08dd1c37b453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SCRsRRHNvkZ86m9krxspB3S3D1tcry9oSA9H4XT87FUJoKmV3D39Qtbo8+?=
 =?iso-8859-1?Q?oGf+CVtezIWZwUIRxHhRV+0r2+n8FBi+cTN3d4DJL59zNMnwGFSE7eW3G8?=
 =?iso-8859-1?Q?G0en212oY3LY6zGtPgu3bfZ9F98ybTv/qYDXemblaTNVXFNbvbmqfNxr5P?=
 =?iso-8859-1?Q?7gJkzXb7fsRv9nFNt7X+w7V8a7EFa2/fLx94IvsYYsfRHT0ZqoP09ZnROP?=
 =?iso-8859-1?Q?Gd6kv1Gn0x2osVogE9Lc3X4XHMcpnyA6md8GgA9nr0bbPs3Q7HzdsqO6Qu?=
 =?iso-8859-1?Q?Xhtg4Oo6vlQIIWcW1OGIgiry6dd3CZ9qZ+5SBUYloUfC05IPDA+xwImlL5?=
 =?iso-8859-1?Q?luJL3JOqXLjFNcKXWrznS6248zAmwnVQ8bcbk/NAYZvNps8w/yqoL4Npsr?=
 =?iso-8859-1?Q?nXydU9zxDxz+C4pvP+SRn1fu2/i4EjzHQ7jbXX+OjhZNRek6XYtiHagrUi?=
 =?iso-8859-1?Q?eawevhw7xrfrLoj+cJ2X78IBAZ0GHLLfIfVthQgZtMzbz2mtrWUtHcZvZO?=
 =?iso-8859-1?Q?7CFntIblckEDrLHzSnQddwE/YOvPpqQv1U2z4GidzEj5LXrBBr3/LWCzCC?=
 =?iso-8859-1?Q?egIiUuB11wXtJIn/djhadyi6UsRnunj3Ys0XQW/wKzwUAyBeH1blkRMb5R?=
 =?iso-8859-1?Q?Rfj/22RqRt1zxj/LeZcj7u2UbjoEQlXioL6sKccmgQnGiXBTA4kfMKohL0?=
 =?iso-8859-1?Q?eBJS3MCvoyrkv9+n1iZgVL775LpipjRzPtjxpNUYPRLGrIawpAwZI7CmT6?=
 =?iso-8859-1?Q?YRxhdInE0rCrz0K6MN20A/6nJn2pvxC2C9+pfJUlVCjW2ykOyomDt/cqBD?=
 =?iso-8859-1?Q?UbvFCMTEPYGlOStOo5uvgqYIZCkXMmIhTnVpdFr8D2ocj5VsN6abHwqmVG?=
 =?iso-8859-1?Q?0svsCX69P1TJHvh2XWbfwxtZUa1JR5hSzREBbmBSScGGMchOoxIm6FoU7a?=
 =?iso-8859-1?Q?30zezJp047OT/thF7QFuHymi7/iLCuZJa7Nsy9j3iTgc0TKpNk0cS/w8sH?=
 =?iso-8859-1?Q?QS4lzLrAWKiJT7I8q2bb92DSdDSmvTJ5SxgGke74OKkgpuJ8hJyF2qvbKg?=
 =?iso-8859-1?Q?0mlT/ohyRd7UQYqS3rJEWiA5oqSMWZX+MCDMKCIQXryEEEN12dK44ecUYT?=
 =?iso-8859-1?Q?8slASgeHF6I023kya81KAEk7K4OH0lBaTCOt0m8upSOKKP1og8Jt0gxDQB?=
 =?iso-8859-1?Q?UcPa8HCGFc5obDx6bAbsK9W7KyxWiV2ypajHh+yUnyjdzOuhj2StJ4E9UJ?=
 =?iso-8859-1?Q?9jpNRhkUhTdIcvZFqL20ogTlRvGb27o9YluUKD0cIsRvMs2v82LfndrHTW?=
 =?iso-8859-1?Q?J07xapPrO66Rk8MIbgcYDFMrfMw5TECjCqBFLCxY+7UyUxaL3CWaB0n35p?=
 =?iso-8859-1?Q?i6F7VvE83CNmR/UMOkly875XKX23Bon7s3TKcjSEIQjzU7Gm6An9ibB08D?=
 =?iso-8859-1?Q?gAvIxzck80ANZMRS/vEZlTma1B0Xj+MSOdgiAGnFueUAHj9vFtYBwkLykK?=
 =?iso-8859-1?Q?iBXsfQzoifHMfh/G29Ci68?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR09MB5411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W4ZArdXhB54Ym54UcNwH1k4thO8yKzc+qsaKfe2DUNhRGgjNVbPOuuBGR5?=
 =?iso-8859-1?Q?rfX/5qQPXYDpJZREqsGshAKOijk5ksuFHjnpBZYXjKXPLYF/arKJHpq6ZG?=
 =?iso-8859-1?Q?qeW8/y2i26qmI6XSzRPc0Fje+4LEVV7IJZJXzxpiVvN3IDluoxjxjjK0fZ?=
 =?iso-8859-1?Q?usU2RJVphg1lnYP7+MC66YX470Z9aUJL/lEWBIoLzC501wlnTYN3PIzL6q?=
 =?iso-8859-1?Q?oqaSCA7oXsRgXnpSp5blW+JYkTlDlhEQvRGdvKsWZUbivzrf04/moKSzba?=
 =?iso-8859-1?Q?7yhUQipi9bugCdWhiu+HWVEiFlxAdIJ/wIy9fRj45RGPd4DN/Chg6KiTdU?=
 =?iso-8859-1?Q?8Si9YaCZgDQzb8yhs5qPwtgkNVxns0eyPfzfFLwfYtOiSdY/5RxfsvzzxJ?=
 =?iso-8859-1?Q?0i8ugzEH46KrKYpUesQtyu95PZdVIDCrIwlyd+Czzsl6T/Dbs/ugDTYzZy?=
 =?iso-8859-1?Q?E3fr7GzGd/Azh4qgslKvh3Jogz8SiNT7Kac8TW8PLpni6g5JILQrxVcd/8?=
 =?iso-8859-1?Q?j8xhVEKOQQgAcx053ZWKMIB9MzeZMlUGixY85NM2LbwWnfKmHQfzbMz7qA?=
 =?iso-8859-1?Q?rrgYBZajTNV5yzLW7Z+OT/CX2nzezW6WtXzEWX8hd96T6xXDDJ2Hij4VyQ?=
 =?iso-8859-1?Q?xAMchO9t4P1XYpk/mWGpxkygj3dF8LHweNa6V28xg0T0Vd2yvffY6tm9Xd?=
 =?iso-8859-1?Q?BhM0mBMaaSZqcwD5oIyD84N9khCNM8wX3a1YBmcN4q5d6hvoeIRAwbMpbf?=
 =?iso-8859-1?Q?dsrtS8o+3xnP/60ABk7zu85COm18zo5e0bT8QwAJ0VUmfNu/LD5jgwhnBD?=
 =?iso-8859-1?Q?1/zoL12yKKHUI8hzjOBKQk1yBE+iiyX27TOa7afa+AfT/T6zCTByUFATPo?=
 =?iso-8859-1?Q?SssUjJlbXkE65knz5/LkHcNhL2w/atS+UPtCQ9tzjlhBYc/knNy1KMarzj?=
 =?iso-8859-1?Q?XOTaRYFXHpS82IrEiajoRxGz/BIC1sDRqBKalWP4Z3OYYC4Dk2N1U4I2Hr?=
 =?iso-8859-1?Q?PocScJlqM3rDA7n1aLDJ8ggzZUvTvno7DrY5opShkAn0o19qh7SDfY7GSc?=
 =?iso-8859-1?Q?vTt1KLHrGMcmLhOv0BLqJWWN8aWlk+ra7wvi3kkLQ7ia7nm+iANx8WKP+9?=
 =?iso-8859-1?Q?6bGE2kSUG2vmtxfASvIzGZKnq7FAuaYg1kI5ZqiCN1OpsPPe6bw/p8y9b8?=
 =?iso-8859-1?Q?GyCmIWyMEhHWuS8EdsekK2Sl/0vzgG82sf8ILcGrHDeGhK3rTqU5CWyCyP?=
 =?iso-8859-1?Q?0Y/GyM7MRGm2U83k/l/Xw0gCxbS/Gw9ozJXDZEJ9RiIHLuWVp4b/PG+BhY?=
 =?iso-8859-1?Q?vljGhXzctjFvjPtLj5HAo470DFAQaana+/27YF0HYPweF38ehIB7Op2f2H?=
 =?iso-8859-1?Q?aCt+UTDvBharTGLTG3FItrh82Q2QoZ/fx1JDTFOki+y3ecWB1PKzB4RDqk?=
 =?iso-8859-1?Q?rUlpZQ/th32iXtzlOvnYCqCXGojaVf1p1ba1rGsD+NXV8asDZDQMEIS5S+?=
 =?iso-8859-1?Q?arq5mKMcUqjOh1xgpOCnPPjffCRiaCmH2fo5vrO+SaCWI/yba47BMMf2BW?=
 =?iso-8859-1?Q?hVzaipusO2A1Ndjp8sMRRplDRWIlMtDuBxorFaafq0b17n3lZe09N34JOL?=
 =?iso-8859-1?Q?XuUO3/MGVoXpI8O/Ihc41UjojvVdll8H7AUZfDISl8NNr4acaxSm55Jw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cloudbasesolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR09MB5411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd660bb-945d-41a9-76d9-08dd1c37b453
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2024 12:06:13.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FSAw8mBWoTwBzLATHXLvsVz7NRWSgU/lVXJjT3p1/rLLT/J7aPrtBjQjUMEyQ6RzIJzGIF6f2uWuxc8nmHwm14XP1Uv/ulgHHniJpDQ7aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5401

Thanks for the refined patch, much appreciated.=0A=
For Flatcar Container Linux, we would like to use 6.12 kernel, would be gre=
at to have this fix backported to the stable branch 6.12.=0A=
=0A=
________________________________________=0A=
From:=A0Roman Kisel <romank@linux.microsoft.com>=0A=
Sent:=A0Friday, December 13, 2024 8:11 PM=0A=
To:=A0Saurabh Sengar <ssengar@linux.microsoft.com>; kys@microsoft.com <kys@=
microsoft.com>; haiyangz@microsoft.com <haiyangz@microsoft.com>; wei.liu@ke=
rnel.org <wei.liu@kernel.org>; decui@microsoft.com <decui@microsoft.com>; l=
inux-hyperv@vger.kernel.org <linux-hyperv@vger.kernel.org>; linux-kernel@vg=
er.kernel.org <linux-kernel@vger.kernel.org>=0A=
Cc:=A0ssengar@microsoft.com <ssengar@microsoft.com>; Adrian Vladu <avladu@c=
loudbasesolutions.com>=0A=
Subject:=A0Re: [PATCH] tools: hv: Fix cross-compilation=0A=
=A0=0A=
Thanks, LGTM!=0A=
=0A=
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>=0A=
=0A=
On 12/12/2024 12:28 AM, Saurabh Sengar wrote:=0A=
> Use the native ARCH only incase it is not set, this will allow=0A=
> the cross complilation where ARCH is explicitly set. Add few=0A=
> info prints as well to know what arch and toolchain is getting=0A=
> used to build it.=0A=
>=0A=
> Additionally, simplify the check for ARCH so that fcopy daemon=0A=
> is build only for x86_64.=0A=
>=0A=
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio d=
river")=0A=
> Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>=0A=
> Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbo=
x-debian-v2/=0A=
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>=0A=
> ---=0A=
>=A0=A0 tools/hv/Makefile | 14 +++++++++++---=0A=
>=A0=A0 1 file changed, 11 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile=0A=
> index 34ffcec264ab..d29e6be6309b 100644=0A=
> --- a/tools/hv/Makefile=0A=
> +++ b/tools/hv/Makefile=0A=
> @@ -2,7 +2,7 @@=0A=
>=A0=A0 # Makefile for Hyper-V tools=0A=
>=A0=A0 include ../scripts/Makefile.include=0A=
>=A0=A0=0A=
> -ARCH :=3D $(shell uname -m 2>/dev/null)=0A=
> +ARCH ?=3D $(shell uname -m 2>/dev/null)=0A=
>=A0=A0 sbindir ?=3D /usr/sbin=0A=
>=A0=A0 libexecdir ?=3D /usr/libexec=0A=
>=A0=A0 sharedstatedir ?=3D /var/lib=0A=
> @@ -20,18 +20,26 @@ override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(O=
UTPUT)include=0A=
>=A0=A0 override CFLAGS +=3D -Wno-address-of-packed-member=0A=
>=A0=A0=0A=
>=A0=A0 ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon=0A=
> -ifneq ($(ARCH), aarch64)=0A=
> +ifeq ($(ARCH), x86_64)=0A=
>=A0=A0 ALL_TARGETS +=3D hv_fcopy_uio_daemon=0A=
>=A0=A0 endif=0A=
>=A0=A0 ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))=0A=
>=A0=A0=0A=
>=A0=A0 ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifco=
nfig.sh=0A=
>=A0=A0=0A=
> -all: $(ALL_PROGRAMS)=0A=
> +all: info $(ALL_PROGRAMS)=0A=
>=A0=A0=0A=
>=A0=A0 export srctree OUTPUT CC LD CFLAGS=0A=
>=A0=A0 include $(srctree)/tools/build/Makefile.include=0A=
>=A0=A0=0A=
> +info:=0A=
> +=A0=A0=A0=A0 @echo "---------------------"=0A=
> +=A0=A0=A0=A0 @echo "Building for:"=0A=
> +=A0=A0=A0=A0 @echo "CC $(CC)"=0A=
> +=A0=A0=A0=A0 @echo "LD $(LD)"=0A=
> +=A0=A0=A0=A0 @echo "ARCH $(ARCH)"=0A=
> +=A0=A0=A0=A0 @echo "---------------------"=0A=
> +=0A=
>=A0=A0 HV_KVP_DAEMON_IN :=3D $(OUTPUT)hv_kvp_daemon-in.o=0A=
>=A0=A0 $(HV_KVP_DAEMON_IN): FORCE=0A=
>=A0=A0=A0=A0=A0=A0=A0 $(Q)$(MAKE) $(build)=3Dhv_kvp_daemon=0A=
=0A=
--=0A=
Thank you,=0A=
Roman=0A=

