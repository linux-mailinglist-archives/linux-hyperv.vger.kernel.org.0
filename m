Return-Path: <linux-hyperv+bounces-8040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13BCC4BF7
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBD9304281C
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D133C19A;
	Tue, 16 Dec 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TODCXF/6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023082.outbound.protection.outlook.com [40.107.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636091FDA8E;
	Tue, 16 Dec 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765907324; cv=fail; b=Y3hYVRqu6/qFvVQ/8HbhSUyycpNltnwUyK3q4BiGEQKD1mJfM9PDzCyiVtzuBiAsSMadfu1XXhBWqLuSB7fEJ+coQRmWmqN0hJsvGqQdwEVwCsbXyirsYobbtvKVWnP8CF2iRs1cKwbnpFwS2Gc3y9NHPTiGaQWmza5OtLuBXgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765907324; c=relaxed/simple;
	bh=9FRUPvSIA0l+eZYQG3rkfVJiRu24wmw7rZH0FhrxWY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MoOtUedxMhdrqBodM0ozUMi28148o6KXGlnAoya9oUjykXZKzmFLdxoUOsrVDYTIDsXTS2ZOVZsNGLBdl68jZPl/B3QQFExy5sh5v8XfIakx0uGQq8/npfVREZkJnS6FVYfgnyFNifyBNI2sbKQuniO5NR5MxRNMNdGE1+LXXfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=TODCXF/6; arc=fail smtp.client-ip=40.107.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4u4Qys+zZWLnfeZrGksJCjfGIxEzdHz5hqgpU08mTBeFcaoTYHId1ydseZgdTCydI5nX4qUebQaAQ5THLi7ocdzCB3AG2e+6XLKLLnUZ9Gl0ltiR4ovTiOmI7jHSsdckNh5OLylNu5xkIR0KdjQREvxxaR0Q1kNq40DfOxpuUnyZKJb6PDkVWFIMUpxXpz+f5MaaOFGzhbnFH8rrzUovu47rkbnegZGH5HmEs0WjjFWnf+xnQL7xfMhXSQ1civBOnVCfGeUUsHL5YAUk+peMEnTw+OmH6DfAjKAczjK3X+tHu4zm74hLan326JHEYLc05OvIWG7YAcu2VyMd+pRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb3wWrK4kkdd9hOeXskXbL5f4CZu+81QcOMdubV+vVA=;
 b=W+woke7DuHnoSCjCGHlgUV9NaaZ3KMoqX8s78s+qvuJKWtyiANDd58ldbfEi0XahVEvYfS5y4v/3gROhZRPOqp0C5YF4yyw8H44jlO+E66RrApKy2IIiB9R47ml8KcdWcsElathUqzar+4/jqKRB5rWArYnxAaTjZq5bAZZZb57BiTzsXLOrAqZO8mKfVxsvJoTURbqn9Bn9VE8i8vKf6jjD8iup8jaOW9zY++DKtxlTfbFRPAr+7uOBbA3V4VGz1+jl4aqL9K0BfdmBiEbp+XnuDgZSuKHRaJYBnidPTbTZgv3s6R1VGuAudS4CTj6cD0eH7k84iusOY0Bw0fRg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb3wWrK4kkdd9hOeXskXbL5f4CZu+81QcOMdubV+vVA=;
 b=TODCXF/6FEFzvzub5RJWdEGYhCYjT9FUoCIiGgzn34Ql7Zz0Wlf/7xh4WpJcSe+JUDHHfeQsGo1oKTlbaixab28T1uELcd12dblN94GKTZTknXLGLUZNksd6QsRNLI+Y9VjM5IOhiHXvbj0c0taPswXG2xaSzF/zDozsx7JMIyI=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6817.namprd21.prod.outlook.com (2603:10b6:8:2ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.2; Tue, 16 Dec
 2025 17:48:34 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 17:48:34 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Dipayaan Roy <dipayanroy@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: mana: Fix use-after-free in
 reset service rescan path
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: mana: Fix use-after-free in
 reset service rescan path
Thread-Index: AQHcbnpz//IgCp4tOE6kq/AACpHZEbUkL9KAgABbgrA=
Date: Tue, 16 Dec 2025 17:48:34 +0000
Message-ID:
 <DS3PR21MB5735821FBD021FFB386AD466CEAAA@DS3PR21MB5735.namprd21.prod.outlook.com>
References:
 <20251216105508.GA13584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aUFOl4euBSyPtA5F@horms.kernel.org>
In-Reply-To: <aUFOl4euBSyPtA5F@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bfa09cb-be1e-40b2-bcc0-2b424a494beb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-12-16T17:48:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6817:EE_
x-ms-office365-filtering-correlation-id: abfefc67-a315-498c-8354-08de3ccb55bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y0OgGc8S0oF0wn10xi0Ob7UW49AaXZh+m0rrJ7hd28IoYg+I9MQLk8sjq58H?=
 =?us-ascii?Q?NL/kokMSaZEI7Yr2u+cbwGiVa322p1p5HvjHX8/oD7Uu0t20eZFtQfqZLfZq?=
 =?us-ascii?Q?Z/mykITLkJL5BpVcyYvZbr5sDwsD6J/EnzUChcN74BIe0bXSL+iSN3Y03BNL?=
 =?us-ascii?Q?73uSwUwlS39X8Fn3d50q25islnQeQu0a8jvUkFOx2lgyXS7ZwKW6NvRjZGGe?=
 =?us-ascii?Q?0//nCkfm0dcGA5LsUCAo4GRfng9ykCECpusNbDSqERfxM6re++itPcLsp7a6?=
 =?us-ascii?Q?nQxIGUQGtsWrCQgAZyp471aEYZRnsnvo4s64DKuK+kQWzXEJ2CosG8HmdQ5M?=
 =?us-ascii?Q?QRuHPH6WYTmkiijVo11vXW6PLrxZRSCwd5rnK5MTbkOWVwAiqfordWmHZMe8?=
 =?us-ascii?Q?GVXGudGkqukeagLd4SRun2XNkB0AHeey1lWjmfwWt41jJUsFSBpG+jta4/9b?=
 =?us-ascii?Q?whiuQJkZ4hTDmp9cLr3PLbWAjaoPtce6NYzDRVzICzoivsNHtA0lR6NshHs4?=
 =?us-ascii?Q?+4t7uCilKJRMRtQ5UA77tN8EDiKer3fy5bMS+fHHoWL49cwVV7yJ1jyzCoOK?=
 =?us-ascii?Q?kmEh45UbZC4d1vynVfFXbI7+LiZExA/To6kCeG4PeiSjhOeX9UJwDzFKaXX1?=
 =?us-ascii?Q?LcQeD22kY8a8EEpvwWJ1Yxdg+bG0lYGqE+28JS9oFmiXBuwslC0RMuqn/0Wf?=
 =?us-ascii?Q?bpnT+/SpHUwc+pk1hzWhUAx67Zz+48CR5k8NhrZstGQMDMnEvFxiGToP73Zn?=
 =?us-ascii?Q?vSw8d15Jp6nhRtGVXP83G2uFYI1EHbZHkmi4Tt/R0KszkRS304BWd4xxjD6O?=
 =?us-ascii?Q?a92g2LsjFPm25iCDyrdItQkdc3Sj/eAa7T+5Oad9YyfPN+D4VwUmH9voDIMH?=
 =?us-ascii?Q?i0eo8kZDrK6K01aox4JYZKe+m3r6EJLcapmiqHShOJ/HVSBODFJjhSuFHCTk?=
 =?us-ascii?Q?ljz0m07siL8qUHZb7Gg4Qs7TSGWc4vcQ7AM6OD2U6s8B/AhVzBHgEbReQ0eG?=
 =?us-ascii?Q?xGz9FDFCVUW+xef8Vy80zH2F7esDGPoE17Duwzz9C4kFfosSxRcSAuKJ9Bl8?=
 =?us-ascii?Q?2acWTerPeRtMY45keoU9Ok6Ak7OSrXow3waKI5jBZ5qpn0IMUVuXKw7nv+QL?=
 =?us-ascii?Q?+fWV7n3k+//58JkjGT6pBoaBoG3sqiWeyzpYtjXJcJe36rKNOZscZCU8EZ8j?=
 =?us-ascii?Q?JYi69l3/Wj35aORW0uiRRT+NRR9BkyR37+YyZ7YhoyfUAXzUx5AYDHs6C/LK?=
 =?us-ascii?Q?6kwvmdTrH+9BbPOr4yPW1XNwcnGQhb6hVjv69RWtZUa/+jZYcZf2q7zP0oka?=
 =?us-ascii?Q?4EGhJSx6KTI+i7mDhrlWCoZ1KLxoYSy+fb35Xs4uU+2qoTrYJV5tE56c37vn?=
 =?us-ascii?Q?eEYP9vzQOycvKB060wCc7HKESW2YGVruWhIHRh6XCLo+0hlVYynDpIgRjptQ?=
 =?us-ascii?Q?V671dJV1mPPaQ0nnZj/0g6TujLkL74qzuPPHiaBncSWq7glPCkdTtJVMKcl9?=
 =?us-ascii?Q?Z0jOiiqAT9S6uFmbMEAK5C9pE3eX27YMS77e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LEHHZqSGG8QkiO/xu1zCzDBRDtjApHHKtcKwApXrjZwfqY//cOiMxCVwUi3s?=
 =?us-ascii?Q?Pz88SaJyRFU9170Ar5z9CTH4zqBB8pgh1vcXGm7Lk1Khx+Pzmd93sgDHStQk?=
 =?us-ascii?Q?P1GcIKYcC/ipSa2D0FsL7qhRzE4GIzFi6htivKMNN5dklTu1cjlZsoVEBfFh?=
 =?us-ascii?Q?Nc4jEsdzGckLTNPhdpVDZSJslxsUVLqSFpLC4gtdkZDYyfVUUqzTv1b3n9gQ?=
 =?us-ascii?Q?cUGRjQVm7x5bGAAQwWU1sBiiHBNUOGpz6L7SLjpIjawxl5w6rfhMBzfo3fwx?=
 =?us-ascii?Q?3xz9ihiM0ZLENlmJfvHPFDUswLtZY60tvfoSen1FlwKZQRf52/zpAJLYG8RZ?=
 =?us-ascii?Q?iWsirXqa7/DdoxAYBp71rUb9/ULu+8x0mssJSWJCamTWIi/fQdvDIUPAo8jc?=
 =?us-ascii?Q?Rmik0+/rZR0cV9eCVmRi9CYl7hnjqZPIjzivwMhsxOU4rtgF8b/HKpl43FKy?=
 =?us-ascii?Q?HpxyMiOidTAKNd8KlhDEDM4zrV04QmfTVDK/zpZZ/zB/H2TEO+KfkQa5mYMR?=
 =?us-ascii?Q?nbefA9YsWMJ7BPySDCeC7dMMnH2L/kblor/hjZA6c3jbeOfrGitu1tdPwjDj?=
 =?us-ascii?Q?zxgfFYLvy4QXt10tQdAhteZhAQzB2OWY/ioD7Ud2pUr/KbNelJuCYYr/Xro9?=
 =?us-ascii?Q?8M4nnr94BLZLzVbhwJGGf3DZxlH71qZertqk6UH0zejStyUActM73Op2t/KU?=
 =?us-ascii?Q?EIo7HMpM2k7XandGEwvZoKyYxPTmvzMIEe7eDAQnH7tgV3/Fzb0kG1XpqAty?=
 =?us-ascii?Q?XsyG9ZuYZeUwGvC90iDKfltXrxbU7P+56Tfd57yGx3n+GL6s1r4VMFHQawQy?=
 =?us-ascii?Q?gePylUMFNTbFnANfZN/1nvRrBsnk4X3iYRUQ+lF2QAV5exu7VZQfDP/PAOtM?=
 =?us-ascii?Q?r1Lei2DyxHIjPPb9c2trcvBcZ5zUOohHGJqatwJw3kRUAZ6Qieq2yCvQ9ZIn?=
 =?us-ascii?Q?yd0Iv84n1PPspXGR4G+74Viu4lvJVfWEvtH/JIgCM0kk6q3bVgdfZ2hmBwhR?=
 =?us-ascii?Q?NfONb/05NI2qMDB7n+xQUX1GyBg+H3UOUNM4Vo6aRSoGcyHfGx2MAKZDzpO9?=
 =?us-ascii?Q?2XR8zyLk7sPy4f7dk3bnHcPDkrOxFkp8jxgiKxzm9x9EkrwMELqbcLPA0fn1?=
 =?us-ascii?Q?VvOHlMA2NKx/cfvPBiZQQEChJqsedLsnsoY9wzo3PkQgD7xFiBYUysRMbpsm?=
 =?us-ascii?Q?HT4yv1BOQtUICmKHkz4RgUKEBfhDlrxQQHnjMVejWdHsO6+YeQznAaniw86a?=
 =?us-ascii?Q?rdejpiZ58N8QzYaPJ3bP+6bB5MgCPsZv4jRNB8tkHDwf5nIttcRlI1C1Bg02?=
 =?us-ascii?Q?AwCNQs8M6d6O+PPrXC9Lu8wKWDEKrgQscWaluF3U1EbEcRnajRgr4xgd+pi7?=
 =?us-ascii?Q?zJlWNRm0SVlZUULF4zmPtrQd366CdYYWgsNFJZYOFyUf7x3u9y8haLYJTNl8?=
 =?us-ascii?Q?OMcJLxHovi/XJEfXJtGoj9jomEkpq2xqKyjrDGT1JyVLf7fFto7IOMRLu0pF?=
 =?us-ascii?Q?0MSSUUq3JnCwJZlyMkQUU2acy1q+vtRlCvnUdX1AGGVxOfK4O0lVUvunMUVg?=
 =?us-ascii?Q?DyWHinKDTmCfZrEQ/1nIlF/VYgKYGnTzrKQUklfLCJdZrkXUavfuUj5BcGbx?=
 =?us-ascii?Q?LdyktZX7DN8PP9hF4lK0W+uSYulRhshmUuDNFxKZpYb6tSz7/+i/jdXcv3y6?=
 =?us-ascii?Q?6LZrrc/c2IqdpTrRSdKXVcf4jC1VC32RCJUIi1c4SbqRzOnq?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfefc67-a315-498c-8354-08de3ccb55bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 17:48:34.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE8YCNlqfoDTFRMXMi21ANqdY1ZZ0ltricjYXni3ri9TUCRLY1dyULw52wHyJAGrDKGqHeULCKGZtKYJRA4q2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6817

> On Tue, Dec 16, 2025 at 02:55:08AM -0800, Dipayaan Roy wrote:
> > When mana_serv_reset() encounters -ETIMEDOUT or -EPROTO from
> > mana_gd_resume(), it performs a PCI rescan via mana_serv_rescan().
> >
> > mana_serv_rescan() calls pci_stop_and_remove_bus_device(), which can
> > invoke the driver's remove path and free the gdma_context associated
> > with the device. After returning, mana_serv_reset() currently jumps to
> > the out label and attempts to clear gc->in_service, dereferencing a
> > freed gdma_context.
> >
> > The issue was observed with the following call logs:
> > [  698.942636] BUG: unable to handle page fault for address:
> > ff6c2b638088508d [  698.943121] #PF: supervisor write access in kernel
> > mode [  698.943423] #PF: error_code(0x0002) - not-present page [S[
> > 698.943793] Pat Dec  6 07:GD5 100000067 P4D 1002f7067 PUD
> 1002f8067
> > PMD 101bef067 PTE 0
> > 0:56 2025] hv_[n e 698.944283] Oops: Oops: 0002 [#1] SMP NOPTI tvsc
> > f8615163-00[  698.944611] CPU: 28 UID: 0 PID: 249 Comm: kworker/28:1
> > ...
> > [Sat Dec  6 07:50:56 2025] R10: [  699.121594] mana 7870:00:00.0
> > enP30832s1: Configured vPort 0 PD 18 DB 16 000000000000001b R11:
> > 0000000000000000 R12: ff44cf3f40270000 [Sat Dec  6 07:50:56 2025]
> R13:
> > 0000000000000001 R14: ff44cf3f402700c8 R15: ff44cf3f4021b405 [Sat
> Dec
> > 6 07:50:56 2025] FS:  0000000000000000(0000)
> GS:ff44cf7e9fcf9000(0000)
> > knlGS:0000000000000000 [Sat Dec  6 07:50:56 2025] CS:  0010 DS: 0000
> > ES: 0000 CR0: 0000000080050033 [Sat Dec  6 07:50:56 2025] CR2:
> ff6c2b638088508d CR3: 000000011fe43001 CR4: 0000000000b73ef0 [Sat
> Dec  6 07:50:56 2025] Call Trace:
> > [Sat Dec  6 07:50:56 2025]  <TASK>
> > [Sat Dec  6 07:50:56 2025]  mana_serv_func+0x24/0x50 [mana] [Sat Dec
> > 6 07:50:56 2025]  process_one_work+0x190/0x350 [Sat Dec  6 07:50:56
> > 2025]  worker_thread+0x2b7/0x3d0 [Sat Dec  6 07:50:56 2025]
> > kthread+0xf3/0x200 [Sat Dec  6 07:50:56 2025]  ?
> > __pfx_worker_thread+0x10/0x10 [Sat Dec  6 07:50:56 2025]  ?
> > __pfx_kthread+0x10/0x10 [Sat Dec  6 07:50:56 2025]
> > ret_from_fork+0x21a/0x250 [Sat Dec  6 07:50:56 2025]  ?
> > __pfx_kthread+0x10/0x10 [Sat Dec  6 07:50:56 2025]
> > ret_from_fork_asm+0x1a/0x30 [Sat Dec  6 07:50:56 2025]  </TASK>
> >
> > Fix this by returning immediately after mana_serv_rescan() to avoid
> > accessing GC state that may no longer be valid.
> >
> > Fixes: 9bf66036d686 ("net: mana: Handle hardware recovery events when
> > probing the device")
> >
>=20
> nit: no blank line here please - tags should all appear in one block
>=20
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>=20
> I see that this patch is targeted at net-next.
> But this is a fix for a patch present in net.
> So it should be targeted at net instead
>=20
> Subject: [PATCH net] ...
>=20
> Probably it is not necessary to repost in order to address the minor feed=
back
> I've provided above. But if you do, please be sure to observe the 24h rul=
e and
> wait that long between posting revisions of that patch.
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> .kernel.org%2Fprocess%2Fmaintainer-
> netdev.html&data=3D05%7C02%7Clongli%40microsoft.com%7C4c2a8e5358f9
> 426996e808de3c9d8a30%7C72f988bf86f141af91ab2d7cd011db47%7C1%
> 7C0%7C639014844545711953%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0
> eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb
> CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DNboWX%2F1bx47kxnm95
> BiopW87UR8pG%2BuOqatiMYaUCyo%3D&reserved=3D0
>=20
> The above not withstanding, this patch looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>

