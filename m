Return-Path: <linux-hyperv+bounces-2061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837A58B9F25
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935CEB2062C
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F3916D9A4;
	Thu,  2 May 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="od97fs3X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2104.outbound.protection.outlook.com [40.92.46.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D615D5C4;
	Thu,  2 May 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669329; cv=fail; b=hkwkkKBab+zG+R1hSXT7jyZYaxVLL0WGahYFeiKo8/khBEzJumY3/Jx6eFWxR34qChjPEcw9TDLrwojiYNiFWqp1xUIq9tCGb0GCbpIKJi6/27wEwZMP8bb3+d0r6hXYc5jY8STqk6lP8aOJoVcy2ovFNb+epxxAr7YCMtmvAmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669329; c=relaxed/simple;
	bh=iyCF1Hu/4O8cKPrEtmL2ojTOSGTfBB6isnO4UC7tp2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NdKwnkT99OBFoJPH8RuuunztlOuUvhXtQO9bH3bAHP6TxhI8R28IcrumfBMkyjCc3+zW43LPurEKBMKQi3tyXLxink5ErAVdKvuCoIna85K6Cu96UTMtbemPRbJt+6gj0PvgULqNUuhy+L7x62C4IoU4m1gECEAboncRZGh6RSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=od97fs3X; arc=fail smtp.client-ip=40.92.46.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/VVqrb5iI3qJqSro8Njt4orCdKD8wx5cYhxI4Vr9KSxLsK7Q2zHUrXAj59o5WtajJd0fL/bPZO7q/lkKbkXT51OExctd59lhqPkLkCMD89KKdMrhScyQ4r60Ikgqm+iw9Fh2PeGO8svcWL+acZFiMwdso0cp9SQyrwktPN55b4n2b0NMjcC69VStmctvl6dPeN4DiwD/3WnA0JGK9hecOS+QB5EYXZU+9zPtJ8GmkdG5xoOiDodpFNYEnMHBh0LJKgAwEHEFQkLRPCpy5I9vKkRYQXo4ynEWlxJJo2rAQo8ZVtR215OfyTK3u/VNTvYX6wTC1zysuFOhOVRKPLTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhBoEJGfe+iwEKzCIX5HQ5yJQayrMK7nUTp78agsYSs=;
 b=OuSV/Y1J4mawjUUsCDkk9ne8TdeX5RuoE161PbdCGswnmc2/8D27nC+S2k+rQMpTI3AH3Px4/HDE8m8GT7Skb2+9vYEG+FnWvNyazkObpqTXCG22GCAaf+4phWj2vCSiLGwG4OlvapXYN4SpX6vSvx16k7bPGSGD8A7bMttArjykg6VESlNhCIIlKvOqdRc/2bB5EJixE3PButchszU9aceHp6g1woc7YiXf+JZZSJ39awzzIWFU+7B/PiVKRnDqnOp5JYXgnYHmTq8T85QA6fuS45tewEimDa9fVD1fHXEG2X/ih2qDOKmkxVA414VYCF7zsziub0bDN9JZKnuGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhBoEJGfe+iwEKzCIX5HQ5yJQayrMK7nUTp78agsYSs=;
 b=od97fs3XKy3eZ99+252Q68RLKMwZRSGkLWI9vlBGCJOPrfy5QAFRAJgmRlrn8SwMQP1bmvWNltaHHMvj6zZbSm3GfUXOho0YMi7yTbz+f+GPe2DixVir0U/hgZRUHC+pvwTEp4GIDelQM2hfVfmiD6IdLbWjMmOjUyzc77Az+8gjScamBK9UpdcaJSUy1JKX31WTrVPBPxFPRC2Qdp4/tmKjgc9dKDy7D5pzmCImdNpm50zeUy+a9HyHI/Kd/UlyukzUKCe7+TX4ohoW73+wYNF0vO5jWhg6zR/IRVy8hZUHv/PW/pMJOLRK8UV+c96mRDKfNdv93I6pArS4Qwyx+A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7148.namprd02.prod.outlook.com (2603:10b6:806:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 17:02:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 17:02:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Schierl <schierlm@gmx.de>, Jean DELVARE <jdelvare@suse.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index:
 AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysIABcguAgAAcUjCAALI+AIAAvzYAgAAT/rCAAsG3QIAASRsAgBQtslA=
Date: Thu, 2 May 2024 17:02:05 +0000
Message-ID:
 <SN6PR02MB41579E87F827F26B3A2E10FED4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
In-Reply-To: <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [gbV5Ls7HgCM2hEube4nWuVcn4SE/Zg4L]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7148:EE_
x-ms-office365-filtering-correlation-id: f17cc220-e7ab-487c-b8b2-08dc6ac9982a
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 gMGYVlZJB+wJGO/lm3guAMsiZAsW1HgScF03ZwKp3D7W04qLmzgI3qPxUy6i/4YMET+vxIJ3bdUDXBielwcU8Np+s9S9qJpH3203vDNV/ISKh+57Zg+8P+PWGY3JDJt7x7B0bgTg9ZOj/2RCs7Si6QvlK0KZxegKuL12D1IU2Wo7eaKpQhZHsfVIQ5AEe8eQlVUaHbrv32FyjKDQtsaPFknelII9qXXzyNvnzB0eoLfziYnlZ0ez6VBWmXIGwZFXd2cyzgb0sOXNhBN4D8XzRbhf/CIc3ZOqf1xIKK0UuSgk5rswvQ7hj7sn+eFOGNQtdnTZ9YfOoV3nkL/4SGxll0FgN03KKJnWr02JlBkqroZh3S/FFjUrqY3jxWe2adcZP5DtKowBZobDpoV53Y2h5m14OlrV/Qejlu3Ol/P7ezhbiU484eQIAyOwg8S6Ofj428WPh/f9CWP5JeWuOxCRL1qZH6GbCRctmgvp1qCgDtcor1pLfQmrRBq3swjYaFyaVeuOyWvl7iQqqMPyiMIDhf3+Xgae/5hUNnJVeplaHUJkl3mRsN67cEYgDvQsVKYG
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hUkbb82QqWk5yFdQaO8Iu6b43YyKCEjWffhuY6f+WgxUxc2wIKd+ifc5Tvnk?=
 =?us-ascii?Q?roMIw89ZTZoad37JAnTXhsITmiq/aGCcJFig8ygSOYNlGOFPCAzzx04c8snD?=
 =?us-ascii?Q?4uvJs2VED1yagCzmOr1yfCPdQhaWrFunOCJma4U+YgbU7qESwB9dlUi60Huc?=
 =?us-ascii?Q?GAKt5GUFAu/+DaMvHM3Q9RppmiHTeHSsv0C5FJWQe80uh5I//kaFa201ebhR?=
 =?us-ascii?Q?q76Syra+RYC8okG6guVQ+99CBKr+7/ly8QNsrwBGqtjLRkwBmduNVC0r95tV?=
 =?us-ascii?Q?YbqXBshcdUOUNVkLDlnz56ZcmzkXSP9+xtLB6ZDygOTZBFzQlmlyetY6jZWx?=
 =?us-ascii?Q?LqfGcPUX+juGYBb2z6wc8rqQ0hZv88M5nVf0d7gFUsfnMrEdFy6blWu2ZGPc?=
 =?us-ascii?Q?BxFZoEzH6Lb531QiyojJlEPdonm6CRrJPLNAdMSLYLXH/fOQ2hBmrSbtrYgN?=
 =?us-ascii?Q?0xPvWJEbpRMaolyhWLYl9B3jj28HCix1cXrgiebtFipD8KRdV490QM4Z0baN?=
 =?us-ascii?Q?KuFFzo5KRDKord3ofGrzBCj+HewZ3fQKN4ZVZqPANhXB0DGNew51airc4B+P?=
 =?us-ascii?Q?MopqVuQCBwncaxGO6h37g6henM8CtrfpVIwTRMafBJ80JgkTkMGDo17DHbWl?=
 =?us-ascii?Q?MP4amqBf9eFwHxxukQnj3AfRxeU7BMO9EtI2ibOUmcYJKB1D3oxmihL/3zH7?=
 =?us-ascii?Q?BD+7Ksydpqh0V69suQ/OqO/u2QseFsQSVm7ffq/yVb1Jp96gw6ADKjNrzShj?=
 =?us-ascii?Q?vpDLM4bMV3FmweWUG0DfqYPTHsnXZ0QICmdneX0ip0U3VYPwbG+RnNSs1Hv2?=
 =?us-ascii?Q?tk4cbA9flPDnowigwn2O/Wfba9hh6lf1JLC6K8eoe61Gm5FSNL4ky/5V3cSi?=
 =?us-ascii?Q?YR66sRdRpBOjVc85Tvtku/BlKIxA3Efw8N67JeTU1BJ5HtD6o1Yaipga6fJ/?=
 =?us-ascii?Q?ITOHo4Y3LJeRRitbcPcahEP7DjiR+AOC/pRVztonZQ9KnNgnRW4obPMKax8j?=
 =?us-ascii?Q?+rtJSFIHXT0K09G6xxL1TGWqwIfZL0uuPw9l/mrV0kUKuE2tzeDIs7D62DBI?=
 =?us-ascii?Q?+dYzXIso5Uy7gPbkeOJ8RTO09gvz6JMYmDWjpil3sDTH0SLhK8efytsn/jZ2?=
 =?us-ascii?Q?wPZxlYUHhoY8ToFhapLh1W108z+CjYVgwWn7V1Uo3R1px0jkjlopXgJQoKGv?=
 =?us-ascii?Q?0pKG6lchZ2cC0ixOaR/yScujyS4ULJiI94M9ox9Wxe+p8kbZcpALrVSi7w4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f17cc220-e7ab-487c-b8b2-08dc6ac9982a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:02:05.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7148

From: Michael Schierl <schierlm@gmx.de> Sent: Friday, April 19, 2024 1:47 P=
M
>=20
> > Regardless of the 32-bit vs. 64-bit behavior, the DMI blob is malformed=
,
> > almost certainly as created by Hyper-V.  I'll see if I can bring this t=
o
> > the attention of one of my previous contacts on the Hyper-V team.
>=20

FYI, the right people on the Hyper-V team have been informed of the
issue, and there's an internal bug report filed to track the resolution.
I don't have access to the internal bug report, and can't predict when or
how a fix might be made available. But given the impact, they should
be motivated to work on it.

Michael Kelley

