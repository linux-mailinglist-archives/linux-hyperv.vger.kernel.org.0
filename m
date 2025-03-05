Return-Path: <linux-hyperv+bounces-4244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F6A53E7C
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 00:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADB918892AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA72063F8;
	Wed,  5 Mar 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D8YyoBVU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020110.outbound.protection.outlook.com [52.101.51.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CC1E505;
	Wed,  5 Mar 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217365; cv=fail; b=Zng/vgeiujSDTHVPhT5RUhf93XiXD3FkvZuYWZD6BGd6UeKUsB1HsDa1TqX/mpNkVkOuQtksAlM7Np8RN9OgGwoHzXSQ87lEeqkq6KLGGxvPcmvz16mmk24a9wVCsJNh/RlATU6yA4ZmsriEVJQ1WOng+vMy+SYILIEJgl2eG5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217365; c=relaxed/simple;
	bh=iAesW/EGZu5WeCiCBkvZQtPAUE0L3J03cE+W3FgldiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0xrEnblF92cR769jdHV36Z3clkpe9MKjqb77qfXmZGmKX74gH5VcFBTRR0s/vAPAMBC+XcVnHWIio1Af0kQh7ObvSCM+F76yBh3Jp4lKol2RWGoDKBi/B/24+UrrT+YSVE5JLlylDdsF+0GfUzmsE+KLezf8Br5XaXK2mSRbfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D8YyoBVU; arc=fail smtp.client-ip=52.101.51.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRuyA4OW4SSfmVxz+V6lm/UYFAX5qRupTn00hgwZFAUh/CR8sr2/H+zohIIQwMNwbxXpQgq30tFDVCOfK4iN2srnDlDuTUyAbWrKOuu1glqZlX/Dy7SfT5g/9uA7MY4M3WxE8F1DZ+SoHB2uajkpRrmYTv/PK6BccDoWxJGFecIYt+pdicJmrGGvy9BYTSxvdDIuDX+NehFOT/0fpjBu+7PuCh+IWa9Uy2ZByDLuhy8ho1GRUyttnT3zZntvKTuZ3y4Y8VIbS3Uc57cxQ7Pj49Bjk4e9ZG6fFowNm6fBRKzNjH9vQajkXJHsIJTNVFajO/w3L9jTwwGmpL61dZ5/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAesW/EGZu5WeCiCBkvZQtPAUE0L3J03cE+W3FgldiI=;
 b=L5TgP/r2HTisCa2qJBSpvue2pQr0YzjTirqJA/fqDP9z/rtQlfNYyPteIPHMeO8f196OGTyJTsV9nDrGwDloRKIDXA8Q/NpzMgl7QMrzb080j9IxNkdV4fPQjztWvNTxKi/yAf0fGXx8GhBhfwmvA5wv+hk1xpFfBORfCNfpA4uAHW6RDi7B84m5nbcdWzXNpHel4O1QBB6KTU2EU5LMkEdSoUpD8bIwz2Z8Pv7RNg04mJb3IJtIkZbEqDKcqzi/U4PU3+p45KppI3Z4Qc2oWwA7KEKLJPddO5+mihVoxCm34f5LBQONbc03jvfla/5v/WjO0Fujo9vxCuZoqXgCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAesW/EGZu5WeCiCBkvZQtPAUE0L3J03cE+W3FgldiI=;
 b=D8YyoBVU3BZ0gF8Bh51akLKpeDIxY+6sRdOhqEjBTrxaO3T5XQ2wvjnmpRUwuzOjGSdWchoDpGrDlXCCxm2Ny8dH51w0kcuemc503t24Mc655UWXcczLmrDfmu4k8n0imlC5i9+i9CZrVOdF8BGemya9cCfJYTOeWr8IvrAnIDM=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by IA1PR21MB3665.namprd21.prod.outlook.com (2603:10b6:208:3e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.8; Wed, 5 Mar
 2025 23:29:21 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 23:29:20 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [patch rdma-next v4 1/2] net: mana: Change the
 function signature of mana_get_primary_netdev_rcu
Thread-Topic: [EXTERNAL] Re: [patch rdma-next v4 1/2] net: mana: Change the
 function signature of mana_get_primary_netdev_rcu
Thread-Index: AQHbjiHJfgMGf6TR5k+NnjkKQsEYgbNlL49A
Date: Wed, 5 Mar 2025 23:29:20 +0000
Message-ID:
 <SA6PR21MB423103A7760280380AAED1EBCECB2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741213360-14567-1-git-send-email-longli@linuxonhyperv.com>
 <20250305145604.56855467@kernel.org>
In-Reply-To: <20250305145604.56855467@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cb974313-e458-49b6-b152-0f8c4768222d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-05T23:25:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|IA1PR21MB3665:EE_
x-ms-office365-filtering-correlation-id: 21727e7f-eb5d-4502-cae0-08dd5c3d8e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzE2VGJIUmdIL1dKT2VLWlI5aVdmZjZucVgyU29zaGNZYThFVDRWMXliaTc1?=
 =?utf-8?B?bFBUOWVidTY5Q3lyZHQreGFlZVJaZitDL1ZWT2I0NFlNczFLckJNN1J1RzRM?=
 =?utf-8?B?QUNaUUFSamUxL3JGbFBHM3YreUpPbGhZUzZoWjNzb3NKbEpBOVdWdEtVS29Q?=
 =?utf-8?B?Y05GaDNpOWs1OTRwenJiYy9KQVoxckNnSnlQYVhBVFNmaXFjMEV1eHp4eStH?=
 =?utf-8?B?TnpVUXZoRGV4MXB3dTNkdTJWME5iSHJzcCtHRW53RzArUUloOFNrZks3Tk5o?=
 =?utf-8?B?R3k4am81elBJMUhtOXQ3Q3dLczY2R1BmQjkzMmlZL09BamhlZGMwM1dsSmdw?=
 =?utf-8?B?TUpLMlNjbmlZNDFzWGN1bUJRN3NscDRFTGdQazNLY3ZNZWNzUklPRWd0dzlY?=
 =?utf-8?B?L1ptUzBpbUZ6NDJkQWhScW91ZU5DbnhTaFJ3WndycnNPcW9oQ25aSmsrYnVp?=
 =?utf-8?B?RTl1SEdSZzhSNkxhMlhEc2YvQWlLQWFmNnN0amVmUFlJM0xUQmpZc3V0UnhH?=
 =?utf-8?B?SWNGa2ZPUlJkdkw5TDR1ZWhUeEo1K0NYYmR1YUNXdmZKZitNV0t5blYyelgv?=
 =?utf-8?B?a0QwVzRGMlhMMmJ3cXQ3NU5jd25rUVpwczBDZkM0Q0RDQ2RjZ2w1dkIrSzdW?=
 =?utf-8?B?Q2U4K1c2MGc1Y3RyUXh6Rjh6T1hlK1FLaEo4eGsyS1Jpb0NBaVJlN3FMY21P?=
 =?utf-8?B?T3JTK3BxZ1JudW4wZVNBSnVxUmllclpXbzJlcFBWS1RrTG12b28wMk9xV0pV?=
 =?utf-8?B?Rkp1ZUhFMDJkLzNkVWNhZUQxRDIyMFd1Q2xERWk0RWlxdTdPcVkrSE9heDhZ?=
 =?utf-8?B?dmdaekhVZCtVbXpIK1pYdnNPMjhWOHYvQ0RjaGd1M3h4MktmeUdWaXppTWUy?=
 =?utf-8?B?dlBsSmdIdFJYMnh5L1U3WEh3V3lBYzE0WnY1K3hHOEZpN1Q5UFdtdk1tbmUr?=
 =?utf-8?B?RXJDejFDTm9ka2NRYmhmMWxXQTlUL1poYlVibDRPZXdUV2svTlZjdVhjcGV2?=
 =?utf-8?B?R3dRU2VHK1hlZC93Unl1eDB3SHhFdjZwUDFtY0lqNlVuTjhRQitPSlorK0dC?=
 =?utf-8?B?d1U4U0JxNFQ2Nk5vUzR1Mk1qVG9VV2tFVjdiQkdhb1ZCMklkR09DTmVYY2wy?=
 =?utf-8?B?OWowVUQ5OGlaSVpvNzd1TUNiUElwdlhZenZDT0FsK1YrU2FRZUtCOExHMGNR?=
 =?utf-8?B?K1FWMVNEendGWWxVT0I0UisyVTNueHRPQk1kQXlpQzR6VWNsRkNEdG1FbnA3?=
 =?utf-8?B?RVhiRWRzenI5aVQwUm9XTmVIak1BdjBPV0NPYkhSNTIxZjY2ZGp2VUZTMTVu?=
 =?utf-8?B?VHByOFZXRVZwQVg2ZnBTT2FpeWNGRE5OeE1pM0VMNUlad0ZIU1NOcFY0WTJo?=
 =?utf-8?B?dHdLSjZ4cTFRZk9HM3ZLU0RXRFJXc0dJV0VsTFFRWVVWc213Z3JZZ2kxZktM?=
 =?utf-8?B?MTJHSzdMVElxMXZtMCtwdVMyUkgwWjAwdHN0UWZMWmlkVjBJSTVxaHQ2VXhw?=
 =?utf-8?B?c285SSt6SlBzZzZmUnMvTnFBZ1JiMkhtOWVvVk5oV3ZSV1R2NHFKKzNDNElx?=
 =?utf-8?B?elNJcWlPQXJLeXgxQmRMbDVSeERCZ0JsNWpQMzl5c1FPVXFwNHViL2R3YytL?=
 =?utf-8?B?N2dvRVFqRVJNUmsxRGxJRThvMVU4VHdObFZ5RUNQVmNSWjloQnl4RkJHMGI4?=
 =?utf-8?B?U0YyTXhia2MxNWxwK0g1VWNoNHk4NHROQ1NIczE0NWFNMGJkTlNmRnpPWkl1?=
 =?utf-8?B?aGU2R2Fjc1lDWFdEYXBkZWVUNjV5MTNoQ25LWFFWL0xEdmw2b2RJeEQ5MVhz?=
 =?utf-8?B?VURZODFFZnNRTmVzRXdQQW0yUGNldGkzU2N0YXQrY2F5K1lDQllGbjd4clhs?=
 =?utf-8?B?eTl1alpLb2VHYU1PaHYycE00bjJWY3MwQzkxUXVtZXFuVHZwZENsMkQzaDl0?=
 =?utf-8?Q?dPTQDVaUoIo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVdZSVhuYUd6WHVaYkt2T2p2OFVWeDB3UmhBbW1wdDhiNXBlQkQzbXkzeExm?=
 =?utf-8?B?U3dtQnhFUTBwbEZoKzRiRGlYdzhDL1R0TGFwRFNwMmVrRnh6d2JUUDQ1cGdp?=
 =?utf-8?B?REFNY1dqbnhpbjB1WS9kd2o0V0o5ZUZDV0l0TE8za1JSWjBVT3llTlppZGJj?=
 =?utf-8?B?SHg5MEwrZWxzQkdvSkd0WnFHRlg5Qit1TjB3WHdFa0sya1FpTzY0YVBzbFEr?=
 =?utf-8?B?V1FEcEprZ1FISmVpN2FKNjhneWxHaTU1ZXZ5cWVKKzBMTmdGaFdVQlAyNTEw?=
 =?utf-8?B?T3FKNSt6ODdTaDdweFVJRjZmaDgvUnlVaEdueldLdmRQMVZNcUpkb1hBUlNt?=
 =?utf-8?B?L1R5RGR6cXVyaUMxSHlkVkpmazdXRlZHRkRuWTJOOUtCZ3liTU1pei83T1VS?=
 =?utf-8?B?eS9CcGdvN1VnT0RrS1JML0VVQlF4ZDFTYVJyTVZhRmo1WGJYVW1ZRFdWckF0?=
 =?utf-8?B?eHMrRDkvVUtOOEMwandKVFNWOERzVnM5eTg5Yk9JM1I0MmI5TU5RRjlabk1p?=
 =?utf-8?B?U1VrL1BraG9TeUljV1Nvd0dmTHpIVEdyTFVkbVVuTU9xSXFmM205K0VseHY0?=
 =?utf-8?B?TllSYVVVcW03cjJXMU1TYlhINGRkeFZDSlJEd1BXRitReVF5VE45eDNHeDZy?=
 =?utf-8?B?ZnNNRzQ4R25rTU5rR2hRVEpmVzQvNTF4RTRubzE1Sm5mdDVqdkxrTnBpZXFL?=
 =?utf-8?B?bTBoMHZ5cUc4Z2hQYlNMbUJKRVkzZkVqdkpKVTkxSTlhdWZMczcrTzYyRGVo?=
 =?utf-8?B?RkRVSzZUWHQrVXQvcnJ2RUNmZXBGNFp3VzF6bk5ESTgvczNqV0pWczhxbGwy?=
 =?utf-8?B?VEtlaHhySEl6L0p6ZkZRSUl0bFZkQW9kVHN3MHlhb0JwYmNLTzg0K2NNQldM?=
 =?utf-8?B?eEdXQnV3V0xTVTdQNlExUllJNXpHdTZoYUNiR0YwRGZ1bEJQMzBqTDlVVTg1?=
 =?utf-8?B?elFFeFJ5NjBWbVhWMzZUVTN0YVVpbE15RHZtTGQ3N01sdkhtMjlXSlhDRDh1?=
 =?utf-8?B?UVRVR2lYWmlCNWQ0MGQyNjVNeUFvVnFDNWF4UW5aVXhSYkE2T0tGSkt5WENr?=
 =?utf-8?B?MFBCQ1ZXREd3ekN3U0ZqRENWcFlxeW5tL0tuV2xoeHFMZkdLRXJyMkxhVWI5?=
 =?utf-8?B?YjE1cG5zeUNzQlVicGlTbzlDc0FKVWNTRUswRjlOYkkxSmR6S0p1Nzd4VW9i?=
 =?utf-8?B?Y1RGWjRRcVV2cDdoNmFwR1hGV2tQVEJESjg0TDVva05PbEMyL0RCK2RSNGY4?=
 =?utf-8?B?V2FBdWZ6eVFrWDhSK2luNFlvSHh1ajdROWNib2NFci9ZWEZBWUErSWg2UnRM?=
 =?utf-8?B?VVlmRUo5S3AwVVIxSE9aQ2h5b2QyZzhZUGF4KzhjbzYrT1ZZOVJFbW96bXZ1?=
 =?utf-8?B?YW15N2VxZklBQ3Rhc205Sy9TOWhrUDBDWnU2Q0xpNjlzNnU0Y2NjNWRJdUpU?=
 =?utf-8?B?c3FUZEx4OHA2eTJpMmFOb2YvZUVKTGlaVkdPeWFqbmtZKzAyWVNITFUwQzhs?=
 =?utf-8?B?SGFVVUxORlZCQjRUc1NkZE9NK09xQmp5L1ltNE9UWDd5a09LUGVlT3FKdUd1?=
 =?utf-8?B?UXRyOG5QYm1TWXF4YWtrTHp6OTB4amNKVTB6bWpuNTV5Sm05L0hvVmwweWV1?=
 =?utf-8?B?K3lmQWJldkR4SUg3WGwzMVBBRFduSTN4YndFZCtDaWhWM0F1N0hUK3FJTFVw?=
 =?utf-8?B?SjFJSDNrUm9GQXBSNnRNWHZWOUViWm5PRGNqeUl4emY1SDVuODVPUGFKNFd1?=
 =?utf-8?B?cDk4a3h2YmZqSUk0ajJhd2dwQkp0Ym1tWWg4S3NSUnhwSVlmZ2VUWlJET3Nw?=
 =?utf-8?B?ZUFVVnM1cGl1czNaNUlkOU5IdDNqNWlUS0MzRGFCTURsR1R3UjZRSFo3b0V3?=
 =?utf-8?B?M1BaaTdna3NoZ1JjNWlaejBJT2V3ZnhPMkNQUGRjQU8rd3BQMi9nb2dtcWhL?=
 =?utf-8?B?Ynp6VjZDYkorazVab1Q4MThVN00xdFN6MVJZMGJ2bVZtYk5tazNwaVhwK05S?=
 =?utf-8?B?VUdYTzZIMFF4U1FPbDFiWnRKTG1EVVR0alVhYlFwM25NY2JhQmwwSVlWWXNX?=
 =?utf-8?B?a2FzOWhkVHF3eHFmRE9wZzk3WDlWUDZxWmdpTGdpL2cweDc1bUtCRm1MVVRn?=
 =?utf-8?B?cUpyVHdiTEs5SjFSWFU1b3lBL1F1ZEZ5Tm5LdnRIYnVrMnpiMmZKVkpKM2dT?=
 =?utf-8?Q?isZF/B4X+leeuw4kFiGPIRUvLDxoU9zRwYiNmESDyFy8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21727e7f-eb5d-4502-cae0-08dd5c3d8e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 23:29:20.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUi0qGFjn7NHF1d2rJxLHn8LKiZU04IVuP9I1SodyqClc76jk5++Au5SEkw1ZGPhWq6hejG61NcVM7opRZxwHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3665

PiBPbiBXZWQsICA1IE1hciAyMDI1IDE0OjIyOjM5IC0wODAwIGxvbmdsaUBsaW51eG9uaHlwZXJ2
LmNvbSB3cm90ZToNCj4gPiArCW5ldGRldl9ob2xkKG5kZXYsIE5VTEwsIEdGUF9BVE9NSUMpOw0K
PiANCj4g8J+Yhe+4jw0KPiANCj4gSSBhc2tlZCB5b3UgdG8gdXNlIHRoaXMgQVBJIGZvciB0aGUg
dHJhY2tlciBmdW5jdGlvbmFsaXR5LCBvYnZpb3VzbHkuDQo+IFBsZWFzZSBkb24ndCBwYXNzIE5V
TEwgaW4uDQoNCklzIGl0IG9rYXkgdG8gcHV0IHRoZSB0cmFja2VyIGluIGFub3RoZXIgZGV2aWNl
PyAoaXQncyBub3QgdGhlIHNhbWUgZGV2aWNlIGFzIHRoZSBldmVudCBuZXRkZXYgd2hlcmUgbmV0
ZGV2X2hvbGQoKSBpcyB1c2VkKQ0KDQpTb3JyeSBJJ20gbm90IGNsZWFyIGFib3V0IHdoZXJlIHRv
IHB1dCB0aGUgdHJhY2tlci4NCg==

