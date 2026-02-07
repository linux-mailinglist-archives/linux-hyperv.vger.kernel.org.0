Return-Path: <linux-hyperv+bounces-8766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRhM6uVhmkUPAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8766-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Feb 2026 02:30:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA3104830
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Feb 2026 02:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65DC2300BC89
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Feb 2026 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91A29B766;
	Sat,  7 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ff4Nw4rB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010021.outbound.protection.outlook.com [52.103.7.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907E2989A2;
	Sat,  7 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427815; cv=fail; b=UvS8bQS15OVF3L/ghRpVlFM7kNAApqsSpuSKe+GaXp095v6Hg+X2GofbDoTQdrYOlu38s8/swZmrHIiSaRcXl4cL3k1743wJdAhGbO0s+7UkWtuSUYa6uS5wpmPkuWzRYTpHjhcQFlaIDpRoNjfqaemgPs/458kjZwgYw7pMZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427815; c=relaxed/simple;
	bh=Z9MzDNDKZN/BRG1qeSXh1heZptMNxFH+tON7segzsvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJbDPTU82eNpxesIhtd66G/rfD6lsjiZhlLuD2RcVtfnTKvoTR1n3xTVmxcUNbyfzxvt2pE/YfztLyk0ZLdK7EuGzgMD1RX0ppdgX4GPsarIRPzzE47b6PGnybVHWCI/OtPqKXa4XUvtppx+CW6c3LyHX1rfudCl8JzfyeMS8r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ff4Nw4rB; arc=fail smtp.client-ip=52.103.7.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unaL+Tf1I59oKzY5ToOFCG3Hf4l9OeKFSi4DtxeRXXpIllJn/eNQ3iE9p0WOM9JheFyHqclD9SXNi58qtFMHj7Bneb09WJjcjdNJVo9F4+hfy2nLiHjPQawl+C+WOtIdRntZ4srJLve4JILxLAxIPabh4YC+q1wSQwkhk8ALMeaO0peqoI7rMWsDWwARPJXBkT9x2S3NmND0pR9Hg7Ah7FCysVgTRqQCslbdt6kzEa0YBTW4ebzOvZriRWtj02FLeEzKoOmh0quBP3kyvDiNYeww8AyaJjSI84K+qsVn4IcNZAUw4Llm9ljsBfra5wwLLZbr2MO0ioTtJfXXYbjc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFK2Bv1KnSIXOQJ5ZMMTF1L6jkiy/yy4grvY2v2J1mQ=;
 b=k/nKJHiNNryb78HB+zyBASNWulP/tnWlXsSUqOC25YxQjPOOr61lpfCL/shMdqoeW052Jn+kRl0C/7H6spdDHvVnsD7J4pDfJQdFMRTkewHDRbZq+kgjbUdf5hMcmUPnD5bTLrnlkoHJEEZ36i2Azt/CXPLCQAVNuIO7id/HtPbXr9DSxh+o0MChRSXD6OQbolUFAJMGyiCF7oeZ3UfrDSHyJzDD33il+xyRsVSeogpYMtDtw0qzZ3MXy2kGas4tRcEqIfPRE8JvjHFE6BlmM/6ZVphi4eOv1qyXrg0r++bVj9qL4ST7qmS7rcuzsjMYGwSn/AcSTWnUo0E1hIZ9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFK2Bv1KnSIXOQJ5ZMMTF1L6jkiy/yy4grvY2v2J1mQ=;
 b=Ff4Nw4rB14pFoLkM6CO7DIhiEIWmIU++1bOGIMzCY6iD9Pub5n0u+WgoSm4aJq1R2RABnguxFRVdyLOCWHnqi1j86l4bPVMC/o4+Ocuj64zR1amEzbVNXooyQZSxyttU6qvvySpxSzZzkO6Ayuwvks1wH/oavHlhvax8In9Htm1+JsovX0+XadbBOg9DKsci/Ggv0ePTA4LpEic05jUkwA9nhrzB6eHLJnQGiHo6Qn3nHdK/MRBDTNjyrP/kihrPhFPPqJ5OCMqnZsj793PA9Xm7Z3aP3+K8LRBxHnydO2HII4WAJdqzoBCALHAMFj3F/Ur/BKRvFFJ5rOfXfRSgBQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7387.namprd02.prod.outlook.com (2603:10b6:806:db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 01:30:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 01:30:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "anirudh@anirudhrb.com"
	<anirudh@anirudhrb.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Topic: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Index: AQHclScm1YuvygUhI0+fe3CZOPBAobVzKaaQgAITHgCAATQUcA==
Date: Sat, 7 Feb 2026 01:30:11 +0000
Message-ID:
 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
In-Reply-To: <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7387:EE_
x-ms-office365-filtering-correlation-id: d019f7a4-48a7-4f10-cd11-08de65e8701d
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|13091999003|15080799012|19110799012|8060799015|8062599012|31061999003|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6S3ZJs2NdRqMs9EKKlRWNPlYvzA/XXc3Dx5ZHIqdc+T3Yf4aT0ImJcz4Cbpm?=
 =?us-ascii?Q?ZHIE7aH+nOF9buBwWB+ZYTQ22viZdT1C9txakMqeukMe5cCjgl+07bNkaCBg?=
 =?us-ascii?Q?PXqJWelx6T0yNFJAbgyrNGT7ULtKpOdswW9J3eTtq77yxFqUEXHCBWkm7cDx?=
 =?us-ascii?Q?rxQOGuTVKwr7MFef4sCjQet1OSPScoeoAVoLIoYidkW5FDKsUkzukj2XUAeT?=
 =?us-ascii?Q?47AdivHPaY20BFc9EiPb85dW2s8lsJHeQTESLtxGfzyYByETIkYZeG2NKAGC?=
 =?us-ascii?Q?haEP7PehD7E47UD7mJtz4Zmod9OL/6cVQMJy6zm6s4gZ3RLY7mkVdm8lYjyB?=
 =?us-ascii?Q?2BI7lyzE8QCuJyzcDaUeaBltcLztxytULGR7un8S74fsyKqpVreuvV+0SoyI?=
 =?us-ascii?Q?b1Q5S/wC6FWsg4YjEq9s0beBBT0RUoIvSHFH75/Vl3AYizgBDpIBwLT5cCHU?=
 =?us-ascii?Q?sS+j7uTCasRXEA6LWmi7oIcqjjTmd7Mxwl3VWLrkHgzO0DeHzFMbsluIDW9Z?=
 =?us-ascii?Q?sNYbS1o594M1CLfF2303LhCtfcz8zCNCjuD3UAPnYIcWf1PcXQe7uN/hY0NK?=
 =?us-ascii?Q?3jG22F29S2gS5+7xFLhPVxpzGMGR8mlfsEaPn5WXL9eGwmlbqCxK2JiF+Ic/?=
 =?us-ascii?Q?Ob5OVFjClKPZXNHZZjINX4CUy4QVNER4jjmHpc43YrII3BJaY9QoTaFNN23v?=
 =?us-ascii?Q?/XVwneE+q+Ngs/6x9LEuTv8J0WxMrgdPquf6JAVsDoC9MCVtcVrNfj7SzES8?=
 =?us-ascii?Q?49Wz1Y20HQuWrvzouHQe8RqqnH4nb1xvVxSFGncU498d0Y6TKwxSK+c0UwlK?=
 =?us-ascii?Q?7ARfTpypucaFeZrs3X4yNvJe38qish/C6KTkC/Bd5kNj4vQ/XDkDlDdcUQYv?=
 =?us-ascii?Q?+da+XTlMmMSgzwEOpzxSpy6o5ZZ6UMLWqdJyo+jyUflqHjEQmr6B1oAx72ay?=
 =?us-ascii?Q?fCYOuiAc2ayedGpxVZCd/syFYWGV3cJvdgE4iaeDOD0oZRZEbLW0uI1xVSDf?=
 =?us-ascii?Q?5izs9qwKNiAa7YnhwWKUKgXR8UKQlaD2wgd4GAai+1Ex1Sq3eWCGgkaeBRh9?=
 =?us-ascii?Q?1JJ/dZn5Bkx1xlaacKQg316Ccs6fBP4fDVc+gQV2W9ELdsk2OrD8Or1clv68?=
 =?us-ascii?Q?y71vtKX1RI+RPigftu6pd8I1ZmdCQm5zi6dwQRxuazRMO+JrSqXljssisQJF?=
 =?us-ascii?Q?P1Hu2euh1L5cjvRgVX1sYiDuEWNSq8jWqKl8iw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zj3r43Ftvqyf3jiqwX7rqqDm7Hak93LRd1tzZGYhFHr8B6n02+zjF5Tx/oxj?=
 =?us-ascii?Q?FQ4Ge6kMa+7bmd4c1UE4VPpdB5IaVy8cMBE+MoTt/p8iHc3H/0pC0A+cS7Oy?=
 =?us-ascii?Q?17121nHXgzKbxONYMXOj6RlnYshbUYJCGUKvyCCEiskQpBl0ZLFY2cK7BwY9?=
 =?us-ascii?Q?1gU5Kr0/saGAaD/+QGh5rSAO4WKVPytve8s19a72Um0jz3r7PuR/YSolzdHV?=
 =?us-ascii?Q?WOYtM/O2lHiHrdUdu2Vh8Uciazwb8utn6FanxIv1PhSESYZvxRORFyglh6ND?=
 =?us-ascii?Q?O3uFhxHOv3WhZHr5nAbg+1rP9U4GWLvHVfspay/8WGiLUSSA5h125kQXNFTg?=
 =?us-ascii?Q?t/3a2XVVWUYKzctIYQaWX4+MumVL6ddC97Y2u4D6JokdnFZV4ye+LexvDuCT?=
 =?us-ascii?Q?hTiukvkqL2CtRAhsIfYHGG5ywAN4eyKTPVhVfcCPdIRizAxUrA8ro8wuPoGq?=
 =?us-ascii?Q?HG/PitW25UzYTSTeQkScJZDjvBxX5D13sYDA/JnmLUYNYVIypn90xv3+jrfj?=
 =?us-ascii?Q?FRzC7Ewd2rp/iweBNjKucBgZl67qrDzRwyktGyTsSBmLt2FyxkBXEpCtfjbS?=
 =?us-ascii?Q?Vl8f+yrzOokSdRqDVxNVvsxrCw2pCn6vAqB8GvrPuydp7eTPB+QPEEQa3WUL?=
 =?us-ascii?Q?Uv9Qq972jDGc9tZJF5zduHpDrmDhnETh/F01RHnVebq6aWJa++gE8oh6oWv/?=
 =?us-ascii?Q?RtA9T3Ue0tIiVBcwCpeCaGkA89RQ/iKj8jPIIC6XeavppPCIUrlbvUYzEbm8?=
 =?us-ascii?Q?aMdehpBpG0ITtg88OUe6OowI7fpsLtOEUJIDoOvqOibOtg6MuL6EfnjXkIPt?=
 =?us-ascii?Q?rYOI0JaNjdXW4q51wNarygqo/sY38YQ94ObC2205Ok5qlcmA1Cer8diMT1z4?=
 =?us-ascii?Q?YDU08oWFS0w4Yer+vtJECdX3zNTEG/G3OyztJdtFvcVM+EXUwxh0Fb5DGAP8?=
 =?us-ascii?Q?3keFWbJnhU65DF8aCQbbVMRhyS6QQFkZEBQXsYAi7QhQ2hDzi3Myb5kuqMj3?=
 =?us-ascii?Q?iHwujd0F1vw846g5AlD9Q2Abu5L368iNu8ErnFxO0ewNhkzHFTvUonFW0yZb?=
 =?us-ascii?Q?G0Y5932L1nK6cpCvtr3iiOTHA7ywITsltvknBlWqhsS72vjIEg9HLC2tPzWT?=
 =?us-ascii?Q?mKfFPoYmuzCRDgN7I2jchDhihDiKvwE0a77j0fTx+usduFAo41w+rmYQM7po?=
 =?us-ascii?Q?IUuhtaC66a07fPXxXPeGSVvbXoR3RciHLaHovWbVZp6MLifBirKfTM++rUU5?=
 =?us-ascii?Q?SCPb4X2INe2OrN1UT3vt77iM74tF9R7X3pP26cmUv03bDKB3s/BSt0WLVyyV?=
 =?us-ascii?Q?H3Bcje+Hd3x7hjmtQrr5lQK6oPzwyRnto7q58X0+a598hl5vcZBMzQkRUsrk?=
 =?us-ascii?Q?QSuWWrKGAA+H17r9BOYsejJDBieGR7HNSBs4DaTzrzWyogg7UYlLbBY0f34I?=
 =?us-ascii?Q?WC7kEUNUIwk9NzKKZ2MwgioaAex2Nt6V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d019f7a4-48a7-4f10-cd11-08de65e8701d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2026 01:30:12.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8766-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com,anirudhrb.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,siemens.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 08EA3104830
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Thursday, February 5, 2026 =
10:41 PM
>=20
> On 05.02.26 19:55, Michael Kelley wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Tuesday, February 3, 20=
26 8:02 AM
> >>
> >> Resolves the following lockdep report when booting PREEMPT_RT on Hyper=
-V
> >> with related guest support enabled:
> >>
> >> [    1.127941] hv_vmbus: registering driver hyperv_drm
> >>
> >> [    1.132518] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [    1.132519] [ BUG: Invalid wait context ]
> >> [    1.132521] 6.19.0-rc8+ #9 Not tainted
> >> [    1.132524] -----------------------------
> >> [    1.132525] swapper/0/0 is trying to lock:
> >> [    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at=
: vmbus_chan_sched+0xc4/0x2b0
> >> [    1.132543] other info that might help us debug this:
> >> [    1.132544] context-{2:2}
> >> [    1.132545] 1 lock held by swapper/0/0:
> >> [    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: =
vmbus_chan_sched+0x31/0x2b0
> >> [    1.132557] stack backtrace:
> >> [    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0=
-rc8+ #9 PREEMPT_{RT,(lazy)}
> >> [    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Vi=
rtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
> >> [    1.132567] Call Trace:
> >> [    1.132570]  <IRQ>
> >> [    1.132573]  dump_stack_lvl+0x6e/0xa0
> >> [    1.132581]  __lock_acquire+0xee0/0x21b0
> >> [    1.132592]  lock_acquire+0xd5/0x2d0
> >> [    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
> >> [    1.132606]  ? lock_acquire+0xd5/0x2d0
> >> [    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
> >> [    1.132619]  rt_spin_lock+0x3f/0x1f0
> >> [    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
> >> [    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
> >> [    1.132634]  vmbus_chan_sched+0xc4/0x2b0
> >> [    1.132641]  vmbus_isr+0x2c/0x150
> >> [    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
> >> [    1.132654]  sysvec_hyperv_callback+0x88/0xb0
> >> [    1.132658]  </IRQ>
> >> [    1.132659]  <TASK>
> >> [    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20
> >>
> >> As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT=
,
> >> the complete vmbus_handler execution needs to be moved into thread
> >> context. Open-coding this allows to skip the IPI that irq_work would
> >> additionally bring and which we do not need, being an IRQ, never an NM=
I.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---

[snip]

> >>
> >>  arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++-=
-
> >
> > You've added this code under arch/x86. But isn't it architecture indepe=
ndent? I
> > think it should also work on arm64. If that's the case, the code should=
 probably
> > be added to drivers/hv/vmbus_drv.c instead.
> >
>=20
> I checked that before: arm64 uses normal IRQs, not over-optimized APIC
> vectors. And those IRQs are auto-threaded.

Just to clarify, with CONFIG_PREEMPT_RT=3Dy, you expect the normal Linux
IRQ handling mechanism to offload a per-CPU interrupt handler from interrup=
t
level onto a thread?

>=20
> That said, someone with an arm64 Hyper-V deployment should still try to
> run things there once (PREEMPT_RT + PROVE_LOCKING). I don't have such a
> setup.
>=20

I've run your suggested experiment on an arm64 VM in the Azure cloud. My
kernel was linux-next 20260128. I set CONFIG_PREEMPT_RT=3Dy and
CONFIG_PROVE_LOCKING=3Dy, but did not add either of your two patches
(neither the storvsc driver patch nor the x86 VMBus interrupt handling patc=
h).
The VM comes up and runs, but with this warning during boot:

[    3.075604] hv_utils: Registering HyperV Utility Driver
[    3.075636] hv_vmbus: registering driver hv_utils
[    3.085920] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.088128] hv_vmbus: registering driver hv_netvsc
[    3.091180] [ BUG: Invalid wait context ]
[    3.093544] 6.19.0-rc7-next-20260128+ #3 Tainted: G            E
[    3.097582] -----------------------------
[    3.099899] systemd-udevd/284 is trying to lock:
[    3.102568] ffff000100e24490 (&channel->sched_lock){....}-{3:3}, at: vmb=
us_chan_sched+0x128/0x3b8 [hv_vmbus]
[    3.108208] other info that might help us debug this:
[    3.111454] context-{2:2}
[    3.112987] 1 lock held by systemd-udevd/284:
[    3.115626]  #0: ffffd5cfc20bcc80 (rcu_read_lock){....}-{1:3}, at: vmbus=
_chan_sched+0xcc/0x3b8 [hv_vmbus]
[    3.121224] stack backtrace:
[    3.122897] CPU: 0 UID: 0 PID: 284 Comm: systemd-udevd Tainted: G       =
     E       6.19.0-rc7-next-20260128+ #3 PREEMPT_RT
[    3.129631] Tainted: [E]=3DUNSIGNED_MODULE
[    3.131946] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 06/10/2025
[    3.138553] Call trace:
[    3.140015]  show_stack+0x20/0x38 (C)
[    3.142137]  dump_stack_lvl+0x9c/0x158
[    3.144340]  dump_stack+0x18/0x28
[    3.146290]  __lock_acquire+0x488/0x1e20
[    3.148569]  lock_acquire+0x11c/0x388
[    3.150703]  rt_spin_lock+0x54/0x230
[    3.152785]  vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
[    3.155611]  vmbus_isr+0x34/0x80 [hv_vmbus]
[    3.158093]  vmbus_percpu_isr+0x18/0x30 [hv_vmbus]
[    3.160848]  handle_percpu_devid_irq+0xdc/0x348
[    3.163495]  handle_irq_desc+0x48/0x68
[    3.165851]  generic_handle_domain_irq+0x20/0x38
[    3.168664]  gic_handle_irq+0x1dc/0x430
[    3.170868]  call_on_irq_stack+0x30/0x70
[    3.173161]  do_interrupt_handler+0x88/0xa0
[    3.175724]  el1_interrupt+0x4c/0xb0
[    3.177855]  el1h_64_irq_handler+0x18/0x28
[    3.180332]  el1h_64_irq+0x84/0x88
[    3.182378]  _raw_spin_unlock_irqrestore+0x4c/0xb0 (P)
[    3.185493]  rt_mutex_slowunlock+0x404/0x440
[    3.187951]  rt_spin_unlock+0xb8/0x178
[    3.190394]  kmem_cache_alloc_noprof+0xf0/0x4f8
[    3.193100]  alloc_empty_file+0x64/0x148
[    3.195461]  path_openat+0x58/0xaa0
[    3.197658]  do_file_open+0xa0/0x140
[    3.199752]  do_sys_openat2+0x190/0x278
[    3.202124]  do_sys_open+0x60/0xb8
[    3.204047]  __arm64_sys_openat+0x2c/0x48
[    3.206433]  invoke_syscall+0x6c/0xf8
[    3.208519]  el0_svc_common.constprop.0+0x48/0xf0
[    3.211050]  do_el0_svc+0x24/0x38
[    3.212990]  el0_svc+0x164/0x3c8
[    3.214842]  el0t_64_sync_handler+0xd0/0xe8
[    3.217251]  el0t_64_sync+0x1b0/0x1b8
[    3.219450] hv_utils: Heartbeat IC version 3.0
[    3.219471] hv_utils: Shutdown IC version 3.2
[    3.219844] hv_utils: TimeSync IC version 4.0=20

I don't see an indication that vmbus_isr() has been offloaded from
interrupt level onto a thread.  The stack starting with el1h_64_irq()
and going forward is the stack for normal per-cpu interrupt handling.
Maybe arm64 with PREEMPT_RT does the offload to a thread only
for SPIs and LPIs, but not for PPIs? I haven't looked at the source code
for how PREEMPT_RT affects arm64 interrupt handling.

Also, I had expected to see a problem with storvsc because I did
not apply your storvsc patch. But there was no such problem, even
with some disk I/O load (read only). arm64 VMs in Azure use exactly
the same virtual SCSI devices that are used with x86 VMs in Azure or
on local Hyper-V. I don't have an explanation. Will think about it.

Michael

