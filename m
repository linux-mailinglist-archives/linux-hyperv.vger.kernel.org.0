Return-Path: <linux-hyperv+bounces-11179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GANDBiDFEWr9pgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11179-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:17:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 734115BF9BF
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5FF3300DE3F
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BE304972;
	Sat, 23 May 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VAH18pX4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012009.outbound.protection.outlook.com [52.103.14.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D823EA84;
	Sat, 23 May 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549466; cv=fail; b=C3x3gRYiOAvVjkrtPpmdFGiXlTTxmHNBHdHiL6AuCcUK11Z0s+CoTc642rVGM2iRdUyv6oKIaW3SwpSZGwQFpx1hm8i1uSItdC2I818VqXFw1H6eda9VxErwuA+4dfT1gqlOepfaxsUWF1IuX71lFe+1rEAR3reTffgBx1H5D70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549466; c=relaxed/simple;
	bh=D/3hc3H6h/66/rBbcLlMnxfnyjFsRo8wvoKdR61Hs0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qwl9PCX1WRfwaT/can/BqoeLPrOkNQmF9kzEuDyyPK/daVu6Va6TkPeASRXmE1yoGc+/IQ+GzRxm0VcLvkYDVOg7hSohO1RHVESAXYD8QPDSSZq1cED1J0+egLDZXODiXzsaZ8GqwMouM0vhduqygaNqSY8W6M3ovuR5nkjev1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VAH18pX4; arc=fail smtp.client-ip=52.103.14.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5PMx3bPgtS8WLRy4O5OAaKe2fXndfXAB0VbxUDJDYmjVKQdN3tsiOOJ9GyoaugH9QsOk4tINJfuHTMh1UZn9UsRIVZ39SPFIZqz9nOysWMyKOoqpx8iJx0LB97BUPX/aGvy6UwrEfwi27rLb9yfQMAvX2vE5zQ73Clk8IU585iDFLcO4kvCLJ8Cv0tEMeO20T51y97Wy6Prr3XjCdhRAqpy3J+ANOub5xtiepXgj2rUPji301t8lpKApdw6zC8iqp8jOH1UbjtKtqnG4I6EfD1K+cmkiY4S65qcAYZvJE9cGN9S2C+C42DHghGogbCec+hrseHFLoaoTsU5TWrCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/3hc3H6h/66/rBbcLlMnxfnyjFsRo8wvoKdR61Hs0A=;
 b=ldtLbyhWwxq6PfN9IlAhJ10BoytqvD91YTb/BTMyq9wZEl7t6HJ0cR6bFWt5nTo8nYNPfowwMUnP3JR196HWCy5408f25pbLmZ3tgRERdJif6/2t8Ctq44tMC3YeqPvEl0M/PtTf0iDOrLZAlhWlweKi50OdFot44Slz2CQ095pP5JNbFi2uBZlYU3VgiVflz1Yi/sLubAb2RG9SeCQ+KgpYZaOoRbHWwIp+g2W1pLke1w4t+5/ODRXuR/fZpGb9ei85wpl4UZ+a38Xzv1wYXzVVHNqPTFkihUL5/5MJkU933GBu9ETBvzzF4/0CaKIDzOh5DgVnPiO6Arlub9dbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/3hc3H6h/66/rBbcLlMnxfnyjFsRo8wvoKdR61Hs0A=;
 b=VAH18pX4LX5FZeFn6Tbyxi1dmdJ/JWo2+G2PoDrZCgnYNzDp73ds7hz0NY5l9JjNNUe0Rms7uk96iTmWvf5ab/owMoHTB3m26U7NyBoi1AQbHIFz8ILnJRGCTo0Y/3zfu3GmengHjfColn61obUv84nZb0Hh47rzxzY9fbQU2ZoBfTtLHFpixU221IlV/pDwlXjkRUcVWUv+ilYL3zNV5KunxP3H4IjSqagmbUM77dzWUftEDQtDZ4RsZOIXn55XGDI93Due5sCc4bnpFK8yAmKGlIyfn6/Mo/ix/kjd3OjkLs5UOBDGetRJr/Fuf9fCjbExGMbMQm/FZiWV3a/KTA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH3PR02MB10217.namprd02.prod.outlook.com (2603:10b6:610:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 15:17:42 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 15:17:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v5 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Topic: [PATCH v5 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Index: AQHc6rxvMycFmGm6QEm22FwBtt6GtbYbuR5A
Date: Sat, 23 May 2026 15:17:42 +0000
Message-ID:
 <BN7PR02MB4148AD0E2AB843DEED89CA1AD40C2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <cover.1779542874.git.me@berkoc.com>
 <8200dbc199c7a9b75ac7e8af6c748d2189b5ebd5.1779542874.git.me@berkoc.com>
In-Reply-To:
 <8200dbc199c7a9b75ac7e8af6c748d2189b5ebd5.1779542874.git.me@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH3PR02MB10217:EE_
x-ms-office365-filtering-correlation-id: 231b7760-2437-4b9b-11de-08deb8de6f59
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNyN66BYrEwvv4fYlONVvgUwpVkHRbRNLC5lSGWCep2h5cnzS8RBrg1rTOB9deKQdWxywaHBGmn0bv2nS5+HqaazQeMh/ufkQS7E4kKMmNQkt7yzkUj3ExBSlCYU+dXJztoBn5UIt9r0OoB02W+EESe+GIey8pg5ymJeAY1irCQGH0phOkd+lo05iB5HcIqzA2Og+WN3gSopmZiEvlJquwcOu7G2koOdWUZ1A/1VowU4mBxen70GsdBvw3YofrzZbWeeEo8Vu5Ws4Wx1Af44RVVg118yXl8qeWLdtsccHUz/YcHzznAAhVcEn0mxB+DWa5QOvsEyulKGR+Ek4ETZhZbSwbkGvKyn4WMYu2l++iaZc/7RTgOKONuCMIXShFmXp9BY3WD6IMazShtO5BvuEsSyBIuLXBxZvSiOVzyh2feD2rL9tofTTPy9Tf9JEex9HTZVZuSwWQx3ZfKSu7qE02gFnTwv1jQmsLKhOIPvuoiXldamyxS7iu9bhLdJZRWbQi6gIFoS6NIUjRH0Aa8/UDa4h6BI3rgb3PCO9ZVn6vAa+MVsye7rC46DQlH0zPvNgcac04rl9/JSOdnSfqGU5yTvoR6mf6+6vXhKQSsGfmSA5ubbUsiIgE8qvhHZD/LjEU0k8aGWgiNq8MA5ZBKQOwcbk5Tq6kg/LVxTZqjJeIFxfNqJHL5HoRYDuBmzLsEP8yvxGSlDCTF9JYp9H2dMF0S04S8zPXeOTj9X3eHkilsrku9RFVPJ06QkOhgrMtZ6Sw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|41001999006|19110799012|15080799012|8062599012|8060799015|31061999003|37011999003|51005399006|19101099003|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWhUcGp4SHlOdG0zZFBaRzZNTnN1dE9LYkNjNGE3QXBTOHR0MERxRnFwVm91?=
 =?utf-8?B?SFgyVEo0Mm0vRC9DTHVJK3lVMFh2M3BpRTN4RWEvN0lURDhIVkV4aE90T08w?=
 =?utf-8?B?dWtERW5vS3N3NnB2MGxZQWRhb2tWL1ZZdmRBS29QKzQzZVR6Z0Q5RGdERW9Z?=
 =?utf-8?B?RWpnakRzWFJJSCtTZjR3QUVCbldQSlFqWllUK1BmaXNDUjAvbFBONTUyQmti?=
 =?utf-8?B?RGxtb3pHdCtWVTNVYWk0RlVyVkdSSjhqa0t4WUN6d3NNY0lsTWNTM2N1d1Fi?=
 =?utf-8?B?U2swcU5GYnd2RXBFVXlyc2lxUlVjdGV3Umh0alVsazhsTFRCM3NnclFzTFly?=
 =?utf-8?B?WDN3NC8rMHF3WWd0bVoyc01PcHFDREJGZUxxTE5iL25ETlFnc2JvcnhmQXUz?=
 =?utf-8?B?VFBVSHcyaGxtT0NMK0toZ0RxMzEzV2hGdjZLTzd5cjd4WXVybmUyWkpCNUdY?=
 =?utf-8?B?SE5EamYybHFmck1TMnBuSHB0Y2ZjM2FOT1Y0RTJVQ09BZ2xCNFJISk9MRGNE?=
 =?utf-8?B?dWlXZjlPc0wzK0NGNTRaZDc0ZXdGYVIxR3BNZVpFZ3g0WjF2VUZsL282L1RQ?=
 =?utf-8?B?V1RRcGpOTW1ZZVA5Wi9TS2VjTHFadUdHOU9XNi9QT1RkbHVhbU5lajd1N2dJ?=
 =?utf-8?B?REJ3OTM0YVZzMnYwS1gyNXlzQ21Uc21MeWVxWExDalJxc1hFVE43aTUybFZI?=
 =?utf-8?B?Q2hzc2FRWHJWS2VGaXROL0Q0T2tmd0Q5eFdVU3Izc2VhWlFjQTdxMFlRTUMy?=
 =?utf-8?B?Vk8xUnBpbzdWZTVxZmovRFNJNU9ndWVMMGxtU1NLcXpGVnVyN2RVeUNLWnBG?=
 =?utf-8?B?ZHYvRW05dFVNSTdxRUYrTmxJQS9tWXJkRzYxT0NtcjA1MGlHbzZyRnN5TWZr?=
 =?utf-8?B?L1ZwaHRSbURmOW85NUk2WUN1bll4WWFnbGV1Y2N4b2YrYWFFdkhTRlFCVG8z?=
 =?utf-8?B?RmdRUUp4UCtsL1JIWGlHcDk1bDV5VENKUzdsTEV5RXhKZ2tpT3dMT1JGNnZn?=
 =?utf-8?B?dnNqbER4MVU3UExXL3VZVXg1TXV0bHBnK0d3b0t3Y3FWK20rVThuUkFycytN?=
 =?utf-8?B?U3B5aXhZa1ZZd0pFN3VYV1F4M3pzdmxKOHRicHpDeG10NGJEY3BXdFFod29h?=
 =?utf-8?B?S1FFWlF3UHA4V2JZVjNCVlZ5SXA4amlSMUZYWWw4bkhEbktyeis4ZWNKWmR1?=
 =?utf-8?B?STVXcHM5bzFTeS8zM0E0MHlRQUdvVWJGZStra3VwUnNHK3pCV2lUVTI1UFFW?=
 =?utf-8?B?bXJoNTgyUTZVNGNqSUlyVGl1OEtPUDJNL2xidlpTWUJDcElZT2wrN3NFdUNy?=
 =?utf-8?B?c0VBL2ZmMmxtWWxLbVNxR3VPbHhoTG5XeDNzZmVHWVVYU0RwQndPMjVSU1g3?=
 =?utf-8?B?T0JGSVdXSmNJUVVOU3JHazlvME1GbE0xbFUyZmplM0laMHpFcHluY05QV1lN?=
 =?utf-8?Q?rW81+bIM?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aitqdVR1cEVZM2g4SlRLbGJ3NHhFL1AxRHh2c29SUUVtZWloZDlCZnlsWUhB?=
 =?utf-8?B?VnZTSVJBdmZjSXh6NHFVWm5hVlVYUzFUUWxWWC8wVlZkUVI2ODFIekFSWW92?=
 =?utf-8?B?OUk1OEdrKy93WU5kVHpHMkdvRUVwUGNKazVtSkthcDc3MU5DNEk1Zm1BeElN?=
 =?utf-8?B?alcyaGZSQTlwbEpuWXZYWlE2NUdrNk5MVGFBOVg2T1JvcXByY1N4UDkrc1hG?=
 =?utf-8?B?QkFoNEg2RE9GalJ6aXo2a0QvRU9YeDdqR1dLOFBnRG9pak5WS2NpZmlRSUl4?=
 =?utf-8?B?aTIvVEt2UGxNajV0bWVhTEJaVFc3ckszamdSSStINTZHVC9HMXBrTFFHZ0Jn?=
 =?utf-8?B?cGRPc3VBSGpMYnNyQWdNd2kwM2hILytKd2VxMkZUTVhOdDhxY0ZEeWJ1UnNS?=
 =?utf-8?B?bjNoUThtd20rYmk1enlQM0RXbkZ6ZmlMTGcrUjhsVU1QUks1eFdzWlVlUk9p?=
 =?utf-8?B?MXFOSElxMGlhOE5UbWQ3RDZXTmozem5iV3JzY1NoWlM4S0pWWHJPd0JVSmNG?=
 =?utf-8?B?UVNnRDFVTmpuWmJsSVFnVUl5enpjNTRGT1FMVkw5ejF1VjErQXczaTZRaWQy?=
 =?utf-8?B?anFUWkJ2YXdCalBmdk5oU0ZPbjNpY29sa0RQVTYvL3Azak45V1dITGZUZDU0?=
 =?utf-8?B?OUw3WmpLaU9neElHRUhUYkRyc2VJNENIWDFYYU5wUDJZcWI1TWZSYWh2RUpT?=
 =?utf-8?B?T2lpaTE2bmx4VytCVWdIZXV6NktYdFBwOU1NQmJZbk04ZUJWS2hEd2E2alRQ?=
 =?utf-8?B?eDhGR3FHVW5zSitncTl6TVRsbzNLaWdCSzhwRjF5eHlIaVhJT0c1bitkUGcy?=
 =?utf-8?B?QnhGQTg0akRUWUg1eEtNM0FQMzhJTGhIYzlmdTNoZXM3RktzcXZOZDE1c1lR?=
 =?utf-8?B?ZVNDeGZDUEh2NHowUFhjbnNlM2xYVUJsbHlYditzUW9CbkhrYXhaL3lnazlU?=
 =?utf-8?B?blpyOCtpMS9BVFMvczdmUWZxODJ5ajVGMU5CYmtwVHA5MUFIVWNpbEYrVktm?=
 =?utf-8?B?VlNad0VOMlpvd1prakFJOHFpdlVnVFhSM2E2NTRaWVViWkI4a1dRNFc5RE1S?=
 =?utf-8?B?SU5scllBRHFoV3JOcVZyS3RlTnczNVRRWFFud0ExeUx2T0dyTEdCWWNaNkpF?=
 =?utf-8?B?QkZxQkV6ZVNsaC9ycTN5NXlmdElqTHJGdWtydGxpS1N6dlg2cmJROTZpYmUy?=
 =?utf-8?B?a1RiWmtIWnptYmhUWmRoejQzRjkzVksycms2YktCQ0tMWUxHYmZJemJWZGtF?=
 =?utf-8?B?dk5wTXp1YnplNi8wc0Qzc3IrN1Bkb2duMzd3TkZiMmVsTEs5YlpHdTNoTWEw?=
 =?utf-8?B?aENEVHVIWHpldEJDdEZCTEtFc0dUcFE0THNmR09TMHRLNW9MZ2dVWWVCZk5z?=
 =?utf-8?B?UGRoL0UzbzlIOUJXaWR1dmJnT3JjMVRGd3NEY2c1c2M1WUttRUtkeGFGNnNF?=
 =?utf-8?B?eDZjNlMrYU5DSjdGTjRDTDJOWGhkaDdaVnBZMExRSjAwaDF5M2VTcEl2QWdT?=
 =?utf-8?B?dVdSWnhZMUN4TmY4T3JRK1dWSFpMMWVvSEZ4dFVkc1dFT3A1Y2gzaVVqR1N6?=
 =?utf-8?B?SVEwK0prS3h0UjBka0lnbEY4bFRGOTRvSXFxZm96ek9qMVpDVVc2SzAvWlg5?=
 =?utf-8?B?YzF5ZkRSZFlicXBTbURNL1pVNWhUVUZGTEEzalh5cHBSTHd4RG5mcG13NlFD?=
 =?utf-8?B?U2JveUR4S1JIV25qUEVZZVZQZ2dnVTV4SVlNb1hFZ1M0VkRaVWdWbU9QOWxC?=
 =?utf-8?B?WXJMeVhhQUp4UmhnTTJrWE9yVXBwS25hUW5LSWJjSzJGcVlBUnBzSDVVTlhQ?=
 =?utf-8?Q?8Uq8DP1n7L9tXdVTkE1HgX0YqNGvb+XtRMGLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b7760-2437-4b9b-11de-08deb8de6f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2026 15:17:42.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10217
X-Spamd-Result: default: False [6.44 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11179-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	TAGGED_RCPT(0.00)[linux-hyperv];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.978];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,BN7PR02MB4148.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 734115BF9BF
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

RnJvbTogQmVya2FudCBLb2MgPG1lQGJlcmtvYy5jb20+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjMs
IDIwMjYgNjoyOCBBTQ0KPiANCj4gaHlwZXJ2X3JlY2VpdmVfc3ViKCkgcmVhZHMgbXNnLT52aWRf
aGRyLnR5cGUgYW5kIGRpc3BhdGNoZXMgaW50byBvbmUNCj4gb2YgZm91ciBtZXNzYWdlLXR5cGUg
YnJhbmNoZXMgd2l0aG91dCBrbm93aW5nIGhvdyBtYW55IGJ5dGVzIHRoZSBob3N0DQo+IHdyb3Rl
IGludG8gaHYtPnJlY3ZfYnVmLiBUaGUgY29tcGxldGlvbiBwYXRoIHRoZW4gcnVucw0KPiBtZW1j
cHkoaHYtPmluaXRfYnVmLCBtc2csIFZNQlVTX01BWF9QQUNLRVRfU0laRSksIHNvIHRoZSBjb25z
dW1lciB0aGF0DQo+IHdha2VzIG9uIHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgpIGNhbiBy
ZWFkIHVwIHRvIDE2IEtpQiBvZg0KPiByZXNpZHVlIGZyb20gYSBwcmlvciBtZXNzYWdlIGFzIGlm
IGl0IHdlcmUgdGhlIHJlc3BvbnNlIHBheWxvYWQuDQo+IA0KPiBQYXNzIGJ5dGVzX3JlY3ZkIGlu
dG8gaHlwZXJ2X3JlY2VpdmVfc3ViKCkgYW5kIHJlamVjdCBhbnkgcGFja2V0IHRoYXQNCj4gZG9l
cyBub3QgY292ZXIgdGhlIHBpcGUgKyBzeW50aHZpZCBoZWFkZXIuIEEgc2luZ2xlIHN3aXRjaCBv
bg0KPiBtc2ctPnZpZF9oZHIudHlwZSB0aGVuIGNvbXB1dGVzIHRoZSB0eXBlLXNwZWNpZmljIHBh
eWxvYWQgc2l6ZTogdGhlDQo+IHRocmVlIGNvbXBsZXRpb24tZHJpdmluZyB0eXBlcyAoU1lOVEhW
SURfVkVSU0lPTl9SRVNQT05TRSwNCj4gU1lOVEhWSURfUkVTT0xVVElPTl9SRVNQT05TRSwgU1lO
VEhWSURfVlJBTV9MT0NBVElPTl9BQ0spIGZhbGwgdGhyb3VnaA0KPiB0byBhIHNoYXJlZCBleGl0
IHRoYXQgcmVxdWlyZXMgdGhhdCBzaXplIGJlZm9yZSBtZW1jcHkvY29tcGxldGUsIHdoaWxlDQo+
IFNZTlRIVklEX0ZFQVRVUkVfQ0hBTkdFIHZhbGlkYXRlcyBpdHMgb3duIHBheWxvYWQgYW5kIHJl
dHVybnMgYmVmb3JlDQo+IHJlYWRpbmcgaXNfZGlydF9uZWVkZWQuIFVua25vd24gdHlwZXMgYXJl
IGRyb3BwZWQuDQo+IA0KPiBTWU5USFZJRF9SRVNPTFVUSU9OX1JFU1BPTlNFIGlzIHZhcmlhYmxl
IGxlbmd0aDogdGhlIGhvc3QgZmlsbHMNCj4gcmVzb2x1dGlvbl9jb3VudCBlbnRyaWVzLCBub3Qg
dGhlIGZ1bGwgU1lOVEhWSURfTUFYX1JFU09MVVRJT05fQ09VTlQNCj4gYXJyYXkuIFZhbGlkYXRl
IHRoZSBmaXhlZCBwcmVmaXggZmlyc3Qgc28gcmVzb2x1dGlvbl9jb3VudCBjYW4gYmUNCj4gcmVh
ZCwgYm91bmQgaXQgYWdhaW5zdCB0aGUgYXJyYXksIHRoZW4gcmVxdWlyZSBvbmx5IHRoZSBjb3Vu
dC1zaXplZA0KPiBhcnJheSwgc28gdGhlIHNob3J0ZXIgcmVzcG9uc2VzIHRoZSBob3N0IGFjdHVh
bGx5IHNlbmRzIGFyZSBhY2NlcHRlZC4NCj4gDQo+IE9ubHkgcnVuIHRoZSBzdWItaGFuZGxlciB3
aGVuIHZtYnVzX3JlY3ZwYWNrZXQoKSByZXR1cm5lZCBzdWNjZXNzLiBUaGUNCj4gbWVtY3B5IGxl
bmd0aCBpcyBieXRlc19yZWN2ZCwgd2hpY2ggaXMgYm91bmRlZCBieSBWTUJVU19NQVhfUEFDS0VU
X1NJWkUNCj4gb25seSBvbiBhIHN1Y2Nlc3NmdWwgcmVjZWl2ZTsgb24gLUVOT0JVRlMgdm1idXNf
cmVjdnBhY2tldCgpIGluc3RlYWQNCj4gcmVwb3J0cyB0aGUgcmVxdWlyZWQgbGVuZ3RoLCB3aGlj
aCBjYW4gZXhjZWVkIGh2LT5yZWN2X2J1Ziwgc28gY29weWluZw0KPiBieXRlc19yZWN2ZCB3b3Vs
ZCByZWFkIGFuZCB3cml0ZSBwYXN0IHRoZSAxNiBLaUIgYnVmZmVycy4gR2F0aW5nIG9uIHRoZQ0K
PiBzdWNjZXNzIHJldHVybiBrZWVwcyB0aGUgY29weSBib3VuZGVkLiBUaGUgbm9uemVyby1yZXR1
cm4gcGF0aCBpcyBpdHNlbGYNCj4gYSBtYWxmb3JtZWQtbWVzc2FnZSBjYXNlIGFuZCBpcyBub3cg
bG9nZ2VkIHJhdGhlciB0aGFuIHNpbGVudGx5IHNraXBwZWQ7DQo+IGNoYW5uZWwgcmVjb3Zlcnkg
aXMgbm90IGF0dGVtcHRlZC4NCj4gDQo+IFJlamVjdGVkIHBhY2tldHMgYXJlIHJlcG9ydGVkIHZp
YSBkcm1fZXJyX3JhdGVsaW1pdGVkKCkgcmF0aGVyIHRoYW4NCj4gc2lsZW50bHkgZHJvcHBlZCwg
bWF0Y2hpbmcgdGhlIENvQ28taGFyZGVuZWQgcGF0dGVybiBpbg0KPiBodl9rdnBfb25jaGFubmVs
Y2FsbGJhY2soKS4NCj4gDQo+IEZpeGVzOiA3NmM1NmE1YWZmZWIgKCJkcm0vaHlwZXJ2OiBBZGQg
RFJNIGRyaXZlciBmb3IgaHlwZXJ2IHN5bnRoZXRpYyB2aWRlbyBkZXZpY2UiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIDUuMTQrDQo+IFNpZ25lZC1vZmYtYnk6IEJlcmthbnQgS29j
IDxtZUBiZXJrb2MuY29tPg0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtNyBi
ZXJrb2MtcGlwZWxpbmUNCg0KVGhpcyBsb29rcyBnb29kIG5vdy4gVGhlIGVycm9yIGNoZWNraW5n
IGFuZCByZXBvcnRpbmcgaXMgcm9idXN0DQphbmQgdGhlIGNvZGUgaXMgd2VsbC1zdHJ1Y3R1cmVk
LiBUaGFua3MgZm9yIHB1dHRpbmcgdXAgd2l0aCBteQ0Kc29tZXRpbWVzIHBpY2t5IGZlZWRiYWNr
LiA6LSkNCg0KSSBhbHNvIHJhbiBhIGJhc2ljIHNtb2tlLXRlc3Qgb24gbXkgbG9jYWwgSHlwZXIt
ViBpbnN0YW5jZS4gSQ0KY2FuIGNvbmZpcm0gdGhhdCBubyBlcnJvciBtZXNzYWdlcyBvciBmYWls
dXJlIHdlcmUgZ2VuZXJhdGVkDQppbiB0aGUgImdvb2QiIGNhc2Ugd2hlcmUgdGhlIG1lc3NhZ2Vz
IGZyb20gSHlwZXItViBhcmUNCnByb3Blcmx5IGZvcm1hdHRlZCBhbmQgc2l6ZWQuIEkgZGlkIG5v
dCBzaW11bGF0ZSBiYWQgbWVzc2FnZXMNCmFuZCBlbnN1cmUgdGhleSBhcmUgZGV0ZWN0ZWQuDQoN
ClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQpUZXN0
ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4gIA0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2h5cGVydi9oeXBlcnZfZHJtX3Byb3RvLmMgfCAxMDAgKysrKysr
KysrKysrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9oeXBlcnYv
aHlwZXJ2X2RybV9wcm90by5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2h5cGVydi9oeXBlcnZfZHJt
X3Byb3RvLmMNCj4gaW5kZXggYzNkMGZmMjI5Li40ZTZmNzAzYTEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9oeXBlcnYvaHlwZXJ2X2RybV9wcm90by5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9oeXBlcnYvaHlwZXJ2X2RybV9wcm90by5jDQo+IEBAIC00MjAsMzAgKzQyMCw5MiBA
QCBzdGF0aWMgaW50IGh5cGVydl9nZXRfc3VwcG9ydGVkX3Jlc29sdXRpb24oc3RydWN0IGh2X2Rl
dmljZSAqaGRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgdm9pZCBoeXBl
cnZfcmVjZWl2ZV9zdWIoc3RydWN0IGh2X2RldmljZSAqaGRldikNCj4gK3N0YXRpYyB2b2lkIGh5
cGVydl9yZWNlaXZlX3N1YihzdHJ1Y3QgaHZfZGV2aWNlICpoZGV2LCB1MzIgYnl0ZXNfcmVjdmQp
DQo+ICB7DQo+ICAJc3RydWN0IGh5cGVydl9kcm1fZGV2aWNlICpodiA9IGh2X2dldF9kcnZkYXRh
KGhkZXYpOw0KPiAgCXN0cnVjdCBzeW50aHZpZF9tc2cgKm1zZzsNCj4gKwlzaXplX3QgaGRyX3Np
emU7DQo+ICsJc2l6ZV90IG5lZWQ7DQo+IA0KPiAgCWlmICghaHYpDQo+ICAJCXJldHVybjsNCj4g
DQo+IC0JbXNnID0gKHN0cnVjdCBzeW50aHZpZF9tc2cgKilodi0+cmVjdl9idWY7DQo+IC0NCj4g
LQkvKiBDb21wbGV0ZSB0aGUgd2FpdCBldmVudCAqLw0KPiAtCWlmIChtc2ctPnZpZF9oZHIudHlw
ZSA9PSBTWU5USFZJRF9WRVJTSU9OX1JFU1BPTlNFIHx8DQo+IC0JICAgIG1zZy0+dmlkX2hkci50
eXBlID09IFNZTlRIVklEX1JFU09MVVRJT05fUkVTUE9OU0UgfHwNCj4gLQkgICAgbXNnLT52aWRf
aGRyLnR5cGUgPT0gU1lOVEhWSURfVlJBTV9MT0NBVElPTl9BQ0spIHsNCj4gLQkJbWVtY3B5KGh2
LT5pbml0X2J1ZiwgbXNnLCBWTUJVU19NQVhfUEFDS0VUX1NJWkUpOw0KPiAtCQljb21wbGV0ZSgm
aHYtPndhaXQpOw0KPiArCWhkcl9zaXplID0gc2l6ZW9mKHN0cnVjdCBwaXBlX21zZ19oZHIpICsN
Cj4gKwkJICAgc2l6ZW9mKHN0cnVjdCBzeW50aHZpZF9tc2dfaGRyKTsNCj4gKwlpZiAoYnl0ZXNf
cmVjdmQgPCBoZHJfc2l6ZSkgew0KPiArCQlkcm1fZXJyX3JhdGVsaW1pdGVkKCZodi0+ZGV2LA0K
PiArCQkJCSAgICAic3ludGh2aWQgcGFja2V0IHRvbyBzbWFsbCBmb3IgaGVhZGVyOiAldVxuIiwN
Cj4gKwkJCQkgICAgYnl0ZXNfcmVjdmQpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiANCj4gLQlp
ZiAobXNnLT52aWRfaGRyLnR5cGUgPT0gU1lOVEhWSURfRkVBVFVSRV9DSEFOR0UpIHsNCj4gKwlt
c2cgPSAoc3RydWN0IHN5bnRodmlkX21zZyAqKWh2LT5yZWN2X2J1ZjsNCj4gKwluZWVkID0gaGRy
X3NpemU7DQo+ICsNCj4gKwlzd2l0Y2ggKG1zZy0+dmlkX2hkci50eXBlKSB7DQo+ICsJY2FzZSBT
WU5USFZJRF9WRVJTSU9OX1JFU1BPTlNFOg0KPiArCQluZWVkICs9IHNpemVvZihzdHJ1Y3Qgc3lu
dGh2aWRfdmVyc2lvbl9yZXNwKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBTWU5USFZJRF9SRVNP
TFVUSU9OX1JFU1BPTlNFOg0KPiArCQkvKg0KPiArCQkgKiBUaGUgcmVzb2x1dGlvbiByZXNwb25z
ZSBpcyB2YXJpYWJsZSBsZW5ndGg6IHRoZSBob3N0DQo+ICsJCSAqIGZpbGxzIHJlc29sdXRpb25f
Y291bnQgZW50cmllcywgbm90IHRoZSBmdWxsDQo+ICsJCSAqIFNZTlRIVklEX01BWF9SRVNPTFVU
SU9OX0NPVU5UIGFycmF5LiBSZXF1aXJlIHRoZSBmaXhlZA0KPiArCQkgKiBwcmVmaXggZmlyc3Qg
c28gcmVzb2x1dGlvbl9jb3VudCBjYW4gYmUgcmVhZCwgdGhlbg0KPiArCQkgKiBkZW1hbmQgZXhh
Y3RseSB0aGUgY291bnQtc2l6ZWQgYXJyYXkuDQo+ICsJCSAqLw0KPiArCQluZWVkICs9IG9mZnNl
dG9mKHN0cnVjdCBzeW50aHZpZF9zdXBwb3J0ZWRfcmVzb2x1dGlvbl9yZXNwLA0KPiArCQkJCSBz
dXBwb3J0ZWRfcmVzb2x1dGlvbik7DQo+ICsJCWlmIChieXRlc19yZWN2ZCA8IG5lZWQpDQo+ICsJ
CQlicmVhazsNCj4gKwkJaWYgKG1zZy0+cmVzb2x1dGlvbl9yZXNwLnJlc29sdXRpb25fY291bnQg
Pg0KPiArCQkgICAgU1lOVEhWSURfTUFYX1JFU09MVVRJT05fQ09VTlQpIHsNCj4gKwkJCWRybV9l
cnJfcmF0ZWxpbWl0ZWQoJmh2LT5kZXYsDQo+ICsJCQkJCSAgICAic3ludGh2aWQgcmVzb2x1dGlv
biBjb3VudCB0b28gbGFyZ2U6ICV1XG4iLA0KPiArCQkJCQkgICAgbXNnLT5yZXNvbHV0aW9uX3Jl
c3AucmVzb2x1dGlvbl9jb3VudCk7DQo+ICsJCQlyZXR1cm47DQo+ICsJCX0NCj4gKwkJbmVlZCAr
PSBtc2ctPnJlc29sdXRpb25fcmVzcC5yZXNvbHV0aW9uX2NvdW50ICoNCj4gKwkJCXNpemVvZihz
dHJ1Y3QgaHZkX3NjcmVlbl9pbmZvKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBTWU5USFZJRF9W
UkFNX0xPQ0FUSU9OX0FDSzoNCj4gKwkJbmVlZCArPSBzaXplb2Yoc3RydWN0IHN5bnRodmlkX3Zy
YW1fbG9jYXRpb25fYWNrKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBTWU5USFZJRF9GRUFUVVJF
X0NIQU5HRToNCj4gKwkJLyoNCj4gKwkJICogTm90IGEgY29tcGxldGlvbi1kcml2aW5nIG1lc3Nh
Z2U6IHZhbGlkYXRlIGl0cyBvd24gcGF5bG9hZA0KPiArCQkgKiBhbmQgY29uc3VtZSBpdCBoZXJl
IHJhdGhlciB0aGFuIGZhbGxpbmcgdGhyb3VnaCB0byB0aGUNCj4gKwkJICogbWVtY3B5L2NvbXBs
ZXRlIHNoYXJlZCBieSB0aGUgd2FpdC1ldmVudCByZXNwb25zZXMuDQo+ICsJCSAqLw0KPiArCQlp
ZiAoYnl0ZXNfcmVjdmQgPCBuZWVkICsNCj4gKwkJICAgIHNpemVvZihzdHJ1Y3Qgc3ludGh2aWRf
ZmVhdHVyZV9jaGFuZ2UpKSB7DQo+ICsJCQlkcm1fZXJyX3JhdGVsaW1pdGVkKCZodi0+ZGV2LA0K
PiArCQkJCQkgICAgInN5bnRodmlkIGZlYXR1cmUgY2hhbmdlIHBhY2tldCB0b28gc21hbGw6ICV1
XG4iLA0KPiArCQkJCQkgICAgYnl0ZXNfcmVjdmQpOw0KPiArCQkJcmV0dXJuOw0KPiArCQl9DQo+
ICAJCWh2LT5kaXJ0X25lZWRlZCA9IG1zZy0+ZmVhdHVyZV9jaGcuaXNfZGlydF9uZWVkZWQ7DQo+
ICAJCWlmIChodi0+ZGlydF9uZWVkZWQpDQo+ICAJCQloeXBlcnZfaGlkZV9od19wdHIoaHYtPmhk
ZXYpOw0KPiArCQlyZXR1cm47DQo+ICsJZGVmYXVsdDoNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4g
Kw0KPiArCS8qDQo+ICsJICogU2hhcmVkIGNvbXBsZXRpb24gcGF0aCBmb3IgdGhlIHdhaXQtZXZl
bnQgcmVzcG9uc2VzDQo+ICsJICogKFZFUlNJT05fUkVTUE9OU0UsIFJFU09MVVRJT05fUkVTUE9O
U0UsIFZSQU1fTE9DQVRJT05fQUNLKToNCj4gKwkgKiByZXF1aXJlIHRoZSB0eXBlLXNwZWNpZmlj
IHBheWxvYWQgYmVmb3JlIGhhbmRpbmcgdGhlIGJ1ZmZlciB0bw0KPiArCSAqIHRoZSB3YWl0ZXIu
DQo+ICsJICovDQo+ICsJaWYgKGJ5dGVzX3JlY3ZkIDwgbmVlZCkgew0KPiArCQlkcm1fZXJyX3Jh
dGVsaW1pdGVkKCZodi0+ZGV2LA0KPiArCQkJCSAgICAic3ludGh2aWQgcGFja2V0IHRvbyBzbWFs
bCBmb3IgdHlwZSAldTogJXUgPCAlenVcbiIsDQo+ICsJCQkJICAgIG1zZy0+dmlkX2hkci50eXBl
LCBieXRlc19yZWN2ZCwgbmVlZCk7DQo+ICsJCXJldHVybjsNCj4gIAl9DQo+ICsJbWVtY3B5KGh2
LT5pbml0X2J1ZiwgbXNnLCBieXRlc19yZWN2ZCk7DQo+ICsJY29tcGxldGUoJmh2LT53YWl0KTsN
Cj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBoeXBlcnZfcmVjZWl2ZSh2b2lkICpjdHgpDQo+IEBA
IC00NjQsOSArNTI2LDIxIEBAIHN0YXRpYyB2b2lkIGh5cGVydl9yZWNlaXZlKHZvaWQgKmN0eCkN
Cj4gIAkJcmV0ID0gdm1idXNfcmVjdnBhY2tldChoZGV2LT5jaGFubmVsLCByZWN2X2J1ZiwNCj4g
IAkJCQkgICAgICAgVk1CVVNfTUFYX1BBQ0tFVF9TSVpFLA0KPiAgCQkJCSAgICAgICAmYnl0ZXNf
cmVjdmQsICZyZXFfaWQpOw0KPiAtCQlpZiAoYnl0ZXNfcmVjdmQgPiAwICYmDQo+IC0JCSAgICBy
ZWN2X2J1Zi0+cGlwZV9oZHIudHlwZSA9PSBQSVBFX01TR19EQVRBKQ0KPiAtCQkJaHlwZXJ2X3Jl
Y2VpdmVfc3ViKGhkZXYpOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQkvKg0KPiArCQkJICogQSBu
b256ZXJvIHJldHVybiAoZS5nLiAtRU5PQlVGUyBmb3IgYW4gb3ZlcnNpemVkDQo+ICsJCQkgKiBw
YWNrZXQpIGlzIGl0c2VsZiBhIG1hbGZvcm1lZCBtZXNzYWdlOiBieXRlc19yZWN2ZA0KPiArCQkJ
ICogdGhlbiByZXBvcnRzIHRoZSByZXF1aXJlZCBsZW5ndGggcmF0aGVyIHRoYW4gYSBjb3BpZWQN
Cj4gKwkJCSAqIHBheWxvYWQsIHNvIGl0IG11c3Qgbm90IGJlIGZvcndhcmRlZCB0byB0aGUNCj4g
KwkJCSAqIHN1Yi1oYW5kbGVyLiBDaGFubmVsIHJlY292ZXJ5IGlzIG5vdCBhdHRlbXB0ZWQuDQo+
ICsJCQkgKi8NCj4gKwkJCWRybV9lcnJfcmF0ZWxpbWl0ZWQoJmh2LT5kZXYsDQo+ICsJCQkJCSAg
ICAidm1idXNfcmVjdnBhY2tldCBmYWlsZWQ6ICVkIChuZWVkICV1KVxuIiwNCj4gKwkJCQkJICAg
IHJldCwgYnl0ZXNfcmVjdmQpOw0KPiArCQl9IGVsc2UgaWYgKGJ5dGVzX3JlY3ZkID4gMCAmJg0K
PiArCQkJICAgcmVjdl9idWYtPnBpcGVfaGRyLnR5cGUgPT0gUElQRV9NU0dfREFUQSkgew0KPiAr
CQkJaHlwZXJ2X3JlY2VpdmVfc3ViKGhkZXYsIGJ5dGVzX3JlY3ZkKTsNCj4gKwkJfQ0KPiAgCX0g
d2hpbGUgKGJ5dGVzX3JlY3ZkID4gMCAmJiByZXQgPT0gMCk7DQo+ICB9DQo+IA0KPiAtLQ0KPiAy
LjQ3LjMNCj4gDQoNCg==

