Return-Path: <linux-hyperv+bounces-2588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1B93CDEB
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 08:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E321283439
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CF33981;
	Fri, 26 Jul 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aiPI4Lo+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2093.outbound.protection.outlook.com [40.107.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3582EAE5;
	Fri, 26 Jul 2024 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973745; cv=fail; b=enfZr7gwmL2ukArhzD9xqUulNNsMpIcvpVA8WMpdmIJ22hgIWCCALBywFVZrdY/ad7ogIdyLIJvRD8hhUocDXo1Dk18Iw8mvekEQ4ldUB9FfmjpdVgBgSPgdRyv/4Xdoh/41GbFK1XX0sEbfcan6kAGfhGEepg1oS030vxMbcWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973745; c=relaxed/simple;
	bh=jT/jrvCaYmT6HvfV5WURASJjYv5SQkga/ZQ1Urnl1hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrSJISZ2tnT8/5+JPcq04uxTs2UNImkZMNIlT2SzOHeSGFLqrYpL60zxQw8usnMg6L3NbWJMRsVuV3illtPi/t/25ttiX5ssS0t3+id8TbfH+5D2/M8Ga4vDTtElAlYFyLCn2IRqmFGyxhCpwAqVZZqQNSX8EEukF8xQ1Bn63kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aiPI4Lo+; arc=fail smtp.client-ip=40.107.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi+EHWGjPdZJhNG5frkSh4twZEdkk1QQFliGITHuCHbS8ze2vi0DYnwvie8YzQNqjJ9+mG2LhhFS9e+bPPwXVAbtadrRO40FQDHhuhje5oR6N0QJM7CgCPAfxsR8TTx5T5oImUxs2aO6FFNLoH67jM4lMKNB+ulV3Edg4TCSuitheQDSAdQzZNQ6Opf850opbCX96QprfzBiC0eFX3Gl4WU2Pw7T5QjnXoipo63Z52WnzyMPOF6MwXGZqkPF41w6Ij5xQHCnm0Zt8XCGdek15G3d5nQVY2vjNYOalDj7cJYc0D9h0VjDkwRwwjJmPs+v3Dmp6/JIInqDRcp/gJY2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpxCVnk169x0ImNLRd9wz8S5UDOFjwyOT7iqeZVF98A=;
 b=BAKHD9Gy/B3AiZrv9ayQo/LYaxZ21OcM4Qzt9NfVWP6Np6FFI0UUNbUnEQwHkS/dkBmcWBjBpNc3dRxbQwRVvXM7LIFHBS3eSzwXUjx+ZlhwTL4TQ8pP5NBIOCY7dBV6COmRcIctDHLDHjhIAdqygULRq9nwS9XVluqEP7IGFJzTfXJgI//zvOuwKjfdhDWdsJMtGro0SRRg0PPauaxjkYVV6dqAC3js6SEP1gN5zOFOa7eaLKk2kjg3bB+CI+NnnfndH1m6rQjide6/SvDq2ZsWJAVQXkDD23FoWAyc01ppv+uDPnCTPCrrVAmweYoBWhrC8vyNMYPHEeWQhLNjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpxCVnk169x0ImNLRd9wz8S5UDOFjwyOT7iqeZVF98A=;
 b=aiPI4Lo+gtkP7OKeK3ynJbmcEpjja3RD3htjMGAgmKzKTV8InJJ3z5P7q219KUp1tYqjfkGv5RJszsapWj/mNH6vYsEEJdPf9RcE9qbYGeqNOoMCHritPw5yHm1MyLHc61JD7anwm67yrdw7xZw0OsoeHZ4gKiGjgq9Kew12Anc=
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com (2603:10b6:a03:3f0::13)
 by DS1PR21MB4353.namprd21.prod.outlook.com (2603:10b6:8:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Fri, 26 Jul
 2024 06:02:10 +0000
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::dc0d:bf6d:3ec8:3742]) by SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::dc0d:bf6d:3ec8:3742%6]) with mapi id 15.20.7828.001; Fri, 26 Jul 2024
 06:02:10 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Nuno Das Neves <nunodasneves@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saurabh Singh Sengar <ssengar@microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: RE: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Topic: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Index: AQHa3qhEsOrm9cI6AkSqBV/e1CI0a7IICBlAgABzbICAAAmBoA==
Date: Fri, 26 Jul 2024 06:02:10 +0000
Message-ID:
 <SJ0PR21MB13245A39F619F5C67A1D7BDEBFB42@SJ0PR21MB1324.namprd21.prod.outlook.com>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240726052651.GA28809@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240726052651.GA28809@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cb3c2c38-041d-4174-a472-deb41536e56b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-26T06:00:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR21MB1324:EE_|DS1PR21MB4353:EE_
