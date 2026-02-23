Return-Path: <linux-hyperv+bounces-8955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMjzGXF8nGm6IQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8955-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:12:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4106417974E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6075630817D8
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CFF3090C1;
	Mon, 23 Feb 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pz9reodk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021116.outbound.protection.outlook.com [52.101.62.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF752EC09B;
	Mon, 23 Feb 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862859; cv=fail; b=H+1BDKMa+sVKime8py9EsGanD4W8HXhm1Zgo04U8KRBtxKRaRHYCSpXOYMu9vcZGThNdMhU/Pv42m7dagJ2IqluJg8qQhztHknWtDeNMCvLbToFFNPr+0Gf3lXzDID/Mz+ca7c3NXLbBSG9sgTU9uvMLE/Zbj1lUAkGclvEIZ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862859; c=relaxed/simple;
	bh=3toHGPWuNC88ERAWtoze1RuBoBVBufb8az0mBB/0sJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftk3jS0SpLLBSdOB4Awg3HgcAotQrYFWcPcv56obBWlGgE8JyQdgfe2nKB1ZJS0GXzFhssqdfJBbVgYwY4aZyf5D5ARp1UB9UCPbNVuLGo+97XtQ9aNKejNlH9mM0h2Xf+LHM2ubHDplU3KPpPtIsq6cdVYlqFk0MRokPiiUmJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Pz9reodk; arc=fail smtp.client-ip=52.101.62.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1vV0tE0FsjGinsQJzowvw9MJNeqyEB0K2JS26VEshURE3rwaCkK2LjhyQzz5odlrgvKkV7wi08okxQQyLBNgBnCO7lqVgLwLtRW07EvTrHGpAagn/uRw0WtmHDiAJcQ4htjE+qZuBOxLgZFbad8+QBT9meNrUeXQz27nQVoxhb2YRMUPl09YhwW7ino6PqHX+Sa1pnZTDlEczdCjZK90kUTKBL8zgHbUoUqHhBpuiFvHyBurkGI7RSFTTpofmzLmX831BXfOhdvzjUTPGioHBJnjBeWNZYxFBx6u+GXcoT/ypDrJhE3btQHt4aH12cDKvp+ax51poV1TDujWpCMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3toHGPWuNC88ERAWtoze1RuBoBVBufb8az0mBB/0sJI=;
 b=ew6mmpRK+Y4tAEJWuxztAwqNm3uXs7oOGCA7mJEqruT0zeAtLw2J8Tnfz98/C2nF95M9+5EpLY28yYgkvTUx66O2acGiep+vqWwYVTvfHKLrMKUiu4hztZlL32tt2bJnan8LhWmlh3Fo1QiygqnPU9imOcPOJdtWEce0xxCz1nafaW0IxZBjHaBQpkPtrNyMBN5/HDFeKm1p5cqJHXc8oeHAhqVJzIFwSI3qSNEQo4r11/Nvt+5CDjFsWdeUMSrufw2QaMZb00Sw49gG3v+ywLReeZ0Y70BlC3RL7mVSuYEeh8TvoIGFdRCAqiE8bvgZJ96rOn9h34VkrKdTt9A85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3toHGPWuNC88ERAWtoze1RuBoBVBufb8az0mBB/0sJI=;
 b=Pz9reodk6QxxY0/ldPbadJrDl4NKcHgqn68Gy2F9L91AwmZf/R2wnnvKGrYqTEttrxr5eX0gJ8E6zzDUGX826SLmYPwj4Ds09K9qDqas17/z6023PU0RSLqyoR+P/kK13mQu5BMhLLuOV1oReIUAUCGXLVI3qEK74XKksgPcuKw=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5794.namprd21.prod.outlook.com (2603:10b6:806:499::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.6; Mon, 23 Feb
 2026 16:07:34 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.006; Mon, 23 Feb 2026
 16:07:34 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Kory Maincent <kory.maincent@bootlin.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Gal Pressman <gal@nvidia.com>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Index: AQHcpEGiDcItgSgzW0KbKcdvetQIAbWQBDYAgABvgUA=
Date: Mon, 23 Feb 2026 16:07:34 +0000
Message-ID:
 <SA3PR21MB38671D269251FB3C4C4CD85CCA77A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
 <20260223102534.0a87ed4c@kmaincent-XPS-13-7390>
In-Reply-To: <20260223102534.0a87ed4c@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=18f2f4c8-5d1b-42e0-b20a-edbeee1c0999;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T16:04:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5794:EE_
x-ms-office365-filtering-correlation-id: 0f69edb6-3494-44aa-ba19-08de72f5a80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yAMwhYMLNP/VLRLXzcXniVqQWLzVac9WKp0WhsOVDX82IpOUdkJJrlpfEQyt?=
 =?us-ascii?Q?SIOxdq52lU0e7u3ZTWdMzBiGLp7919GNkhdpl3WM04iYexyeZYET3t8CLF1u?=
 =?us-ascii?Q?kgkI4BQlztSBEZZ5J5Y+ubaU6ZWGrq2EpCHH9/5Vk3oa+6cAQzpW7++/gWIt?=
 =?us-ascii?Q?XkPeCIDvBRQ9USnt6hntmdadmZv1jHyplMahbsW8dWEzQG4i/78Mbqu+wcUy?=
 =?us-ascii?Q?KeXvUUntNXK9YEGAxPzSOsLDK/3H7E5q1imFhYHO6DTlHpg2W/0tJGnOFd5t?=
 =?us-ascii?Q?5cIz0AN+c7CgcAeILaQOec+T1DiuzeFjTQ+wFY+VOnmm3n0lc/TZw4YOLLJS?=
 =?us-ascii?Q?EYHzy8/qqZJOBm+fgYQITa8gO0Q08WaDp6LX5KnnksHZqZGQp9Yy1M7Xt0D2?=
 =?us-ascii?Q?6mp4yTYKdkHekRxSEWA01uWo+WSq+GF1WskxDazGFOKA14XvLvTo9/SABYGm?=
 =?us-ascii?Q?MuxIVm3GUsZKn7QhASEiiHo4r6zflsGowO3F9nUuXGREgrXRK8RjBXKQ+Gzz?=
 =?us-ascii?Q?Z7kFEz/8X/uKwJ3/Eyamv9IPM8V+xoX5Wki/2AkAP18oqaRpZVqIFVxUkzgh?=
 =?us-ascii?Q?pkWb5k9qNK0cOITkFDBS/h7AXetqdQ5AMXyd245O6DbNC/Yqwdmt2VkGibZS?=
 =?us-ascii?Q?4GBT2Q8h1Mho14J6T7w8c0DFJ3hGpq8EmrxRpPd6rkUT011JvGSeXndtXc0v?=
 =?us-ascii?Q?jEaGW7u55+iRqZa2liKeLs/7xFw8R+kK0C245AbhzPNz8fwpBfjVZJUEArrT?=
 =?us-ascii?Q?ZNk5ykbrwLIcVVq5nCGdqkKJ6dREqZIhyIG+1RZp2OivhlK6wInSH3CYmPx9?=
 =?us-ascii?Q?AnF0B3CvEe8ay32WekfN0w5vjTMjRHMpJE1Wx+KS6k5/Yv9Lu1JxYtN49wUY?=
 =?us-ascii?Q?VJf3le5BAm9ac6jXE4GkDUmaJM1MItSKJDmNczcT7X6KFw9ja4DgvqaNrTJP?=
 =?us-ascii?Q?Wwt6NHnOyv3ZV/eEIf5ZCbSnRQudi+m1sw7F7aItVVR8kHFBdm7W45T6pJxr?=
 =?us-ascii?Q?dE+JWHst6SMiEyeUxzM0LutHG+Yg9rFe1KgLhsronkfTwPKEaqyccXLDCkzp?=
 =?us-ascii?Q?mBARWrjXsQi18vjkZbZB/i24/9+QZTzPxaDtUUWtXTP0NmMFea+Rf+CaSlIm?=
 =?us-ascii?Q?twFJfIdwoY6rnYaoTDqltOAokdQ5rGiV40pvl7zjWoKavGzuT3ZPJX5U62iM?=
 =?us-ascii?Q?xT8wMBRUYU58iosez32FjK9n5OvXF1wKFwHUgXQZISFkMn4sX7bFA7Rt4LYd?=
 =?us-ascii?Q?tfzt/b9poi4bH4ZkHoQFbh6am6KYYLGgqgGxGp55ROqe4CPSkp4v7qy3fi5E?=
 =?us-ascii?Q?aZrzWBAqiU2eZDI+cRx/0MOJuR7Ss5O7LN88lFVhjv7i84/xWvYWCDGQB0Vr?=
 =?us-ascii?Q?B2X4mvLEkmvs7nl75hCfZzNSPTpo1fpuUY7G6Gsk+P/v8B5Y8my/s1duqUpX?=
 =?us-ascii?Q?A8AlD8RBVjNutnEiep1rOEw3yyfoaSp1L/+ynng6aZPOknPu4aPnTH8fWrEa?=
 =?us-ascii?Q?3YNJNwGUTDmKnBNxHZadzB2RWdUj1cqtkurp10I79LMEwMvu9bF6e+p57HeM?=
 =?us-ascii?Q?oImxiQb88/N86a6Q1P6tIKviFySecvqD+S4sdnY7BtaCFTzYX0zRBqgGyMxl?=
 =?us-ascii?Q?qEpAwfYB5KXh8dk+FlSoSFc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?14EYhhVTScGzoRNqxlKs7CBoGdWfIj5nYLhcbdvEZL6C7njzrYy1lk7GZryt?=
 =?us-ascii?Q?OpMeosO4o88410ZWPggS/fBlgRqQhjzPMgIUloVJjhoVyY04sDGHe6hp7zZU?=
 =?us-ascii?Q?uK5Tk5cwAOWQhdUamM7ITrPbXhCfZZSztuS8BbQ7DriKOmRQ/MVDh3Mt4OTY?=
 =?us-ascii?Q?2iUgDGGy0DdICocNqQNzwqSMDSxS4oRwJPY5R1VnGuAyLaTdmgdgmRP/ctda?=
 =?us-ascii?Q?0OWnBXy40NnzBEnDG0/jVB7vJbv+x434hlampFkxU5nXZmq9wBRI4bCykX+q?=
 =?us-ascii?Q?w9WxCMD5VOl1vNrN6rnsgZ/9WpekyGBWX68OrqMc/ARv8GBfwC5qeFfmZAos?=
 =?us-ascii?Q?AnJiOQoP39VqjX1sfQu0V+kNfJ6KfDNE/DNTZaqqe6TS/TkJ9EH+tE70sdtb?=
 =?us-ascii?Q?FEikL1jsEv2ypx8wqWX/rO5HL0FTEbFl5+3eAeOVO3xgbVA8vpfQfc0dn63k?=
 =?us-ascii?Q?jHL7imH5+Eb1WPfI8sAcSGf49ACOID7QZwJOAd6vzezLvYX6qtEm2c3V0M/C?=
 =?us-ascii?Q?Afj9uGJPOqr/lgXwak1ap4boSvUVlZZ4pLyMG12LHzFqYSMSqD7w2OeLElV9?=
 =?us-ascii?Q?oct6j30eKQHMpBQpmLkO7gboWyT8BknjCCvuzvFdvNT7rpZycdC089Rl0uTg?=
 =?us-ascii?Q?ZJmfANBZFRBl571yYpDR9LQptnhGgRmDL0xZ+MSCyg0Ae3YOgc7hAzT+nP4a?=
 =?us-ascii?Q?w5GfMjkX/oF7p9VRq3jAb7EIt0orHNhZj3DD9ukl/wxtwIYm3Le7NQVoP0of?=
 =?us-ascii?Q?5fX8M57nSb349EtFYk8j0cEtC4ED8cmC9CJdQHUmwyw5sSViXlDEABqUshFi?=
 =?us-ascii?Q?+oZnHr4tqoLuKt5dZJXlqn68MkC2xmocxHuHSIMIHIZNsItgQB5imBmGIahr?=
 =?us-ascii?Q?9YgrhWfg9laZ6Ss3KkT94ytzePfuB4QsBENAjx/0Tkok4+0rR8XJtWx7U2jn?=
 =?us-ascii?Q?pSLXbW+g9luPuzqNMpfYGHLpIH1vfUX4FjUeed/sN8OdgRvZEi8RV2FL29jl?=
 =?us-ascii?Q?5cHAZIJjzcRmdDDfjkxu92YPARQQBWQYCy2HEvWOz4hfaj9krhG+vLbpNKpN?=
 =?us-ascii?Q?Cy9+xgDqOdgj72f79UQbAnylAoEqiSu+wqxiG3atMQfBqvs8SsF8fyD67Ssq?=
 =?us-ascii?Q?W/9iqZ0S2Sjr/1wkXSTpdc11eeJjECg/4BIgeUTzeUk2CvESNJ7+MJ94RcWd?=
 =?us-ascii?Q?BVHSaHxoBE96ME7xLqWfswSTT2I0GopBj7aVgc0qibTdgoR4lIGc6fDpp8Ox?=
 =?us-ascii?Q?fyGaKnQObYnQrNoiACMqpIoan2BYgyltq0ZLfcjWNeaeRRSt3fmMOBClIh2j?=
 =?us-ascii?Q?I+WVDKl0ZnKey8d1+vdsOCarUYVPdCyyucKdpLYRnZ8kj5FpPmc3wG00oHOa?=
 =?us-ascii?Q?LFIhRDT9/TBmm/DkfQl7dReYcx5YYzktLVrSJpnqMiYdC4EOhmgAASZUpbjX?=
 =?us-ascii?Q?1TgLSADbwQA8n06Ssg1JOUUC9RI8sTqCz2mLneV/d98KK4yoaOCPwT8AMlHD?=
 =?us-ascii?Q?tUTj8Q4L3MlXTd3sFoO9943uvmemNLuZJK9IvpXR+K3zq6qqQP78Pp09UStP?=
 =?us-ascii?Q?CMsk+WLFaM1onS40uTzHI+D3rMteTclNF3veq7f7URdzK89TMGRgFeIgdwZs?=
 =?us-ascii?Q?PcAgqIfMQTykjFZoHULpRKO5pOZVUi8+mIBIBbk/sXdRsyW9bCOS+cbRmrQE?=
 =?us-ascii?Q?1T4sOew1VULkHzRg90tmWTanzAUVpCILd5aIhjCYk1JwmFhlK01khKi0LRzG?=
 =?us-ascii?Q?w2r/xbvoAw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f69edb6-3494-44aa-ba19-08de72f5a80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 16:07:34.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA0dmGMddQMR1Lp+Q5r+SX2lTiT4+g45PfXYIxRSSDRyyG/AbFNZh6WLbsXE9oFDYw1iNECbRR9tjuBss5brLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,nvidia.com,pengutronix.de,linux.dev,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8955-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4106417974E
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kory Maincent <kory.maincent@bootlin.com>
> Sent: Monday, February 23, 2026 4:26 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Andrew Lunn
> <andrew@lunn.ch>; Jakub Kicinski <kuba@kernel.org>; Donald Hunter
> <donald.hunter@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; Gal Pressman <gal@nvidia.com>; Oleksij Rempe=
l
> <o.rempel@pengutronix.de>; Vadim Fedorenko <vadim.fedorenko@linux.dev>;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
> COALESCE_RX_CQE_FRAMES/NSECS parameters
>=20
> [You don't often get email from kory.maincent@bootlin.com. Learn why this
> is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Sun, 22 Feb 2026 13:23:17 -0800
> Haiyang Zhang <haiyangz@linux.microsoft.com> wrote:
>=20
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Add two parameters for drivers supporting Rx CQE Coalescing.
> >
> > ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> > Maximum number of frames that can be coalesced into a CQE.
> >
> > ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> > Time out value in nanoseconds after the first packet arrival in a
> > coalesced CQE to be sent.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> You send this patch one day before the official reopening of net-next.
> Not sure if this will be taken into account by patchwork.
> Else:
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thanks for the review! I sent it a day earlier because of the winter
storm :)

- Haiyang


