Return-Path: <linux-hyperv+bounces-2586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E993CB9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 02:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1410B1F21F3D
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA104748A;
	Fri, 26 Jul 2024 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dncsEHYL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020108.outbound.protection.outlook.com [52.101.51.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB06FB9;
	Fri, 26 Jul 2024 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952109; cv=fail; b=M7+jZQ/8JEJsF40zoWeOGHnYIc1NV0fWB+pKr546bvhTcM0/RmwTqJ3nh+2J0+nR/XiMLUIXUJUgPri4s0iR/q3HI43eXICH+oYMYb2VHkl6c3AjSc3t1t0KNYE7W94HaRru7NhwEvTYTMVYOeVelxBQmP8bGZygx4weW7ybyIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952109; c=relaxed/simple;
	bh=l/IvQzp08Dc3z7D8S83bcJr26bcg6Tf7zchnZb8nmAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWcLnGdCYNp7dhFwsa334xmvN+6Nqceel81SLgN7T5yZTCNS3QrrylemLt0uw92uY56KHEp7lNVqwukHGmRajKoNYi1T3p76F2AQa5m3a2ICNbdjmupR/9OtJCXtXyrwRi8y1r7W+evzvj1khD9VjsuUiWLzMvD7oUb37hDJuP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dncsEHYL; arc=fail smtp.client-ip=52.101.51.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWU2faMTdQssfcIHzGwpwVF6BGyZJwNgng9NGFzmdoYLikrCf+DKpZYaM8DH3lG910ErPddEck0EZwVoRfe3JznCFS8Th5DELblGs/PlmtdgsGTxIynh06xVDfdG77PdfDpIQj4OYXz46lWy6CDa+Gdwdfg52wPVzdp3Bv6tZsFO7ezoRtDgA8DfcuQ8y5ZaJ4/722C7pBo7LzTQPhD6HjTieBx6BfBVadR5N+Eb9EuTtyhhX8y+6XVNVdsl8acm7tQwc6V7no52eCopCbIuHvBn5sUvMF2l6850aT7IHD7Q7M65jn1pOrN3epEIN1KxHeeaajtN6mwa9D6j9VC9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kO4lpAsXHTS0dFcW5AbfMbBHq41JEI35FwUkhWPBq8=;
 b=fugMY37LqV06tMgvPT/jO1Jl2lRQlTtwwzOic0AMFoF7pnM7I9PZxYzfB6fj6r3LSAjgChJZfbnboFy2S+aD3wFlyfllyqV1yFIUeyIA/2Uvd63f8fn92WYeyqvS16xmQ20vyb0XcgPpxp70QN8gF6u49jny02pibhOh5TkI2TKDde82hc5FyTBsfkY0jBzNag8Fbb8Vl2KFDBnOJHqfPw11x7RcKqEsgLaNxOi5Di982ckemcP3FhP6o6B18PMIrZy9NR+hURqmJF5BBZhJ+wj49OK7ceIxpH2QOHMMk1RSjT4lJv3QtZMO1UgEs+xH32VWNrQsySjv9R4lRHbEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kO4lpAsXHTS0dFcW5AbfMbBHq41JEI35FwUkhWPBq8=;
 b=dncsEHYL/+/Vl41QvtsDG+dgCS0KKMy8ZM9CE4SZ3noIJoCrk1dRpi4LUtD/YTbiYIy4t+y1ZKyhjU1YWRl1WdYRBOjoTvDQHKGdx7d5i1WYj4lPP6DYTMj46wxQHG9B/If/xcAloexj/nfGTlBrmmbpijmXGTI9iGmEIqjhmRQ=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by PH8PR21MB3956.namprd21.prod.outlook.com (2603:10b6:510:238::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Fri, 26 Jul
 2024 00:01:34 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7828.001; Fri, 26 Jul 2024
 00:01:33 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saurabh Singh Sengar <ssengar@microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: RE: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Topic: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Index: AQHa3qhEsOrm9cI6AkSqBV/e1CI0a7IICBlA
Date: Fri, 26 Jul 2024 00:01:33 +0000
Message-ID:
 <SA1PR21MB1317797B68A7AFCD8D75650ABFB42@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2db04f8d-5bfc-4c2e-9812-f80a77e1f7b5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-25T22:33:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|PH8PR21MB3956:EE_
x-ms-office365-filtering-correlation-id: 33fa3a9e-de2d-4e90-4b15-08dcad061c56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pvBqkjp7w5nNIpVFtITZROAujyawvMS7LbcQ7UdqYY+TUIYKsO6M8SqASwhZ?=
 =?us-ascii?Q?d7YjpjEbIItbe9LCRjaQhucOSTDU6t0p0FAmspDAIas/BdbGifxbDyaF9mGp?=
 =?us-ascii?Q?/Ret/BoSP3ct8m7i2mQlMxo3wKBJuGBMhxuoLJzUX+9Js3fAATJWurm28obD?=
 =?us-ascii?Q?sIthnFMDY+jOcV6y3WHGigLvWUEC+pjPgOSID2njkm0sa6tr/QGoy9KoD/oh?=
 =?us-ascii?Q?kBXNKDTrSzfq5mWHxR4K3eFvGwwXPMMxxTNi/E1T8Y5Yno6xP1+tX70aadb+?=
 =?us-ascii?Q?KVwKODlSJ83+nchdh1N702gwtCJ+Os2KVsQQm9JgbJvETNtfLy4QlcazZyyk?=
 =?us-ascii?Q?04T5DnGxxcj7aHQlLWK7vKxkeD42XsnqlO7wvhLbosmpjSrHx3sQsdu+SbSP?=
 =?us-ascii?Q?5l6UBCtXYBXdMjvVp1IXURkWWl2Wq2bbDivjF1ebKnziibI3v73xsSReW02E?=
 =?us-ascii?Q?DRQ5vJfR23xb6WPZ7iWUXwzJ4LteXwzCjyCf1ss3XYc76LDSx2xMpf5FXFfJ?=
 =?us-ascii?Q?vSdHz9MrpL6bDtb5whgMI9gsliIV6TFk3orOvCfMEOUaO3xPo9zcd39oGjur?=
 =?us-ascii?Q?yvObHrHoglswuBQz/6gR4hHW9D02RXHcyo8YrhrVuj3lTeNl8u11k0W6eaEx?=
 =?us-ascii?Q?bp128Kg5H+9v/56X9L8PtOxLFO+fMH2uYncS+hadC5YB+pt0+UXSy4dyrwOq?=
 =?us-ascii?Q?6c5t/+p5K/fZkZCkULwD7FxX3DmCh/IPC8LgBoy6xIcx9WkoyB3Ii9ZWNHfw?=
 =?us-ascii?Q?crxhRc/NcX2S1ZMwoztK66rcm9v6Wtg5H7wpzwY7BvJ5bX28x+VCpfFXAlUj?=
 =?us-ascii?Q?UVLeMb+jpKjT1/2JeCxBA73m2Dvys6mKOAVsf/I0gz6JJJ/JFEiFbXRTrbMt?=
 =?us-ascii?Q?E7C+rz4VNUuZYLSu698331ieFIUkSr8NmOfQKlLhR/cXVAEofOsONnkDnWRR?=
 =?us-ascii?Q?4dRqYHJIHhZkVkOvJBjUXsARObTy9eVEu1DgNrGa5FzYj+emNjxqjsRviZrc?=
 =?us-ascii?Q?2fNnX/bNdlZbeKd9hOaHt2ZHlJG1R47oGcrtlrR9lh9FAc556yeX2SG7mB/I?=
 =?us-ascii?Q?NcZk54z9V+M0ZctgDe/jlAXQydXo1uuuH7hppLHYYsItuNVTGVggkwbmMwg/?=
 =?us-ascii?Q?+Pg4/YggWsVzFHKfKObODD6so4HebYCmoZJ+qfa3zEy3sQo3ecsiSAtfgsGY?=
 =?us-ascii?Q?Aj8T8nGgnLNcUV1XBuvBPXAVG7EGu3LS5SYAsqQmyZHw2j5xmn4Z/s1gcP/7?=
 =?us-ascii?Q?U1dqD2xQKz1C2gP+LJRkndbDM3u/wXQWntoc1hbleZRoYgmi7NeoJtQWjayb?=
 =?us-ascii?Q?PXW6VQ3k9JiClUC+bFWJlHuP1tMCi7ytxg6JP4Q7/KX3HRAcXlZrxZuNjI3f?=
 =?us-ascii?Q?Ck6s2aij81F+6tPQiIGdDVZwW4C0grEV/HyKM4riftXzc1VDcA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u+yAMB7bHEWtVj3q7enB2slO6L0P8I5xYQsHO3m9G7VLa0+83MDEBr1ZZcGx?=
 =?us-ascii?Q?5Wi1/jgShQaZcOkz7qF64ZdVSv/6R/6gEsHjjPdGaxvThAWeU1YoYcuxUjQq?=
 =?us-ascii?Q?R3YsPITunxzl92ylnq/hLCKfMZkj+wQPFslaX4zluVF0Hr1ULeUeCCzxmK1Z?=
 =?us-ascii?Q?02N6j8M+oaRpmrOGKqmF9JvMAT6n0hmAjwq5s8yNQwBHtBfWTkWiqJVY8XgJ?=
 =?us-ascii?Q?c1viL1G4bvnTo/T9H3wl0mdhCFWTrahi2gU2iPRJYkH66/pUdWVwF4gH9eNS?=
 =?us-ascii?Q?B2qg+4MptegZmkjGNRlm05f0ws+gZ7cDQ73fBNxOF7Xrf3uLCjSGIF4PcBh2?=
 =?us-ascii?Q?vb4XdE3EsYpFE0VwiLk2+M+Ux47t+a6UoKSQywvBxI+shqViqNFvBBMaBBl+?=
 =?us-ascii?Q?Vuv93Q7f9HvNgi1idp40mFBAODCJulwLAkJHT40p/qfv6nRzmyJRhin1+aTY?=
 =?us-ascii?Q?u7CJB4QQKOMMNrDtz6u/VUV+VERvw9cqfHvCLsevKmoahP9XIxEMIl0hshV0?=
 =?us-ascii?Q?LvKiUY0dEOsEwtYklIbZylOhxUNgH13meq3gHGJvshZWXyaQBGH6vmCKnZlA?=
 =?us-ascii?Q?k3+6g751kOECWZJZCWLUvUPt2P/BIJ6QdTvkC9AvlnaNhTbipbiRRkDsxyvJ?=
 =?us-ascii?Q?TuQc6K8Tnf+W0nGz7DKDt82XvAUFYTWymhwy0b3wyYb1kTGa9qD8ro66QCVt?=
 =?us-ascii?Q?83Gel3ewljMjBQWBOGvB7I/7tBOk+PjfaOgI+zq/p7N7s8XgYwujQ8Cf3rux?=
 =?us-ascii?Q?pQ6jc1VZx2fObYCd1ltwRC7b0UG0dX1nNy4dsnyfnnNDTyuIk1Tt2GO40Y8c?=
 =?us-ascii?Q?/yfVrBkJKDYJeZQvzntb0LZjwK+AHeIp5MRW++qCT9dQF8r6j5yJjhVqzC0g?=
 =?us-ascii?Q?Yt8XcJlMifPPZbtxdbIiwIfKjm9vp9ceEaQruXla6qaI8sc85vwKyKcdVPJh?=
 =?us-ascii?Q?dkACdlukhQJ/VQNKk6qYdMS2LUgTpHajPSq3HEHiMUuacTZkfjK4YI1YD1iL?=
 =?us-ascii?Q?V9vKdz5smA5liKvoOwUIYh/qCd9abkC+zs9LmY+G6nUqCqbdjEWjiz8sstas?=
 =?us-ascii?Q?5UNV5nDWlsOsKwq8/K9VSFb1KtdzDOCEeGKosE7N8oGytDVjowAXsaVZjFlG?=
 =?us-ascii?Q?tza/mJP+1It2Cnnj2a25jDHBQheQBTNUJaU2akovmcGfR37whnTXg4hF83cZ?=
 =?us-ascii?Q?DskdYigvJ9Zai2xpWnBgCXrAO1DQU+A5FERvt2lfSEUodQBoQIZBwW8PUS15?=
 =?us-ascii?Q?Q52pyHeEl0Bqx5CRxTHLiX9yiCEghhLV3ZTmdwcIaUfz5nliW9h6QuMXeaFz?=
 =?us-ascii?Q?GPCfqaoolff+OY5GKLpMrNJQ/5FveGjuyLA4E065UFAFadK+oMByf0LvU+jE?=
 =?us-ascii?Q?T0kvhi0o2nLVBdisrjRRQFXnnW+4uafTL3x3PDq+iI/L2nBrLCDi5lQLiyCr?=
 =?us-ascii?Q?mnA0E+LlO1fattOxoCRvBe0GewAPegJ55ZWKe/AcKM2YVzrr5bsWMpY9SnGZ?=
 =?us-ascii?Q?+9ujCzpK/d7Izr/HpwaNBFj4qV60w+L2pcrSpcMHGCng2owhX3kmO6hYAXIt?=
 =?us-ascii?Q?q1P5vM2I1yJQYkoj7l0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fa3a9e-de2d-4e90-4b15-08dcad061c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 00:01:33.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXgxXo8/exX+xmQImo5MqTG4hWdzY75PX+PU2mKvXullrhY0am2Ccx2xfGw72lZg0S32/HmS8GVlUGt0v/fvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3956

> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Thursday, July 25, 2024 8:35 AM
> Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks

Without the patch, I think the current CPU uses IPIs to let the other
CPUs, one by one,  run the function calls, and synchronously waits
for the function calls to finish.

IMO the patch is not "Deferring per cpu tasks". "Defer" means "let it
happen later". Here it schedules work items to different CPUs, and
the work items immediately start to run on these CPUs.

I would suggest a more accurate subject:
Drivers: hv: vmbus: Run hv_synic_init() concurrently

> -	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> "hyperv/vmbus:online",
> -			hv_synic_init, hv_synic_cleanup);
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, vmbus_percpu_work);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(works, cpu));
> +

Can you please add a comment to explain we need this for CPU online/offline=
'ing:
> +	ret =3D __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
> "hyperv/vmbus:online", false,
> +					     hv_synic_init, hv_synic_cleanup,
> false);
> +	cpus_read_unlock();

Add an empty line here to make it slightly more readable? :-)
> +	free_percpu(works);
>  	if (ret < 0)
>  		goto err_alloc;

Thanks,
Dexuan