x-ms-office365-filtering-correlation-id: 1784daf4-a1c8-4bd2-b82f-08dcad387cd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2WZz1i4rb0+npmWLJfV080U1Tio86DCf75ENn77mLVRC129UjCj3NeY8mUlx?=
 =?us-ascii?Q?5xS6BfnvMsub61PlIVtdCbDxSmovM4QddNEWP4Q+DguejKBuSeIa3rMpPGXL?=
 =?us-ascii?Q?gBNaElPk91SxaVGoWkWFg6UVEJuE3GEqpHeD8xPP4lnBWmL9TtOZDlcrH89x?=
 =?us-ascii?Q?7b3I6Z6aY4SQ7f3JS4Ja2qhQabXSmGu8IQqjrXkj0bHcgMOTPKcihueFGbWS?=
 =?us-ascii?Q?UAZt9mpRwMdY1YWDfhULuAOpi+iNgjmYGQKVtnQdvTMhUqvbBZUekFQnXtLr?=
 =?us-ascii?Q?LUGrzaknWmF7vy/Km4kLM4a1oGhr5vlBGxirToU3mfC5ClHuRPkvTaxLZXmQ?=
 =?us-ascii?Q?1JiSCs4bAMStkJf6Piwk263Kqtjty5Qn8ZU6OlWA3oy34hY1zpKd1Mjiw0FQ?=
 =?us-ascii?Q?k5zSrbvfn1JSQ7IPO6S0NtZr83/w16lfA8B8kEkJtMAm+yj77M4t/fA5Cl9p?=
 =?us-ascii?Q?M+09QZcrdDgy5uHNayZMQ2gORaGnlg8IU1UjgHNUrOXSHsgCIxbHECZ9VdEn?=
 =?us-ascii?Q?v0UsT5WtRbSoG5tvSrllbSQ8mS1y4dzs6rbqd1WegY77e7UYFbSxq8iHpPzf?=
 =?us-ascii?Q?MnVHvPra7MyPxyt+Wz+PYFcFO3BQLWxJA3RYl4fbusJnV8GT+6Ut7T8OCtaK?=
 =?us-ascii?Q?VtXfRBYZG1MZfNUbkiLOGVmT4ze0g1W217j/c0YjBDrICx4utVCINIxV0mxo?=
 =?us-ascii?Q?GaKRIJrz4+CHEooLtcENNMWSr0jqikg/mtkcDcNvqAzwie4edfWwFlmSE7xr?=
 =?us-ascii?Q?Wmg/aBaYm+VGm8TrBDdmq9tNcVWnwPhVIKgjcI6TJNaLdiAnqvWKV50sxy92?=
 =?us-ascii?Q?QTujnALLLeGeYwnYUri8eKO/z+toBmKZfrrQHKzdlpqgVspisDqI84rxkCl+?=
 =?us-ascii?Q?xOxvrADnntHyopCNqI5goDEj0NUjRrK6ENJbb59kp8yVFqsB1YZdFVdsc0by?=
 =?us-ascii?Q?sM/Aqd1VJx/7d37tJsMeXkpMUPzPAuVA+Ngi9xuSEjFP5USp9RIOBsGnPRJZ?=
 =?us-ascii?Q?3wiRB4A2vOc4OFRnHIRKvHwNA4Ws58KFoOXyVngdkarSCUYTkHDAgySBoA5b?=
 =?us-ascii?Q?nxdS6kWmsXKuQWDkgtvOfMIM314OA2IT4zch0S1zBwoU01/5ZrsL7uzkOFLL?=
 =?us-ascii?Q?F5Qe9IGrLhh4ATUVXxRR78WItnD8x8xIioueD7SPOgYmXAv3wUKBJDDYUYZs?=
 =?us-ascii?Q?Bd77dpkeacPf3IywhI4WdNxuC6BLIjz195NxRch+pJR6srcamx89j8fXF9h+?=
 =?us-ascii?Q?AvDHJL9Zn6CBtQ2MJWWi+4mYu4Na6JnGx+sLeM1GNnQZi1ACFuu2dNwP01gl?=
 =?us-ascii?Q?doIQjZE573hqaMu4Z93SLpa93XvU606Z3tesdJQrbxjNNxALwv2oCb2yI1ov?=
 =?us-ascii?Q?5W4W5ZMnGo2GmjcR0vPX4n5gMgq47rywS+51zPgKkV8SHCpsXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1324.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f48jEoKvB8DeLdMQMPLUkHks5awk59Y4kJg2UCQa0mN+AV4fSjzIF1AHY8IH?=
 =?us-ascii?Q?jPJkuNyQ3BF5Qk6hpF5DrFPjiyZWoBNAImnyGs4pmH0p/3n/G6zrmJhc19Aa?=
 =?us-ascii?Q?U3+ib1FfK93lh8nIniWInS7EVcc4jSaYro3kZ5MTirQtnhDq+qa6k9ztysZO?=
 =?us-ascii?Q?rGbyRCcBbYe9WWMvitgMFm2PlEATxq+p9rPwEtxNDAbZnXa3brxu7wEF1UR1?=
 =?us-ascii?Q?SrNYYYCFm33PB5v3ys9/L28iGgWQEq/JUvXU3hetLI7zfzfGDoPJYHzw5Cka?=
 =?us-ascii?Q?hwl2cpPQnhnSoc1QyNWCk0ju2JUWR5Kmy5gPUA5Ea7M+9pvvSDZjXnfWaNtt?=
 =?us-ascii?Q?x6nDyR0c5s9q442HfsDmbIKVub41xOZOXNrfYUt209asNP5IYcQ1r1Q/veMS?=
 =?us-ascii?Q?TrugUcNkTfRgGG/XMZTqorXbUAMFOsfJVLY0UMT8JzmjlOG5l90ogHog9MrO?=
 =?us-ascii?Q?RtUGURXGlGTyzbPKgj6UAnmT8YvRpyC03vPx407D2Y/g+GzG0TC0kuwWDmK6?=
 =?us-ascii?Q?dqDTUIkHgIsa/TRQgMGCny8P4m+dup0NsIA4/KMeNY1UMTYPMoRYy3wdX6YN?=
 =?us-ascii?Q?1bEs2EVfSzz7mNJf5BUCGpgTHqSlWF4iTzExl9W6YP4OR6ZbEzKY/xd7ccMd?=
 =?us-ascii?Q?MXJti6wiowcRDUw5x3szxJUX3xovhBmzKJXqBAbZ4tsLHDm2d5n/LLK6E2wf?=
 =?us-ascii?Q?AGyK+Vadij4q/WLmYp6FH1s9FpVgXKyQXm8XyAXoKUD8o6opdkNPDEXT8DDq?=
 =?us-ascii?Q?Ci5np6/AkpprWap8XzevL/qzzruvZeNtHRvNrEGl+zJFTurpYwop9KG/4w1r?=
 =?us-ascii?Q?H6WytN6j+y62LFoRKuY0spljat5RJk6wW6Fxe6RQjm6uk4YXYvGg1i2Evm6w?=
 =?us-ascii?Q?ByIFr60jeQfEWxozTTfdMMayqI3W+V1HYa6jPpRrtEhXFlCUrm74EO036i3r?=
 =?us-ascii?Q?L41ucQW66S23wipMiRuyoIJSPZ9WDRjm4YBk8aDV6p7UkttFlnbclFRd/MnR?=
 =?us-ascii?Q?5DKdHpCvZEuWqRFXjdYhNir8gIqENaa9PUozF3YAxhHyEh10DgYwuBSPKVXJ?=
 =?us-ascii?Q?uFBHpxqV9Cvn4lth1+GdqAOVtAx1FjaDAnk4DrHvMiRxkvfUwIjsDrg1CJCg?=
 =?us-ascii?Q?D3ekGYjmn4vgsqhG8/xsmykdQkINBI6kopnfkUrPmBXotwAXT8Rz5xStBCzl?=
 =?us-ascii?Q?ThnWIEAoLfimLBvtvv3zQmNeynNFILUC4HoCVpMvqPMFU4iqZ2LIbT/HJs2C?=
 =?us-ascii?Q?Np4VM7+BZaHyp1wLoECOaSIptmR2842vaDqRvOzDWhzn6PxQgaacwMFdNrhc?=
 =?us-ascii?Q?rz7+lf9vuLebJ/Gvg2pdJivGWWjMd5y1rr7YVR0kfrHCXdF3bfBzf7rIIJv2?=
 =?us-ascii?Q?Mmjy3fNqpmWQX84X94gW3PuN6/rA9SL2cqki8hxNYt+dSepU26wrTNwg5hqU?=
 =?us-ascii?Q?ZjyfuqpdVMjRrLNuoybVxHtl+Va06A1p5xu/3wpLOt3Qe7VmW6Fm/e0KXpUC?=
 =?us-ascii?Q?EMJAkVZ6t93Rb4Ew4Ki/PdVBCrOigHC4Fd1T4Fkbc8QM1zWEQvH697VRGPoo?=
 =?us-ascii?Q?1HFqwfMY3iq3ubDvHhCL9iWjw1alZNh9X168EEhT?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1324.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1784daf4-a1c8-4bd2-b82f-08dcad387cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:02:10.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJRnEcuu/7WpYMpqOkWpC+4BG9DdqjAiHv9MvXGXeYQJYi0BR4MRKSLel7wb6mmCmjaK9QhCYQCVc7JPhvDiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4353

> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Thursday, July 25, 2024 10:27 PM
> [...]
> > > +	ret =3D __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
> > > "hyperv/vmbus:online", false,
> > > +					     hv_synic_init, hv_synic_cleanup,
> > > false);
> > > +	cpus_read_unlock();
> >
> > Add an empty line here to make it slightly more readable? :-)
>=20
> My personal preference was to have empty line as well here, but then I
> looked the
> other places in this file where we used cpus_read_unlock, hence I
> maintained that style consistent.
>=20
> Please let me know if you have strong opinion about this empty line, I ca=
n
> add in V2.
>=20
> - Saurabh

I have no strong opinion here :-)

