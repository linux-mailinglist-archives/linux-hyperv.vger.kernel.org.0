Return-Path: <linux-hyperv+bounces-7373-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2102C1AB0E
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C465188AE12
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE7299A94;
	Wed, 29 Oct 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sy+pTrBs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022080.outbound.protection.outlook.com [52.101.53.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EE290DBB;
	Wed, 29 Oct 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744054; cv=fail; b=dpZgYH+tOsNe2J8oal9TSNXNJOWauHJ0BePfUIBqV44qYokbX+e5idN4AgefDJ2YwWUoIXrP5oXepVA97egkNmOjkt3idfRw1NtkmlTI+7sS/LIN/9HYMACOraldTnj7Lqh4CBr9LZPnQaFc1tYNFLVpvsA8YJJxggp4oSLndPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744054; c=relaxed/simple;
	bh=5mludImsH+3mcajCnhfy+agizZ261CVunhIzAbixXIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AH9LfeNosXNSZPme6z4bP+CfU0hv4SpqAG2bZmqdzHjsczT/es/J3GBGU0BkDWFfqjPRWZxU6b49t63C5cjUgjPu2jiSHrilUElMR/thTEsRoP/JtkgLtBvDCtY/wbNtLmbd9FXtOrx/F6b6IdqYDRMFeIUvcZa8FtMyeavKNao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Sy+pTrBs; arc=fail smtp.client-ip=52.101.53.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJVpzy5csoFOeLfZBteBi8wFSNYTwT4wUvSmf6QvffMDLosU8xfEl4CxTNmNEubXRWyHGzOBKNehRl0Pd5W5UCN6kOumcPLZXZsfY7CMMc5IALGGl3zGnC01DXRDw+PAveSi71Sn2uq60UkBFjsg/FCmrS1INtT6tHwQRj9OkbSqwnH7iD7cAvoRgj6LlYcPyySRIYDiGoPLflVG+giLDcN6FR92B8jUw013SIqZw5zpyPHgmQ9QaODtMaMWbfKzfSZda1BeeiT8/flgZXJ6yHpD5ViFfB+um8GcY1/VYo/jHX7PtN8Xow3ongvKvqrQydzQ9+3NFL98n/eFo/NtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBkuccyurYMRDdVo1CAEpzlQ/rXC0cs1B8z3bjrio4A=;
 b=J/t1q7UBrYmiaDW/D2mY/WCiEiN+Bg3Uf7cye7QJ48gz5Bt5WUHC/tvV4ZtX2rDFDtwkh1t15NHxne04jX1YpbSWjKl2lIlu+TT7P771mo8S3w8f5j+T3W4Aludba1qpzmoSSwMGibGeThv3IxUvoVxSwH6YtF5CuABnwfRc0Bpi4uPulEEJcnMWsYtBaLyQkmymrbCu6yr6eJFNFwk+D9ruVTxpLBQUJSrg0Hao2PhCnKAcrQ955v9lRNrA+pBFzW1eQ4sDyjSU8WUxfu9kGFIzV1h6Vtr+8jdxL1iO9wobqcXocVTneljPvh9cz51iAvtwVFf3xGEIbMvbbWGVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBkuccyurYMRDdVo1CAEpzlQ/rXC0cs1B8z3bjrio4A=;
 b=Sy+pTrBs5vmNQQOu8BnbZLFiv2LEboUk2Ul1ifHI3Adhpf2KahiqspLk2/bSmKsyIrGSyMUqZvVtrzmux6Pp+wdT0nB2JunLozJMlpwGsQDTPZrs0X2ocvLcvyZTJXWMxbGi4KP26quwOiil61c/Za5N7Ps4hfvCBLnT9Uqzq68=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5867.namprd21.prod.outlook.com (2603:10b6:806:494::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.4; Wed, 29 Oct
 2025 13:20:47 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9298.003; Wed, 29 Oct 2025
 13:20:47 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, Dexuan Cui
	<DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link state
 events
Thread-Topic: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link state
 events
Thread-Index: AQHcRIdkXDiS4CvhKkmBHWd5T/YuT7TXpggAgABR2hCAACv8gIAA/3LQ
Date: Wed, 29 Oct 2025 13:20:47 +0000
Message-ID:
 <SA3PR21MB3867F780F0247DD9D774ECF6CAFAA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
	<76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
	<BY1PR21MB3870D5B860FB1F26932EB73ACAFDA@BY1PR21MB3870.namprd21.prod.outlook.com>
 <20251028150151.3b3b7121@kernel.org>
In-Reply-To: <20251028150151.3b3b7121@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2d1fef7f-7675-434a-b549-aeb0deafe37d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-29T13:16:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5867:EE_
x-ms-office365-filtering-correlation-id: 468fd981-0850-4db2-de60-08de16edf936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c6axWhyRmlX8xVXn/jJdh33UKLxtmu/PNjF7k1tkKms8LDVi45FBSg0iBAbV?=
 =?us-ascii?Q?z9FTh3VYA5GSoX/PKeub/ZfkKkEobC+DW9sxLVRePeHhv/Ibc8MVovmSVWZ2?=
 =?us-ascii?Q?RM7jiIC5mHNcXel2a8Ffb4UgI9ZK5ZRIyEKUY5ixye1RLO+9x/z0tUi99QY/?=
 =?us-ascii?Q?2Jr0z7b3/PwrDGGTjzfi2vDD/L7qHU0JoZFB2834J0bARDriXwpNEO2uUsNx?=
 =?us-ascii?Q?eVA7m4lt9X0F1aFd89U43OKqDRnvFMUkwRTgr+QzlCjY9Y1MB9IxA6jtYstf?=
 =?us-ascii?Q?hXQJXfkmgdKCltzinN2dxvDk9PMnpJuaayrA+EBmudxx1b0CJBy9ybrDR6pp?=
 =?us-ascii?Q?NydP9BVOP2xS5Kzag60VSItR/FsI03MFy+KRYHAc3b0Ce7F0V983TLZvCBoC?=
 =?us-ascii?Q?4CA2Z/Kk3HwHnAhsmCf/SjTngpqVHOjYophFjGUVPrRKu8CSW4ReI/JgB4tT?=
 =?us-ascii?Q?Ik7KiYE1vfYxOe7QzuyLvowyV3WfWmeATEenMU0chWskY7vLqBvERqf+EJq4?=
 =?us-ascii?Q?XM5yUG1AZLAGktx7VyZp87lPY92VaB47ltZTQJL9g+34MEM/UIHfBD2eA9Yv?=
 =?us-ascii?Q?8dET+DsUj+SuSY9udbtMcAY1IuhhHlu4nI+16OsMLG5Cjd0csG9JMOFhTG/c?=
 =?us-ascii?Q?q+90cs1n1u5jMyjek5JDwe6y+ELLcetbn3gHtjaFwwXq50y3JQDinXBWmNxI?=
 =?us-ascii?Q?GTJjYtaqo7OoGhxVNqc6JlTuovpy9YcoyYDS6zynLtV9Fz0/Rpc+GeORI1b6?=
 =?us-ascii?Q?QMMo+E9tYlgpSDm0n3W+L1oTQC+Dd6eNpJIAH/jQr8R99g+KKi+UySx8a618?=
 =?us-ascii?Q?GyM/ZTF6O2s2SJk7Q66KRuTZkdwG8f5Az6ZzaKGYx4OT4dY8DoCkn9JB1lay?=
 =?us-ascii?Q?PhTUXBjqf2E28g2EAsOl/U8YMBbZXkvNyCzyhjbE1Cap2YvJr0tAL62/ztMB?=
 =?us-ascii?Q?gJfgXf+PhdZH8LAjQ0Ot4K6GZY/agOkyF+1P69TXPnACbbPrL3DwzgvYqgl7?=
 =?us-ascii?Q?cxc1B7MBYQJ59F5xMXsjxJZ8fNh4giSgKHz0RGGuvSm5sa7piml1lQ+DTSfE?=
 =?us-ascii?Q?XL5j3xTaBv9EG9VBWlvp/Lof2KbYcgukkP6DQAqzVm/YR8nVDmMsA+7YvKZY?=
 =?us-ascii?Q?5GwA0LOlHPLJaRXkXNwMvauzek6BBn2MYM5JC7COREDeXVe1ZwAbOLaR+ekO?=
 =?us-ascii?Q?Qx2fFS2Jt3Y35M41cq6baZ5cjmfsxJm61DAGHB9fKP48BelgKog4KKEVEWBl?=
 =?us-ascii?Q?alQGLiohkIJ0BjKK4zW7BzRvDa7ZEvsFY3bHRmIW/wHdzjt8ByUS5JZHBw4A?=
 =?us-ascii?Q?8mGvIBZsKlDlwgFS82w1EPt4MreUzmNbTre3nR9zWpDyJq7Lu5q7rwnVzf96?=
 =?us-ascii?Q?JNHhlAQMSISvd3/7kzmgHc1xPDUDyOCEsb5NLx/OQVfpKTu9/LKxepkC2caK?=
 =?us-ascii?Q?w2/cOdeJeyCBnA841gsYIoU/OgOfBB+KjOSeAdfCw4UTqLBEcS2Ptz7SpLBF?=
 =?us-ascii?Q?Q/AmfDQx+uA0K7Au/QY2g1OoEGLj6UtxG23x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nY7GO0QcVzBlssj4URY5p2tk1+7gnv5B7iflg/p62QY7LhWXJCcA63M1cp1o?=
 =?us-ascii?Q?bnJeeYZClPrb6Dpk1qsBdIQ682HMzo+dqSnpVJXBskKiFKxm86FCPfOngd2d?=
 =?us-ascii?Q?NJ1Mh6Jm7Ehz6UKhDopbm4Vlperfjm1ep6GETPUpNUyahZ3ZEYF7L0wb+ebl?=
 =?us-ascii?Q?85/wCwjFj3Ezt2VaOiYvn5AiPCmKWq/i2SjcsaThGUprfGQqAXZDXni1d/BC?=
 =?us-ascii?Q?dFrQOMcWXPybnPFMGuL7ZErIrFogrBmWrMu6rjq3vn6fD9MTsf3cRn22a7Ne?=
 =?us-ascii?Q?ZpO6ZnNMj8h0BTxvGWQy1zTY2h5D++cZ+Xh6L5jWh+8Bj3Jy/8I/dhSynZOX?=
 =?us-ascii?Q?YlXnNv67mj5SCsXrVwOwYB1r1S67QTZtF+K9LMGuZDPwSYqe5beTOufaPp1a?=
 =?us-ascii?Q?4NKaCA9SeO+noEDDmffN0m0NzGePWyH1pRSWjBY1hoC1S0EmQdII4azSFMA4?=
 =?us-ascii?Q?0a3N+aQpTJeJXn9Yfw+9e9eSFfDM/qSZFZZ1p3yoNtZrqpFCOOuBxB0Rm3VT?=
 =?us-ascii?Q?mxCNU8+7d36Ww9rMspYK88zzlpJz4HLHs81eOrbo9Kw9aIMlPajJB0ziITgj?=
 =?us-ascii?Q?lEma5jv/bj99VM5jxwa4auqyKZg6DgLa06XhORT9XDWQL2T82JNWL7PmNwRO?=
 =?us-ascii?Q?ePT+3oyYzXNSYHYofukAARqsYFqQ+Q4sVCMHGH4x7MDKiHDiUXTpk+Wn65Aw?=
 =?us-ascii?Q?+q0vXdn4OfZITxZqF5gC2VyskbbBsGFYZXMeDkoBbb+lHpCyTrYm5TDiSLgd?=
 =?us-ascii?Q?LRmU2aNtaRQbwGuWSyE9Tj4/u/TM/ag5SigvXt9XVaK4UN7b8OGU4E+Dh7li?=
 =?us-ascii?Q?uNGHM0JAkqF/16PxPEFEZl8mxeInCm6PkKw1Wqf110t5k27BwWzx4rADPeOI?=
 =?us-ascii?Q?SoBPX6AxeeacGVjMZ67Lf+BSN9NlzptLfALx9BSQaONGIRGqT1GYvXvhSP1S?=
 =?us-ascii?Q?9LHLoi6aLTXKzl95w1lPy8rUsUav63lmjHAN6LYRFFwACJAGHEzd0Q6tm292?=
 =?us-ascii?Q?Cc4F0L67opNxkqSqXrOrgSx9SbX9XPqcqcqGZ31LiMg3KjmHsmTekLSGOcJt?=
 =?us-ascii?Q?keTnXLZsTTJp0+qE4/Zm3F1cztIBH5yjHtzOwVz/ekbFUVQfN3e0rKKK3fJ+?=
 =?us-ascii?Q?Wip2Wpcp06XfMcp0VWw2zlHXp//wAN8cNgzavzxQQbSXGJSsnikKdZwSJc2/?=
 =?us-ascii?Q?qS6ekRihiUlKmz70OBgCWfsJocIbHp/WzMt1RCjBRO6LdSjP0YISdTBkAP02?=
 =?us-ascii?Q?06cYzYWjLl8MNQGXMfIKfCE5qxiv3OHCribWMe3H8S4DUT2Wk0iZZEuHA9LL?=
 =?us-ascii?Q?t9aFov0qaOPBHo5r+9bto0SeCIuypUncHn2RvUpeYTo3jcMPOcAujsBZVRXj?=
 =?us-ascii?Q?Q58ZvNZxiG4oUMuWxRXjxtmPuwKemvLbHulJ3sMFbPLgaturJHB2sWwpNide?=
 =?us-ascii?Q?C+apUPccLxeG+otXtU/xtYnlqxevzxdHpBDVerU4Z1XrTtQ3pqWwBeF43/rk?=
 =?us-ascii?Q?BgcyW5AGsPYZNB7ZViIW4KuMO4FBVyGFFZlciviQ+uM8YCx1vrb0onQGTPU1?=
 =?us-ascii?Q?Hwi6jfwnXBoH5YMAyTNiEMehkm2gC7s7kvhAT3Uy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 468fd981-0850-4db2-de60-08de16edf936
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 13:20:47.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wU+RbmTK0s/FrLemGIGRhijJ+ghV9lHqXylg8lzzfC2xIo7OcQ7jVaO0Mif7dLl9nfH6SkT5HJb63LxR187Lew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5867



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, October 28, 2025 6:02 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Paolo Abeni <pabeni@redhat.com>; Haiyang Zhang
> <haiyangz@linux.microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>; Dexuan Cui
> <DECUI@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; edumazet@google.com; davem@davemloft.net; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; dipayanroy@linux.microsoft.com; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> andrew+netdev@lunn.ch; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link
> state events
>=20
> On Tue, 28 Oct 2025 19:36:02 +0000 Haiyang Zhang wrote:
> > > Why is  the above needed? I thought mana_link_state_handle() should
> kick
> > > and set the carrier on as needed???
> >
> > Thanks for the question -- our MANA NIC only sends out the link state
> down/up
> > messages when need to let the VM rerun DHCP client and change IP
> address...
> >
> > So, I need to add netif_carrier_on(ndev) in the probe(), otherwise the
> > /sys/class/net/ethX/operstate will remain "unknown" until it receives
> the
> > Link down/up messages which do NOT always happen.
>=20
> Oh that makes the code make much more sense.
> Please add this and more detail into the commit message.

Will do.

>=20
> > +			if (!netif_carrier_ok(ndev))
> > +				netif_carrier_on(ndev);
>=20
> Testing carrier_ok() before calling carrier_on/off is entirely
> pointless, please see the relevant implementations.
>=20
> BTW I think the ac->link_event accesses are technically racy,
> wrap them in READ_ONCE() / WRITE_ONCE() while you respin.
> (Unless mana_hwc_init_event_handler() is somehow under rtnl_lock)

I will remove the netif_carrier_ok(), and add READ/WRITE_ONCE.

Thanks,
- Haiyang


