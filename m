Return-Path: <linux-hyperv+bounces-8680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILRUBCdBgmmORQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8680-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 19:40:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752CDDDB95
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0FDE30E68EF
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841A2773D3;
	Tue,  3 Feb 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U6NrO2OT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010021.outbound.protection.outlook.com [52.103.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A1202F65;
	Tue,  3 Feb 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143744; cv=fail; b=Ui1LZ45h9/wM0giC9ylkdqMzNNZouGEQAlADIstRF+vZU+6mPEm9FI5HOTvb5HOYcJEjTBQBWQ7S+yUC8LTIaf5jRqjfPFwTJ0Ui/0K0SzNOImpqRK2MOQxZelPKs5f27tGMnYvz5ZvZZwHpIt7P3wNPeewY5s1415nYLT79qT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143744; c=relaxed/simple;
	bh=5Rq88yYFRLW9TJKy6cNcHBwuWwo/wdzZVeWe6O9R9NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVBFURGWxpDoADzt0m8HRAAcN7w1R780NoJnU7JmysWQzFpPJ3bXFFBtu/0X+AT5ghP/9/drbKdpQ7rmwRzkIAEc/od35X4cpL2AYxkCMXpXqPhZxEhvYef5IiaudnbvQgMpkYSTUqub240AXnHlTPV4wvKgRoRWMJWZIFNtlAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U6NrO2OT; arc=fail smtp.client-ip=52.103.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFt6Ieukvc8fYPND3sjHt0PS0mfv9+JMCQ6BqVrePVvHQ7s7wziclC9dwLhyxKKgZGkkV4dako/1eU1BVWVMbtm1zbh/DXxuc8oUOct1rxbQywJsQpOnnXMLwCMOsmUsKIVdeAwdxjRafAwFGbhufArrNLr2rldc5PzNi1myorrArjOb8YRUR3+Tmzv/IZM9mzXB5wgVIhCLszszD6Xk2+S5wg+SFNcs8j1EOxVrWTtPyq+ZdZBGqgmdKTYk6k5pIylD9S3klQepw197IIiENpPti0eB0CdHrG5e/iYbqgKFkyWqHO4qUj7OZEkER+Usi5rMquPtS8UeGJaR3mWcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnrmo7y0OxcpBSUGgl1HOluS3igd/TnyNmNBcx1o6/M=;
 b=wFwJ8OS+lJONfwRKBKuH3MpsWbZ81F7OHDXb44wrcleCgbRkJx17r2eNygw+kQrmmSkfHK57JtKcIJWMtnfOnPNlv7KiiNpzTo2WM0d/CAxOBNOmOLDde3geJlGOeIIhBVRTQzcpjmXGIW/3zQIHChfz46un/cy+Wor9k03Hqjvs2XRSCw6UvbJqD3i+4EyEjSSV/wGcgwBPKbkT17cp94FJHWrpRHe+rC0EUFZjbQkSBWlpgUOP/unbeHfwq6O+xFPGp9uMwVWyMFcEgkPATvGi1kixmpgNa2yvcMPvLe48GNf9E6ph3Ns6myBc4NwCLBP+SLAL7jlUcbdIcR7tDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnrmo7y0OxcpBSUGgl1HOluS3igd/TnyNmNBcx1o6/M=;
 b=U6NrO2OTx8eNjm8khY5oliIuFeG1r40rai+MuP4HbK46q5S/xrsckyNQSJwrPrZhF8Jl5dnX6N7D5J6WMwlVISrCB75YKiNc6LrpgTx1NrM2JNVZPTLtO0Y8Svy2WpgjwLZ1cL5J+6ss/3+BQatpVHul1MetIXc6yQQU1nzKJr0qhbaG3kVG5jgoCzptmktuNO/l7zij25ezF4/htkESyqZrudBorWD3CWvADQbSGkgFWTetn1uJJQ6bQRT8zL3JotrpVMRUT/QFpU6mJejquG59zYOaVk7ijNObs7cAANckqj/WYYDw2DEsmXplk+XSx/SG0W+keiW4cp+6kdi+tw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 18:35:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 18:35:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Topic: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Thread-Index: AQHclGTjfuUHRH1hI0mR1MgYgqXlO7VvptmAgAAPmDCAAAwAgIABh5Ww
Date: Tue, 3 Feb 2026 18:35:40 +0000
Message-ID:
 <SN6PR02MB41575CA65B0A07C935F85665D49BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
 <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aYDzU5ujoBlzWaa6@skinsburskii.localdomain>
In-Reply-To: <aYDzU5ujoBlzWaa6@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB8927:EE_
x-ms-office365-filtering-correlation-id: f010be76-3211-43aa-cf98-08de6353083b
x-ms-exchange-slblob-mailprops:
 suo+AMQROd7KWLzCSB/8AXewUiiF+4xJuKBJQimJ2v79iSY8P2qEo8rIxfjy3sUZyIB8KgxX1wuzEYlFbGjUzH0LGLx2NwPF1SmWARPc08eKWAWR3y9uNCyzN5GUUV+LhqDzn82zIwk17eqTpueQO4QUKOGz9RiHFzW9F2AZ2asMO6PRwdo9GcGGhmunhVKeoH1NKc2kYNfCGjKx493IbLM8+NLPOYKrjWiw9BVTpi3LNMOoIlNwfopUS9EDfnpnEVmK6Qi8KWSXzS/6aYZLa/+GrYQAi0LpxQUiL/TzfOLgjFYuJnonG2hNRHNKiw/fn3uMQa9la3+lKZ2FQn36mQtUifPayoPnx8Xx19qME/nStJEjNhNRKwm87429NB5JZUW8ry+TMbWnEXEmb+/D+S8f/2mdcQ/Ve2UaWwWi9Bx4IXFMD5eHVUjhIKX8OG5RNKmbaW7+Xiw2HA4rJAowC727kl573bZiBiB9hC2OBhBQRB5QnlwdRfBD9W/KXHSOFEO3IRBrrFBaayFVlHd/C9iCuLfH79GmNGgiDeusoEtJFLrTDNtHnpCKjg/KXY+AHZ3j6nU/gWj+lsJRZfpHOr44D4J3577N9LYJOwCypHBB8+8FVmg3NFjtGuMBi2n0fK2DrTWxwvQw3sP7SA0qLpwEpM+/32eL0QZ3cYsyQCDHz+wx5kwRhzCzl3ITbLdgFoPZ7nQtvCJUBnRvdKGZULmtEoob12xtaBUqMvO9vWYxJVY3afW7Tz60PEhDn0P44akl6HWk5/i1VpJB+jxLBAwE5W1HCTwQI5zpgbvBd4JWaCpKqaXQcZ3r8VpQ7A4VzPA378Te3GKOoniqjOuyag==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8060799015|461199028|41001999006|8062599012|19110799012|51005399006|13091999003|31061999003|440099028|4302099013|3412199025|10035399007|102099032|56899033|13041999003|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NpeOQ9mL1+dd4Cbj/TamM1H1RRq+5kHmEGQr55aUkAU/TcP6rNKH1iDyaaqn?=
 =?us-ascii?Q?DEycgeCMAOdx0GBvkBW/AL2rXCcW3gcDB7tWtfr3vSp4FmZ4b6ZUzjteKkiG?=
 =?us-ascii?Q?jXjKn0i+ydTkUz4Hy1YZdE4t/tNfaMlJOPiJiGqHox4CpDReBK0KOebOZRm9?=
 =?us-ascii?Q?Y2JZoOlrmEhJzIInO5b+9A0FCZeqH/CHH/eTO/tBQHf0002IxsoG6vxvzo8f?=
 =?us-ascii?Q?fojOiYp3nWKdJYForWvI9JyvUOY5K4N1WyabQN3q5G5TICJ3WEBaiyOVALJY?=
 =?us-ascii?Q?MtVllkXxf7CpYOk7tmHrAreG3yDnqJSu8KN2XfEnXkLutj3NWZXRAma6i/jh?=
 =?us-ascii?Q?pnGNe8nm3x9WL4ShvD/w3NvXwiqfzv0Jcn38kwMkvvNwgaGmgs9JLGwZuv8R?=
 =?us-ascii?Q?nAL8MDMNcMeUCvQJxCZGzA7AbO/NEzThOdUjRc7YkiUvoShct+C8J3IKtmnb?=
 =?us-ascii?Q?C85AXWDEQQhY6/1VmeL91OmqTVpFRB/NiQ9q+AdqXZu+RKa9wjeXRfZjtprx?=
 =?us-ascii?Q?WYABFXKIfx2Ako6UjsHsLc724fI/z0rTDUv7mO76JOpHSZokffYY7b1sA92S?=
 =?us-ascii?Q?h5OjQvKhEW/CWctI5JSWp95WcpSNstiY9w/YphmxYEnNDilnKxFG72UXrKEg?=
 =?us-ascii?Q?vZhDM8BfwzHsIoPO1Sy5WLr06sg45R8yKbQChWdieD21GFbbO9s6ig+HPGM8?=
 =?us-ascii?Q?jONXdZUoWH8HFEFTrJJcTHprJ3nAQqbcn4LzDMRuDiHAGZgz4rrXSyMR/3Kv?=
 =?us-ascii?Q?ZiL73CWhpEqK7anzxP3vJqfSnjcC/xC63Ym5uGB26rrPxBdm3OP8RvFwuHzk?=
 =?us-ascii?Q?Atz3Pek0k4LXXuRALgkKeqhXzEXlAe61zJp0aN9mkg1uHE5WnmzMzSZj+afl?=
 =?us-ascii?Q?+dvt9cDGk5WT+RLDGbW+qJM+fcEq0tmQeM3W+7DHYD+xyBVrQNAKHe+9vclR?=
 =?us-ascii?Q?U1+AujvAWy2H2GSZyVt7e+RlhxclFK+zOs1VcEn3y3W+CB4p4tMmLZOjqCL6?=
 =?us-ascii?Q?y81zlFQMnjhKDLvPyHiktdwEcdP5KUccQJFJDm4LN3NPsWu5Q+Umxv2CX7LY?=
 =?us-ascii?Q?N0pcKu9m/rnX3sfM8pECvx2w9PD7o3wukLla4RRnKT7rz7LMDbHqqpm3QyaR?=
 =?us-ascii?Q?l0gaCqHGRjx2dCragQpdFjqInlTUYwx5GajeQkEuqTGf+jcPt9QmwgzAYFy1?=
 =?us-ascii?Q?vRjuzAx6uky1FlItuT4gOxM90ZEwCmeonxM2CrdAy56Oi4ToRxQVXqMYB3Wg?=
 =?us-ascii?Q?f0L8Q9KHd2ZbNR/EByrsQ2HfEb/Lz9AGPqSCYQcA7QxTg35lrRWXXeqmL7nD?=
 =?us-ascii?Q?GP8IQX0Pyi4OK0lTdjCIPDGTJIfyut7uO8aAKk86+B1zswIx8LNed9uMC8Uj?=
 =?us-ascii?Q?c0z03Bzth/CfKoRhvw7yINLhSLaLUhNh+9xaaxY+4U31rvUxdw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UzheQaMe1x5tMHfyKBF+6upcOmgX2Dlxd55PJxWKjBqNpXBUOUC4GRaz0RMA?=
 =?us-ascii?Q?wNDfWiExM/X+5qynOKs9v/aOwmmy2cEkexLMwqIBrcnFsaHld0e7ZB6/GKWl?=
 =?us-ascii?Q?82FtnlhHnHSYwbT0BAccYLraGQFCreZ3o0g2MiM8PpQMimyAytOZw4tKOnO+?=
 =?us-ascii?Q?jl/0qX845Gnei4WjCpbbSmbE9Vf6+4Ch0YvtAu05G0BMbtU15QwyknlZcI4y?=
 =?us-ascii?Q?ADvKk760WNWwf7jeWLasjfjk/nYHNSO5nHUeUUo/zHR+vSyq4GIqk99ExiBw?=
 =?us-ascii?Q?esrV8q3NrQAe+xXOtlfM0rgLv0zMZP1Z3lZZKd8r/fxGgaW0DWDpNo79pWA3?=
 =?us-ascii?Q?UXsSmThOnAtuXfoug+XTaeqFsjfxYdX4TqW54W/e2dD27oiyhRrRV7l/Falc?=
 =?us-ascii?Q?Rhf7I0Q9wczXCLJcdyIBucj4h50uSeOL5+8C192SxtbFFofyZ5yFeBSRjk5a?=
 =?us-ascii?Q?v5nSe9NSrIo+OG1CbpP/706wFMP3tSEJ/Zdoax7mETiwRWSey8WZN/iovZPr?=
 =?us-ascii?Q?mTGDX16UZOyHJxOANAcXRJJuQ3C+uJ5ONI4pH2W+WwW7DnAbLTGU5pAnNdGD?=
 =?us-ascii?Q?ywQri2KULRzjmnKZHVoqiV1SJ/KGYWCaHM1y7qY+NWrLzD1Ud3CmTt5SePSe?=
 =?us-ascii?Q?qpUEg0475Leau/7LAznxOhWEMoPRF5/p172fj67LfUIKhbw+DiI5e25SO/j/?=
 =?us-ascii?Q?b1sPMc0TFh72pJGOM3uHf/TE968GouzXiamVIkg1SwFTPmdVn8gBM96SqILl?=
 =?us-ascii?Q?j57GBCKZzNWz2qn14ACVtSqFXZsixuQO2btCvPI92+JOPa6EmsO0cwCD9yr3?=
 =?us-ascii?Q?a5UiJWWgprNtU3LtrH5lYsDsh1qfM5lgMyCnFWcFOPBhsaySpSUrt4seUh2K?=
 =?us-ascii?Q?PZlPsuSEiEfKMO1Td2NEzrVEPIl7TsAYexTvRSEmeH+tuLUdXZ9cUhc81BWO?=
 =?us-ascii?Q?kpzEeZJOi/CtQHwAXgLT6SWdk2CSD50xE39n93kwfbY0UCYGO8iCesf/+j6l?=
 =?us-ascii?Q?/NmenR8931nFJipkvkzMSJ6jSdDwF8OwwyJ6lgfbjuDrvhmbuGoAktUihUNh?=
 =?us-ascii?Q?PHvPTUQLbeSPANOA+WCJtxfLOQVBzGDfULJZj6sK4xYhNAyh0gBAPFTJreiB?=
 =?us-ascii?Q?CoxjzYVtRq6NgJx++PQQzKhHtGU8mhZcXXJ15zvY0mrnMvrMqecLqNkXQLYO?=
 =?us-ascii?Q?wI1ZN3dpPWljSaQtCoqcHDUPCPbq0kjQWp4iY7lfZKT8QBUy2hMWG+iOqQZL?=
 =?us-ascii?Q?0gwC3wB4WDCYFezQOveYNYqrwC7SCciN+GWg1o3EqRJTaZbj9nT5ae0pD402?=
 =?us-ascii?Q?kLeoRuYRSSounq+ttNYQy+I+UN1FV8GESDOQlz20LLANKorpNYbAzM/ZDxUt?=
 =?us-ascii?Q?akPqiCY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f010be76-3211-43aa-cf98-08de6353083b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 18:35:40.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8680-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 752CDDDB95
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, February 2, 2026 10:56 AM
>=20
> On Mon, Feb 02, 2026 at 06:26:42PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Mo=
nday, February 2, 2026 9:18 AM
> > >
> > > On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > Huge page mappings in the guest physical address space depend on ha=
ving
> > > > matching alignment of the userspace address in the parent partition=
 and
> > > > of the guest physical address. Add a comment that captures this
> > > > information. See the link to the mailing list thread.
> > > >
> > > > No code or functional change.
> > > >
> > > > Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsbu=
rskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > ---
> > > >  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_mai=
n.c
> > > > index 681b58154d5e..bc738ff4508e 100644
> > > > --- a/drivers/hv/mshv_root_main.c
> > > > +++ b/drivers/hv/mshv_root_main.c
> > > > @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_=
partition *partition,
> > > >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> > > >  		return mshv_unmap_user_memory(partition, mem);
> > > >
> > > > +	/*
> > > > +	 * If the userspace_addr and the guest physical address (as deriv=
ed
> > > > +	 * from the guest_pfn) have the same alignment modulo PMD huge pa=
ge
> > > > +	 * size, the MSHV driver can map any PMD huge pages to the guest
> > > > +	 * physical address space as PMD huge pages. If the alignments do
> > > > +	 * not match, PMD huge pages must be mapped as single pages in th=
e
> > > > +	 * guest physical address space. The MSHV driver does not enforce
> > > > +	 * that the alignments match, and it invokes the hypervisor to se=
t
> > > > +	 * up correct functional mappings either way. See mshv_chunk_stri=
de().
> > > > +	 * The caller of the ioctl is responsible for providing userspace=
_addr
> > > > +	 * and guest_pfn values with matching alignments if it wants the =
guest
> > > > +	 * to get the performance benefits of PMD huge page mappings of i=
ts
> > > > +	 * physical address space to real system memory.
> > > > +	 */
> > >
> > > Thanks. However, I'd suggest to reduce this commet a lot and put the
> > > details into the commit message instead. Also, why this place? Why no=
t a
> > > part of the function description instead, for example?
> >
> > In general, I'm very much an advocate of putting a bit more detail into=
 code
> > comments, so that someone new reading the code has a chance of figuring
> > out what's going on without having to search through the commit history
> > and read commit messages. The commit history is certainly useful for th=
e
> > historical record, and especially how things have changed over time. Bu=
t for
> > "how non-obvious things work now", I like to see that in the code comme=
nts.
> >
>=20
> This approach is not well aligned with the existing kernel coding style.
> It is common to answer the "why" question in the commit message.
> Code comments should focus on "what" the code does.
>=20
> https://www.kernel.org/doc/html/latest/process/coding-style.html
>=20

Which says "Instead, put the comments at the head of the function,
telling people what it does, and possibly WHY it does it." I'm good with
that approach.

> For more details, it is common to use `git blame` to learn the context
> of a change when needed.

Yep, I use that all the time for the historical record.

>=20
> > As for where to put the comment, I'm flexible. I thought about placing =
it
> > outside the function as a "header" (which is what I think you mean by t=
he
> > "function description"), but the function handles both "map" and "unmap=
"
> > operations, and this comment applies only to "map".  Hence I put it aft=
er
> > the test for whether we're doing "map" vs. "unmap".  But I wouldn't obj=
ect
> > to it being placed as a function description, though the text would nee=
d to be
> > enhanced to more broadly be a function description instead of just a co=
mment
> > about a specific aspect of "map" behavior.
> >
>=20
> As for the location, since this documents the userspace API, I would
> rather place it above the function as part of the function description.
> Even though the function handles both map and unmap, unmap also deals
> with huge pages.

I'll do a version written as the function description. But the full functio=
n
description will be more extensive to cover all the "what" that this functi=
on
implements:
* input parameters, and their valid values
* map and unmap
* when pinned vs. movable vs. mmio regions are created
* what is done with huge pages in the above cases (i.e., a massaged version
   of what I've already written)
* populating and pinning of pages for pinned regions

Does that match with your expectations?

Michael

