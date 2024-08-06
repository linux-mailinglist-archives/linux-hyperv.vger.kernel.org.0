Return-Path: <linux-hyperv+bounces-2731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DA94983C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8551F230B3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21113C8F3;
	Tue,  6 Aug 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D2zJEINw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020113.outbound.protection.outlook.com [52.101.193.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8C83CC7;
	Tue,  6 Aug 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972500; cv=fail; b=M5dNkb3sjMX3fhOeUAhv/qn9bENfihK3Kedrl+82XZgxRW1Rd5bwPYv1+e8hgmxz5DLOI8Rn/v8hneCu6lQOo7aPZYupcr8jANbnp6W/3g1N5+wOpCrIINPH6pkkbDMoFlt/goyO0rwjmLE8sbzP4i8cIcT53UhAuEFJUUx85ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972500; c=relaxed/simple;
	bh=jr5DqbMaXOH8Ft/N5UulJFTQki24YXP2/7pzzhDx3Ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5s7jnboMlCMbtAgcEOwPMWlit59ldNE9gG731rXTkF6k3/cj/q7yJXnE6ObEKuiAhag6Q7uIHhukNpX3px3T1L705y00H2OJe+yLP4ZokI41C1ODfeh660EE8TQ5fkK7mKFmuHd6+rrkbRD0leSCNfBC5fPxHdlTTnOpgummMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D2zJEINw; arc=fail smtp.client-ip=52.101.193.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO7Ek+qAzzH+5C9qNwZScwMKTGMnxk+4v4+fZlmOENpigmr33OqlZ2UyeVZTIguSEQ4Oi83msfl8ayE0BkYgJvQ7FA6qzZb4Thosbuv+AK9sN//LofM51lx6K+vWhkgGM/lcmTCLss2MNuHnGD8A2DGqipnlxnnczexkFj4jplscb8s6Zt+Rl1ofzvANw/Ot0KUNJqy81JNFqmQQeaARbEZZFfMh/KZsTiHJv8V2qN61JnEELpXKlUaQRgHUGHllP6HCU8qKByqOcqFEf65ZecCSdhog6z4oL02iVIs+/5lIU3JVEdaoR122eXLrD7QQOt0FG0BXDSvNsfZ6StKq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQACX2t6M+GHBtvt52JrAMlUhOpmzb4vwcK9Ts4HnTE=;
 b=yLAI5PiHq7x2KnmJ4unCpinrla+tWa7uuCGzuBgM6ALQpFloMkSPaxhDHzkv+3Uw9TAhaMCPZM3aSiYeu01qLWPvBvwxqUU3WuZBosAd9I0R5XnGPGqKKN6jVFEdgAslmyRps5RtPEJfuSNVrQgDvHMqjeDrpPGr3LRZ4r59IYStJFplTD3looBdP6pxMKyyPp9npeRbmrgJoBlXAK6NN4CXrBbPoGSjTpRdj0eDKOH+PkOJ93knUi1aGejdVkTZeeyWmkfUlZxWPyCO3w1b8fFMOzEmAmKWyxSUJsGmih1+hKSnXCuQOyRUmuN+YVLE3zj7L4HK+ocPW2fybjFB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQACX2t6M+GHBtvt52JrAMlUhOpmzb4vwcK9Ts4HnTE=;
 b=D2zJEINwQpfJCgs5YKvICkOldvCaAgjPo3KgsUxXWWQWWaOwmxNPg3Br1AmdN9WdkWvhv7nAqh/i8QvgW8F0QtBkYfC3BUsS6Wzk/buTMaVZaDz7AKD3dgYcqe4X5A9qRxzTyPQDqNhELWxEBsJy8TYKXkiH1AX9SKeXEZIjPXE=
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com (2603:10b6:a03:3f0::13)
 by BY5PR21MB1460.namprd21.prod.outlook.com (2603:10b6:a03:21d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.6; Tue, 6 Aug
 2024 19:28:16 +0000
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::dc0d:bf6d:3ec8:3742]) by SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::dc0d:bf6d:3ec8:3742%6]) with mapi id 15.20.7875.001; Tue, 6 Aug 2024
 19:28:16 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Index: AQHa6DbIU1SxtHhW50+unVG74GtuGA==
