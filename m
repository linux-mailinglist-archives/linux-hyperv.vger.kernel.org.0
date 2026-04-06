Return-Path: <linux-hyperv+bounces-10015-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN4KEVC+02m4lQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10015-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 16:08:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE93A3C89
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A210B300E630
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86D37DEBB;
	Mon,  6 Apr 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="smpk4QNW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011031.outbound.protection.outlook.com [52.103.14.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E36371D0D;
	Mon,  6 Apr 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484492; cv=fail; b=tyYHPGRvOIicStLE/VRnrQBIVPFZOVNVid0GH6EshhKzizHMuEaHvsc+J3Jazbn+sjqmjxwRr/OR629jLB49evHPx7qSSDCbsVVj11Uc9V8HPsUF492mvbtZoZDvgxzfMIKJwDNCDzJN75wgJkdfdjzTBNLsoaYqtOGnUQ8O5QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484492; c=relaxed/simple;
	bh=DHL/yWe/r29J96101pDQCmdKUvp3rAcGIIpysShI8Yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a58OorKCDCQZRWuRf8YG0qLGTzqXZxKjygRfsE54SrRuDzFND1FluvePySxZjhQn8XhqAZKezh45Gf0fWfnJgAqybcvg1NmHXujby3lcDFlziGAQokAxYhNBAC3/FwF03KuUFoAeyUOTi278B31fWt19k8uqW3jzyH+MRxxmE0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=smpk4QNW; arc=fail smtp.client-ip=52.103.14.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCdhEfyta0MqvRpcYPE1+jqUsQywnsrNK4RTMS1UgIL4OrggOnSAirG6pqLpVw9ozZEGYLrvFldYaxa/Gwgm8tW6J7pmW6xzZvmSuSdSOFv2LY0lSSKYaHR/4OCMim4is7afX9D8wM6/+5roQeDiRru3nbV+UxoBv3BNQMHbx+YqXNnp2BiXCQgdD6i9TpciayT473Wc8Ji+g/g+mrmc/0E/L4j0jMyLkEJ4+li4pk+eU8BckyPwfCnfXfG23gtGUUjy24U2bThQAIe5HDV/VLkrn+Y9vQrjsmLJFOQDE2Wo8c/3+axc4LfdMceNUk4AbIBRw5DlOJzBG2UBceRsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rgbBHAjQArVAqwa8qAWTBz2MLKk5XtIPjDwvAXHkIE=;
 b=UEN95naJqqxG4B8IytRcncuIhH0qLgiMJ3tiBgvmTSIX50lnsLIBUNXHSnFIAcaLhyVgfXy5NP8MB5T9VbWWtCTJ5a/EUfTkKujpZ8EQKItmgHDyYboszP6bvcMp0FFEv0fzed0egbvHw49T4rSWVN9cnjw/0VNtjjP4H+aHcCdE6rAm4RnCitlDVp2JT8ZiYJDHeBNXNgTs7Lt0mSxpW3V7VlH6xA9iUAyaAx/I9qkXxIBR0NH2NCrMq/GPcC+kJ5QRv8bGkNLIO64si9vQEzT8DkRaj13apByqHyPeUpq5TcQ4jL1kJe8tRLbcnHNyN1fqvGUTkdAOOSonjvWHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rgbBHAjQArVAqwa8qAWTBz2MLKk5XtIPjDwvAXHkIE=;
 b=smpk4QNW4PpK4W/dkPxMZFstYdCMnuXWgaQnFaiPHCAkkkJjcurgQR8T2BU75gAlsZXVuxdqt5yXcsBYJMa3JFvU3EvAKIC+KZ1dXKKrbdSUqDVJ4HwcwgVCJ9X5mP9UxgfhNBQ9Vrv+V4CKVJh+sXCWNtpQ31UMMvR9b8SuK9MawkB3i5kxjz3u9QGPAhd3KDr8noaJ/I1X2JfqdNbbxJje/yjVbzD0RRhUeOrHFxQnrHNEGe/rAwSUx1gPPZGlqiaMtYWDsnr4qRLh4hbmBaLh+qxacK3LF9+jRPQ1gM7m574sKPqP5tDiQwzUlDQN5IQBtOD8JFKm7jAx2Ri/+A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9342.namprd02.prod.outlook.com (2603:10b6:a03:4c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 14:08:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 14:08:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER
Thread-Topic: [PATCH v2] mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER
Thread-Index: AQHcxadDltAPWfJr7E6qBCQIUjpZYbXSEkMA
Date: Mon, 6 Apr 2026 14:08:07 +0000
Message-ID:
 <SN6PR02MB4157AADD1038801A5FA14A5ED45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260406092459.2351028-1-namjain@linux.microsoft.com>
In-Reply-To: <20260406092459.2351028-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9342:EE_
x-ms-office365-filtering-correlation-id: 554f0a20-6edc-41a7-8c41-08de93e5ed55
x-ms-exchange-slblob-mailprops:
 laRBL560oLS7IWERjHonlu/qsKr3Bu1Zy3R+7x+2IB6NScV8K8MAvRkLWpSjTnx07nMNs3TMMBdsOj0HW65SiOIAzuZQY1+8200mVAoZKIxymWHllNXmXrpcTDjDBfAE5FhpXZu+O5FmoHdbk/Z3Yyr5vCDkCCGKniDL+vXtLAKUH84m6yUgGophFbniYcfv2eRcIg5YmZktLt/R5rUyNu9oiHTSt5YiOmwqsU23SKZQdTvNW9uh4aWv+dGDFUv5JW4kIUYFcCmi8uj6KMF+2b7UXXgnTBenVIUaEvi6y31thyOQoHOCGd19ta6jN/i2aOZkTlmFPS+fMJwJlD6cw0V8fIHsmK6NOpkjKka3vSkl9AiSPsxXb6TXC6+wRS67e0mFOkbgH0z7tV9zZ+rTC7i/sMo0VkADpMCNqrO4mEDfIGLex3D0y9yr38a84zJ9grMYVsdITCnGDZck8VsHOAlR0woulKdBGZSX8Qftkray6oCbXx/XRhmO4RThDagxAkKWTtj39pAH6O2ZHNXT4khycXrKK5jn2Cla64kay+JQ5BvXiuEIFe7Y/+bk/OAzqeltgB0p/Hbu5z8qeAWzI32BecY+a7oGYSLJKMKZoowTXfJFmhWhL44PhZ/JOa0G2y2uzWGZGbrA6JQuv9tbndSzjPoQg3AlLimE1PlTNATA66+MJW2akeWDd64hvFYVvqCg22nUEYMEzI9DD7pDqwBLzQaqt/Xue09fDpJQZe1BZ+hKZxwSMjhA8FDciCNgAk79jpE4bnVDGhAfCgh5/BHDZcEqHBDJ
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|13091999003|461199028|12121999013|37011999003|19110799012|15080799012|8062599012|8060799015|41001999006|1602099012|40105399003|3412199025|440099028|4302099013|10035399007|102099032|12091999003|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P1D3dg9TV0eNenmbZqmNCfoVSpJppgSBKHDosPLaj0E8WyGBPpFFYsvzqpm8?=
 =?us-ascii?Q?PRuXn4BeQpyWx9hkuCfzOTVRO268ytq/cWdSQnwxG4WQKHTQQiOPLC1vjdTQ?=
 =?us-ascii?Q?0wCXIBvNo+f7ckNlbObVXe6MWCFlEcjh99JNpi/pajeMSRRerUiTa9f0JGUH?=
 =?us-ascii?Q?IsFKA+TcNYXNAKdpLB2G/Cgs/7iZQ0Eco44nE8gsrtr2D+xDER044xBXww7m?=
 =?us-ascii?Q?5YS2SrMs91/cNkxfkJ9BwjwNG7X0wvkYpMKTFF6B6sSVHwCv2F2yUMgdVyNC?=
 =?us-ascii?Q?lAhCvuhAqKbLMULRWr/udWhsYxwGz+Ip7iSBvFgMWIxYPIcjxKP1rHCqMWon?=
 =?us-ascii?Q?4tMc+LbKtDKzwVBJ8TR7mwZ0X1c8Ma/rnwn2lxAj2mIezQjQDKZaToX3Jui1?=
 =?us-ascii?Q?PxBEeH4MZ6yZlUJgLKIBSVt333pc8AMmkXwY2lSCDapHEH9j34KBgVMUEHZC?=
 =?us-ascii?Q?4yn+l5lCN1pSwIs0ELfkPdIwliJSr/ZnGaZ1AGu94MU36aaKA9Gg6tjE6qlB?=
 =?us-ascii?Q?TfU9PgEdzK5A3keioK6NVs1fpGpfBTIvslpvpDabvwW372cOMjPAS7om3zBL?=
 =?us-ascii?Q?mPL86EcaTBQYoWqVVINEQa17t7Rqm6mV/Tjzmo/0sUSAEzTLsvbXS+xMEzY+?=
 =?us-ascii?Q?st30BYteWysSXJzRn6aKLsjUrITFY1xW440Gn4Xaxq79N7QtVClS9FuaH1Vm?=
 =?us-ascii?Q?5H2Diqi3W4IVCCdvk4usPQfjw53PrhAiU3JKkFpS6hHTzbPChFlfJlUBOYtR?=
 =?us-ascii?Q?U3GPUxlo39h033StX+7Sa1lyYFp1hx4DwZuqFmpibE6VS3u4MCqIyERIEQYj?=
 =?us-ascii?Q?5GPk29w/TO0/2/Xfs5gxl2+Jdl58E0btHQMAuXVrMhQFVEGHS5GcUYIj7/5m?=
 =?us-ascii?Q?3ap368kVfZvv59ADUNSxdUQCH6IYIVsPpGc28mZSF8EupHLR8T6jyPEc0Tb7?=
 =?us-ascii?Q?8XbSfo8bvjmGL3BplQvW4IwvFUgB72+6y9PcGv76XE7IJ6E8mUnM0jsA55Dx?=
 =?us-ascii?Q?Vjv0DVfOIoxirjSLhKVlUrXCae5ZxLHQ9v/KRn6W8gMuvenW3mrlLC9uyDZq?=
 =?us-ascii?Q?O+HIOvbtU3ej3q+46zDzbt5ZSs7FFtHjJEeK1Fh7nDUsbZ7Dfr8UYwE8Hhm0?=
 =?us-ascii?Q?TdSGpvz42h519twKnxet2B7hpU0DZkloN8EbecVolYCPiTpwGmxF03zp7o3W?=
 =?us-ascii?Q?ee+BbJKYesKD9ssEj0XOmM3F+72mwPANvRfqNis9ysXAA6xMjvUJ3TcOY1kB?=
 =?us-ascii?Q?pCO1OGvYEibrQgaspxdZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?92gU1rqWThYCRtaTyzLpJwyVQPBShYyPP21R7G3YbHPjbhrF4XYqNmYgCCFY?=
 =?us-ascii?Q?HvDDhf0GQMp7d7/s4amiLwwKNDLTCEQEzSM4TsxS5CUCFkaa3AK+z2zKlES+?=
 =?us-ascii?Q?GlLEKSjdDgaox5KQLsveNYBUFf4Ezwj0PQIsY536t17h+4/jNDMtvFGBEsPU?=
 =?us-ascii?Q?FaHoIZ2dEave1Cn78mxKcoMDC2RwZd9A6oEy5eAnq6JdPFA6acovOHFvudf4?=
 =?us-ascii?Q?glonmvxGB/4dlzJnwlF1LIncIktBuwR9cPjbg55hj3ETazEaT7iCppSI4N7x?=
 =?us-ascii?Q?Zwu+QctfqEnSN07IJYZOwDrmRaZ7B0LJnf7STsv0LMuCVly97T3awDAFxsD5?=
 =?us-ascii?Q?aFt53ndeFq+EOdNH1Yxi1kzSEiontTXfJvj/ruwEUPF/CTUgZmaAh1Nsad1C?=
 =?us-ascii?Q?2ANriGW6ZUnX8NFsf1OLuB3KmZzKmZZCeTMC+z9qYOLkstJsDgID6LbmuRLV?=
 =?us-ascii?Q?jLkF7lFR3uSr9SdNiigBWs+y2OAI0c7g6s8YHHEngFpi2AtKstHOtXIioGxm?=
 =?us-ascii?Q?UFM+I21HW8/9NsUK+UqrIrImpsfg8tXSwt4fgbTpdw//Zp2fgIE43I76GMBu?=
 =?us-ascii?Q?/iz08+vmpb+X5ub6Y++DFddrM8bYXqUBUuS61ieFYhDNJ4deLPGayWa6DboP?=
 =?us-ascii?Q?Nzoe7QrqTwrNSreXFHruSVj6f/X6tBGWV+7pILAa7CVEblZGW9ymPHgnMWA6?=
 =?us-ascii?Q?hg4CbwIxljI9HuoLrlEWO9zlJGYu592VlQBNSMxhqssRfg+HR85BHCqts1kg?=
 =?us-ascii?Q?rlJAdINGyNS5r7UNwWk/psuOgs6X9VWSEUQ9W4d5XV5Ts345ue1t42vDfcom?=
 =?us-ascii?Q?svAgZCoM+es5jfIN4udOxzYgWU2IfGRQZDtegcQPM8nMqSrOHixB9T24p075?=
 =?us-ascii?Q?jyDTClkDbtKNJzLEFfznokr+1GjMMB+DN2o3w7luDV2JwjIEG58W75khj6rK?=
 =?us-ascii?Q?MJ+68Csn/GmmkZ83sEcU8HajHDA/C4EwsgEnHFB4ZHSpscZaPPnPDqlVMYz1?=
 =?us-ascii?Q?QzlVqCpKoehYv5W8Bv7aovEucWDrHH/TC0HVTSbJFECx1af3AK6uHSg0JtqG?=
 =?us-ascii?Q?j+no2Eq4X925KqLtUYm71uZcSE460AjrhuoH3arj/mH286DEnkpPEO/kWdCY?=
 =?us-ascii?Q?JjWTRRs3LSUNk3PxtfAWf43+/70O/ZCO39xqb+a5AZcBPyMs/Jlp+ak5P0Nv?=
 =?us-ascii?Q?X2+7wv22yCj+Dgbd15LXVrf47sn8hD+zIAjyUwSpF7VEymlix67iaFj4lSH7?=
 =?us-ascii?Q?7v7bzVWGz7G4DmWjBsAD3M7MZNnQR2NK/w4lLUmdr12h7imVngngj1rhAiey?=
 =?us-ascii?Q?8ZR9zuVANyZtF3A4Lxg9lN5YqCQRYZXYsDibRTKM9Bzxs9SH3J+knOXI6mgZ?=
 =?us-ascii?Q?095LYHA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 554f0a20-6edc-41a7-8c41-08de93e5ed55
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 14:08:07.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9342
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10015-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: A8AE93A3C89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, April 6, 2026 =
2:25 AM
>=20
> When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
> computes pgmap->vmemmap_shift as the number of trailing zeros in the
> OR of start_pfn and last_pfn, intending to use the largest compound
> page order both endpoints are aligned to.
>=20
> However, this value is not clamped to MAX_FOLIO_ORDER, so a
> sufficiently aligned range (e.g. physical range
> [0x800000000000, 0x800080000000), corresponding to start_pfn=3D0x80000000=
0
> with 35 trailing zeros) can produce a shift larger than what
> memremap_pages() accepts, triggering a WARN and returning -EINVAL:
>=20
>   WARNING: ... memremap_pages+0x512/0x650
>   requested folio size unsupported
>=20
> The MAX_FOLIO_ORDER check was added by
> commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
> page sizes in memremap_pages()").
>=20
> Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
> request the largest order the kernel supports, in those cases, rather
> than an out-of-range value.
>=20
> Also fix the error path to propagate the actual error code from
> devm_memremap_pages() instead of hard-coding -EFAULT, which was
> masking the real -EINVAL return.
>=20
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20260401054005.1532381-1-
> namjain@linux.microsoft.com/
> Addressed Michael's comments:
> * remove MAX_FOLIO_ORDER value related text in commit msg
> * Change change summary to keep prefix "mshv_vtl:"
> * Add comments regarding last_pfn to avoid confusion
> * use min instead of min_t
> ---
>  drivers/hv/mshv_vtl_main.c | 12 +++++++++---
>  include/uapi/linux/mshv.h  |  2 +-
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 5856975f32e1..c19400701467 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -386,7 +386,6 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vt=
l *vtl, void __user *arg)
>=20
>  	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
>  		return -EFAULT;
> -	/* vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per d=
esign */
>  	if (vtl0_mem.last_pfn <=3D vtl0_mem.start_pfn) {
>  		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
>  			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
> @@ -397,6 +396,10 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_v=
tl *vtl, void __user *arg)
>  	if (!pgmap)
>  		return -ENOMEM;
>=20
> +	/*
> +	 * vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per d=
esign.
> +	 * last_pfn is not reserved or wasted, and reflects 'start_pfn + size' =
of pagemap range.
> +	 */
>  	pgmap->ranges[0].start =3D PFN_PHYS(vtl0_mem.start_pfn);
>  	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn) - 1;
>  	pgmap->nr_range =3D 1;
> @@ -405,8 +408,11 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_v=
tl *vtl, void __user *arg)
>  	/*
>  	 * Determine the highest page order that can be used for the given memo=
ry range.
>  	 * This works best when the range is aligned; i.e. both the start and t=
he length.
> +	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when th=
e range
> +	 * alignment exceeds the maximum supported folio order for this kernel =
config.
>  	 */
> -	pgmap->vmemmap_shift =3D count_trailing_zeros(vtl0_mem.start_pfn | vtl0=
_mem.last_pfn);
> +	pgmap->vmemmap_shift =3D min(count_trailing_zeros(vtl0_mem.start_pfn | =
vtl0_mem.last_pfn),
> +				   MAX_FOLIO_ORDER);
>  	dev_dbg(vtl->module_dev,
>  		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
>  		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
> @@ -415,7 +421,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vt=
l *vtl, void __user *arg)
>  	if (IS_ERR(addr)) {
>  		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(a=
ddr));
>  		kfree(pgmap);
> -		return -EFAULT;
> +		return PTR_ERR(addr);
>  	}
>=20
>  	/* Don't free pgmap, since it has to stick around until the memory
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index e0645a34b55b..32ff92b6342b 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -357,7 +357,7 @@ struct mshv_vtl_sint_post_msg {
>=20
>  struct mshv_vtl_ram_disposition {
>  	__u64 start_pfn;
> -	__u64 last_pfn;
> +	__u64 last_pfn; /* last_pfn is excluded from the range [start_pfn, last=
_pfn) */
>  };
>=20
>  struct mshv_vtl_set_poll_file {
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


