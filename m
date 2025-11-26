Return-Path: <linux-hyperv+bounces-7852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B0CC8C167
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 22:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694693B9724
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC73314AC;
	Wed, 26 Nov 2025 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hc7SRS3Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0831985E;
	Wed, 26 Nov 2025 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193589; cv=fail; b=sUNCAFFfUYc2D7lzDD/haBOAsU0cfqLabhvF/1f9Yd+lUleKVP0rtcXhKYaoOPd+G2aBmPqkHqtWVtK+/PjcwqMkN5DB2s+P5zkOW9bZWHtrnxBoGmzyxDqzFXgLKMOIpn7xTnZmGp8xJlCi2/QAb6eOBMl0A9pVK8Si6aig83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193589; c=relaxed/simple;
	bh=nMF6lh9gfssBMG/jOisrrR7vsTlVy0UyErRrPM/tbHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJ+Qn2jECosNK4NnjIfSGntXoExBAR2BX0X0nnwnOhBu9LLfJI8fd5sfk9g2m0n2VrBlmAVz3ZCP3TAZvgohJ8CJUzdzVVFTbHHjuD49IIfuN8LOE64mSMYXA4kS76zBjxs6CbBfgBvspPw7iAO9K/VoNhfE495qzabQPwkkyho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hc7SRS3Y; arc=fail smtp.client-ip=52.101.46.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLeUrmRLiW+7AZ3Q2CHZ2M1162unhR214vC1MAElP+4nSCbsJnh0YuPW5m2WWL6VhX8xo6JTh7QEgjzJtWVrxchscsc2bLKXwtM2bpGicYoaj5DEvtNX2QqLG2iDwG59BOThQ/ulEldqw2F8tr/WR3lzB1GrFJYdlLJ1QH4mZ2js0P+BIpJgKs52zb53zP+ZGDgbct1AZ5T4cH9yMCd2SyaFJFXxsU4r5RVd1PxqgIeIKbh2He54J+8Kerken+U5ljDACAKDEzkFeLGmjqebPlux7jjCtG6sH7zWqWDuOGntkmDfussmQ2RirZakS/ToE8arjfnKWgFdhceG09hnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMF6lh9gfssBMG/jOisrrR7vsTlVy0UyErRrPM/tbHY=;
 b=esfQa/Vvw8Zkm6bn6Mx94AIUvEyjKXgayhtG4eqiMsTvZO03Ng4QblAe3Xsa2nThZkx99geHX8VGLxt6s2oR0/MYTZSo97bzR7hYFJxL7tyUwLNHRJ8P4mRZoMH3ISbQEYoOfW1W2NcFzqVoHWwWsKI+UYDrLh3V323WBvy/yf/8QFt4N8xipGTha5eUOPU+IcHCQbPzML+xUIcnO+iRmAE04A4D4rCNpsFbB7rS972q4gkF/ilI0WuqHkCwTmnqHJc2ZVcKYOAFcdxu48ERK0OmAXhfBLUk2CPYCTK8Q5koNx9YpZgwHsJKb29c1VUrf+dgsX5KEk1R4KoigiEpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMF6lh9gfssBMG/jOisrrR7vsTlVy0UyErRrPM/tbHY=;
 b=hc7SRS3YrIRzzjnhdRfSaIzr1yDxZwzCcD+ahb4U8ycZqjmD0gRGVV2hlZLHe9f85FiJHvB1/xu1I3imscWHVcp2dGbC7RVQloKnfOhbLjLrM0o+pEg7AkDA4COmUrSzz4oDCc2ssfaTO3YYtez9m4iUV7OWBy9P3U5JnVNxrGY=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6405.namprd21.prod.outlook.com (2603:10b6:8:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.3; Wed, 26 Nov
 2025 21:46:25 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%6]) with mapi id 15.20.9388.002; Wed, 26 Nov 2025
 21:46:25 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
 recovery events when probing the device
Thread-Topic: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
 recovery events when probing the device
Thread-Index: AQHcWnJxBK4mddwuFE6X/SkYC8/etrUDPf6AgADm1gCAAA0CAIABVWFg
Date: Wed, 26 Nov 2025 21:46:24 +0000
Message-ID:
 <DS3PR21MB5735CD9B3CE54504A798A9DACEDEA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1763680033-5835-1-git-send-email-longli@linux.microsoft.com>
	<aSWKLefd_mhycGDv@horms.kernel.org>
	<DS3PR21MB5735CC21A800623D2DB5D144CEDEA@DS3PR21MB5735.namprd21.prod.outlook.com>
 <20251125172410.124e2eba@kernel.org>
