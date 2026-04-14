Return-Path: <linux-hyperv+bounces-10152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE9fG2pK3mkzqAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10152-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 16:08:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B313FAE06
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 16:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DEE9300D1EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A653E7174;
	Tue, 14 Apr 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eFIYzWog"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022091.outbound.protection.outlook.com [40.107.200.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DDB3DBD59;
	Tue, 14 Apr 2026 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175720; cv=fail; b=QMMAhbA3x/OO4ffXFdPsgOG1pI8nATxP7vr/ufLv3vS/FR0iyCFO6t8tUi/ucGg3rwmzjguu32/S7d38JitDoeBsxO5upErXH9zNbY1XzNmD9utgItxUFtS0/3OAKVk2o/QJKNSKS/QscMwR9MheKeeyhKTgW2akzSyhpD8R/Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175720; c=relaxed/simple;
	bh=9B4LQjaM3bCMuIEnJqC+B28TxhrjKkKF6MPH7P0pmKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWfauoR9molGln0rn5iNshptmn4j4ICdE0l2FxroHeK5jGttUwy3eAUKstmfTiQ0upPqjEiwRyc82p1+zAqq/lIppNTcwyO8A9e8YhuRLT1ndzGxHOFf0uqZLjDJDRe8crZ23dst2BrjuTMlnSylgWLWYXR6qy+nyR5nxAa5AQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=eFIYzWog; arc=fail smtp.client-ip=40.107.200.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdwxDyoaHL1BOWoAe5v16GLp5AjPgKJ0fUNGNPKIUdaKTtcc91QmY6OG5BxoDVWJDDIB1AflmfwhwVoMsguzTqMVu4sXlXXW6jYDfdYZiWf4V43tbnM1oR6yJE0s4veenRxGjTIcuOaxliDStFaXvYCdcEEj8dMkzUsFNZ99CNA72Cig5nQtAExZ+OGT77CKBDSFCWwahk4mL8mTJoo1Z6bJQnfVu6nDuBOjLJEIkPuD796APJmSqXTScDLfbiOx4W3aT8PTpKszxIesg+QqJnIhOr6kDFLUBYmUklfjvZ6Bf+1CD6TBdx0k+9EvcZxB+16QkhVFGhcjaSWDBmIqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uwR5/tPEEAT9EOKFeYmVS2sXENykNgE55Af8IEfHPw=;
 b=OCjys85p8NTyHZJ9ljvQ73PU3uS2VWHmhiL6f/NUdJi2NafgmvR8OPxBuGN5QWbrq4A01wk1AZ3oddtzuJCL22fzIVb0EZEKYFWe2FiP4/hCTK10+B8wB+ekKQrb6VQYo3X9+KPI7x6PwQXEXbZ0BBzoFkiZcp7eHskRPtuAVMz/YFfbcV2+c00/bG7Rw4tj9u7dzXoQNiLSn3+xNJzVHYcr277Jc5Zfu/vHYRyWHrRx2ZEOeL1mSBT583h568vYyaqWNANtUzqEReSgMkzzKPgsYFCo7v7J6Ge3SdbtVL0NiFaMymFZIHt9G5i2KBhVk038GWQyyEiKeP/YaJUiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uwR5/tPEEAT9EOKFeYmVS2sXENykNgE55Af8IEfHPw=;
 b=eFIYzWogCZ5bzMEy70CxshjB7jh3Vqtm0djhVWs2hlX3lid6ENZc2f+aUzrsuEgqEt3t1tQxVfw/333UK5DPp6fKtKT3i/UGG7gM5GySXzavJSCq/U0NczE7mREfhFBp6lLrfZ9zOi0c2QqP+a6vl/66sohLItHniYMlrNU31XU=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5818.namprd21.prod.outlook.com (2603:10b6:806:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.2; Tue, 14 Apr
 2026 14:08:33 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 14:08:33 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Li Tian <litian@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang
	<jasowang@redhat.com>
Subject: RE: [EXTERNAL] [PATCH net] netvsc: transfer lower device max tso size
 during VF transition
Thread-Topic: [EXTERNAL] [PATCH net] netvsc: transfer lower device max tso
 size during VF transition
Thread-Index: AQHcvBLlTQuTny5sv0eGMyPDLKqDDbXet7Jw
Date: Tue, 14 Apr 2026 14:08:30 +0000
Message-ID:
 <SA3PR21MB38678FCF70214C76249AE809CA252@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260325045006.18607-1-litian@redhat.com>
In-Reply-To: <20260325045006.18607-1-litian@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f97f89d7-3845-45a3-a1e6-fc041b1210bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-14T14:06:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5818:EE_
x-ms-office365-filtering-correlation-id: 3184b02d-c434-4999-07ae-08de9a2f4ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 tCJuIWKLq3T0tBgSIwRCMUDtSJFcRuqwLBEql/xPp6dmkt4CyO9nMtO/ww+oQDtVPht7YUCVjJ0PCHrlSNkypQNjm6unqKqzZVTLQZi9myBR8BmCPBplvAXlZzqNe7+41cJbbsbAdoFb42fGePEXRN+sNC2y0whiF1mU4l2FN82s51M9CqxJMi0YIZjxxKYG9+WKnZ8mfXggNP5bqFT5CAt8GCkIKiqLveOVOtSEd5WSBJKLOTmNPFk8N4B8SwZp/JIQe2iHYJxJAyIG0cKNUmQyiq7rqgRszaXQPhE0B70YHyJa82PqfSGJ56QDzvDWrDbITyq6sGiWRr5prU3zaNFldKdcTQSwSgQJ8gllDPBY1LdBhGy2/fDlUehsEPZ2JoW/FuNYNBgjKjjz4vUMwCK3BTd5b8A0/yeC9OKlFEEZMoq9FXP8OLrrVPmOVRraH/9veKITVrUb6n3ED7mY67ogEIKmIHhplj7lCQrZhKiatHcuHXZ9tlqnHZIxvQSx4s4zd0ka5s+sccujBnrWSPtq8lUhO3XMBW2vmv8GZO9UOBk2UhraQUueTBn44/KEbu5geELlFtj8R9iVT2H2+ZaNlggjAwxiZgIcogOksQHNgQXiemZ4ncZlPvLKWebS3eVVbsj3HVofh8IcxN/KJbc/y9+kIBdJw//yOX2KWUxfbUPxHjkq0D3p8aUtX1+KWlxIy6KYYreJkhK40Z2DgB5Oo4ybX69ctylV1LmUzR40aMjKtNQlv1n3gpdNLKBXyd32wWJx/Dfz/MVgeVEMLQU3apNCs20WYKNiy1XCGPk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ryWLK2M+sg+j1S8eqg3f5wcW0VsK1nwgFFxTy6oMLi0CkJyfDXxdlXKk0r1P?=
 =?us-ascii?Q?/p6ZAHRnhuiwcuKq97BczKWxvFm69MyioKBtAC2zuDHimVJGrsV1dedfQRBv?=
 =?us-ascii?Q?9625aXjWev6rGCv/iKz3iAM+KMsqSg2TXlJhXH1LT3sqMy2lfPYP1f06RFyz?=
 =?us-ascii?Q?SubViwdEPsS5ZF08x8cig2peW6P8+ugaV03yZvVCS6dN/ALN4cXjYY40OOfs?=
 =?us-ascii?Q?0HDdIkZomKVw5vkBGzFUDjxRfWSOg9fxO0rar95RsJkwwvDOey4VXiFubHgY?=
 =?us-ascii?Q?oOEFpKrRQnYz6eQHz4pMoVHCgYFAdvcBvwqKzAK7bGTIPElLBR2T+RGEEhNV?=
 =?us-ascii?Q?qTu0/3N2hx6OgWawn10bGMl+H8kdydxevcnOISosWcusU6u+7FMnkfjnCUul?=
 =?us-ascii?Q?81H30sSb33MCA8C34ZZ1dzGNefLJkQ8J1sTA7AGn6za9aOKSlXM/S+X9hiYB?=
 =?us-ascii?Q?yIhmOL9CuwCy/17JDqOcnVGrnmByjLdlkbROPf0Yv98EA+ArM4FqaTUci9nV?=
 =?us-ascii?Q?zejFUfFL92kpi57bMD801WAcVeOkAoGw5c5B8V9BQMNuORp5CxVvgvtxv2sd?=
 =?us-ascii?Q?H66xt9i3JBW3DgJdCq7R06vd1d6rjb42ECURCP0ehHxmLT0z1crH/1e3pgWY?=
 =?us-ascii?Q?yvoQ9nHjnZ8pVtET6si56et3LuDB47KiwHr8S5h5nvNK2O77IQ489wdkngmT?=
 =?us-ascii?Q?2Ve7OFrx4/GogiIY2xTgRbrVSllbK8Yu9Lkp5wvlgOBNDyjmJkbBM+ITNZE+?=
 =?us-ascii?Q?OBAO9Qim2lZrz64UpYAQmWCAZgKzUlczBd+dnokkzHeaOz7/8djtndekgIPS?=
 =?us-ascii?Q?L3V5h9bOLd3uW3RkOXhpDBHZf7z923FXWhJoanB9NQ0gLz74XiUJHeFjBsRw?=
 =?us-ascii?Q?VvcgE4cQu1JyJScHwQ+lQaj23LyW7uK7VN5VIbAUmLBhccsOIqIsgW7FGdgU?=
 =?us-ascii?Q?fkl5DCuhiaDl4WHIjzXC383+SGOZbcghSBW4/vAPKURx82lBF5IWK8xZJuAg?=
 =?us-ascii?Q?6V4XiGenrggLtT8EpewPur4Gpp1QaR590YQWI8MZYsaZ5pG+1KqI1QZJGlh5?=
 =?us-ascii?Q?KOl+qNVtNWpbY+HQmX7Mi7/gKrgTM1ILaqi2AQEI5WEyJhspiPV5aWzAfLe+?=
 =?us-ascii?Q?M0yeV/lZa2JlBI2dFx69McGZvM6bTmZ+qB2U0c8SlU5VLu42w+Y1REEJeKIu?=
 =?us-ascii?Q?k81d2KvXH7AJjxmizjZAf2rlFGHa71Rhbu55Au+3JkpUSAPOuyakRdim0QiL?=
 =?us-ascii?Q?ibsicKao3wuvUkrMVAu0kNm0A70NszD1eSlUaxIU4Ak9nUNhFJzxc1wra7g9?=
 =?us-ascii?Q?3ZYz8Pv273fRC153W7nK8Or537Ljdtspr/+OAfaYEAK5DHx6Z/4zftikgIC1?=
 =?us-ascii?Q?W7WxZgDNo8RgOLzN54l8CMXModRrkASHytkPUl/sq6tGI2q3r7t9tnT1uTpc?=
 =?us-ascii?Q?3ru8lgm/BxslkWdUHnYDeB20s1l9YptD/bRwcngLQo8ckY7lrbqsC/QxaKVx?=
 =?us-ascii?Q?4e0vOvrFXaoVEUktGnZzERMpFQdkhjKmmzRxxqeBmRdddSexO7yqwAAu3nh0?=
 =?us-ascii?Q?UfVIgcN7kolbIWMiz6XpdKH2V5D5MXNka+UN8cn9SISylELpvZ3br8j7ufFy?=
 =?us-ascii?Q?5eeI8ZeAdrpWSm9CRD+oQ9oAx+fr7ZF/ox/2kQyPVncnMC0+sTfIekcVMDEO?=
 =?us-ascii?Q?8vg5iaZ9OGBkaxS7pwH6UlYPhv9AFF2QUXSK3hQUqBi55UTg8xaefBnsjEdR?=
 =?us-ascii?Q?04nj2gwMeg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3184b02d-c434-4999-07ae-08de9a2f4ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 14:08:30.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPAiGbOaDI5nPdpXOcXEgs1Sz7wkzf06DXbszbEyrFVlFABvuvya2HawTjVhlhBs3IPGdSiLghfqlWdF/OAFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5818
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10152-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,SA3PR21MB3867.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: C7B313FAE06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Li Tian <litian@redhat.com>
> Sent: Wednesday, March 25, 2026 12:50 AM
> To: netdev@vger.kernel.org; linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>;
> Wei Liu <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Eric Dumazet
> <edumazet@google.com>; Vitaly Kuznetsov <vkuznets@redhat.com>; Paolo Aben=
i
> <pabeni@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jason Wang
> <jasowang@redhat.com>; Li Tian <litian@redhat.com>
> Subject: [EXTERNAL] [PATCH net] netvsc: transfer lower device max tso siz=
e
> during VF transition
>=20
> When netvsc is accelerated by the lower device, we can advertise the
> lower device max tso size in order to get better performance.
> While a long-term migration to user-space bonding is planned, current
> users on RHEL 10 / Azure are experiencing significant performance
> regressions in 802.3ad environments. This patch provides a localized,
> safe fix within netvsc without introducing new core networking helpers.
>=20
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> index ee5ab5ceb2be..971607c7406f 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2428,10 +2428,14 @@ static int netvsc_vf_changed(struct net_device
> *vf_netdev, unsigned long event)
>  		 * This value is only increased for netvsc NIC when datapath
> is
>  		 * switched over to the VF
>  		 */
> -		if (vf_is_up)
> +		if (vf_is_up) {
>  			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
> -		else
> +			WRITE_ONCE(ndev->gso_max_size, READ_ONCE(vf_netdev-
> >gso_max_size));
> +			WRITE_ONCE(ndev->gso_ipv4_max_size,
> +				   READ_ONCE(vf_netdev->gso_ipv4_max_size));
> +		} else {
>  			netif_set_tso_max_size(ndev, netvsc_dev-
> >netvsc_gso_max_size);
> +		}
>  	}
>=20
>  	return NOTIFY_OK;
Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


