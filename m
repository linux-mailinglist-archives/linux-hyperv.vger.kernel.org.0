Return-Path: <linux-hyperv+bounces-7614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88DC618AE
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21AF4E16DE
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80F30DD1F;
	Sun, 16 Nov 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CPUnZzwP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023100.outbound.protection.outlook.com [40.107.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87F30B519;
	Sun, 16 Nov 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763310970; cv=fail; b=KrzXHXPYx5DMkw6QsQpk8tQfzrte5TyuyvlJB70FrxztQH0U8XhWu6AHbd22wA1cDHBwKB2lVWFetZxrUMb76lIRlapVJehjYxuYaocU+5h2LCkskf5ssHff1YMqFp6gLE87XWNiKEGJY+q4JLEyzTpXmdZPBXH8B/Qohfd2cuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763310970; c=relaxed/simple;
	bh=y67f5uYjhuTuWCfCuGPJ8wb074EDsVrIz3DkIQKi6B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gU1EUuZB8masW4o9K81ohN6Q7gRbkQgmTaAy0bCIztU2vPb8dYDnLC1xA4OtIV6scRAuANvmlihE2kkVV6yNzw64xFj1ObAp3Df95dfp+yXPSf+qq2328BPGt60IyJOLBOnQZJUbo1elLTwOPAM+rw2wY9krxBoNNcmSF20I0NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CPUnZzwP; arc=fail smtp.client-ip=40.107.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAwtfz73+s6IejMNL+8MuNL2GkdkUdqdDgdt0kFOUtMnt5A3LsfPuc7Ig5AcZcKOs/z+GGyehQRL1kpkpSjQq5Gn++ClgC0eumqVcGLoL3z828XieMxA0ex0z/C+V8EYm9MKOKMgVk7dkIS+knFPFdQyiDJeJ0bV1LG2Dvs/4CXS98fGwBZv5ZfDOWY4tdfZpQBJsOLiEoUeBBs0o0ZNxtpRT41WKTzNTffMSiqapgLwEDsaowzNaaGYv38Xx3bGgAbPrjF+sbAsYCQJxcjF6IkkvGCwallmeyYcRMgc45qFZL1AjqHNz3u/PsuFyOZ+IrXS9EOb0lBtTiaTlEc+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vsMMOH/eJMU1/YDcfjYSuEtWjLbPpn8LxfPsm29a9Q=;
 b=BqEd9eN8SsD/Hth2HwAoJYptBPy0XqKxyROzWqFgH5cHSee97bYCYNUA/k/wXkCVVuRhX+pyeXbZgSlxjdVm6XX4GeXPrS0dKwgmdO8Q7DH6oohKCFiQ0Y0NcP7YxAuXzjOgbQPkLFeq2lafVppBUagioEiqvAZ/AYQ/xmzOqN2IJ3gvxcloURW6k6W1EThkNsL40iuSvd9sglw/vP4CUvgUXbSwy+pS2fbGU2y2titDdkXsF6Y7SgfmDj8cRBTto2yq285+QC+bWSHhpREWUzffMbwQGSWLY6H6ySXrJYpXBin6Hyh0peRwWp98v51VjvaamXzcMf797c8PqjVZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vsMMOH/eJMU1/YDcfjYSuEtWjLbPpn8LxfPsm29a9Q=;
 b=CPUnZzwPUUNhR6dLasBJoFxU0/7mYTrFYiZ6IZe3rxdoL/rZ7sMaGt3huxrivxgFv9/X1JQM7rF36jGEjarXav+/JVjkJ0ggqTw0gZaJM2sWPGlvi3eEy9mgI7r/y+5jELo2TrqxMayCUiyfgifhoQhBQxZUGE7nCNxFX5AWPE0=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by DS0PR21MB6264.namprd21.prod.outlook.com (2603:10b6:8:2f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.7; Sun, 16 Nov
 2025 16:36:03 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Sun, 16 Nov 2025
 16:36:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "longli@linux.microsoft.com" <longli@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [patch net-next] net: mana: Handle hardware reset events when
 probing the device
Thread-Topic: [patch net-next] net: mana: Handle hardware reset events when
 probing the device
Thread-Index: AQHcVdeZn1ZwFr7axUafLZH5t/R3ebT1fGLQ
Date: Sun, 16 Nov 2025 16:36:02 +0000
Message-ID:
 <SA3PR21MB3867695C1B6C975ADFDE635BCAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763173729-28430-1-git-send-email-longli@linux.microsoft.com>
In-Reply-To: <1763173729-28430-1-git-send-email-longli@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e9f0834-7ceb-4fc9-9067-2b03ca083e03;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T16:14:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|DS0PR21MB6264:EE_
x-ms-office365-filtering-correlation-id: de26e9cf-38c6-46d3-6144-08de252e3b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uHu7H68lWVu09yOWo1zZ3vMsfK2/YOjWUb8I3Qhr8SyKavsLal0DlbOYhC4R?=
 =?us-ascii?Q?n+sCAMvzwsaWw7Mj4BWGjvDRq4P+9HH9VfKMKrYSV9nXxBf/VFDa3pRSl8js?=
 =?us-ascii?Q?gowgQO2THiNNFpW3n2ZUJM9NUDOOtZZ29geK6SBTHdNKSPvSZ/rD2nSjekmS?=
 =?us-ascii?Q?z2hyYr6D7Mrd/o5oXeBNn6zVM9KtOr6oC+Sblf7Vxg1pm8hSsB4tGo54tzAa?=
 =?us-ascii?Q?jAEJ1TquotnMICafQAVluIumGx84stu2mDG5eMwn84pD4c594HWBXl71Mw+M?=
 =?us-ascii?Q?u3aSvzvjRYcnkk4Lue1Ne8yut1lvWg4mz3lV4UktIjCWV6EV+m2vbfHOhxFz?=
 =?us-ascii?Q?+3OV3g2pI77mDVvHupjUyKbKElEgvIeLBQ9FDufivEOX20wCIrxmVkyS4Q/b?=
 =?us-ascii?Q?bUip1UN2It0Q/N+cXDCf+bV11MtgR1xNXvuDfOKiUEYP2I6ob21Bu1w/FA6d?=
 =?us-ascii?Q?3G8KQnO7lp/GOQSytPc4N1XcT81kIGYwD6IerOQ5UD0yTFD/EeK0YNzD3lB1?=
 =?us-ascii?Q?23CY3QNadudR8zD+cdnLsFR1PS7WrFhHkErfQUYnbrIr/ncKEDOHInqPb8/3?=
 =?us-ascii?Q?pVbeCYizcBVMWrpQjSGm0FGMkCX0USGoK/PZLMTcFaT4+PTtOI7riW5Digc5?=
 =?us-ascii?Q?7sErCw/UPS9LDYMIvSad2mdqSKLQRl+zBZKWUsLL7BCzOUkwLSVsOdWopW76?=
 =?us-ascii?Q?EJWnqn8G+8YgKeruiPCOzfwt3t8Om8bW4PjmJd6d5n2zq+COsGUf5C/DPu71?=
 =?us-ascii?Q?lC/mElN8iXzvp5M0qlpUv6r7bvqwqLLhLhw5B2F5T3MEf1ye3OKSfl/GuHx0?=
 =?us-ascii?Q?RXnB95knumeAoJQH5Uad72EYx9CWR8QmGjV3xgsWiFshx1tkOHocam9jNu4h?=
 =?us-ascii?Q?cBunwgE3Ll+LoXNRVvpam6ZPiOpdkmwJX/Y8QBGGbtVH25QM5110yZ9YKa0E?=
 =?us-ascii?Q?wuldqoJFamupNUxVPMi+pMo5f6znGVAqtKmRmczVV6b0J6lgT49zk5Fpz6ut?=
 =?us-ascii?Q?+VwXNO0oMbm3rBiCEP7iMn5tJTE+hErxaPlHwZ/Z18p3S7rgdHrP+KvJ3KL0?=
 =?us-ascii?Q?34magsOltfVmPYDDjNUk0Yv71yMF6+/xpY9nZcpOP5VsAAGU7dcF4cJ3fdKC?=
 =?us-ascii?Q?pRGu50G9xraMIQjoPPDGPdci9FqTIQch41HEtgGn89ggClC60suKONAMEybl?=
 =?us-ascii?Q?BQ+HyvLYIiAy6Dy8mxsu+U/X+vMXczDICDd8p9g1cb8r1f/fKGD0EGNKujmv?=
 =?us-ascii?Q?wBWGy5fRuHi+NkwNf1/jI17hf4FD+G5CRzstj2+jROgFwrRPbqZDzFDpyICY?=
 =?us-ascii?Q?mCS8f1pSikSmbqA7weVTsAOifMgFL7UNGn+u+LEA/neJHH/WdT3ep/55JXzI?=
 =?us-ascii?Q?+0yHwwDuI8QR/w8moKRhZ65x0afmG4ppOpeVA57nKdqxvHaG/GBGlbiVeC5b?=
 =?us-ascii?Q?SCD/dpVxRNJFaO4z8MDjdhinEltx4zv+WFjVq9RKpRot69As8AxGOU494aYz?=
 =?us-ascii?Q?akXqJgU9QeMc/1eG7v0fLQykM/WkglHAh2g3rpg4gexM8uQj+tiuyjkEDA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qbYoPwHh1dRAKLFHI5bU+Qk7lfUYvmDHeLkKajDtlKMJgMK0RHujyUcYWNJz?=
 =?us-ascii?Q?u8mgnjH9EVCyKvb9OAds23oUMh+CcIIwMJObI7LRz+D5Jb3EOmADerkLzJ5i?=
 =?us-ascii?Q?J4mcqHgE16rpGuWStzQFQRe+v8nl24h2DnjS2qdTXCsTYWSCzcqKeTKC/OJc?=
 =?us-ascii?Q?vlKj9DTMIzeA+iaFCf0tw6zLspR9E/3xPvef/EtJWym6YwVLWRMpOeSZSaQZ?=
 =?us-ascii?Q?c07Rq+5vxOJSRQFcECO0PTcU4uywolS0vNMadUvl9J0KOkhPPCnzkTBGlWa4?=
 =?us-ascii?Q?SFMSmsGcVcNVZ8U9Qk+9iacUzDkx28YknCFjQGG+5twfuTFrXTzdv2uyo4sN?=
 =?us-ascii?Q?P+WeSKc8058OMTTwXRWnX2A+SuEaPpUongYLTAu9aS633lW3jWQ5HhazuSZE?=
 =?us-ascii?Q?Gpd0XeDMhNaURr1PjZEwyV3DXQJ8PD3vEOKnOcKTVknByhIhFx5caf3AfDaj?=
 =?us-ascii?Q?xG0X+aYyb4bsCf7lNQM84TtwBzdCWd86r2MHco/EIR70ltNJjuXWf5ZCm0/u?=
 =?us-ascii?Q?yYujtz0G11KecxTroXdYCb7mN+N8rZpQyBpxxEnvhyszEsOAj/B2uxxAJG0m?=
 =?us-ascii?Q?AOjkCsJucx6SNmmEQFOnzIeNZozWq4tJ7SQeZVakhgvpSXW5/ZsOBNiVxuON?=
 =?us-ascii?Q?U9lrSiptk54kcyRrAKwJjXkG99ZDybG910+ScKDkdxuTN2HsxtpuTjyAyEmL?=
 =?us-ascii?Q?xdE6P5dYiLoA13iNgUovxFdnIYEfZz0QeJo+1G8lv9Dr3wftHq724Hwt3WTD?=
 =?us-ascii?Q?eHHcB4ITgodXN2Udqsj1e6vCG8pqk566xPkgSUJUsj4Nvt21R0DokQzuXi6F?=
 =?us-ascii?Q?cfILGJD4Ho7kvbXVCVX4/DDD0IhQRBYO7HdKMuC6iZMASP+SS/i5YvmmQiQc?=
 =?us-ascii?Q?k2A9NRa/smTDhQ9RUuCgA+fpVE7x+cZH1RuV5ANgc+MuGcPYCgWsLOcRol+4?=
 =?us-ascii?Q?JwAjWGOSnARLAjj7uxz+6ER+3IGiVq5wkFH6yYmtAAV+6cJN/N+KfgxeF+Ni?=
 =?us-ascii?Q?DYKco2hyIiuJCjfDBerLCDOF3Dr09nZ2eZMlh0z5DsErlEQeiTBdNJ2FfESF?=
 =?us-ascii?Q?8PoSzoyRF3HVuqS9Kda3wwgs/AxVYqxV9ap516qKsx6InByUmWYkm5u3dY6z?=
 =?us-ascii?Q?2yRx3tLq8zImWUtx3w7bbMUNS1jFmYrIOG1FxhUE/r5HrTsX5fKs3DVHcQQn?=
 =?us-ascii?Q?pMmW11fEuiPQNe25BYwqQJ2qL+MsJX/mnCCTBFM0+PD82nCQZ2DZI+aadkwD?=
 =?us-ascii?Q?jEUGTtSSgwEEp78wqGqDDOWb6QgBUC+oO3q8syCBYnh+MJbwhFhKpDy1y02+?=
 =?us-ascii?Q?cVG76qpzlC00LGcmJ4y8NviGpcmDIUy/+OfWx7brcBn0xgYWuVFdYe9Bm5tW?=
 =?us-ascii?Q?rykfYsBO1Q1eui63kEIr+1Nlj2iql/s/epSJFtaOil7mU6V89mmmSSBP/Ffj?=
 =?us-ascii?Q?IuDyIBkSWwcpKoDxNdhdoT70RG81IUBee233woWSnzrmTLboN+h9NGNEGG26?=
 =?us-ascii?Q?ceJp4Z3M/+zsTN3bw0KLljfTC18JMK41hclpaRo7IKQe6PPl2i0V979jimU3?=
 =?us-ascii?Q?xPtZz3iZQvSJB+agSLQ6ClCwpGjg+1tyrwgVXlaN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de26e9cf-38c6-46d3-6144-08de252e3b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 16:36:02.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdqhhdyRXDOBBjP0ZnMGtL5vry9UWqPotQoM7/G7quotgaJ4TyjYvb9OorZLUHYg7Ajvdk2H+iK0yyJMcofBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6264



> -----Original Message-----
> From: longli@linux.microsoft.com <longli@linux.microsoft.com>
> Sent: Friday, November 14, 2025 9:29 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric Dumaze=
t
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Shradha Gupta <shradhagupta@linux.microsoft.com>;
> Simon Horman <horms@kernel.org>; Konstantin Taranov
> <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [patch net-next] net: mana: Handle hardware reset events when
> probing the device
>=20
> From: Long Li <longli@microsoft.com>
>=20
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
>=20
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 131 +++++++++++++++---
>  include/net/mana/gdma.h                       |   9 +-
>  2 files changed, 122 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index effe0a2f207a..1d9c2beb22b2 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -15,6 +15,12 @@
>=20
>  struct dentry *mana_debugfs_root;
>=20
> +static struct mana_serv_delayed_work {
> +	struct delayed_work work;
> +	struct pci_dev *pdev;
> +	enum gdma_eqe_type type;
> +} mns_delayed_wk;
> +
>  static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
>  {
>  	return readl(g->bar0_va + offset);
> @@ -387,6 +393,25 @@ EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
>=20
>  #define MANA_SERVICE_PERIOD 10
>=20
> +static void mana_serv_rescan(struct pci_dev *pdev)
> +{
> +	struct pci_bus *parent;
> +
> +	pci_lock_rescan_remove();
> +
> +	parent =3D pdev->bus;
> +	if (!parent) {
> +		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> +		goto out;
> +	}
> +
> +	pci_stop_and_remove_bus_device(pdev);
> +	pci_rescan_bus(parent);
> +
> +out:
> +	pci_unlock_rescan_remove();
> +}
> +
>  static void mana_serv_fpga(struct pci_dev *pdev)
>  {
>  	struct pci_bus *bus, *parent;
> @@ -419,9 +444,12 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct hw_channel_context *hwc;
> +	int ret;
>=20
>  	if (!gc) {
> -		dev_err(&pdev->dev, "MANA service: no GC\n");
> +		/* Perform PCI rescan on device if GC is not set up */
> +		dev_err(&pdev->dev, "MANA service: GC not setup,
> rescanning\n");
> +		mana_serv_rescan(pdev);
>  		return;
>  	}
>=20
> @@ -440,9 +468,18 @@ static void mana_serv_reset(struct pci_dev *pdev)
>=20
>  	msleep(MANA_SERVICE_PERIOD * 1000);
>=20
> -	mana_gd_resume(pdev);
> +	ret =3D mana_gd_resume(pdev);
> +	if (ret =3D=3D -ETIMEDOUT || ret =3D=3D -EPROTO) {
> +		/* Perform PCI rescan on device if we failed on HWC */
> +		dev_err(&pdev->dev, "MANA service: resume failed,
> rescanning\n");
> +		mana_serv_rescan(pdev);
> +		goto out;
> +	}
>=20
> -	dev_info(&pdev->dev, "MANA reset cycle completed\n");
> +	if (ret)
> +		dev_info(&pdev->dev, "MANA reset cycle failed err %d\n", ret);
> +	else
> +		dev_info(&pdev->dev, "MANA reset cycle completed\n");
>=20
>  out:
>  	gc->in_service =3D false;
> @@ -454,18 +491,9 @@ struct mana_serv_work {
>  	enum gdma_eqe_type type;
>  };
>=20
> -static void mana_serv_func(struct work_struct *w)
> +static void mana_do_service(enum gdma_eqe_type type, struct pci_dev
> *pdev)
>  {
> -	struct mana_serv_work *mns_wk;
> -	struct pci_dev *pdev;
> -
> -	mns_wk =3D container_of(w, struct mana_serv_work, serv_work);
> -	pdev =3D mns_wk->pdev;
> -
> -	if (!pdev)
> -		goto out;
> -
> -	switch (mns_wk->type) {
> +	switch (type) {
>  	case GDMA_EQE_HWC_FPGA_RECONFIG:
>  		mana_serv_fpga(pdev);
>  		break;
> @@ -475,12 +503,36 @@ static void mana_serv_func(struct work_struct *w)
>  		break;
>=20
>  	default:
> -		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
> -			mns_wk->type);
> +		dev_err(&pdev->dev, "MANA service: unknown type %d\n", type);
>  		break;
>  	}
> +}
> +
> +static void mana_serv_delayed_func(struct work_struct *w)
> +{
> +	struct mana_serv_delayed_work *dwork;
> +	struct pci_dev *pdev;
> +
> +	dwork =3D container_of(w, struct mana_serv_delayed_work, work.work);
> +	pdev =3D dwork->pdev;
> +
> +	if (pdev)
> +		mana_do_service(dwork->type, pdev);
> +
> +	pci_dev_put(pdev);
> +}
> +
> +static void mana_serv_func(struct work_struct *w)
> +{
> +	struct mana_serv_work *mns_wk;
> +	struct pci_dev *pdev;
> +
> +	mns_wk =3D container_of(w, struct mana_serv_work, serv_work);
> +	pdev =3D mns_wk->pdev;
> +
> +	if (pdev)
> +		mana_do_service(mns_wk->type, pdev);
>=20
> -out:
>  	pci_dev_put(pdev);
>  	kfree(mns_wk);
>  	module_put(THIS_MODULE);
> @@ -541,6 +593,17 @@ static void mana_gd_process_eqe(struct gdma_queue
> *eq)
>  	case GDMA_EQE_HWC_RESET_REQUEST:
>  		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
>=20
> +		if (atomic_inc_return(&gc->in_probe) =3D=3D 1) {

Since we don't care about how many times it entered probe/service,
test_and_set_bit() should be sufficient here.

> +			/*
> +			 * Device is in probe and we received an hardware reset
> +			 * event, probe() will detect that "in_probe" has
> +			 * changed and perform service procedure.
> +			 */
> +			dev_info(gc->dev,
> +				 "Service is to be processed in probe\n");
> +			break;
> +		}
> +
>  		if (gc->in_service) {
>  			dev_info(gc->dev, "Already in service\n");
>  			break;
> @@ -1930,6 +1993,8 @@ static int mana_gd_probe(struct pci_dev *pdev, cons=
t
> struct pci_device_id *ent)
>  		gc->mana_pci_debugfs =3D debugfs_create_dir(pci_slot_name(pdev-
> >slot),
>  							  mana_debugfs_root);
>=20
> +	atomic_set(&gc->in_probe, 0);
> +
>  	err =3D mana_gd_setup(pdev);
>  	if (err)
>  		goto unmap_bar;
> @@ -1942,8 +2007,19 @@ static int mana_gd_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	if (err)
>  		goto cleanup_mana;
>=20
> +	/*
> +	 * If a hardware reset event has occurred over HWC during probe,
> +	 * rollback and perform hardware reset procedure.
> +	 */
> +	if (atomic_inc_return(&gc->in_probe) > 1) {
> +		err =3D -EPROTO;
> +		goto cleanup_mana_rdma;
> +	}
> +
>  	return 0;
>=20
> +cleanup_mana_rdma:
> +	mana_rdma_remove(&gc->mana_ib);
>  cleanup_mana:
>  	mana_remove(&gc->mana, false);
>  cleanup_gd:
> @@ -1967,6 +2043,25 @@ static int mana_gd_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  disable_dev:
>  	pci_disable_device(pdev);
>  	dev_err(&pdev->dev, "gdma probe failed: err =3D %d\n", err);
> +
> +	/*
> +	 * Hardware could be in recovery mode and the HWC returns TIMEDOUT
> or
> +	 * EPROTO from mana_gd_setup(), mana_probe() or mana_rdma_probe(),
> or
> +	 * we received a hardware reset event over HWC interrupt. In this
> case,
> +	 * perform the device recovery procedure after MANA_SERVICE_PERIOD
> +	 * seconds.
> +	 */
> +	if (err =3D=3D -ETIMEDOUT || err =3D=3D -EPROTO) {
> +		dev_info(&pdev->dev, "Start MANA recovery mode\n");
> +
> +		mns_delayed_wk.pdev =3D pci_dev_get(pdev);
> +		mns_delayed_wk.type =3D GDMA_EQE_HWC_RESET_REQUEST;
> +
> +		INIT_DELAYED_WORK(&mns_delayed_wk.work,
> mana_serv_delayed_func);

To avoid INIT_DELAYED_WORK potentially multiple times this should be in=20
the mana_driver_init()

> +		schedule_delayed_work(&mns_delayed_wk.work,
> +				      secs_to_jiffies(MANA_SERVICE_PERIOD));
> +	}
> +
>  	return err;
>  }
>=20
> @@ -2084,6 +2179,8 @@ static int __init mana_driver_init(void)
>=20
>  static void __exit mana_driver_exit(void)
>  {
> +	cancel_delayed_work_sync(&mns_delayed_wk.work);

I think we should call disable_delayed_work_sync() to prevent the work
scheduled again after this line.

> +
>  	pci_unregister_driver(&mana_driver);
>=20
>  	debugfs_remove(mana_debugfs_root);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 637f42485dba..1bb4c6ada2b6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -430,6 +430,9 @@ struct gdma_context {
>  	u64 pf_cap_flags1;
>=20
>  	struct workqueue_struct *service_wq;
> +
> +	/* Count how many times we have finished probe or HWC events */
> +	atomic_t		in_probe;
>  };
>=20
>  static inline bool mana_gd_is_mana(struct gdma_dev *gd)
> @@ -592,6 +595,9 @@ enum {
>  #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>  #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
>=20
> +/* Driver can handle hardware reset events during probe */
> +#define GDMA_DRV_CAP_FLAG_1_RECOVER_PROBE BIT(22)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> @@ -601,7 +607,8 @@ enum {
>  	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
>  	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> -	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
> +	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
> +	 GDMA_DRV_CAP_FLAG_1_RECOVER_PROBE)
>=20
>  #define GDMA_DRV_CAP_FLAGS2 0
>=20
> --
> 2.43.0