In-Reply-To: <20251125172410.124e2eba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5e1a40a7-71c5-4153-a986-965efb85f389;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-26T21:46:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6405:EE_
x-ms-office365-filtering-correlation-id: f60ae029-74fd-430a-8e6b-08de2d353f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PWEDSNeGzgIDyc+m4f/0GJKq63RC2kRRKQFUguPCMHuuYomZmaoShdN650B6?=
 =?us-ascii?Q?gP16vggpzFy5NX9I0jFW8kYvhma/LqOQ4OzvrZUHCHh2aCREjdiPsZBM0X4r?=
 =?us-ascii?Q?avMMEShuXUzckIk5vMZw2dzzSTxNfjD5pA+xPzw6JcWxM53O+FTSCy/Npvw1?=
 =?us-ascii?Q?msPoEuE+p7RQIqFlUONk6o+v8z5VwYR5ajBlsP7mF3A4shzL6gCFjeq6Wq9p?=
 =?us-ascii?Q?MB1bxaN5RVuKcISqlWLxn9J3Zu/bW9UJZ2VIXhjqVNC76BJUwSPrUcvuw6Wi?=
 =?us-ascii?Q?D+IdAeZeo52xNrWgzZE4maseoXizBQoqYQ1Wr6pygZwQDcMFczO/4LYX6yKb?=
 =?us-ascii?Q?dQ8wOhKbBYSXO7DZy4b6xxPzryJpPgH/FlKmPyzfFKMdQjNytlSQcIC7AcW2?=
 =?us-ascii?Q?VJ+vwFU2iWo4iyg0coMbx+F7LV95GIdWtKMRZII9hraby5pUmbEX+U+e8/n5?=
 =?us-ascii?Q?9qoRU/cl5+cer5OvpaMuCDPCwUn3kTdXvdhd2BeedVgQeiXzCJYAcCG9t03w?=
 =?us-ascii?Q?HCyJiKpZqiEPYL8UDNA5hG1rRVzaNIPVBFR3WQq90/KSWoRs1Uc+Ykv6he7+?=
 =?us-ascii?Q?mnAva6ECsqI9w+WMfNAvUKZvjogODcMbO7h/GzkPUff9NiyzTXvZp/0AcbT9?=
 =?us-ascii?Q?HJBnJGmrcVlry68CQesvhkECk95iRRFcqK3C02Mkipl2o7pJGRDdJsM/LOS0?=
 =?us-ascii?Q?1xkRNLOTbjGRaK0hegaqYA/mBeBDvJmsaYVKnF1KLnSxpr15bCTNYKQwwgV2?=
 =?us-ascii?Q?R7r7hUx5eqchW9BuyR3L6yfhxgN/gl5Mj0qFJBlgGkZO4CHxQp4Xq9NGdgmo?=
 =?us-ascii?Q?85cfIYDWQuNxZBFcsgPzvRKd5Rle9TNzLbqANtYg8Vq0vJgxcpqKFOtoG5y/?=
 =?us-ascii?Q?YJbO566ifwTCsubkkn7J5nXD642wU3xTq2We82s4KaFR+LW5BLknNTIdkPvs?=
 =?us-ascii?Q?/qdXp1yLtj4myWHpePciMXvfTKUflVBP3jl+IxBuhBFVqWihnVrfkgZqLnRO?=
 =?us-ascii?Q?Omm8AQQlSPBPbkMBjRVuxg7gLHPuwVqS4cjUIFLO2xlaXRSjv/w3A5cZH2vr?=
 =?us-ascii?Q?aU8ycYpIz9Z374Hk3JcsTuIZK9s37RVbDAPiPDpp0UgzzausqUoSG9wXzNFS?=
 =?us-ascii?Q?OepnsQOuNWq2CUKqI8oqaxNlTXUNuvXaQBWvDyiEwKZSjwXM+DeBveLxOxtd?=
 =?us-ascii?Q?blDNxZdsYskXgSTadg2lynQnXiUR95Am5Ox39BU6JU6BNlpo0FrlZbuvZvPG?=
 =?us-ascii?Q?wp5W9jWDKmTM+7vfdujdT8eXsqTFszq60dlUkiLKKL0SJeog97gCiTWE2ntN?=
 =?us-ascii?Q?SA9b5JxwA7MN05Om5Xc7TksFYEpxGJtD2FEoaKxTTBZIuPl4Kgl4MtsOjsuC?=
 =?us-ascii?Q?VWbjfJwLiBo3P+Xt+4AtWz+NBBu+qnyngwvAsc51Zzr7zA2CUkjsQIZDsYl4?=
 =?us-ascii?Q?yWheB0jK0LvhxStDS+lkDuIdniCLKYoEcibi9e601ZUpc3cXOk/HOnyYIIo+?=
 =?us-ascii?Q?1igBe9rF0shDL8GE1YjH+royKL5g+RZbpooP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UaF25S9CZK190kYmoV+aG6AkhyDp0nmawmDXA38AUr/jbO160HAB7q5F+Y2H?=
 =?us-ascii?Q?yGv1oU3Eb2OOsCjuiqjDfaDLZjgSEwPMdZ+0YqFsDan5s1PiB5wv1vE2l1yT?=
 =?us-ascii?Q?PJdKig4vW47EseLyyjlOB8oaw4eZOWYW9bXpX6FrFgYbOTHYdkA9rFiC7XIQ?=
 =?us-ascii?Q?DGRw648cY24lxtMhZt9jBQtSR8eipztIgsRiIGgAhsGURxM554B9ZMgiUVMk?=
 =?us-ascii?Q?d9IT9m/5lHxABb2ROCvrg03dGWZ4JwMOySjEMzqEtmsBCus0hpxMYuucsoYu?=
 =?us-ascii?Q?T7JlDsZrxuBFq7zAUQnxIivUiQRtGAJU+rEj76XQ9ZWdkUvL1oQDXwQgMjG4?=
 =?us-ascii?Q?h4cAat/Ftru7KNprSpI6EMe8v1uOzMRz5qPicz9UzJ4TkmYSQDSZYBMyOqKu?=
 =?us-ascii?Q?rwaekn15tS23xEZOwVx7CbjZTXLdoAMlsew202Gf0Ub6yPVKxno7vRXaFuEz?=
 =?us-ascii?Q?cXDpqyAysDyhujf529pytEpFOOgXU4vY5Pfdd5ub/YTqNeSHBWgsXJt3V4Mh?=
 =?us-ascii?Q?jpp/skBQap0HI6TeLsZCZ1AGSNnITd5Uj1mtsr8k2l5xnrzANNTmTa0aCFL7?=
 =?us-ascii?Q?43kP0pW9XjHMK1WrJxpvMpWcTyoKDZ2oqhgFCO2l6Fa0lxGjiS1Cc7QFQ2/r?=
 =?us-ascii?Q?PEslZsmwpGss+khPcYh529jUR4r01NwRffYHLXQztDcoPc8hM545DMCh7RV8?=
 =?us-ascii?Q?E2hC9LdtcSd679/R+dy9mYdwk4A2TiNORDv6x9fNauolglctTQUfbq43+16J?=
 =?us-ascii?Q?k9HFgBHfYzsuherMla5IUJaTYi4QrHnjbmQvfRjsbckl86ZPdORaC+wanMIw?=
 =?us-ascii?Q?LXOVvUsV/MISkAfhmh8kSssuA0TkfWXDqfhbeR0PmiqykzULFAMlDf3BZhR1?=
 =?us-ascii?Q?JgZBR9qH44/Vij8U5vku8ekWMSkdPUnBBBdk3txMrAv9R2Mr0lX9LyrOzIOa?=
 =?us-ascii?Q?RWon08utkbI5XbJYJY+7ptWhzPR1/8HfmsSnqba417Rcic+d+0S1cDDVS5Cq?=
 =?us-ascii?Q?mR2484UEX9pFVR8cs4Nr3jdcnCWRRIzeqUpEebjtkcXAf7agbXIzrckJGw4d?=
 =?us-ascii?Q?4uZB/cbUNZESZjwQvQR2siztzyTrwobm+i3zvmwc66/JI64hsWoMxNF+LMhq?=
 =?us-ascii?Q?DhOLfcm03vL2j6eNwqIgOPh6/XvKkPcO+20Ume/b5edkpWrkqdKAsPcMZkT0?=
 =?us-ascii?Q?L0NVlIrBu7trxbPI4StoQOzTtshYMnaX+u6duH2t4pFFdWJGASis8470tm/9?=
 =?us-ascii?Q?jxT6egPoEzY7X8/WQaxC2b3ne41O15ng7kO64RefgpUgNrjf6CG1FCoidq15?=
 =?us-ascii?Q?S4b6cdJBwjY49RAEctlWXUqS5jUP44DjR+ImtuQ0U69iZsX2Vp8BsPEPCmrg?=
 =?us-ascii?Q?GfyXNo8M8BDtBvnwZSr1mttMrCuzKquRZ4UyuYVwyfbtgPAk4VWa0+Kvzax3?=
 =?us-ascii?Q?mfSAZyTgpcVEZNNLrTwujNxdOHXaBg3JPGZb8uTrrIvcClvrV1l2yF1tsYqQ?=
 =?us-ascii?Q?1gb01WbB45PxS3kEyMxPBzg3emga7HwyrfY7H2DFIBzF2gjFqGsjNbucEpnJ?=
 =?us-ascii?Q?IV5cJN6UWbmgl6yWJdY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f60ae029-74fd-430a-8e6b-08de2d353f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 21:46:24.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32EBgJapg5yZrYSFwR1a/8IxkPhFJp1rPTuYVq4hBPofxw5EmZIHu2Xg45Sh9gU9zfo6ZNuG8Oi+pAN5okW/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6405



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, November 25, 2025 5:24 PM
> To: Long Li <longli@microsoft.com>
> Cc: Simon Horman <horms@kernel.org>; longli@linux.microsoft.com; KY
> Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Wei Liu <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Paolo Abeni <pabeni@redhat.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardwar=
e
> recovery events when probing the device
>=20
> On Wed, 26 Nov 2025 00:40:08 +0000 Long Li wrote:
> > > tags (with a blank line in between).
> >
> > Can we keep the "Fixes" tag and queue the patch to net-next?
>=20
> No.
>=20
> > There are other MANA patches pending in net-next and they will
> > conflict with each other when merging.
>=20
> We merge the trees every Thursday.

I have sent v4, with "Fixes" tag removed.

Thank you,
Long