Date: Tue, 6 Aug 2024 19:28:15 +0000
Message-ID:
 <SJ0PR21MB1324B5BD9AFCE00B271F198ABFBF2@SJ0PR21MB1324.namprd21.prod.outlook.com>
References: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5173a82d-6447-4e63-9127-5972695b92d9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-06T18:43:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR21MB1324:EE_|BY5PR21MB1460:EE_
x-ms-office365-filtering-correlation-id: bcc566f0-db8a-4ad2-737d-08dcb64deb8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mHEBniwp7Ei2DmwBW12Hn9by1B6VdO7brlRJUKtVotjggjHUTFDf2VAyUEJu?=
 =?us-ascii?Q?DpGrdVwXP+rD7Mf7STrWDxjDGHHhaM94eY9tAF3Rm4cG8tnHBolR+8YsYsZl?=
 =?us-ascii?Q?4DEWr7zmV08oSJXA4xTDQQq+hWYn1pwczxydvhL4VelPyVSanY7txGWbG1uv?=
 =?us-ascii?Q?SA5u04xf3gWwXi9tGCDiuGJILPjXbM2+w1kNavWQtm2PqVvaivxn3eZM91Hj?=
 =?us-ascii?Q?Z3nlD/VzhSx4/atCXTZNEd64bQ9688OL+7+zSkXACZ+L3Ljrg+Itohfo45S9?=
 =?us-ascii?Q?fIWCB7C81mcijOa8F1prXv/3/r9dTZ+DwKOwtXYyYvt0ez25xJK4i64co74l?=
 =?us-ascii?Q?VP4ef0mS98PFGSwmLIhOcLf/CdQGT7jwcMCyM4XjBZAm7CcCGy8xT8rmRodO?=
 =?us-ascii?Q?IG76N/1/AGK2v3VfP4v2zdwbbuCMW7xdNTcc5Vd+wuolpDLRnn2bPjLON3NN?=
 =?us-ascii?Q?+PEWDlufcNtFetmphbeZw+o/Hp6vI2Ea9iZpQpIHpStWiuhcqbjSu/eru2QE?=
 =?us-ascii?Q?HX21tHvTuDJ2Bq8SKxzHWytGmBE5xjrcWy+9iBzP3oMto48LHgdpNM2dE12g?=
 =?us-ascii?Q?LwyKWQU0Q1r7cj8/kJnMgTc7Z3oTSTAczQFLK01OqC9WbMwzJGgNtrHLg2Td?=
 =?us-ascii?Q?8aEEP91HbnJS3NgOqhrCrzHkInpyS6aLadxd6AiOYdSH4j2PybGBq2WzZC+r?=
 =?us-ascii?Q?MzsVOXDGVyZkGhpXKGVwX58PXuo+bbeKwxBV7agJrRRIxNJeVE/8RkEjSK4U?=
 =?us-ascii?Q?y8rjQwSJN5RjotEPL+vvlVIUEFqemDMUSQf7dJ0yQNKHfEk0Qr73qua6KUca?=
 =?us-ascii?Q?JHd+TE8+V5HSynAK3iKt11IGTEIKClWikwro9BkeOphJ5lxdKyN6jxs73hXm?=
 =?us-ascii?Q?TxPr0MZHak4l6pfFkHqmaERIZgMqvU9nL78VwKjrjiiuIJuAq8I7ddyw8FOR?=
 =?us-ascii?Q?6OOC+GYJV1HRk3d+Z5a8sM4pX7vaQUFF5JeZBs9OxF+Z3L2DUBeWg2WXXAQE?=
 =?us-ascii?Q?8X2IcEWbCHD1LyxiOMPwe7Ao6s9TluldcpoFXmM+sAduc3X7aymyI2qEnf0G?=
 =?us-ascii?Q?XGyQgfxorcbGociXQftb4wCOhECjrnRnFyRu2DFx3BN7tk3YBOcf9GQjOgI0?=
 =?us-ascii?Q?a/gAm25N1afiFpPEm/ZB7dr1zc2fxjt99IMwi3wPcCKaV3VKkAmUuHTpdQTU?=
 =?us-ascii?Q?9TaMav+y0wCzYG7+YjpxO2RpQBPyBSlkY1yPc3Jwi4dRKFO4UpJ0INHOXXwF?=
 =?us-ascii?Q?Mx3f/yBgPeu5Kctn7JVegr7yuXnj7UwKM8PzX+v7g7tFVHyTWYHcCq5y2Nyv?=
 =?us-ascii?Q?8Q7mLoX4hB7agY5FnPn2AiRDtUbXfRdoibPVUc2ZIrqJAVKE34MKQwTI77PY?=
 =?us-ascii?Q?c9fLiPdIOI+cFf/kK0A9kzhpIRSBFlMQRuk1hNb0IKyiiLsriECmNcXYtYDG?=
 =?us-ascii?Q?+SovW2kZ+7Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1324.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r9Hm87PIlihQO+43tIM0Wjyv2FoO63GDJcWbrZXdhjZfCLSWtmYpStQqKXoc?=
 =?us-ascii?Q?LVxAc4TpWwPVYEL6AC+EyfRI0otB6vnnpT8dkw2mxd9rNi7W8Jupweclh2+A?=
 =?us-ascii?Q?t5m46ld4B5d0yqtAQN/4IzIO37YdvvUcEBOyq5fDctG3h2vPzG5TxyJuTEew?=
 =?us-ascii?Q?hyRG4LcPL5snFU01y7aMP9ZHcNctA1sccD9FRTD9mHKHcglmJq1HQyzwQjE1?=
 =?us-ascii?Q?m5dA/Pd+ncVkboDMMQJSw10M8kgtM91VE0Hz44/GTJa7TsvxtZpPXXC/H2ca?=
 =?us-ascii?Q?mJbPjMmhmR5xpVrxwlNo7j8tV+gveeIuBSNKdglFwTsGMYvAZGxlHJIxED8H?=
 =?us-ascii?Q?RDK4P095SBfqNYT9T5xHd007ZJLzNlERxQAvKCJRFFvCZYAT+ZkTQWQinDTy?=
 =?us-ascii?Q?aZVxqIVx7AC+puhP2jKIVTaSdX23+ucQ8av1R0ekV/L9ukoWfaJL4EF8BN1z?=
 =?us-ascii?Q?rT4FD5AjdnQOSuH01ipOhzgBUPl43y6l1LpKkkVC16eMh0KR7Juz5BLoAa0J?=
 =?us-ascii?Q?r5ZSz7oDM6ZkMWQmlLoakpzwccPKTjdmC+HOs4cCBaH7FBh+NN2aGV3Jp8A7?=
 =?us-ascii?Q?09VJ0N5MCFL9LcGBZh60ZWums08HoS61m24YhM0zV3H5DK7gm7VmzpaJ0Ybw?=
 =?us-ascii?Q?qG5FuHN6Mz2Q9AaBAJguGrv43sntDadXRt8t+QyW0sRYl+/yweHHduFfzrAA?=
 =?us-ascii?Q?/VOVf0Xr0iuPoHgO7bf1J8giWNZfn7dbc3tWLuyDfFpqyoAcEHyzF1ZpUGsD?=
 =?us-ascii?Q?PX+r9RPg926bywNHZgH5ebJkPkuClbe81MRYZ3xR92KYL4madeGOfmQa8/eV?=
 =?us-ascii?Q?GtIZ6PeDNestoJUCuIWJrtWyHbH57a0HzsKsgcTeF5ZIcBy5FBFqZR6bhc1K?=
 =?us-ascii?Q?szgW1eqEPSXh4vdbAzvcDEfNMh9PybgVSXR5XKclnDQygGpQx0GQ+iM6pF5i?=
 =?us-ascii?Q?iJp4QgxfIwLtXd53pm3D0eN62w5bCLPWOJ9qVOOg6A5PCf4hA6UdPXmku3eH?=
 =?us-ascii?Q?dCmS+vYwyFcAuT09gFDOv60ddcB+uDkL6yuJaU9Q09Va15pDffztiS0vt365?=
 =?us-ascii?Q?aXP0AP59G0f69ZeAhAhbUTImbCE/6ExRNZSWoV7wuUsNX1byfiJtBK/s9Djj?=
 =?us-ascii?Q?teXOJOPuap6aY3EoMOvz+cNfvT2vs2REO0UDhre7GUO3jI+I4rEqClQbUhFA?=
 =?us-ascii?Q?rS1kgUXsf5ArWjpdXcW3ro+EQbPvmQXCMCEdEraU9ECgv05V1u4H+VzYmU9R?=
 =?us-ascii?Q?X3hJ9zhDaaL6KwhPnssP89xP78/YWc/05sxyVQn5xZ9ikl0Wmtq2xPrAurJ3?=
 =?us-ascii?Q?QWBdTzQezHNqVns4JJd9LWHKDKLATb/y64XpBYnxyZdsDSrTWyEqFU5zyuof?=
 =?us-ascii?Q?494X0pr8YMjHYP479l+LFSQ+7gvoWbe+hDD6AIXCySlp1THSTNViLnL6Lik2?=
 =?us-ascii?Q?GNB4ur7rf1Bm4Nosxm9abQpNvU78roqzarCz3BxyrA1cuRWqYlk1LkAtH8YG?=
 =?us-ascii?Q?feWwg0vEPC4FQiDTDBEPcSwTT8KeqqJP3RIz583uNgxEBEoENR1NRdLNZ8VZ?=
 =?us-ascii?Q?zyVg+rt8O7tCcQJN2qo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1324.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc566f0-db8a-4ad2-737d-08dcb64deb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 19:28:16.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVnnQshjYMVMCn2MXAVlWQFmIq+kRQCTsJ/fDLA59SSKK+9zEMjoPnpu6MEosZTHEDNPoKJs10MjfcRQ5NSilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1460

> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Monday, August 5, 2024 4:38 PM
> [...]
> After napi_complete_done() is called, another NAPI may be running on
> another CPU and ring the doorbell before the current CPU does. When

Can you please share more details about "another NAPI"? Is it about busy_po=
ll?

> combined with unnecessary rings when there is no need to ARM the CQ, this
> triggers error paths in the hardware.
>
> Fix this by always ring the doorbell in sequence and avoid unnecessary
> rings.

I'm not sure what "error paths in the hardware" means. It's better to descr=
ibe
the user-visible consequence.

Maybe this is clearer:

When there is no need to arm the CQ from NAPI's perspective, the driver mus=
t
not combine "too many" arming operations due to a MANA hardware requirement=
:
the driver must ring the doorbell at least once within every 8 wraparounds =
of the CQ,
otherwise "XXX" would happen. //Dexuan: I don't know what the "XXX" is

Add a per-CQ counter cq->work_done_since_doorbell, and make sure the CQ is
armed within 4 wraparounds of the CQ. //Dexuan: why not 8 or 7?

=20
> +	if (w < cq->budget) {
> +		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> +		cq->work_done_since_doorbell =3D 0;
> +		napi_complete_done(&cq->napi, w);
> +	} else if (cq->work_done_since_doorbell >
> +		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
> +		/* MANA hardware requires at least one doorbell ring every 8
s/ring every 8/arming within every 8/ ?

> +		 * wraparounds of CQ even there is no need to ARM. This
> driver

s/ARM/arming/ ?
s/even/even if/ ?

Thanks,
Dexuan

