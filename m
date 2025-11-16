Return-Path: <linux-hyperv+bounces-7616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DDC61DB4
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7C4E3566DE
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201C27145F;
	Sun, 16 Nov 2025 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F9F55cTQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023143.outbound.protection.outlook.com [40.93.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192526FA4E;
	Sun, 16 Nov 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329465; cv=fail; b=l61wpBgbmo5+jVrE8a8pyd9VAzQTVnj92rJzT0D88woTA8siBgRZ/TyPWUYc/HbL3HMxUV8r1KYvTPRoc1xefDci7bR7STW1rExxtuGZusVDhDHRXubm/WK6gscnccZC9/CH5ouiXPbbnbK2EXTwRv2t3G87BbXZWN6FdlSfdqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329465; c=relaxed/simple;
	bh=fiyu6IyzeqJ35rzFDvbyQvixaXFHT50heDDsA19l06A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FnSf3smw9BGw3Q3gLeHenA7cBZpLHxaik6VvOdmi8F3SZaA4h6GvWuAoSQwv1wKeNxsAcZ3VDIPncsQdPN2o/270zXR0unZfMNr0CxBnSUFKSmjVmTrBGA4lYpP4+ZyK2jwU3wHMOm1dy7UdIzAsYRKkmk6oPYZJiE2JEqgm3RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=F9F55cTQ; arc=fail smtp.client-ip=40.93.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL6xNvkJaq4guJdlB4Ft3JZvDikJOd9IeRQbcMAf1UKldHtQiGwwxdVxLr+FaSFfS1j0vVBKr2h0XKvCDLXN0Ugkm+ZWB6PI1O6NsiD1OVBAqpdZhPgrWXJ5rJjmexJeNTEZFk0LJfodwH3/RdiwYUJ8VdJrT6RGfVp2IZDalqfZtYTUZ5R7TFLCS+ysq6XAf2T++F7v/XUyV0WQ3TZV/ktLC9vxHQrWsgXPnu0EsVq/MviGxWv97DaTfY0ML1zX+4xbxi9AS9ccsjeCxPO+SKarEk6ssn/8i0jYaspp3vWK4v3TPjZMJBaN5lAG5zVv253icuaX4vnoDwqf74yQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiyu6IyzeqJ35rzFDvbyQvixaXFHT50heDDsA19l06A=;
 b=FIokP1O0wNzXCQJE8glGi5qGH5cjSRyrEG4V6cQpS5UL4wsxroYtkcMBxqaMu8LzM0acK41vMk3rQLmvnQbDc1dGawSCmWlK9r5d7fbJxVE5Vin9+2eXGmijxq2dPddcV1+7OQmBw1yMxf/9CNxHdruOt6US088nQxftrDd1/09dCTEeW0HQQXoBPV/uedoKlCNSkG/EDFzpQuSz2s7LYRH5MxiK8N3CXawrhI7J0wTB/CbU0rtOVXg+JFIT/5gxeDc4fA39Qe0FO5XZ6KbNnM2mjV7FrgouN3BmL6Pb94EovEQRl0hN266nai6sWHMYLZtbxszxI9kat973+K1AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiyu6IyzeqJ35rzFDvbyQvixaXFHT50heDDsA19l06A=;
 b=F9F55cTQrMyOfriUNqnBe0qn4Cmeebwsrs+Jcua77SI4u3Ml9eVLGeSASs6aXm21LY6+3wbDxqGoHe1/gnsOZ9JiSjESHvNpZEoEblmET25zTuie40YqECz1yHKeL1wkiGnYL7MS74nfS/KvbhSZoY0k/TXUG+1+L5q/0k+7WEk=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6274.namprd21.prod.outlook.com (2603:10b6:806:4a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.2; Sun, 16 Nov
 2025 21:44:19 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Sun, 16 Nov 2025
 21:44:19 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Aditya Garg <gargaditya@microsoft.com>
Subject: RE: [PATCH net-next v5 2/2] net: mana: Drop TX skb on
 post_work_request failure and unmap resources
Thread-Topic: [PATCH net-next v5 2/2] net: mana: Drop TX skb on
 post_work_request failure and unmap resources
Thread-Index: AQHcVaxiA5ioRl432UyU0o/sTQtLibT12LfQ
Date: Sun, 16 Nov 2025 21:44:19 +0000
Message-ID:
 <SA3PR21MB38671E5A715B3EC2293251F0CAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
 <1763155003-21503-3-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To:
 <1763155003-21503-3-git-send-email-gargaditya@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c85c53b1-3abc-4199-bfa7-7b4109f77e0a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T21:43:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6274:EE_
x-ms-office365-filtering-correlation-id: 345a3df7-c2a0-4b2a-3299-08de25594c17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mo7jEoOZjMhg784nDMGPbG1bpEdXcmmr1LEjqlvCSEydJrZtpIS6Svuz+yDu?=
 =?us-ascii?Q?d0/dRKwfDuJ01dg0NW2WMKa+T1UrmMNrUOFTWel+6I63YrwsqNYpvgNGn/sX?=
 =?us-ascii?Q?YLmvegg4ULvKDGmQMMILy1kHOMUBHNk4cuEiLiiALjDB3BCzbff5GG+ZVm2Q?=
 =?us-ascii?Q?mvFtJGTkaaqLuxKdYORqRupdNptT+vZihH2vfKEiqNPHgdx1SHvA+TUqa94Y?=
 =?us-ascii?Q?QA3mnEghlZOQuURPim0tvvjbaH/0UfTToq2VWpRn5NeLWZarEPUGd0eHSYl1?=
 =?us-ascii?Q?fz0UbiF/n+uAWsh+T2Ed3YEqSsjJzniigKvm7t6fy6HZDjVIWB/VbPhh+W4j?=
 =?us-ascii?Q?3KpBr7h2MDBS6lqH5fmvLpGr/nXohKVCphVc8ulBsRPRAECXyGR8KOzTjZDE?=
 =?us-ascii?Q?y8dzUgF+nKg1QNb9YKZ0MbJp3eMHkGPU3HW7MZFjOI8235r2FMEugAnPb6DV?=
 =?us-ascii?Q?tRDypWxdBv55HG8Q9gQRziz0hXLKNovnPj1P4E6BEzm2yLk8W8bkyjtL2Rzz?=
 =?us-ascii?Q?BcrqD9K+SBBB863+7h7e32tyQQroxmH+F0X/Y8y0vJN7TH8/zNYo1rMQn5Ft?=
 =?us-ascii?Q?JsBtLPrcdlfdvZ1b2lJJDrFFOqSd2PoK5qfbPdDXIaUupiAZl4UwoVf043fB?=
 =?us-ascii?Q?w9G86yC0EEqbluaCl7oOpC5mPbYU0XM6fThyEOWS1ix+eFHVUSCg2QfyBP27?=
 =?us-ascii?Q?BMykErlHxnGn4ZGae083h0VY0y1QkeIj8HDw8nbR0510nngWiK7TEGqq6vS8?=
 =?us-ascii?Q?ulPX5LaOJ8O0hv3IQ8kmM4tKeEDXij0xU9ZtamPE/ZHnVta40PLh8rjXq1ik?=
 =?us-ascii?Q?LiXgGsU8GMkFN6PackxVdvdYUoJp/D93RsVXqxQdLt4B4cxlc2ejpPRxpAer?=
 =?us-ascii?Q?jidNemdBfizl0B+oksxsFtQsrBgLM/pG7jrCrp8YA//Hzc5bo7AV9akmFSnZ?=
 =?us-ascii?Q?o7UOofAFPQ260J9lObXBUR+R+LUJ3/XbxhBFTtIxJvbu0xmjI+Kj5xGoxOL4?=
 =?us-ascii?Q?6QoosO7fab3BYOAkzkMkqJHrpPEPBa0yIjlSactcUwz0faygEOBTLru6WHdx?=
 =?us-ascii?Q?ykVnWXXIduLg01I8RrL42/lvgNwk+jFrqvXzLCXiWP2dHL/w4KEuYU1bn+2w?=
 =?us-ascii?Q?H6AdG6rErmaog6jP+BM/PQEcSZYrU/CjeUitrxF4TZ3YEvATa3cgjBokNCKX?=
 =?us-ascii?Q?o2qthF68otHWzuqhJ5M+qs+yO0jwHATnTgcm0Oeuyk6R8ekG2ZRNsY+D8ooq?=
 =?us-ascii?Q?C6nbp8btftNp7jGyFiETMjGiQVtLr5g+imdmj+uFpeWaAN45dAO8YXJa7aXo?=
 =?us-ascii?Q?6tldjL4/DvCoEzRLjtlknQCFHSr+oI96B1Cfaba3VMMnlDNnAOHHzllbx5XB?=
 =?us-ascii?Q?qXBGB5pJbxxU7p42q2TP9wI7j83+nYwSdn615tmuli7PrMdjFmlbxaMakpn1?=
 =?us-ascii?Q?yedRV89mHePVyXNSWJFrqhpZFKJe7I4u8SkdeBcZBvW9P+g1jiYMpaPyh7PT?=
 =?us-ascii?Q?lh6VPm+c81jwcvDsOC35oHjVkOsleaXX/hUZpc3wmEGfMKGujuZZOCQxYA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XJG20whkOnSf6ZXicKlH8w9oLcCGV8JUy1XNNujBEPd403KTkEv2bwcw/2KO?=
 =?us-ascii?Q?uRcrTr2sECziouMSm/Jv89mbj5NtARm+i+kP/0ABvlouib2HqYUu6pdHDTyy?=
 =?us-ascii?Q?fyu1Qca87hq2IQRAiO+yqy7D+fBsSNr6cJgKcrRI3fkBPeqyuI6MGztYuj9W?=
 =?us-ascii?Q?41NBvhfmusS63y84vZRgGbPu50nQEPhCabo4q81+6FvTReA6MS/zEzWyKMAe?=
 =?us-ascii?Q?b25a3x3cbC/fgEFpVEd5Geq0vKqilTPQQDyoJNJ6x7f6Q50niSo7IdfCuTC9?=
 =?us-ascii?Q?dh4cuFX9PG6G7CMnCAUZJ3At6tybtmArvjVEBwvTBKJUhJ0GAUIaKxhVcRme?=
 =?us-ascii?Q?1+yHCyJgmxxiCqmCv+fRic59/N9mJpDmUV2mHdXLneDJi7fQPDAuaEwwgazJ?=
 =?us-ascii?Q?M6gUn854Suj1iSOQgieUV68kpreCv/BoEeh8CMOXCe3e/Ch9bo6/XHWTUlDD?=
 =?us-ascii?Q?ulUnlPgQozHVZR2lSdHx/ta8pow8t/QqVCS2ifdDlm+fNgm03MOgjtxJJwUF?=
 =?us-ascii?Q?81BtwUPGY5mcThho/zbcK8mFFzQpXztGwmN/UYYx4hk39w32Aq5clBKv1FFl?=
 =?us-ascii?Q?pRXXy+SMY5I7W5Hw2mg3DOa5p2SG8L2Sy+H/X487QoT4WzU9awCXnRRXqIQY?=
 =?us-ascii?Q?eb6Bers35q+VPlIxV+MgWyiYRFMWu4HOpbS9iuyo8NjdqpnJ1PPgW3VTknub?=
 =?us-ascii?Q?V6Io4x/yd6V8IGOf7I2tfN6p8rSdug8lwyN/14EmjJpNFeejW3q0S7ffgExX?=
 =?us-ascii?Q?oefYiv4/Digson9xthZKpbhDsG7xww4qigdTSsy/YqOjgrivdS5bIlujN3zq?=
 =?us-ascii?Q?QdqT8B5IhKiV9ut6fIbGmenwK9AM15N7l/RsqMjWUuZpx/TVId4uLrZzv4Sv?=
 =?us-ascii?Q?CG6385qtwZHP3m1Bjb5pQ5KjxqBwWbzpdT/eoQBTzBzEwPNxyoDyQYhJj2Dq?=
 =?us-ascii?Q?ItZ0LYjgs/48pdneADUp/6PYQDwxvEcu+nZ5LYlR8zve73n12G0lmpgJ570q?=
 =?us-ascii?Q?FDmYs4HMZUq9HaEtuf19xW0qQUfREBUUH38UxoyRz3niGPoEtQfd7c927JKE?=
 =?us-ascii?Q?S78uzdE2YNlXLuKEi2z0pf4AQSeiLzS8z9O3BqiRBNGzadw1eUD6e8XKOd6b?=
 =?us-ascii?Q?BS0Uqvpu9ar4Jb24482anZXUdx60Y2bgYOpHRaoZuWKVzhh8X8gKYlmD69cH?=
 =?us-ascii?Q?N9MkXiwIAGeD/3ooXZsQTC6QhejTdkDiomVyLvSwJp0XLXl7WO/Zy/f2fBzo?=
 =?us-ascii?Q?k/UGHJ/rnuUV5hgTqBSC5B4eWEcUCoOAe4acIPt7kap/t9pGbf3aPew+egzL?=
 =?us-ascii?Q?MSeovK6sYX20CE2B+QhEh93epr8VX5U49bqK08eK8bmVoob61UscvJ4ZoNL4?=
 =?us-ascii?Q?wnAmkHclavcw10hr4wx2c7rDIwBjLvqEfgKzgjrfZolIouK3LaXPYRg86Mv4?=
 =?us-ascii?Q?qoSCiVYQ/YwWfFlDBNI0qngBaxnIb9n7O2HkusMrw1xfTDsHWXG3RFQUVmV2?=
 =?us-ascii?Q?dzjme7jBs5V5pa+L79Hg0SeiLkfiCQ2Y+S+mnG4LeWQcca+U5APV5DpRvVts?=
 =?us-ascii?Q?WPYP8SXZelf4RK/FZQtaUoc5IeBuWsWoOD4F/E/V?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 345a3df7-c2a0-4b2a-3299-08de25594c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 21:44:19.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/daA5qtcknLovn70lJuOPXsGv+BtvHPsq4iWOcMUR3BOeZnxQsLw+RXrZPy2aTH3G1hG/OjQd5CRemvH+dBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6274



> -----Original Message-----
> From: Aditya Garg <gargaditya@linux.microsoft.com>
> Sent: Friday, November 14, 2025 4:17 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> horms@kernel.org; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Shiraz Saleem
> <shirazsaleem@microsoft.com>; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; sbhatta@marvell.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Aditya Garg <gargaditya@microsoft.com>
> Cc: Aditya Garg <gargaditya@linux.microsoft.com>
> Subject: [PATCH net-next v5 2/2] net: mana: Drop TX skb on
> post_work_request failure and unmap resources
>=20
> Drop TX packets when posting the work request fails and ensure DMA
> mappings are always cleaned up.
>=20
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



