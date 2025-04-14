Return-Path: <linux-hyperv+bounces-4896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D3A88D87
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Apr 2025 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210041890ED5
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Apr 2025 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B011D79A5;
	Mon, 14 Apr 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W0opU9JQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020093.outbound.protection.outlook.com [52.101.46.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437FBA49;
	Mon, 14 Apr 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664492; cv=fail; b=K2EEutxkYLy72twSUNwFoJN+oZ426nRqdjuVJBgmHEfMATwsJDFDOxvlEIY5fChbBivx+CCaPrN96sFiJYXk7veIyJmbKPB2mOwr00u/8GmiD9Sn7FIAcBJaZps2V+Vy3A6R7hybMbw68de4Wt18Vki3bTF4aHpWLCCpxBlzpfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664492; c=relaxed/simple;
	bh=c8EWWzUnogTNqk6kQv/4OBktGiq8kxK9Ol2SmjaxdVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=knoJyNnyZ1Do9vzjLudZnZBS+MVhKkXFcgS9qILBrrAyk2rYZyRZF2MHFkQO64U0Fu/qEZTsytxghP3KKU3BZ87vrjOxY6eMmSLmum1p528zo198UuCRuK7KzuUj+P62cgzw17ZHljOQA52Y5ILBE/qEh1d/3FRNaGVjgj/SA+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=W0opU9JQ; arc=fail smtp.client-ip=52.101.46.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alU+uYlFxTH4vHml7jw8Yzb3I+SO+ncp0ks84Vkl6HOLOarU+2VOxTrodY8i9RQyULfwv5sse/BZUhVSElEq+60Q1unsb0IewxhKVwacMxdj1SsK3lcG6M43J3IH0+GqwWGeK96H7s6a0VT/vuK1xI6CYgmMTUYD8tPmRK4UNjj/MX/8SWbyEViL/rkudAGBYmKQK4LSZvzhifQPLCc+vGlVYDpBfa9FB/mHlSMVoSXtNvIC1w+lo+mpX02EM5qXHciVK+EQLhpXMgYf2YrLdi6ZD33VmI5CyEsG/sOHYD0twcOt0SVaZ9ezIWYU+L4oP31V6R62Jkz2N8IrywWF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4viT9STfl2NTAL+MLi97V2SA8M9WHomNZJ3jR7uX1uE=;
 b=ObhAt+Pe8Wqttfdt3XWKq6SiXcXf1nG77K6cuU4c0HdDO85MMdqgBGmpHnAOB6fz8vrlwYFOG7ZuRCNhddKrjTUcBAzoA9yv5mhHGclRbjPtzWCiy581VoSrg0yoXChgHUT3jD8vNKoPAl+EfUxBXLg0Os7YWq+Rp9yj0fCeoNeliwy5OflC2YpYTgMvLf7lKRwrxjVzJ+bHt+M/uFAb3MjGICEywE6pAY8/moGg0/1oz2/+xv4XJH0cM72UXpsIBOVqw4D2F8O0nZZnDUr1tOYx0QPbf/0hZjqMm+w/NsvCRC7ke5UixsV8thZDajozp0nvuUeyvGSiBT5zgNpzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4viT9STfl2NTAL+MLi97V2SA8M9WHomNZJ3jR7uX1uE=;
 b=W0opU9JQ8sCq/nQeu2l6kr94DFoxHRtPqGnT3rW77c0iRKSIrWBnv1U/IsBscSKshVKsrA3krzokdpmhX0nUGrpvsmEX9pRtjlX7JgKS/dWainqYXeKnESDs2uEQhqCU4m55Bgyt8rH2xfkxQKBoxFnUO5Y+SnUcGS/Du9O2/u8=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by MN0PR21MB3484.namprd21.prod.outlook.com (2603:10b6:208:3d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.5; Mon, 14 Apr
 2025 21:01:26 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8678.007; Mon, 14 Apr 2025
 21:01:26 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Topic: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Index: AQHbptCjjPJ/mPM/E0Kh2JXNt8dnUrOjrwvQgAADOhA=
Date: Mon, 14 Apr 2025 21:01:26 +0000
Message-ID:
 <BL4PR21MB46274267168AB06EF05CC0D4BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
References:
 <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BL4PR21MB46271A66420D9B03C2947360BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
In-Reply-To:
 <BL4PR21MB46271A66420D9B03C2947360BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4111885e-44a2-44a5-96d9-313acc668af7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-14T20:46:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|MN0PR21MB3484:EE_
x-ms-office365-filtering-correlation-id: aad1401c-7c69-46e2-bb39-08dd7b978564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YtXDZNA8YGTi7IvsSzTaumYMOORAnUlNh/3/rVzGg0THyzcoS/ryoyK3fQlB?=
 =?us-ascii?Q?hrS5nfGYjlzaGIe8yEv3ib55/rJWtVKeVTGS9lLsoUHdml7oRgAIx2vxtaVt?=
 =?us-ascii?Q?m0IA/90epgK+McYjXy3e/TM489M5UF1bLq/QWQR/dC7rSbwMaF/9FjWu0yaG?=
 =?us-ascii?Q?/wnxTxRUx/fJvDObSuGfowjfUYOMQBRxwXhmrLKQXYXGGH6Jpk2+68wnb2oX?=
 =?us-ascii?Q?MUzzyyE4PTTC+Xo84hrgPCi3lzTlRfHRCCCJYE9OW0m+y75wgzp8qMhiLYC3?=
 =?us-ascii?Q?WY1I8Wm2BRvHv+vi837KJ1LwfMF9DpRGtoTzAlQjByfajVXF8Jqviz16af+5?=
 =?us-ascii?Q?KwIsWUKZFXupLyqoPlTpx8ebIIHl4x7o31cjuwDq1dk0n4eKoxVduUigWKTV?=
 =?us-ascii?Q?9moSCeZ2zW32ECNo1YJmKzF+deHslJz2TD8BxXN/oZnNPbjUultLt1FqizG7?=
 =?us-ascii?Q?/LDlJTr4RwzFq+iW41t+8kL3BcgLiCWLyo0xoOIHCT/boPj71FVzbwWNr9Kn?=
 =?us-ascii?Q?WZjLu/DnOT1aLDlSwxSXXD/cKsNoxVwtkSw7/A3R/DkvNnkF0qL3pQv7+26p?=
 =?us-ascii?Q?ozR5hd/WTlQ22dVkt3Tz/SXlUnj5NjBu5eZvhBOTuR44edQawsVKHL+b7VT8?=
 =?us-ascii?Q?TefvzhpMkUCioSbUGjInhmGQgbMb/1a77OpgVx+anpXkrbvB3iTIE+FOmlF+?=
 =?us-ascii?Q?pfAPgtFkn9QoxloQtVX0C3/iaJNjqKH5V8xhQEftjB5sZXYPNfjs1xUHqMSS?=
 =?us-ascii?Q?6cJ45SuMVTm8FO6L1hFjfnEr/CfvqhGvO9ccD3l7ukNuyEKUfOmgqmsg2Ct9?=
 =?us-ascii?Q?D2P7B9NB9/+M0Yl6FdJTBJ4KkUi6bIljYv5fSs/ykPkRYdsROjeXBKw+qGoF?=
 =?us-ascii?Q?chavRERzb2M4L9KsiMm8sNkvGSsY5teAqHGusmLV+hGb2FbEBcIBFkTIIpl7?=
 =?us-ascii?Q?xa28QufFFJMEcwb4k/OdVm3z7KbhLpfoqGRHyQkZ4UhTd5hGu1WgoOyDWnq4?=
 =?us-ascii?Q?Z6hOEnhdvaoOAN70raw65O9ML5vIZD4rP/GWus4XLifywiqQT5t4EKOPBtLl?=
 =?us-ascii?Q?rYlQYxBTeL9TvalnAXpN09HvIcrYG0GNag4QVus+uJP4OzMKKVLv8MtofJZX?=
 =?us-ascii?Q?UA0dnCCPyOjEqVGEFn9J+McnbvUKNZm9DX8/LfTLX2GNlCaUKzwbGm6/jk8L?=
 =?us-ascii?Q?rbb9ALGlYRq+j2cvFBhO4ZmY1Sil2cGBnPyYS9oPa3zOzmrOACbuTI3FaEvt?=
 =?us-ascii?Q?fq2cNzShZHvAQSszb0Gdh4urWB18H+DB4BPv04Bn99z5ww67R/nf3UBezxDT?=
 =?us-ascii?Q?sFYtEmvx8ipndXSjaKaZ/X6xTAqw9Nq4OW1/aX5Bg3tVMouiryWN4KeKjOtC?=
 =?us-ascii?Q?AWAffKXHdlu8GWVysnUmPveu3vrzlW1i8d3CYZFf0GDEku7guGLOeZUOQZWx?=
 =?us-ascii?Q?8ui/y51aZcf8wbNxdbC/yCXP7QbHhTd1sDwA7bSuWF1AU+zqW9BW711vB7ep?=
 =?us-ascii?Q?4n5ZiuuOUlQyggI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/rI+4qFA73whiSa86HeVdSPbGc3ozKOPTUAKsNg0dhTecyhllOTJHVopm2UD?=
 =?us-ascii?Q?LSfix3gl4xoLSVbRTE76jfbVbDKkDbnKekeyPBn+1Lapx0DWrPl8bVUJHDN+?=
 =?us-ascii?Q?Z0FYtS5yaR+tE68yYA0XMOTDcwWXW7c0KwJ1x8EaYnJGpji0/2X6CbxtBjuZ?=
 =?us-ascii?Q?TK8t2AIufhOAIjPd5Q/6Xn4XTE1WTqZ45w6pqe0hsHI9HZo947DltHZmLLrv?=
 =?us-ascii?Q?OGVCXTSJL2lpwTp4jafqKgdXTNyEEnjl0Ufi9kgVOyI7PKhWT4c3WXHPdfmq?=
 =?us-ascii?Q?FVhYm1lRCcdSBqVDMWTu4gSwJo+/W0HzQiCV7MvVrEvWIyg1IxOK42ajke4l?=
 =?us-ascii?Q?5Ujq/+zkW1uoLyS7l5Whq7d9MKIGdZh/US/F4xN5EX4y+jDma3f56MxjU89W?=
 =?us-ascii?Q?HPRoXsP6hWVz3jmaT4Yq/hPWOxBhMWyR7fUGrFqwv6jnMEmLMgbASV3vhxk+?=
 =?us-ascii?Q?FvKGMUVeybXu2XDTxsPOEvTjxhEI90waPBvgHTS3in936y3XKWMS1nZfY7iA?=
 =?us-ascii?Q?seP0rkVFM+pQJW5UMN/ERlIG6TUOCJPnE+QK02p5VTsn3Ym/AKER9ePAbzIx?=
 =?us-ascii?Q?riiYvNOBU92EI5owiSa2qceA0L8xcAsQGRsp564fUTwTCoQosBeDK19NWAPS?=
 =?us-ascii?Q?2D8he2GmWrqGOGUaz00915Jh0ihfUgGJM1gupzBZimM1meptGnF9HSj1xKpz?=
 =?us-ascii?Q?G9zqI4qCk1iCuFR463IfGYlKAb/0cdM3vuB0V8XiVlG51jz/AV/N4SHzgQxD?=
 =?us-ascii?Q?uJYTbjy1hTiVuV67KGKcTgAp57HthRjVwRnbo5mQ+jknPh+eR5fg0GvExUaw?=
 =?us-ascii?Q?NpFxS43jN0JQks8iY6PU8MpMKwPv4lYz4ni3MdMYTeVbWAO8aOEsPGVWWV7t?=
 =?us-ascii?Q?Xc2axF8CBMxD9JC954ZuL4+uw5aWUxeV88hz1L5pMpoo+we4jst/2pG40I1s?=
 =?us-ascii?Q?FGzarlBkRGnTGUytgmUyol82XTz2j4f5QrhV/HrpPInwkjPizjewsY3X3EY/?=
 =?us-ascii?Q?HWgYyHSBe+Bd00yRA2F4YM2EqxgYHEUkBL6Epn+zKHNDnBgfpqrVkn4vW5Y9?=
 =?us-ascii?Q?pwkkMoSAU1DdErRcXDdB7+SQQ5b7lMLVhEwn/feYnNjTo4E7/0Uq67MHlb0S?=
 =?us-ascii?Q?rXrn/q7XgytnaN0XFikdw5Cbkmom0CFrapFP99cSmocfgCToeGdlOaw5bFH/?=
 =?us-ascii?Q?Y/x2GZKYZRpYwVs8X2HYlulZrCQcUhxldLleu0VNMopKKENEet4KCoLm7ekc?=
 =?us-ascii?Q?rkadwGaxntk66ibb4h1dLqBraqHzrCXghORNMn50pRFZa2QVHri8gongg/mM?=
 =?us-ascii?Q?RW2MWK09LtcA5nMdmaZa4BsZqU0Mxptcl+WqsSR+miTZa6K7oG2awAJ4L6yN?=
 =?us-ascii?Q?Ax09TbXMTYJILlBUzF4ZH4a67u58+Wppzo29lymj2qpoYg0lWS+K96d9+99n?=
 =?us-ascii?Q?TMlYtRiOftLksJTKAEXC4R5hwOklsD/n0WYdTmPf2CK0Vyz4f+DoklPw+7u6?=
 =?us-ascii?Q?kiXHTACQpkt3lhnsixNwfYOQy3+YHq3dhfAfIIeeG/hPp/vtkomgL+r3j/9H?=
 =?us-ascii?Q?plsSLgf+mXwmG0xMG32uFgYIGhhVAMfM5aBqAxtE+VABy/vQekH3kPMC4emY?=
 =?us-ascii?Q?06NV3A4XKBqB8kpk04VwzUo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad1401c-7c69-46e2-bb39-08dd7b978564
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 21:01:26.4236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAvveo/l+d7PUIr7oEN/ea4EFjTufM7vIiQYPcw6B6HDraJXT6o42p/BaJE0T27YqSa0tyqfFMzPHuGmz8XhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3484

> From: Dexuan Cui
> Sent: Monday, April 14, 2025 1:57 PM
> > @@ -1681,12 +1728,13 @@ int main(int argc, char *argv[])
> >  	static struct option long_options[] =3D {
> > [...]
> > +		{"debug-enabled",	no_argument,	   0,  'd' },

If we use --debug, we won't have to touch the 2 lines of
"help" and "no-daemon" in the struct option long_options[].


