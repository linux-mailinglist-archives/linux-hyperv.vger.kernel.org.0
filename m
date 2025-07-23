Return-Path: <linux-hyperv+bounces-6370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF220B0FBE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF333AF8A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744722A1EF;
	Wed, 23 Jul 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cytUNWG7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023101.outbound.protection.outlook.com [52.101.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF52E3719;
	Wed, 23 Jul 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303777; cv=fail; b=EXYwxmAdAwT7vGiybYIBJtfg4f0hL87U3pqtg6a6iICnRocJ4AGzA85pbwompvbh4mBvLS1eyxZUqGVUroUYQa41JtfQ3sozunH28Kp4yBIz0YLd9UoV4vxMaJ57zwmmSGWJC8kKXpxq/1pqol3McUjomt8gwKnSdvbq+LqgSCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303777; c=relaxed/simple;
	bh=enyL0jPl6JnJvYDLjMMZR4jgzhTgIUepLNyl4fNhL/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqc/mmESHUDnxZ1jRyT2O+tGsD+mJ2MnKyinWnZCCoRNJMfmZ63d61QajdSRuE4iSVttpVecsvuDEklaBME7NZHIJ8GnBWhutkyiEyWwKwgZQ5MWJ6W4d0eNJWlRhm9EUtybLn4amyBz9/awWuUGszO7L8Cj3TXKY6M/4I56Tf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cytUNWG7; arc=fail smtp.client-ip=52.101.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1hsZENjYh9IaZlMOMnEFmoFxBsRpynw4D3wXYLXFIU6NKnpaBfKiCY7KiHxmr8wNYK5IuU5o5VvCP2QhC1wQwCj9ZyhCyaSV42dQetGrPZ3n98G7eH90NbProg4Shk8MjyV21wkmDSS7N8fK4T8bVBFM+XNqbXJh971furzwOp4vnFR9puvxMRFdNgFoCoqHzGDTwmV+2PgBlJ2OtvWR4LSljKUwBeV6ajNgU+exxOyE7y7S/rk+7I87dczEBgb1GC+1zMGd2i8m/4aYRLZbgoiq5Rqzy7RxdwAkgT3EXiM6dhJLkjBTwLrtjCfVBVbRfmKt/ye3IHk/wq3zusrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enyL0jPl6JnJvYDLjMMZR4jgzhTgIUepLNyl4fNhL/w=;
 b=TVV6i8MN32gQ8ol9CCKQm+LKy/+oTtP/1t35gMqcueu1GUHF9zl2FAcK382r5796V5KnLOf/23g7ZV4zx7yfXOlB7Dzw3DPI/wz0zJS/vVQvk4X+ON+IKdfANWVkjnscKJso0RfuKP+FxvSHvVwTYqaQCdBEBe1xSJB/kliehKhFNdASNaj7Bx6neUiv+4sob9weOYbLumt17lqcFGf1MaClbmCn0OiS14TC1N3nI2fQRJOma0Q8Yz1muLnU3PnJSAaSGocRJhxtXVo45ouvjLb0FvhhjLXVKxVdNbNR86yJnzjF+rbPKka5G1wo1sNXnr6HoRYDbNEVPdEmqAyQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enyL0jPl6JnJvYDLjMMZR4jgzhTgIUepLNyl4fNhL/w=;
 b=cytUNWG7fmrLlziOiyV6H5+KL88LhTiJAsKZBm1JyE7bBNLP2IzQjoaaIiT4KnUyGIfS+HK6hRtcyi9CA/0TqhnpjTyYIbv/Jkv9QmDWBGpeIRiifjHSYZ7wbNFVEKbpHPYLcp88lv8gdZWUCqmpVKcTsTcf+1Gv9ndb67vPla4=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ1PR21MB3529.namprd21.prod.outlook.com (2603:10b6:a03:453::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.20; Wed, 23 Jul
 2025 20:49:31 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Wed, 23 Jul 2025
 20:49:31 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"neil@brown.name" <neil@brown.name>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuniyu@google.com" <kuniyu@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net, 0/2] net: Add llist_node init and fix
 hv_netvsc namespace error
Thread-Topic: [EXTERNAL] Re: [PATCH net, 0/2] net: Add llist_node init and fix
 hv_netvsc namespace error
Thread-Index: AQHb+3NcGZK42ouXrEuRDoOAFVev+rRAKzjQ
Date: Wed, 23 Jul 2025 20:49:31 +0000
Message-ID:
 <SJ2PR21MB40137E181C23C6550604334BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250722184433.2b951171@kernel.org>
In-Reply-To: <20250722184433.2b951171@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f1371c2-3506-440d-b221-7bd9eb2dd8b6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-23T20:33:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ1PR21MB3529:EE_
x-ms-office365-filtering-correlation-id: bf1b75b9-356e-4aa1-f197-08ddca2a6c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nzhmyMgcsaFExwZMjOFeakNACe6bNMmWtEgV5tt5ZT2OGM85DkxZ62a635sp?=
 =?us-ascii?Q?rHIjbjElScx1gz1MNbnoHqz6GFbC/3rHp1/as9QtEHugGGjzaCLijuO7y5x+?=
 =?us-ascii?Q?2koBGznz6InvhYtBfcyJT/TLE2D8G1BYb4Sje9NSRC9VmT4pTexddvVuGbBL?=
 =?us-ascii?Q?h7bL4QTo380rOHRFfllLd/pILselwnOr0HTe2TgDG6EP6/XykEvwslEFeLR8?=
 =?us-ascii?Q?thwvye51DVgEpRzxwm/PaXw6hf7ItBKAh9k1tBth524NawUOAobOs5lrXIZh?=
 =?us-ascii?Q?hy4RxYvQNNQn/TGVWCZPbQt7+OtHn1K3TlAYGWLMfodK7b/DaGwvp8eSNVHD?=
 =?us-ascii?Q?k4pQOwe/RqnSHyJTx2ZqGbAk34+RpOURXLZSN43ONMT9TzqOONNmy5KnAlZN?=
 =?us-ascii?Q?PhUSA3ujMUR/bzPN5kdrai1HGEDlw/nCmQSHhmUUUIWSN1Rnl0CTokIutLCO?=
 =?us-ascii?Q?NLnDAH3uLAqWLaMrPDRjtVFXlVo0NiuNO4b0FK/MmWCMJSypLilxCb5oKTa6?=
 =?us-ascii?Q?huGHY8Om+QaIyMdmsgwz2KNNe8qaq0I+e2iOA+5NLAjCkh97e0ppxpZDI2yp?=
 =?us-ascii?Q?E4A4c15CbeCreCoAY0SZUPIlUVq/HAKtmqhIWHXxXBvGEllDUOPmsjIWalfa?=
 =?us-ascii?Q?19qYeaCpLX7rZLf6edmC2A80MIsYeBF9vtVO0KGUx+1sn5j4llWPOkfMYsrr?=
 =?us-ascii?Q?OJGm/EMz4HNlCbRKlm0gXegCuc9fGo7TBoZl9so9rpo9Feuy8icmdNgFCKBm?=
 =?us-ascii?Q?iOC2P1EwyRI2bVb3ue84g+Ug8fKmxayQkH1gVEId+v+UW2b8WUJmQ8p73pSt?=
 =?us-ascii?Q?qrKsb0C7Es6aoeotsOb66h0UONXhwdkjilYmXVS0awi/v9Fky+HrBrUFRWIa?=
 =?us-ascii?Q?JQl8UGmcMRCV11/KG6BxAe1mKdfOQJTU9dl/t6P0GG3CG8hMfCxcLT1xzswM?=
 =?us-ascii?Q?SeIQZws9/w+X+eojCcT2T/faXJ7p3GvM8+MGR3ILgDVipA6Bb4QpGQ/zUXAM?=
 =?us-ascii?Q?QJnWURoX8br3lfVicXilzoMQfmz5y0exuROwV8OgAMcoMTXg7LiamiGz5eU8?=
 =?us-ascii?Q?e2xf0WO/SYIpMAhTD1UftqY0fYGPHEDB0IDJH/PfH4EYejJGkS+wVH+r7Z1L?=
 =?us-ascii?Q?lUJPVXC8WFdkD3hnvTnsqfHWvW3vgO6k+Ez0RZ24pBsIE75eyHTx62pc31u3?=
 =?us-ascii?Q?YK48eVqKa7s3CNNuFJzqpML9XFxxA0B5J4E22+IPruGXjGhvVOocajjQJfhv?=
 =?us-ascii?Q?WSZRBoxva1lTfn/N4nZyH4Bp1KkNiKmjjuD/jbZwJx3mcS/irPIL/AAcrYJv?=
 =?us-ascii?Q?nLyCtdgFcN0eG/7YVHJFEF5e6FGKbYLUXgbxDxc9k3E8sxAGt5v1VyYQ4Ktz?=
 =?us-ascii?Q?cU0u8BcxfyHcCHmEb/Bk1l2RTrnLsINrGpJrImpLUATwU/hbVLJFR7cBp1OF?=
 =?us-ascii?Q?wgCJNUrXbSfwzVaNlcJSp4Iu9UKEN79mXDLbRH7ZPHaTLLLpiM2ylA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hSlO9xYd1QDRylDgiSzaCB4cDuipERPVHnQ2qebPA1EZZJ1mEhl6xzpmF41j?=
 =?us-ascii?Q?w4UWWqSoUQqwOP6c2Y7Ze/XurMm+gMDgXt89yGCCW4RhQvj5KOgnJ1DvdYfw?=
 =?us-ascii?Q?8byPYRFPfiACzoKgZXu+FnCAa9fT2kuXGrbG33C87DqMMndOao+u0nrYjwpW?=
 =?us-ascii?Q?WZXmLyU47sjKqDPJkJoLJdN4hebay8Nf/Nk14rc+CKs1LFkDdWv7a0haDMHZ?=
 =?us-ascii?Q?XFBJ8t/FXSSO8AoWZ4pVdbKNz5yXxQs+4pIQV9zNhR1wpQOnSejfaEzD0rFH?=
 =?us-ascii?Q?D52FbmRerfjkVzpSz1hLXMx0AQ+VVHGYWljN6sx251i4xm8FZ+f94W9cuHrI?=
 =?us-ascii?Q?rIv7iTMEn4nqomzjtXt+F+9jKs9wNP0BpYZFKjxWQIJC4xliciboQF9MXKAu?=
 =?us-ascii?Q?TY4GdAffPzlLUOgHcthFM9yyaN721o3ncA84Bud6a/zNRFJeYapHmOpMOdoi?=
 =?us-ascii?Q?BbHFz7qw/ycIDhfpjC2qxwnsVD6pv+z0Nys69WyAEmFe/6M6VhaAWl9DeUec?=
 =?us-ascii?Q?IRMIw6lj3HYnmF4ywk5VWtZBp/aWjpS+sJ2iI10CMkWU+8IggtiLsUWHK2iD?=
 =?us-ascii?Q?LN/fJA0sVME+qQ+/5CKvH+TP3DydThTciMbgKtXH+4FfrnsE134PvdqJA526?=
 =?us-ascii?Q?ffdblCNDwYrPTbHVqHtcb8vVyHTsiIf/24mk5tHwUrq37n/erXs5ec7Umbnf?=
 =?us-ascii?Q?fBWijY1yLksyfmKbCTtrqc+oSEGIIzd7hlveIqwnv4K10a1+nEtd529srM7r?=
 =?us-ascii?Q?PxI8isVsNhEXsbO3vBlz4giu9815qXdBNDYXnP8h9UIK42dz793Mr/kInBzy?=
 =?us-ascii?Q?3jJ+O24awcnLA1H8T5oMZP9qB00n0r//8eRNYuwFfKR35wvnBLUgX7pVhWtP?=
 =?us-ascii?Q?Y7N/6eEwBwxKFy6HX4e4wfCm9N6T3HbxRRZX3SqOdCXdYUA4oXSCyNzBhhi2?=
 =?us-ascii?Q?EWp3xyFKVBCsfi02c/BbbKcOgTJ6vJoPRSdPccY/Km/Qb2fccR06bS+tqxbw?=
 =?us-ascii?Q?loDXCzw3MEwU3S/cUfHq7gmtk6Ej/OsUsPIc7XbPrZiyzAGsA+ERY5XU2RYH?=
 =?us-ascii?Q?Cbff3Gt4k9yrkVmay+mo3QYKyMfFsrfeB6bH5NCBPYMqL7Kh9cTfto+zbzce?=
 =?us-ascii?Q?0ztQjpOXRZR7BUW037Nd/MbyBs4qO2zvo8m2kAi4R6+Hx3Scch8QeJMDRxiT?=
 =?us-ascii?Q?22YgUZ5MxwOiiQV2U2nFweG8LRh/69+6sqFENJYFGXQXfpk5eyCpLQOgjvnI?=
 =?us-ascii?Q?ickYiDc0xHMX8b+/RjUyZ5aDcD2NJszPvzwH7WNZACZJgnNrohNi0zeV2mMd?=
 =?us-ascii?Q?uZPnbWd7XnnUQFy4HYBekk+e8i3BH9wTURq0Z+wcp1vicU57gZiSaLyulYXf?=
 =?us-ascii?Q?FEJJRUW/BGVQGlW8/BJulnRIgSfvZAy2lUR9xc9Rm7aZoM8jlohiooPwDgY2?=
 =?us-ascii?Q?HRSDFeEBWSwyyX5vJiiFXMSb19PZbjI6kTgnMmpLD/ny63wWaZswgapjF8Sx?=
 =?us-ascii?Q?VBHHydbhGSY+vpMbBUc93UVfE22WcqxVRjbJ38SO02xNoZgxxs9AnJbvdmAv?=
 =?us-ascii?Q?9aE/lJrNsuwB9G+MkOBlYVkhYH7BVwm5njKS8/gK?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b75b9-356e-4aa1-f197-08ddca2a6c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 20:49:31.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBB41h8YIiNw3CA6VnKqE6aYAPpQezU5Z+MrKLYXK3liIsyleBdeArYxSOnuady9mHUsZ1x1iSqAvhOGF2KKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3529



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, July 22, 2025 9:45 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> andrew+netdev@lunn.ch; sd@queasysnail.net; viro@zeniv.linux.org.uk;
> chuck.lever@oracle.com; neil@brown.name; edumazet@google.com;
> pabeni@redhat.com; horms@kernel.org; davem@davemloft.net;
> kuniyu@google.com; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net, 0/2] net: Add llist_node init and fix
> hv_netvsc namespace error
>=20
> On Tue, 22 Jul 2025 16:50:46 -0700 Haiyang Zhang wrote:
> > Add llist_node init to setup_net(), so we can check if the node is on
> list.
> > Then, fix the namespace callback function in hv_netvsc.
>=20
> Can you not do the moving from a workqueue? Schedule a work, let the
> stack finish what it's doing, take rtnl_lock, do you your own moving?

Thanks for the suggestion! I will implement and test it.

 - Haiyang

