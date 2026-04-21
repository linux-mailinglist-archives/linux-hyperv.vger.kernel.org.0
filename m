Return-Path: <linux-hyperv+bounces-10286-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG9UGXa652mu/wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10286-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 19:57:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29343E3D1
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1608430048F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087339DBD9;
	Tue, 21 Apr 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gc8+Xqey"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020092.outbound.protection.outlook.com [52.101.85.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466442FFDE3;
	Tue, 21 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794076; cv=fail; b=Ppv11+LY66i6hhBy+ig9GimZh48m9FHsGsGoKs7yS6Y5wYLgPx3vGUqWUHGmzBZo4dt7HeuU7i6ruxE3EVI3AcPULBspSA0QiC9WchpeMLqs3zpcV8BsTdDNQ3LbaiWHkzY27ls9RMQ9YxRtSUyAKcOOZhnYlhTLypjcT0jOYFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794076; c=relaxed/simple;
	bh=3D5GO7RTAT5ZDEIfBLfIbfqEoeigki5EZytlmAnfIjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QvEvDx7eOGkJR0UcBBCYaLLTHw1pnni++pfwAuwpuQg6uFjEU45Im7xaYJGkHvHjL8cy6Gw7EVhU2HewMHPdfhn3RyvL2iL4sENULDGw4gLYKsNbjt8kvlp/fn2van22W0ARRSK564UYNAXdqODIP6BOYgm69EfbNhgliLF+DHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gc8+Xqey; arc=fail smtp.client-ip=52.101.85.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9J+588xsb168Ccorp6OnW7JP6qtAbt7xWvn+Uw5tbRpcApeDjHEHZlOcqGaabwvNYgtBCJdX1g/S24sOAYjX7Wxy5k6YeN+G7tfl2gFTw/u//plZs8wsh+DB29dsqgZUWLFaWSo66a+PwWYvDXL/wP6HmTSYbEB9rXPZ+3ydhSoU3IWMvyHZGdtnh8TUZginilmJaNZktC01E/QSG3ocYmkTKKdlOrRZ2R/D3XhYKKZ5fcWKGkhBMQQTAV386VaIEX2DwKxgZ7AfsMLqKEmLdJt7ZCM0licUcUP661zCJu422x72igzNOQTAeO5j4W2pMdaZG8PJF5C8fjpBOmWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D5GO7RTAT5ZDEIfBLfIbfqEoeigki5EZytlmAnfIjM=;
 b=gvo7Fx3bsDU5CVMn5ZZ+wBfjWWM79HPHQjR1A6IAQR22DVyA2EzE+ksUAv1VmHTIvzcmFVmrYagHOeEQWbg/qZUDdpPr4P3wi7/dFFGG8aUzFdKsqRIS8OwqI0oQ/CoHpkmMhUx7YFqjzVnFNabZ29pbzNUlNIRaeodT4LNVacg82n4jYM1w+U03pN/mUWMF5YNhlXWRHvTioXzgoLsS5wAaTSAVGPFIHnbfIEMKDL4flb/+Do94gAnIR+zIwmxbH3KIOewCD4ioRAMqQNGQ+wrp6H0SdCpjFntv+3kIm7N5W6cvsEa7OFpHLu5ca3KOOIeHG0CwmTzW6vIG94v2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D5GO7RTAT5ZDEIfBLfIbfqEoeigki5EZytlmAnfIjM=;
 b=gc8+XqeyHZ0H03N2iXgnady9/hQxBXts0+N0BXit5U+WTt0B0y8G3A4B0WptrvvOov0okVJqafgnrSYwUGlcLTBfw6QBZ7zrjTXoxtCYBM3JJN6MpoEYYG91u8vp1KgHKTljuJlspVi/EK8dPEOcmoZAzwfvmoji3K8KnI+B0J4=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB5961.namprd21.prod.outlook.com (2603:10b6:806:4ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.7; Tue, 21 Apr
 2026 17:54:31 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9846.007; Tue, 21 Apr 2026
 17:54:31 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>
CC: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
	<niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>,
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
Thread-Topic: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of
 -EIO for FIN
Thread-Index: AQHc0REX4zwzMZcvSE2pP2ozCfc3s7Xo1P2ggAC8fZiAADvZMA==
Date: Tue, 21 Apr 2026 17:54:31 +0000
Message-ID:
 <SA1PR21MB692194241D58B7A499D8E17EBF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416191433.840637-1-decui@microsoft.com>
	<177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
	<SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
	<CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
 <20260421071839.30217a60@kernel.org>
In-Reply-To: <20260421071839.30217a60@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70287403-b32c-484a-b46e-993c8d600645;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-21T17:53:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB5961:EE_
x-ms-office365-filtering-correlation-id: 37929982-5d10-4303-47f0-08de9fcf0a63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 fdYSP6oK+L0erIeUJc/etUAoIB0G/f0KIh8Yjgm9jfq5+5tUqnX0BRkkXu9VT7IDH7eK3naW106uHtkU+dvjjYKQWBbHEknic277kmNmcp3Y/rvzAE46NDHhKwPXfFR0bFy/yRWNAOb5S4QNoVegB7c7hSUbIWjvrDTXtiEUnzqsGFwW0E4dSRf3llY2yy5hATLfRbLhP3A6Ryr8v/DhAn5Odn49nJSbcfSvCLAYZrFukJrBzA22zYtWU56a+YTwCbozk8Cb64I5DKuv9HkH1P7hexEFR+btXfQeG+OAS137ES51WXpAxPBtbixTXozAyRWruRaEMNhG7HlN2q4YvpoM73d1tqPxhJaa+1po5TCBzz7aG0C3m2zuXfYQ+L3ZymmW3c0hNXcXDgdxyojpQZ9VScQ4i37Z/TNnkb1LqX01M54aRxquxv2kANvRn1vEWBw+IJlqYzxX1fa51W2fC7tzZ2xJ/p8JhybdWa7Ir8Q4nljUSjXRQ4F0AjlpAkVCll83qbxMtSufwWsyf1nkIlhlDu4NUQWZlYEJic2twjpsqqwKYxfiP/+UIrkuJRbFzJJJcNgIQZxhdSeOLs3KQBWJLWj7vO+20aopEtEioiLKRtywDXkqWLEYFCZShkhivlae478edX/RVD6j/NKEhJTILJ+GnYqg5eP+TPEbUqmFGbEkRLuFGJKndwfeNInJKD4qNzOENgn/oKIGh9MsUKkDAmXK9ayeZPqfDBixcPG6UXBL0/O0/qb8TOsFbZRv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OtCs3PPzVr25Qc7OgAttO78cz+h5lJd/ZelOAKTneqq4k6SrjNjGwcuai/6d?=
 =?us-ascii?Q?un68qanDcG7wtQHXbG7ZdlNmdnc0/KC57jjfHxktMwSZskVJ7qQwg+2sKFIj?=
 =?us-ascii?Q?ybjTXwgPriCrM2q6hJ3YyuuGJmCc/eKDe7cXAY3jhDpsDFuFEJH5QzRXh9nb?=
 =?us-ascii?Q?kD/8DJth5LI0iXLeKYbR1cGIBVleKJ1icmcGhrCQgirjVvOckX1ju4ziuoF0?=
 =?us-ascii?Q?MtmFJuO3cBhv1roNGOkIngrqC+tqN0TJUT9wOIwpg9JJuUbH9Pio1wWFiSSL?=
 =?us-ascii?Q?+NjjE10l19RT1nmQXj49KX1MjVKsaniRUFWNKCvXrDYpfoXnwQgcFHRTOph6?=
 =?us-ascii?Q?fixJn6cv56PY+Oj3fI+6su8kqt8OTZZnXfmQM77MRAhrmitD4EFYeni/9Crk?=
 =?us-ascii?Q?5lKA3ZE4YbSTu7R0t2AJyVhk8L5ATr2xbL5QVR0kmI258aYgXMbl95bo1Sd9?=
 =?us-ascii?Q?6eGSVH0l6OputFXcGwvql/DOtsQ90K/rMFY91YXMCJNk5zWhYlzvnW6dGoN2?=
 =?us-ascii?Q?q2O+nbCHVm+wtJfRrJxN8H1yGg1bXQkAQ/2kzb0NWKMhTBX3d8oGaeXY/net?=
 =?us-ascii?Q?Acx2vPF3emu+jH6/pLWrAoXxVa4ncSCa5vjO2AHtIMMy96znCG0wHTpiXJE4?=
 =?us-ascii?Q?P80Zov9I79ANqsNyJgfXjOmQ5pXmXtHg/dk/2Fy74BRr+ia/ylgHCuasvI8Y?=
 =?us-ascii?Q?MDiM3QnQ1n3EIrlPrj/OoNjQk+nkW4xsTffOtVe5BLWB7tZ1EwSaQW5T6m+5?=
 =?us-ascii?Q?Mq+oRJBnIM0+ODBTVMi0y7P2ShwqfKTzxbinNme0Fe9CL/8Q3kAQnTY72ECd?=
 =?us-ascii?Q?JKkE5u5KYedtmLE4vBhyV392e7KwUbidEn/oqsbDHxgfzyeEzpmUoqS+4bRx?=
 =?us-ascii?Q?Y8HX6j5d6DK2DLyUX/Uz4oqY6oYpqFPA7lRmCw9fFKzWl9N9V9gwKAdjGicN?=
 =?us-ascii?Q?NeI+IS1xSatWGw8y+/HLouyulfFBQsoR2tbt98Qgd1KBXxbIXUIMD4SnD18e?=
 =?us-ascii?Q?A9hVrrqyHsMWZXSbS8C/Ooj1wQGbQcUG20z9G7o0zT/DJyqUEgtQiyZmlQqT?=
 =?us-ascii?Q?dDAV4caWvZ6xbUE3ctLG/Tv9+xWtgulSjGhDnq33WORXQFj6vlvHhLYJsIAv?=
 =?us-ascii?Q?K8e/wbKofsi1lYI9InQXaiqr+tb2Q70yynmXGX82XNzOroRCX3NFlVDfDPYi?=
 =?us-ascii?Q?8fhakV9AhqjGAroJ5gRS40OwxuHEXuW690LJatDp3EQezzXAaiwPomNuScyV?=
 =?us-ascii?Q?iV2o0vlrBEYyYSTbDfiv5rryvucRZEWL/BfWqm1G+qnSTPsZlFLmpucJGnpK?=
 =?us-ascii?Q?qabMP3xh3mytc9FYNQC2f7pl3ijJu+YYzS34Valqtcnc+lBIdQzBqXL0TUoH?=
 =?us-ascii?Q?D592W84e2AImwAEEvMIHVIMh9ggp9aNFipLiHG9nsgn7bBvNCZ3jL9KJxp0t?=
 =?us-ascii?Q?ZZw8PneGa7PdBj1Hk4Ok1KmVzjGJZY0/bZikFIUfibM/bJ5S/DNnBsjKrCpM?=
 =?us-ascii?Q?PwHdYqDye1gVj8hA7bXhokuUbN563SGgyoMFb2fYfRS7bmJ/uTPT5p/TWtri?=
 =?us-ascii?Q?zmJU5zhqYLdJ5K0f8n4tw+Jc22TnmZ6+rXZpYo6C2fOcA+ANK9ySrEeT/ahQ?=
 =?us-ascii?Q?sFhHb6qo+xUhfZjgidNLJ4WVak1WxcV2CKdWH0tsX5WT9YiTbB4ipcZuyNrN?=
 =?us-ascii?Q?LxE9e90MmC9ZfBEhi3K4pRMcOD9g+dukhu6rdV3kuhUAlJ9Q?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37929982-5d10-4303-47f0-08de9fcf0a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 17:54:31.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nok8AQGkWqrha5CaHfEd0wde12g0EBvXU5oVlO3C4fZo3Ar9B/mXiAiumV4u3EoYWsd8JjZ/Co8PvoU24IY4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB5961
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10286-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdevbpf];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF29343E3D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 21, 2026 7:19 AM
> ...
> > Anyway, let's wait for Jakub's or other net maintainers' suggestions.
>=20
> Yes, you have to post an incremental fix

Thanks for the quick replies! I posted an incremental fix:
https://lore.kernel.org/linux-hyperv/20260421174931.1152238-1-decui@microso=
ft.com/T/#u

