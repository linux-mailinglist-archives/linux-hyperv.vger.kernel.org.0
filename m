Return-Path: <linux-hyperv+bounces-3034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4D97B4B9
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 22:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC581C2194B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5E18E058;
	Tue, 17 Sep 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GAWxoOUR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022087.outbound.protection.outlook.com [40.93.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D51891B9;
	Tue, 17 Sep 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605289; cv=fail; b=PRXc771+b/t30aq6qTYvgbTjngw5GhfkEWW1gRBaVy+mLs+Mqx2Bc4GIQU5GBnDA5a5Thk5+obAE5BI+mvLh+lekngMKqI+UIR5+Lu0nUkr3iTwg4nbrD6QpM8Oasor6WRkcI+HVCYe0i1lgpTS9/aqQO6Amv6lxAhDW3UKpXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605289; c=relaxed/simple;
	bh=4z95XiGnmTXWICFA70SnGGrPD4dpA9LcAv1h1K2gKeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YMH6xD9kNCdBv2jmNX8Xcu/05XWXvoNMeznhiJyw4J+Xypu0GoqmUOa4q2UBvQ5wKbD0e7i6zDpA3fYyiogJiyHZQVV8QvVtZHbqVh5yQpNtT0gjlK+b19dktVNywXwQewzaU9IMDzwYh1UMI8ukdNPDBGF48CSPAROqNa5NM/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GAWxoOUR; arc=fail smtp.client-ip=40.93.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKu9reyAr/41KmjPiSN7gK7+ykITqvbpMkDSNXLJ1AEbULyBefknGBTDV4CAragmx7yTNl9w9GPcmsg1FljD0bDnUbptdk85ADvShaCTwkFDEHPEQlHDUbzumRneQwwgd4m6qHcse0QlKEofs31Zf3t5utD8oPzOoeYaqkgdgEPoMCvZha7/Vs4qlyoJPwchDb4rzs3jVUpj2USOqwbrKv3MMulTfK3hKcdmuVtu0sKp9oenVFixpS+xxTH+41u5wlcYlovBltbOQ8CxQxxsSsYTnXZeXRK5n4ZjdrGM0M7RV3U7HZm40pNrVvgD7Sau4Tw+Lwg3R3M1JoRDWGaUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z95XiGnmTXWICFA70SnGGrPD4dpA9LcAv1h1K2gKeo=;
 b=SOFhtTe2L9HxRwgQ0VWUqNX9gEJzV88hNbvd61hJhSG/QdJldBQDacy2BOBfHzsdja5ez76V5m+VSx9wti9Umi83rpu22qqOQPrw/wbXNMMAI5CC4d6ywfJ7N2DE4m5ftBPBeI7cynbVMuZTOvLnOQfY7KCKTDbvnOaYcuQOJyrltKo9Z+yR31Sjv2lQFMzQSFaCjQ2BYq5mMOkN8w2D/vZ66wz1r6KCmJFgsHyESGyEi38Fsassd8UE7iZx9251x486taLx0PtuCLWpN0ZX+cOMwGJ9sDAdSO8E4SceN6fSGuwwFg5T+vObIuOSC/sxtzvErq8G111OdMYA6w1rAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z95XiGnmTXWICFA70SnGGrPD4dpA9LcAv1h1K2gKeo=;
 b=GAWxoOURpLEVco8t8gXUJBk0ihO3FAi5Ms0M9oR6SpY/VGoYrMgLWRK2RXyD0RVqZjOG4ApcUqJvIPE4PBxCgBuKXt9kyG4GCwCveApYDEM7eerU8qPNbleD/g8mfwBwQT4h+AWatCHnUeeD/HDpycl+oz2QfgZgFaa9P65FwXk=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by LV2PR21MB3348.namprd21.prod.outlook.com (2603:10b6:408:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.5; Tue, 17 Sep
 2024 20:34:40 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.8005.001; Tue, 17 Sep 2024
 20:34:40 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ahmed.zaki@intel.com"
	<ahmed.zaki@intel.com>, "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Add get_link and get_link_ksettings in ethtool
Thread-Topic: [PATCH] net: mana: Add get_link and get_link_ksettings in
 ethtool
Thread-Index: AQHbBOeybZTViwmNu0ClIJxwZ4fwXrJWoTWAgAVwXICAAApNAIAAWy3g
Date: Tue, 17 Sep 2024 20:34:40 +0000
Message-ID:
 <PH7PR21MB32606C49F796ED9E7AD0E5ABCA612@PH7PR21MB3260.namprd21.prod.outlook.com>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
	<20240913202347.2b74f75e@kernel.org>
	<PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
 <20240917170406.6a9d6e27@kernel.org>
In-Reply-To: <20240917170406.6a9d6e27@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8122679c-ea6e-49ee-a071-42f6067f4e25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-17T20:30:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|LV2PR21MB3348:EE_
x-ms-office365-filtering-correlation-id: 7f27bea7-28b9-4845-5d2b-08dcd75827c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dqMXDRU9Y/+FCajs2oZH/W1K74Uknfj7AAiMrhLG0nc5iqZDNkZr+ByDDaw/?=
 =?us-ascii?Q?MMdqe4WHIOV5MbvwPj9++VQZ6Qbq0iUWDqvqU/14xaAYHHiEM76ePrrufHxF?=
 =?us-ascii?Q?CajeYF4rb+yQnAj6noUQMCRtdfA0gjcI2qov8QwZl5txyHD4Poec2UyOTT+5?=
 =?us-ascii?Q?QOg0X+HmArEYsvkrJKNl77p5gQZASjZnp1+Qq3UyrOlfjz4a/BqZvhPxiXv3?=
 =?us-ascii?Q?IQvpakIQJjXcd13nMjJ7NsnvV+DSYY5ZUdbc430o6t8oCal1/ylaZfCU6vaw?=
 =?us-ascii?Q?nzd17jYywkvQVrVDIZ5Y4YhFlQXrD+Qml8299aoXhUKugj88LHTvnLkOK7J3?=
 =?us-ascii?Q?VYEjgncU3Sfdhet4RH4b0AVGE8qYgM3YNX8epOOQC8tNuqV5ga7htTXKYv8f?=
 =?us-ascii?Q?5ZjKyu2JbzcsclUWHjWVwzU/DCnk6pVkTh13zMLadJvKDxA5hyBUF6TrtHbb?=
 =?us-ascii?Q?9A0Nlp6px524Po4eK9Zb960HmJhmeEfvFVAInvYyPASXiW7b1KiIHSbjMBmM?=
 =?us-ascii?Q?FvnWkaggpB18OMskT4jqeFTaPrDdsaaOniXpc2NOTPteoOuC/CcIUnQUV0K+?=
 =?us-ascii?Q?8O67/bYnLLR2PIvl05JUJHIDvhs5CIQYnwkVx0MNWlNEJ3m8pmtENiVR7GeI?=
 =?us-ascii?Q?PLYrQ6Slp8ZnSmtWW//RXz77zWfvi41h0E4bQDvvewxzOS8W938287RU3N2Z?=
 =?us-ascii?Q?8vevXZuapz1RmusuT6E4/pQQZDzcYIXX+yyilPClhxOtusGzI9mVrIk7ZTnh?=
 =?us-ascii?Q?tejxsx39ZOzTl0fu4QzOgWXc5kaI2uKtfs+1+Kv8JuLzaumnyxnviJ7cRppL?=
 =?us-ascii?Q?KgrqEde33czPrgrq4+X7o1ZPjrvGfoEWwavqoYwv+sSuzQsYM/l5TRfwsD+q?=
 =?us-ascii?Q?6VzgFzuMq4QJF2cmWdcqJVXwlvtjwDXnQ+Mwre6jSaBC7pCU8ko1qX5lBUEq?=
 =?us-ascii?Q?VEJF+k80UPm7rW03xSIP/Q5rfzchzW4nY215zsD7iF725lGsBq4jOwPQvXGq?=
 =?us-ascii?Q?nBggr0atbVewFsQfiIaxvmgOFqOOxRYIhut5yvkRBzkTHa+2xI5Q5WpBNy0q?=
 =?us-ascii?Q?ar7vU1rT+1AZSJtOFpE3lCXKy45Tjo6nreXGCQb7zwcAZiPUlM0G05lcPjG1?=
 =?us-ascii?Q?gVnERzbH2gzQI3jjgOaCWMQ9Pf0p64uMJzAA46kpqfBnBakQKQMRcAibS0lb?=
 =?us-ascii?Q?F3gujFXl77ZkkeYR3sk+ZteTPpeW7l6sU9x2Vzpx6EqCqvKQTtPbvizgr/r3?=
 =?us-ascii?Q?X6/ZYVM6QXIfXiuY1uRI/mDXmV11CksDN9uM0raShDPkoICbSzuDik4cE2l8?=
 =?us-ascii?Q?4pKvx3Ia6l7nwm6NvdjgsHYvR/yt3jCkoLZx3Cnqj/RDOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GES+A1wtPix+8oANUY5aRTPw00DnfT+WDjB5U0xx5VQCeK/SvhokGFnxaQQd?=
 =?us-ascii?Q?iOkrKaUAqdy5Qp4BRY+qKHFMjCpvPCJ7tPoeuaP/Jkv9mAj3Yo6Dl9A9eFml?=
 =?us-ascii?Q?p7/IKAhjL8NBKOiUiOzUI3+CyqWWUBtR59iXLZLtPdL09NW/4PZ26vLcDPOr?=
 =?us-ascii?Q?6ZQM05y+59gwZfkvq9EzJTAbxKSibiQyU6byzrPsQNP5BVlmMuThAG8ssWSn?=
 =?us-ascii?Q?uto1CocYQo38RiW/3KoiowCnl3Ndu+SqtL4jTJxYAEx1DGJ7wrxDDqKQGy7L?=
 =?us-ascii?Q?HWKaAvRDpuOIw/nQekns1AgqExfzaTDui8r+mH5RI8Jd44PiJwGpc626oMfr?=
 =?us-ascii?Q?xZflV3HmTh5CfMHhCguqvAiARWr5SCLXdstnmE0l398MD0ISWAa0XtX54OpH?=
 =?us-ascii?Q?q/ib14wOd/IjaTB7vTgD26ge5DcKQsa+vPuYTFQwS0TKrrzldlOJqJ5iPmvj?=
 =?us-ascii?Q?zw9xStLcgBjq1+p9H7rYnSrcwUUNYQqXvVv58va08Uhpyd/vUhLj2quK6DGh?=
 =?us-ascii?Q?tyR5UEwnZlTh2Zu8Jz08EmZ5Zpl5JSTz2VYBSOFcCjSj8slK/u6mpWgrJVTL?=
 =?us-ascii?Q?vUbW2RnIgi8OBqY2DjvZ0RkuwdhxEEpS3IKur0KYa7qFn92qOwQmBGj5Sz4t?=
 =?us-ascii?Q?W+yqa4Nbkq2R8l05NaGHM7bj5Xsr/S0OrDvuzBjtE+jBGjeHoJim2ql8equP?=
 =?us-ascii?Q?psq+DUYG1oPUwxNsaK8EcPI8DOuo0XmD0m4jub5gSDGvhdeIPTqWD0jtWWvE?=
 =?us-ascii?Q?bYK54NSZUCsAOeekRhHtXG5x0J7tdfWseoRxnEOJ+hXdv9q1IQDng2AzAIeP?=
 =?us-ascii?Q?ceM1Tgc5ixP69dgjkgW6XTpk5OJtckgMQuxpP55tiS/U2Qfv7RQa+U2OmnRS?=
 =?us-ascii?Q?kNsD4jNnwXyVylcL1PPnJ6jZAYiRtUOK1XF8Mlh582PbdXwum5KGHqBhduFJ?=
 =?us-ascii?Q?MJWXa6OxyLO4Kt2nvNU3+I8v7JKy0VUwjd/zQKEoCi6UZuLvhIz3HUJkSdg8?=
 =?us-ascii?Q?glGIHa6CMwYkVs1LACsa06XUIlV+Skqa41fpntFHvmhTGXRALlyY9X9TwmPj?=
 =?us-ascii?Q?rQ8cTQekdnc7q+ozN2MDbIONud6oT0K7ixSrcftquDrdU+/cQCoJOXx6q7KD?=
 =?us-ascii?Q?ZiEaMbwkzFgmAjjkSNEOD9lUCa23yjp8dkKMQDz9xggLy6BIvXauvQwknbXD?=
 =?us-ascii?Q?vMS5FCzkmRGOTFysYiscmqNvH02b+bJcp1ZeDRoCn3blZ56hj3W4K9QDx+35?=
 =?us-ascii?Q?IRqpxBA9AFtInxjsBRquUxl7lnR/zH2gzpZW5PcMfTaZBrWBHPTDhYJXZbxC?=
 =?us-ascii?Q?G+jWBivCMp/2dtHMdYWo7XlTKwj7LswPbROfVfthYoVOdbN1BAAw+wD2hS81?=
 =?us-ascii?Q?3UQIWWNq5SWiOUxP56DYGLPrIv5yJcyft/rEEUl4pccGRSHPFPts2hAqs2Jm?=
 =?us-ascii?Q?rrWB3S7a4M0Z4P3Ez4chIaizfiym1bpc77P9uCivEExKMSJNJFR+FXIVA3XL?=
 =?us-ascii?Q?d4JnwsycDpjmaVqdFiUYySZolICKMOmw4bftkgbqEfqp+Po0hhlsbtbDrmHL?=
 =?us-ascii?Q?T56YoUmazEFwu/kdz40EmLa4pe0rvBNJXZ7AIsZM?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3260.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f27bea7-28b9-4845-5d2b-08dcd75827c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 20:34:40.3957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcHd5k94YiZoqxymdnBe9+hw5eDxt5vXd9j3KiICuvj7Pu6wFE77ax0tY/LyPTI28dexVPCx66aGxvM5hU713w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3348



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, September 17, 2024 11:04 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; shradhagupta@linux.microsoft.com;
> ahmed.zaki@intel.com; colin.i.king@gmail.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in
> ethtool
>=20
> On Tue, 17 Sep 2024 14:35:21 +0000 Haiyang Zhang wrote:
> > > Any reason why? Sometimes people add this callback for virtual
> > > devices to expose some approximate speed, but you're not reporting
> > > speed, so I'm curious.
> > Speed info isn't available from the HW yet. But we are requesting
> > that from HW team. For now, we just add some minimal info, like
> > duplex, etc.
>=20
> Unless I'm misreading I don't see the answer to the "why?" in your
> reply.
>=20
> What benefit does reporting duplex on a virtual device bring?
> What kind of SW need this current patch?
> etc.

I'm not aware of any SW has such requirement either.
We just want the "ethtool <nic>" cmd can output something we already know.
Is this acceptable?

Thanks,
- Haiyang


