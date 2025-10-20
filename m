Return-Path: <linux-hyperv+bounces-7272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA35BF1F48
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA604EF859
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340422A80D;
	Mon, 20 Oct 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cnJgu+R8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020121.outbound.protection.outlook.com [52.101.193.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6041DE4C2;
	Mon, 20 Oct 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972311; cv=fail; b=nuKe6NOaoJlIFv6QNJjpncJWSNbAlcAV5A04fLGnRKYDACzjhMlYG7h2lIs01747/L2h1jbMvCWOHIyBqcfO7sX2p87ihxGeEeD5SA0SAtdSkOXcVac9YYWYymSQGWNg1nHVzysBalDPndftTQfqqQXRJGeKr+s2SUJPd25RX/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972311; c=relaxed/simple;
	bh=plKSlmJ9Upk2TtQeCR9NxfjxCRz7Co9qh5TbKUov64k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IC7etTAyEbNvg2EolZnAzCMHnpB6PIV88BDR8cl6chVUAc0az1WtLXjyZ6Zu9l/3a3aHz0gN03svphzdmvMY4geGbQau9SFtinYrtkrmGEcb75puMMs1IFs7v1HeP657Zp3apIP15//REJJgR+Dp8xDRojaQO2gsIdQyWm2OJ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cnJgu+R8; arc=fail smtp.client-ip=52.101.193.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHMa0pKnBswXaIfu9VpRCGu4NH0GocnbgkhA8OvgU2dKSrsv92Kab58j1ODlOMzwAQOaazx2k+W4k8ome9tX4zgZPoYSPvb8UZZ+ZvhwLl0rSmt+2yC+XfFUTdrXnOtQOer7aenbH16WVyIY9NwtuvidapaJpnRPHILnTEaLBBXlls1mtxMtfikufDU2sgJMjqlwR02C/93f1FjYHBjDBqwYEUQM7gCF2ZeLalMHAvzNT49G83VanzME3w1+ClQ39k0Oelbs9iPU8F7Czvy1sQtd6c/crAKdYY4MuMl+09opgp3e7M0D+xMOJrSytRG70GEtywBkuh8mu6HOCgfgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCi4EZRMmAoK5qLqQpIJYHfJhTEnXeDCwutNvAaQ6iA=;
 b=L0vAFgkQHebv3Jxit26GAKsKBtuurQgzvEUajye484CVC0f+sYTBIo/5+zF8KFF1HWPbcOiktSbPcLkLRICJIUPmOygq0CHJTaVCRsGFab8YgSfbxXpuHDgc3kaeX55dDDGo7YkYecOVewg6jDqq4QFO//PUSva7nq3R7SDDSU0r1PaN9naHyP2H1u7WUxJYOceIXDXhVvUo7dhSSfulZxzpffAlYWwGd0Dl39MhJ5RkdpsWuzoi4HgdVdzKD+h1ITJeqEqMILGEuA+x6xjjYTjrtHm3O4Bj9VtIx23xyZ+dRUKr5ISkx7u00a4t23i8CYYdNNWm90Ggpy5FlKa1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCi4EZRMmAoK5qLqQpIJYHfJhTEnXeDCwutNvAaQ6iA=;
 b=cnJgu+R8ytfWsEmz25f6p8R0pa7WtDfLbEixLpGsD4sG2pP4KdctNJKQ2TpbeTGzcfyQXZ2ysF02/TCc7nQVwmsKl/0l7f7PpXoyiAqgZVs0ucZWQjJFUqMRw80fTwvovvefZeLeWD53H13650AvDQyxA5HGbtg60xfmVvRaC7A=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by DM4PR21MB3320.namprd21.prod.outlook.com (2603:10b6:8:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.4; Mon, 20 Oct
 2025 14:58:26 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9275.002; Mon, 20 Oct 2025
 14:58:26 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>, Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
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
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Support HW link
 state events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Support HW link
 state events
Thread-Index: AQHcPVFWD9nsmGKsp0STD2ymhxH2HbTG+nuAgAQumFA=
Date: Mon, 20 Oct 2025 14:58:26 +0000
Message-ID:
 <SA3PR21MB38676E685565E2B144C1E1F3CAF5A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1760477209-9026-1-git-send-email-haiyangz@linux.microsoft.com>
 <20251017160541.4ce65ede@kernel.org>
In-Reply-To: <20251017160541.4ce65ede@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7ddb914f-1a61-4541-bab8-c1cf3be7cc9f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-20T14:57:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|DM4PR21MB3320:EE_
x-ms-office365-filtering-correlation-id: 5385a5a4-4214-4b9d-1b8e-08de0fe91f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+V2T9ummH+ki6asOnudrf8gUDfCGiWmwRgEW5EI+YK0pm9Ic8hXCHFGumXl2?=
 =?us-ascii?Q?MDOsU5pTJPXMbuo2QnAB8pNYnNL1whBwHvKIljL/Stuq7qHYDerJqr5gKxX/?=
 =?us-ascii?Q?6eR6yBWAXllzUFOK3CMYrW/uepiHKveH9rxPdgQUwGRF/RtZod7dKty7dVfa?=
 =?us-ascii?Q?6Vuxza3wvZJkziEUIstHM8YbvQIINo59pgiYeyC4Lz1SF2FseIjrtEeliaH3?=
 =?us-ascii?Q?7KyXLAQhl9vMShosECiLjUTZCbOksyZFy8FmmwLiFwMFnrb1PLRAzaWz2mB2?=
 =?us-ascii?Q?dRSypzhu2x+nDEMR/e5e19fjrrs/DG8NRsLYy8n/6giVSMNRBTHG3HFm04PF?=
 =?us-ascii?Q?u8kveKJB73kuz6AcP7985hr2nLwXlkEMHGgX0Ku3KmELDx8ql30GnZAhE4Cn?=
 =?us-ascii?Q?W0Vil3eQB6S9UQFuHFYBaPIQczEc6Sm/FYNlEiWAbmeyK2B+5ym+ELancvvM?=
 =?us-ascii?Q?bGHTjDEQdj1bX543/uqKCIVR+Kzmf5wtkagfPXTs22R+OGODyEwdI9QYTUut?=
 =?us-ascii?Q?AVYyjvwCGd8azGhFBKlD/GwMGgi3jDR4Yvi+NStahU4/N45rqNvQln2TWB6u?=
 =?us-ascii?Q?vm/x1yDXljx4H306Kse8Ghzijwg+ziD76HOAtnFbr1rOaD/PI3Z307OwSY8W?=
 =?us-ascii?Q?RNgnIE7QFeqI+olShwC3EkcqeW8ti+Oyfm145k7C9FyS6eZZagt6UV1e4kCS?=
 =?us-ascii?Q?/WFVg+Zo9FTFRb2PfXFA1sV8LPXMpQz/blBIqWLtN/UOZ9+hqw6fLH3tP+Ex?=
 =?us-ascii?Q?UCnTjEULtQNcqciT7g3Z9RVCf1nIS2jK+E6qctEN13yxLbf3jI6wlXp0qg7e?=
 =?us-ascii?Q?JWAjkSeEWpFlUalL28MbVflzZ56x6WGYu2gsAhp/ETWfDbJFMi8WebN9fq1S?=
 =?us-ascii?Q?n1Cj3y5viOmMaGZcsaZs4A0ARj74Vv+DDBKIp1UNdR+e6yhybGDU96HmoaSF?=
 =?us-ascii?Q?qIdoqI9nIMYY/hRUhVi8oSzbNbjh20LGa65sAg41HyjWV3YZbdBqijbaN1Jl?=
 =?us-ascii?Q?j4Q8Ytj5PpFTfEVxk91lu6A2KPsnKToD/OTdpHirB6ickUVKrS9b/gJex6x4?=
 =?us-ascii?Q?AQLLGW4e014xnRbdOR8iLDie+MwWhdPQBtK57NbAUfciMjOlG+KNtIhfQ2hk?=
 =?us-ascii?Q?8VD+MbgyomsN63kMzRGjBmeY2VVusuRVhrnvFa5oHmnSdOqfQ5xvo1bQ/qIt?=
 =?us-ascii?Q?tOLvefkToQxbVw2ZL0bsycC9h9GYN9X/nnOZ+HGXnXCNPYLRYJjDeTi05viC?=
 =?us-ascii?Q?M82sKNRIMAA8dnWWqSiMp+e3WWpOYEhoV0j189TVVZatREvKVHiz/SJEO3g3?=
 =?us-ascii?Q?75anDx8+uQvsaW4/toBgXhxFRWXnBo6lnvB/eKwWMFJfPUc8aX7DEe6ArG1H?=
 =?us-ascii?Q?UZjHDYhvv5nb6VvNbwqFS4h29/6L5cwuUfxNG9hZrLHpN9Atk+6jf8KuMkNG?=
 =?us-ascii?Q?L2PDFh0yswIdeXmFx0SAsmjgp4zzB+MxvK23CiQXNnf2cIfxETWW54zdk/l4?=
 =?us-ascii?Q?2ABZ8NFHB2RPH5CMbRHwfbFPwPLS6BXTBbuc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sKffxg4mHLipDg7yytJCb+MIGdnyhx+Hn4994n5Vyu+mCBg+tahele34a4WB?=
 =?us-ascii?Q?SQC/8+Lhpv8sJzH1x1lRPkP+stP6zOJ9sZJCpDuuDUcnQnpulMGzpCZS4NTV?=
 =?us-ascii?Q?L6jbTkbWiQX2mOAv3qlKTbamHJbuuDAbTeZ8MZ3OL5qe4RWv3ANWXREZMJun?=
 =?us-ascii?Q?KGE91wn2f2An/GBVwvnaOB/ShV7PW8RPToIq3zN3uT3jP0sMZA9oKZ0njHoM?=
 =?us-ascii?Q?XBnGmMECJP5iXwGzuqVB7RyZTXOngGjfb4rsfgsLL1B45W7XVj5BUBJx9LdA?=
 =?us-ascii?Q?QgyGvviKqpNoD89Aq79EJ5N3WHzZhukfMBUs3lwQeGeDlzWgqgPkxLDn03y5?=
 =?us-ascii?Q?egyYSxQjPQI+hxo7XM9XbMC+zYD5yMlHBK17AI7YqH0i0s02YIpj6ppLj/c9?=
 =?us-ascii?Q?fDHloFe30frvs+8xSlXeCwEiwjB0zu6PVrspmXneuFSVSSPURz/Ia134GoL3?=
 =?us-ascii?Q?e13eptD7AG2Wqm9c3Fxm0uF6TZZ73Qu7bh3U5zdldI1jsRt5oN8a65sYF0QT?=
 =?us-ascii?Q?79VNxrI9krRMUqQcKAWGzhSN/iHR/Cg4rCJkPJ7wUaa4yvm7J0CfxNPDTQCb?=
 =?us-ascii?Q?weagSAqkMP7abmoU+m6dGeLLbgM7CNvJVDUJzHPH4+97zUU2gYo6r14JB4Cg?=
 =?us-ascii?Q?XaOcurBgcPYHvg0AA87U1nOULkWy8feB9kaVTBgz5kgQ/6na4Meb7fYTE3JG?=
 =?us-ascii?Q?tYDgaIk5FEC+OWebBEoOCuX3IuEYPm1Qg4Z+RJ2m9H5k6zuzx3dFrlTfD7S3?=
 =?us-ascii?Q?snj4dLTuoOwsciG6OC8+O3x2oXrwOLYXHPRUuLg/40KMyNLj5Knz62X+RkXY?=
 =?us-ascii?Q?OD20rSmgrqEX3kwvO0yHCo3+0gkKkP0PCzys7Zxz/9QuNQwURyxmgUnqWPZA?=
 =?us-ascii?Q?BZd/j7efNUxTfJhcfFLJriZGDa02IMY/7uaVB/xFPxjz0X+pXRTNImvv72fG?=
 =?us-ascii?Q?qGQnIo1OQtKs9n6lkyx2fS8MkeHrlry7OmQHusXiJ1y2Sqi1rO4dJVI/rQ7R?=
 =?us-ascii?Q?foeAeX/Vq7+DNhnKEnlAgEXSoIMnPB1LsBOKEjvl14Q7Tog8gdkNK+9baGTl?=
 =?us-ascii?Q?6CtbdZfLRAzCW4AT5i8wulEeHauTsmpdZsvCWmJ68GJi1kkSISUOrsw3BRpI?=
 =?us-ascii?Q?N/nI4pOCC37vrIzPI4W4lroqj1iJjdAWuG+2NnaQ3sL55xq0iMrfcdOTi8b1?=
 =?us-ascii?Q?EEc1A7HnLjrandfJK2BZT6c9iU2FIl9VBKxj/bbokacQBW3dFkKi3EDxuC23?=
 =?us-ascii?Q?a/2bBOEc2NeV+DIYshCTlllbOPku+Uu+AnwMfYchxrpA8pYXo2bhseCaqevL?=
 =?us-ascii?Q?KIaBp57eGWoA0I/IKl/y3/4N3kOTtHJm2wi5SAn7UGSwYmpHgZI9aDYGDcwR?=
 =?us-ascii?Q?r+Ql+7KECZr8mar6ZCFoUPyb4BZAzjnwBXcgLAoeqIyODP9seInbzmgcieYa?=
 =?us-ascii?Q?nrWkSlS+NRN5mC/ZmWlU1WVUSeSWU8+nasMmWx+nRhN7JQkUe0ixTy3R3de0?=
 =?us-ascii?Q?76wOnnzIxLK2n+ifp2BY9IucukgLZFS3+RyN4nRKXZaw12/3/kWBNvnAkfzE?=
 =?us-ascii?Q?SY/po9AlDTQoGRE9JvIaia3WxGWsCHSF9afqhH6q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5385a5a4-4214-4b9d-1b8e-08de0fe91f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 14:58:26.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3/DYmZGimNWY0ivg2Mjhep8ZKKVv5eTGc6atVxdHt864i36o7N7Nwhvtf+Mow3D+Is+gGdaubd66WaWOQU3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3320



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, October 17, 2025 7:06 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>; Dexuan
> Cui <DECUI@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; edumazet@google.com; davem@davemloft.net;
> pabeni@redhat.com; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; leon@kernel.org; mlevitsk@redhat.com;
> yury.norov@gmail.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> andrew+netdev@lunn.ch; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Support HW link
> state events
>=20
> On Tue, 14 Oct 2025 14:26:49 -0700 Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Handle the HW link state events received from HW channel, and
> > set the proper link state, also stop/wake queues accordingly.
>=20
> Why do you have to stop / start the queues? I think it's unusual.
> Let the packets get dropped, sending out potentially old packets
> when link comes back is not going to make anyone happier.
Will do.

>=20
> > +static void mana_link_state_handle(struct work_struct *w)
> > +{
> > +	struct mana_port_context *apc;
> > +	struct mana_context *ac;
> > +	struct net_device *ndev;
> > +	bool link_up;
> > +	int i;
> > +
> > +	ac =3D container_of(w, struct mana_context, link_change_work);
> > +
> > +	if (ac->mana_removing)
> > +		return;
> > +
> > +	rtnl_lock();
> > +
>=20
> > @@ -3500,6 +3556,10 @@ void mana_remove(struct gdma_dev *gd, bool
> suspending)
> >  	int err;
> >  	int i;
> >
> > +	ac->mana_removing =3D true;
> > +
> > +	cancel_work_sync(&ac->link_change_work);
>=20
> Looks racy, the work needs @ac to check the ->mana_removing but
> mana_remove() frees @ac. Just use disable_work_sync() please.

Good idea. Will update the patch.

Thanks,
- Haiyang

