Return-Path: <linux-hyperv+bounces-3082-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C29877BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA691C20C9E
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C6156256;
	Thu, 26 Sep 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ACIByTdg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020133.outbound.protection.outlook.com [52.101.51.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F131D5AAB;
	Thu, 26 Sep 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369162; cv=fail; b=eYElneqNzJ9XutvhypkLvMTtpoq3NNIHFu3oVG47aWS5fQ7dQvhaNEQ0iM0OObPkSZde61aKajE885F2fR6Wbv/eZMyuh/zwiMcGdzpOR8oZZ2eTkRxCRO9L3L+n7e8FW22BsjMyevWtBpHam93uDO1stpuBx+H/2lQFWNw20Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369162; c=relaxed/simple;
	bh=zER4TZg+QJ7TVRdZWRbw6Hl4EhsHpVZjgLpS52jXeW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjflYjADRZ+s41hTtH1FqSCT3ea1pGpi0Z26LEU407gmPIKHJ/2UgTjx07O/iI5tBXLf6x/Rb2uagiyT8+loyi2LJn276J5SkVQWp/zecmURWhzyZESLfqy+s1rMRWNVVqvJS2tqmc9X8cpBFlKEZWc8f0zaS3DGfdui0g2osrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ACIByTdg; arc=fail smtp.client-ip=52.101.51.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRDIU+DcJRyKpY9G23W7HSrPwzTqDOVB/QUHwkhOVj6+fAk8rTr+bcSMNLP8Omw7Ax8oSNI0qYjrRvs+pzy80qt3WLdgaQfJ2GIY7QOu6CN4KLgg759WT5E8OhyDncw0E61hjxrTql6I1rYWManILZ9Z72kxGWQW8UUJz0MqaZFsIy3Zt1kqbKBrSZtYohrCF712Efg1hkEYso57weppAal5MCwb/D2QUZW2UpueHvWwHMhoxW8AYnuD2PpYEV4xI3yXfLuAWl8Ut8ZNVEJg+jRKRwvDfbigcuiuqEAq8ixcIzB+iSwEQCdje8X6c6GfI7ZWX29jh4HCLzaaejrE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zER4TZg+QJ7TVRdZWRbw6Hl4EhsHpVZjgLpS52jXeW4=;
 b=NygLOlNq85QAGaEE7eP4EPqslYtLf6g5hOnRbsnSErmXE0T6vsjVSxe1qxFahCGmnQM3Sq61p4yr/pzTN++rEmPqtCYjOhScHdQICUTI1yUXZw6rEWs/kb54aD1QvyB6CgS9duxCPw2HW9bEuPk0bRChS9rAnEHj/wokARMqGxMhF1W+UbbYyI/CK0K51TEYnvjqM/03LiITudQMJSa2dD4E8yVB8M5ozEBIFB2WMp9VecW8dSppcTxW/wgUgYalE4LZYu5CrP9+50O+/cHU/6wjCoFpVNv9tuCHVQGqQD8lFIcIddbuj5/+qN/zQbfw6Ymd2MLrvvtBIiQH7mEzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zER4TZg+QJ7TVRdZWRbw6Hl4EhsHpVZjgLpS52jXeW4=;
 b=ACIByTdgu4Z+4i75BXOzgnbUTP6bIMmBQPPQKkti3vTN/+XTNP0guGWn7GB6duhJVSJi6Im6xyLPuJkQ6nkzJE4P1acZfHaF1fjJltWwRpVTOr/bq6GzkbG4j8cB8uFcyucpRHmR9JQp3LnUTTpjrCoMeky5LqsLDr3SdATd1Uc=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by MWHPR21MB4407.namprd21.prod.outlook.com (2603:10b6:303:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 16:45:57 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%4]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 16:45:57 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Joe Damato <jdamato@fastly.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Shradha Gupta
	<shradhagupta@microsoft.com>, Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Topic: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Index: AQHbDtyDLnpN2WTv30usPP8o3/gudLJo5syAgAFT1wCAAA5/MA==
Date: Thu, 26 Sep 2024 16:45:56 +0000
Message-ID:
 <MW4PR21MB1859962E8A1DA6E309207EA6CA6A2@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
 <ZvWDZBHdiKLE8S29@LQ3V64L9R2>
In-Reply-To: <ZvWDZBHdiKLE8S29@LQ3V64L9R2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb2d8aa0-236a-4fc6-b88f-6e733b834796;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-26T16:45:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|MWHPR21MB4407:EE_
x-ms-office365-filtering-correlation-id: 3c3ccf08-fbe0-499c-bfd6-08dcde4ab1ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7m1vY7yCn/otf5dKL1cGMbJzVX2lTKDjbsFu36b3DVv+HB/CeYtGYrl2OPMD?=
 =?us-ascii?Q?CF0BfxgcnwqJB9FZk1zqcZ/7OkVl+itPzYV0fc1CBDPdLGq+6j7zhAwJ0tK1?=
 =?us-ascii?Q?Eqeo35lpy196sbL+KKg5q4DqdMy3oxdIihspj/+AmAg0m1JmeR/BhVqY0cH4?=
 =?us-ascii?Q?NxfLfJUgrhg8V6qR82Qt4OWURFT91WlcY2r1ZxRKG/qFFefL32p2IkV9gEaw?=
 =?us-ascii?Q?08SwkhGztFxkwEoeTsnPy/eV5jiyA8Vvv+G88Nj2zTyV6asNl3KHFZyUKurK?=
 =?us-ascii?Q?3eKFbJcv5ztg19sJ+HazW3LrK70Adf4+4niIR2sH7FRpaJEaRRHp8SI8DDVb?=
 =?us-ascii?Q?tuSulaGIDvW46FDW3Iaif1h0ccDasqR2kOFsp9D6GweMgyT/SAZl4OggFqmw?=
 =?us-ascii?Q?C+zQTepVnUx6Y5fWWHZ2xXHkxyAuiFUilCArvL3yMas5AFptPAkGPUddc9+J?=
 =?us-ascii?Q?9NTBwF1mXAqfWkUEY1Q83rEPT8cFJHv8UkccY6Olb9xXGQex7R3HnlYwm2qj?=
 =?us-ascii?Q?txy+GJHDa4NVevJn/7LeOeQnBnSCFuUOy+5Eapp8Z4uKrT+t87nag08ZrNnA?=
 =?us-ascii?Q?lW4VcZtPCZbM+Fu2VYGwlQfjWiMWhe/tGgm/AL1Tr1yRRicyWztU2a+Ni7Oi?=
 =?us-ascii?Q?APaZxSadfcrGtsZLfWlY4vzVBZKR927GCSUkUhC5t/rYkHFd/nMlYvVFIIlr?=
 =?us-ascii?Q?oGn7MVVC9i9TpHk/14leG9pFOsTnkzm95bk3kxYMwShlhZFVL6SCNOsEFj81?=
 =?us-ascii?Q?LB7AOzxjdf+8JbgQVgAmc11oP8BYwWgkgZNj8/f8Rk1wDhWOZQdZGImI28cd?=
 =?us-ascii?Q?kimYX5humjMlGZRJs6mzdiudxHDd2JTv8nT4+fcBSOjRz4g75hRScE6prUpT?=
 =?us-ascii?Q?Gt7P3CQ75X5tee7PIli+/tqntHqtzYqOJgvuffJvVsCGB5cO20si7EvUHS5H?=
 =?us-ascii?Q?PuXSkFOzEq8DwPOnmg35Apv9LqZq+qUdndTVZATr2mkvGtlQXMMIPBnvWshN?=
 =?us-ascii?Q?FPvMQX8jyd8Ll4+mZQGRuZxlKIID6lWp+BFunZeLq3llqxrWcpaWDX+l0sx7?=
 =?us-ascii?Q?GqwkaDp5XBJV/xZCAOjYwA7bY/O5tbfMb9FHSwiEoPbKRNiBYT7RjmbFIALW?=
 =?us-ascii?Q?E7RZDwuxqevCGyZGre5J0NGP2typ2tm907+DJcWhUFwSkvrKeV6k+4Z6Aygm?=
 =?us-ascii?Q?WB0KTokcM7dSa+kHB8q6+5kb1cvLGKC2eZhQihtvTPXaCkEUfhRse7VUl1TU?=
 =?us-ascii?Q?UbPJGeK5Cf1mSua2zAMvScEif+4ciAQqlCTXAPd+NwoqHd3X2+vffZmNA6uZ?=
 =?us-ascii?Q?rF9Iv0Ekik0YOA6ZxZtwxmJoG5RBr8DXLNCjpjYb9hVZ6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cXp2kO1dvjftPHHyDpDaRXsiDZKn03j1fpipy8NVkA95J3lKjnUDeqBivaT4?=
 =?us-ascii?Q?8RQE04nXqbY4vwycq1KjGJLPzXKaHnb7jTEcFS3DCq67N3Z/AIbHXoRYb8hs?=
 =?us-ascii?Q?/NtxDXJhhONOzsSaTGa69mfnOlNeghzh4ZUWZi04bFufrYdK0U1edlbETKpd?=
 =?us-ascii?Q?I0cC8+9q4QN+WL8kCo8FozTysSrg/GXdhiiPh/L1TG8ohVMsXDR8pDicLqnE?=
 =?us-ascii?Q?tG8qy0r5UBKgmpukT1dITi0GaSFDdYzEk+Oc5r92GTSj/nc8iHBauvAiQa3p?=
 =?us-ascii?Q?/KsfLtpNTlophC5Et9+Xw8VtVBeAuu36GbbwxGq8u2pxOcLJ6kljhYK3yl/t?=
 =?us-ascii?Q?/EMSN/Zfa0dkHr2KRDq8sndIhgaix41pmbg0LNRxEAXuJQR1mzMhh0NW4ZQf?=
 =?us-ascii?Q?M2e8XGFyrH0AqPKwrLmR2EYYIAczPeAZIstOmXu07Q6Jygb3psFNfqWlRp8O?=
 =?us-ascii?Q?wzKKN0yskCh1Iyabzvl8iDdeJufA84RjA3kvSVTCi5usMv0Eqnub03wtD9IN?=
 =?us-ascii?Q?JHKnEyCOCFWc7yInXpm6/ciDqJ9AsRESowHBwXNA9wh4fCzbndiNo+biM9uY?=
 =?us-ascii?Q?Te6jD/yn7P5lEZPwW1n/o3dD+N5vmdqn/zTm7OhRiSMgQ1YjMCW/hA2cznVC?=
 =?us-ascii?Q?SZWarrsma1syoBzjINbMI4VShaEZVgYz6jWzRDH1HHDkpNwgQA+hKrA3S4V8?=
 =?us-ascii?Q?kMzMraHddOul0RojVjU2M/U5/rDpza0yuR1y0Qk6PtZPNFZdpGiheeoz3+rt?=
 =?us-ascii?Q?fPPLF/Am9edugkSwivZMQHVwo7AIu8bP9jisFwsQDtDCvjE+WDAbTuy+jL11?=
 =?us-ascii?Q?W2ZIg8n2XwuirDJ7+IU50VDCcVoRrXkcVXy5o4xHD8N9QcQh32AJzuOFb4Ne?=
 =?us-ascii?Q?dKR8Cb9C2W85cstfOaW+pEifkGIGmrGlNiAp8oL88RyiDhDJVXfU9NPYr7B6?=
 =?us-ascii?Q?nOS3q0Ihx8k1TuzW1bn8CnTfdz4NeI3PVLtkRy2wPMP/bVjR4EWc2GtJ+c3t?=
 =?us-ascii?Q?peGqILeYz/RVbn0lctqmzLvmIdXokF6BAHLsgeSCVBPBlJXCHSTwVK7wnfxp?=
 =?us-ascii?Q?1KLoKbonmx0VYWB0ljyAY9mha3t+V/Q3vxiyQE69KnJ04qjFAp6XmreG/NZc?=
 =?us-ascii?Q?NmjluwI8vXYGYhGrR5eVgle+os8fAYhmIZsf6hdl9X2RW2WBb/HJkB/dOGrm?=
 =?us-ascii?Q?m+QGNrOCgFThGXG3Nb6/i7LYfL+S0dlKwcv+TUuAHgbO/L16pB5m1vWbjDtM?=
 =?us-ascii?Q?45kASO84/J7JMYyPRTiI0gTNYbKwemx/6NkESaOQyFB6gR4uMKz1A/cg1Qhg?=
 =?us-ascii?Q?9/OidR3vxvPxrBzoMT7xE3FKS0E093GZlLFE92kAVjlzd7C3ZYiLRv4pxQ0W?=
 =?us-ascii?Q?2PDUbwhKWXJZxGgucll3hX8TRMzR0W/gIkdeq8YBITfsRayyxZfmoRAsCfCw?=
 =?us-ascii?Q?ZbB/ZAYhnh+gwR1UfTBvBiDvWCYg5Gklu90UKYN6ph4Z71limkSOFNRAD5CT?=
 =?us-ascii?Q?Slc1vFEgg0ivJn85BLntzAPM7J8qsGQ4ztDWA41OctOoxDMf4fVqoqrEx1pd?=
 =?us-ascii?Q?2u+3oXti9OFtYApYP/8KBJaxc1+bJlj6SWpv7MGU?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3ccf08-fbe0-499c-bfd6-08dcde4ab1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 16:45:56.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyj2/TvCZ+ki2ibyif/SS2EzZnfBP5EzWK4w7B2jGoyTCHp0qLuVZsjeIgjClIykOcl4ol3a/aT89FFY9E8OKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB4407



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Thursday, September 26, 2024 11:53 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: netdev@vger.kernel.org; Shradha Gupta <shradhagupta@microsoft.com>;
> Erni Sri Satya Vennela <ernis@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric Dumaze=
t
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; open list:Hyper-V/Azure CORE AND DRIVERS <linux-
> hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
>=20
> On Wed, Sep 25, 2024 at 07:39:03PM +0000, Haiyang Zhang wrote:
> >
>=20
> [...]
>=20
> > The code change looks fine to me.
> > @Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test
> this?
>=20
> Haiyang, would you like me to include an acked-by or reviewed-by
> from you for this patch when I send it when net-next reopens?
Yes, you can add my reviewed-by.

Thanks,
- Haiyang

