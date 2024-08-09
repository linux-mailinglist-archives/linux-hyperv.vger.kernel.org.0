Return-Path: <linux-hyperv+bounces-2758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9D94D340
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262DD281F42
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C6197A76;
	Fri,  9 Aug 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YkVYJcwH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020114.outbound.protection.outlook.com [40.93.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005731DFE1;
	Fri,  9 Aug 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216770; cv=fail; b=E1qs58UKov/EDkkAkkY0S0+V1TfzPiscm56i3gABEjMDJY/zm7gC+o93hlRqo3ekBX1AedVVOGiwgpF4hJ/5UMxQjaqjgCM5a6cxxjpqapysJqPvbZSfCq9PZNpSZUqU6ybEsdjHm4htlasqb1bcKz0VK2q/5uHsGO8lqB/qKno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216770; c=relaxed/simple;
	bh=fA64zh404lmyH2lgLoHz7eKq4KJuLCfUGPz/HtWDUlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwIweDeFkjHvZrB/OJ1FIhapaBokJn13D9m9Dze+cxpinJAutIXF+1NFbG1C56/WmuTycCf/J/K1DKcSaRM2+mDkLBrltmMTVbYkkrVXcn9DH6DNihdsQGzQ6PwXjp7+olr+w91LJTWbhscuuw/nFsu238tnBzZB+bU1nwX1FPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YkVYJcwH; arc=fail smtp.client-ip=40.93.198.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4QvrhLaEHMOQKSbRn7NOYl3odJ0LfGM0Jl7firch+sSj4EgVjvI8lwHfcjBx7XFiMv+HRvCHpTv+bmfj8ENAwa8PGuOWMMrnPLFdRxey9cqyR85yP9y5KvYkeUcGu6Q+CslVJ6p1RhuQVBc3IRFXqjqOTsbjp19lDV4yemu2EZTQ0POqeBVBPs/KTAqj6qt9rT7oc2SFls+9R+FchYv0jzDHsazW/pGR+NHewHBQJTwTGN3WvvH1Os4Im+rifj8wrtiJkGaCBetZXCUGVNWEDf1BIBCEr/h/WXyz65EYyG8e6z841SS8G757x7zT68JdpzJX23d0j8xv9ZZYrmvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrThUFXO5n03XscYkWV08IKoTbh6JVqoiuV2d6pLSuI=;
 b=tejMtVeJwT+GYQAaiYHG2szrLXtBrQ82RbIEbxmG5M5pGIVb/2+JuTDLX8PKpDswxPPws1mAsg4LvRNxPYUTbzFwZfDCAR3FE10LChCfy59jglcsxNmw72JBC8YNPgfhrvaUo/k1Gk7KHekcKIpHJzkK//V20qUfv5vNdAg184vBIKzNJSCAMgcSRY4kw13ZLAhPVdY42ShBY30E9Rl3QYx5+vmUnWSjGdi2qKjjNuGPBoDpVfwM5/nD7ebvUtY9d/kWceYnb1/5ZbUUNfBma51Rh2UowMZ6tminwDSKtJm/NJjr2KqTneRBynFfUr7Y/XtpH4tSyFHqlcMIlyjkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrThUFXO5n03XscYkWV08IKoTbh6JVqoiuV2d6pLSuI=;
 b=YkVYJcwHYh4fS5lc+zbqTievT/aGgmssHLxsBcmTCYtyew/PQu3nob1Bn5vpiHJjJlqz6YcNKFUIMBEZACOoCA/EJmAWm3NcUQGwLuAOTQWdwsjVNiOfrY3f6s9SrdlydHMo5TwPma0vfQfGTh2tMHGT3Nu4Q8NTJj6NrIC7yXU=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 DM4PR21MB3706.namprd21.prod.outlook.com (2603:10b6:8:ae::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.9; Fri, 9 Aug 2024 15:19:26 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.009; Fri, 9 Aug 2024
 15:19:26 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Thread-Index: AQHa6R/zQgAE3/VEwkaNHXMnN1gZdbIenzgAgABtdvA=
Date: Fri, 9 Aug 2024 15:19:25 +0000
Message-ID:
 <DM4PR21MB35364264950F0182B50F5846CEBA2@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
 <20240809084716.GA3432921@kernel.org>
In-Reply-To: <20240809084716.GA3432921@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14296e4d-4e8e-468c-bbd9-e5cb7bf4707a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-09T15:19:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|DM4PR21MB3706:EE_
x-ms-office365-filtering-correlation-id: 651dc68e-da0b-45ac-dc28-08dcb886a7b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6iokwGZeUd7pyCbQ8ccXFEM/XJU53tKgnD9rvZxn+V9AsT9Hae3DwKdaadW0?=
 =?us-ascii?Q?Lgvoj2XDy74hbN+b30hdFhqGHIIqnIKtbTOregEimt8GctVdDYNMUTZiyxAz?=
 =?us-ascii?Q?DSNOyv+BcqavXN2HjRgRvElB3qo3Eaagb/OWQY/K/rhteFcT4prruBOQ1Lyk?=
 =?us-ascii?Q?TDSF2uA0ZC/jhh2Iw44RMoWtj2hxC2feNC6672rN5Qui0wVLJ0o8e8sVz+yA?=
 =?us-ascii?Q?mHWvEhuFxvmYexQr/jjpLwOKZcD4WgucXwNZXXJQEAS7OV0fZPPcUeR99Eaz?=
 =?us-ascii?Q?B8bqaHn3rQSYyJYGppM4xn+HbFZ8KmqLYXUfMsuXd2rMilfYC3Em2E1DzZ8W?=
 =?us-ascii?Q?qRIFvUxocSdCKZaFEN/vE9175liAetZ0q3Yogu0o0ZOAReCnyW9yug4wMKk9?=
 =?us-ascii?Q?b1nnM+vO6VeefqahBwuTaHmforrlBN9P82rV6jKn+Bh0A3OkuSBOPOy6Omz1?=
 =?us-ascii?Q?TImfky2PeSIACSDUJjfTRPbxMEFAyLjGsgOqIGhovw3CPowqFvW60XSCYwVz?=
 =?us-ascii?Q?RZHjzRVJEmcZpObFdPQ/Zbu5xJWe8AXsF55tOF8+dR/rETLqHZzmWxdpqQ0Q?=
 =?us-ascii?Q?6Nr0ySmibDmbH9fap1zkGKUHm16IAssKVNR3MJdaPPD3NX1OCH83kGzzTzqy?=
 =?us-ascii?Q?lU9k4+hfEnKrvvRIYl9kY02sTmKM6YuFQsJRsB/pCwD/BTWDoK7EyMUSyOHd?=
 =?us-ascii?Q?7Zu8D2csJRMpGP5995QSb6h1CTGMcECdL3WwOraWaXckvdimgQus+sAxop+4?=
 =?us-ascii?Q?VZGhznyiPf46OG6BvSj3BWubgRXJVSs4mC7p9UreLWFg59uHf2JO/hFu7e8l?=
 =?us-ascii?Q?+39XzTSZGong3cRdEn5BoQ0YqzZdLc7uyxGm0ckjB6Tto3oV9kIwe45XCJ0l?=
 =?us-ascii?Q?wgcjt+kd5j5TQJxeOjfRW73EJV4K1YOarK2h+DXOY20BEprcBEq+LK9f0dhH?=
 =?us-ascii?Q?2fIN1kqAcbz21DX8dr4/fMWg8mMQ1QcZkbX6PnhYNKaWVR0WE44XUsoFiv8T?=
 =?us-ascii?Q?JQfTSTykhoB/J1vXfPHAlAQbdM8Pc0NXXxerMM8lRMG1yGIccECXYaPoK+Jn?=
 =?us-ascii?Q?g6wX6zv/GvyEpuiv4ZXXGgLRWn968QaISzQEDRKX1Kd1tLpe9Nw1pZWjXjK0?=
 =?us-ascii?Q?G3YEAzSc11HkLkf8X99/BRbRobxCSojLanpYPoaENKaMwuF7MQrTNqNwhJ8H?=
 =?us-ascii?Q?qXYLgx43c67joZtnsAteg6pf42o0lBmzoc+5whidbkSn+80HzAhCrkuAmB1L?=
 =?us-ascii?Q?2ZvwqzHvDp3ZzkDPxmD89nb8VAmtmTuQPHwKrhkJsqnwTKDP3BN+6FOjfTsI?=
 =?us-ascii?Q?XSVBcg9zw5OBP81Lyqw5tbKm/qOGpGf7+OWXqIIeEPENIQsX12IxMEIcmqtZ?=
 =?us-ascii?Q?gDGoH3STU5PAF5JhTtLFuUoKl2nz9jKBQ4bcOod1Ie6A3iuH+Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KH9u8t6dH49iwIalKyClnF5PY7HWB3G4E+UXKZITI3m8C2j+J1liOE2xgPij?=
 =?us-ascii?Q?PEtBZUpI34i1Ms9DkEQF5je7fUJucsehFTUcC95zXtl2bwjjYzX0Elk2KLn/?=
 =?us-ascii?Q?eC0BKG61/E6v8Bxvd/9KalmQDuOHrviCh1cCe3bMVNfYQOXkvVLBVKT9ADaZ?=
 =?us-ascii?Q?aCeV1an4nqWjtVLT2K7dZyFAIoSMz88nNjGcQNzxKt6UtFOuyfO8IxFXd1v5?=
 =?us-ascii?Q?glj1SwNtt26v7U4OmZff3u1Ye+zZHa4kGRBDrdKnutkuF3dJwqm2TjRWsRgR?=
 =?us-ascii?Q?PJDcazhz1iFbiOCDFp9KkmrQPp/rX1AZY2r7DljX46UtUzzvTRnuGLG+vyG+?=
 =?us-ascii?Q?NZPp696IGatrSXm2TipLSGbCkRUG9Fp6TuCWl94G7gY9t1NyK3ZUSWJH0PFg?=
 =?us-ascii?Q?6WYG0kWCAzA5ajFXeg5Z/uBieh2p9nWnAMQYLwju3LHOA/qnlQRYiFYjPpN3?=
 =?us-ascii?Q?Sn1wxsf/o6VStRpxbnldfPUi5M3f1JS6k7blRcdvbQjt86PD3yrTsvuZFjrG?=
 =?us-ascii?Q?scmzf8FfUoREpoNE2gOAxH9Iicir9DOYBc3rBKCxvQlnqGRGXTJPwAWIDAjz?=
 =?us-ascii?Q?O+oI3l6RlRhuQUlbzDm5i6kzzvMhvZs+Bo2R/p+HafccqKZMSaZ6w+skbo9y?=
 =?us-ascii?Q?UUw6sht8CGJ3YYZ3HHoTZreSmLCJlyF8kUbmryY83Ze2/ywbVSJFBsyvfFRm?=
 =?us-ascii?Q?t/22eGHiovqpo3nr7udeOHT3S9SfxnNGmiibfC8xZF5Cf48arpONFF5NsIkZ?=
 =?us-ascii?Q?RdAzk6xPgAOBJctxt/PMxR3IFzTzdrtDICFtSqLFZnVE/ix7JqhitaCw3IxD?=
 =?us-ascii?Q?GttFwi9dEu/3ojEIdLfTRYLteZ/ORwb83a4NJjslF2TbzGgWfTsSCesZ9Bq/?=
 =?us-ascii?Q?Sp9TSIjiaPBlJq4chazHC32/Xg5Jk3U8+WppXDSX87Li56aCWalugFDcFvvo?=
 =?us-ascii?Q?TeVOjrUtrVcYKipOTynU3krAh0UwDQXVUCHOhclKL8CtVrVu0DiQEckabfnx?=
 =?us-ascii?Q?BFXyDxULG7/YLUGuudOxLL0GmpJ93wqZxjwqKngkVMd5dr7BDKlm5+8x9wnA?=
 =?us-ascii?Q?l6HsbsNPXGp3IwGvJTfhDtE2wwlqPwH3g3KgK56W5BgZ5fNbtunofpnM7pcD?=
 =?us-ascii?Q?tIcQtyXM++qrwJHuZrvjGRqK3Cj0F0KHPAhMt2kJZBbtoR1qbAw9TZeBFjeI?=
 =?us-ascii?Q?aKVThcxPkX5jJhgkyIg6NLQJWyde2o0hsktkn3KK68iuD/Jb9h3tdiVgpeGl?=
 =?us-ascii?Q?Tvc3A4SUAPdoVVDrteUejEnDtJXigeG4X6OiUu+prjc4v3zAY6oV489VziSH?=
 =?us-ascii?Q?jgZY5GMxjuFoeIO7d3l34Fv8Qu7tBdvwNFQvWA9+u71n/KaU+YCe6Tgek4Z+?=
 =?us-ascii?Q?mWOqw+M5VQcamkx+8Av0Xt9FcEpEmeQtNrM+G/Sbl9i59qHy7qkMpjqz+pfx?=
 =?us-ascii?Q?U6Q1xvgJmOTSSmdxsxCh1hd1vEa+Ez0EC4JTU2FinYsXdewW7gE/Jm2G4fFr?=
 =?us-ascii?Q?KhlK1ydNKOML/NHFpALtO4pIdZYMoxPvrGeI6kh/ftZA03Nq8DO+PdHYKCfR?=
 =?us-ascii?Q?Tw3nY5+4au28lL0Xyy5s8rytvXtS3JJaIMPslb7dOgjIdjJvQs4QQSFTF8Tc?=
 =?us-ascii?Q?AupXYHC9e5t3omUHSN5LNZVzcJY+FNNf8pF+piVcFE6v?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651dc68e-da0b-45ac-dc28-08dcb886a7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 15:19:25.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIhwpuHwj7sP2bgtZqOHUdIkuvO3dHiEG7xbF9WABLYKEM0R7H8oBHMbP5ko6F1J7vsPG3j6HCtqOdRegB+9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3706

> Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violatio=
n and
> avoid unnecessary doorbell rings
>=20
> On Wed, Aug 07, 2024 at 04:17:06PM -0700, longli@linuxonhyperv.com
> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > After napi_complete_done() is called when NAPI is polling in the
> > current process context, another NAPI may be scheduled and start
> > running in softirq on another CPU and may ring the doorbell before the
> > current CPU does. When combined with unnecessary rings when there is
> > no need to arm the CQ, it triggers error paths in the hardware.
> >
> > This patch fixes this by calling napi_complete_done() after doorbell
> > rings. It limits the number of unnecessary rings when there is no need
> > to arm. MANA hardware specifies that there must be one doorbell ring
> > every 8 CQ wraparounds. This driver guarantees one doorbell ring as
> > soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In
> > pratical
>=20
> nit: practical
>=20
>      Flagged by checkpatch.pl --codespell
>=20
> ...

Thank you! Will fix it.

