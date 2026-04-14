Return-Path: <linux-hyperv+bounces-10166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IHmHuR93mm/EwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10166-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 19:48:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243383FD416
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C05B30461A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CB3093DB;
	Tue, 14 Apr 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bjMWYZ0D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020136.outbound.protection.outlook.com [52.101.85.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE093074B1;
	Tue, 14 Apr 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188888; cv=fail; b=Di6+eJaDk8W1FFlUj0vj2+cgLz0qv75E5jNeGSpi0K9ILk2QXjYom55aR7tvs4mT9SuMq219fEdwdb0VI5vzl/t+LpZvCbMAebit6DuG0BMlZtjg5HvZDLJ0dYWnSXCmYCkQ5YIclrabX70MTulfCXJI+2WN3DtGqFbwZXYLWPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188888; c=relaxed/simple;
	bh=3lGxQMpdB4v1iiODltNTr3jH5F5gckpRxCJa4Ln9P08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CH4WZ+h7TTsKUk0fi6VBVzcv7jSMjsoYWMWzsLIlwUn4usfvw05ZB5WNhQiQf1r1CnoWmu5Pp0iAw4ghJdThK3if2xkp1Y3MAU638n5sbGiPolFH7oWwiyViXmOvdrwndyX5u4hIlBlVixKVHATrH5xYras+7I4EMnrRTbNu/Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bjMWYZ0D; arc=fail smtp.client-ip=52.101.85.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9a1jfzxpK4Az3exxEjFDBOF4eO5G8jMmGSEO4lCajdFBpgKXp8B3tzdUBcPnVXk5TduA5S1Zrjyo71CtPqrST5tmQlYwdXu8fAdWgjcKux1V+W0LFrV5M3vXoicoMMIKRfNHAzJ/iQgMueoOHwa6QsO4dJ8K2jrQTSrYE8aXlrfy1sf6Kk+Xf3+qM8J1WSjaudBYO4ZuWxGpU8M5lha9HGMJBYHm2J8lMvpW4kdyh/1CCWFX/RTsxSVSDFZ+W9h7h5t08xvb/zDxdSpIPxCIMWrX0fK63mWQkTmKuz+WSjXuN2WY2v8se8GNzE+xb5nS9/2lQDJq6NbnT0YSidfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVlrwmLJ02QW105KpI9/IRMtVh3kY8YUeBoBx36ZvvU=;
 b=odmx78jxGRM2jMMtU5gvGVz8v+tbNyv90C41GFDcOfFDcvB4i07tsfBUk5C3P/fksUi7dYSOG0NIphW1SmpQEDJdrLwrawvYp37z9oLtgc76a1RbEUwB2v7AXB3OEP8IA66/L+J7b0oYPdTAhTGRCWa/Zqq41aE4+yARiMGS0BipzieAtF3vYj+DVeDh3Q/MFc0FvO6vZVVUL9AyS4t26lbtCUxfL8RRHdY+nsUwUoHk2hXo5lp1UtSNiT8MzlFpJYKMyk0iELL+hbDdgEF1I8KtAQfZPHw3sjE1RIgl2hX4Iu1YNxScR/IHLfRG3KZHveomzuFOTO7DyHJDC6J5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVlrwmLJ02QW105KpI9/IRMtVh3kY8YUeBoBx36ZvvU=;
 b=bjMWYZ0Dxto/CnFExaJ5u/3xXMEaGW1OMbIw1E93AgRwFDsKtXImOSq8nLXUFnpprVoipR3rP+BC1u0tFhwcPqBFK/ZjheGRTxh4m/hyYbm3XIPG4m/tRGproaJQpBQD/5TBTbS1IPswQFXf5T7oNSULM2v6wjUo+raaTcowB7c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SAWPR21MB6958.namprd21.prod.outlook.com (2603:10b6:806:4d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.9; Tue, 14 Apr
 2026 17:48:04 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:48:04 +0000
From: Long Li <longli@microsoft.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Greg Kroah-Hartman
	<gregkh@suse.de>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Ky Srinivasan
	<ksrinivasan@novell.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] hv: utils: handle and propagate errors in
 kvp_register
Thread-Topic: [EXTERNAL] [PATCH] hv: utils: handle and propagate errors in
 kvp_register
Thread-Index: AQHcy/9LP6SIQwU2r0inljgKLLoXE7Xe0kxg
Date: Tue, 14 Apr 2026 17:48:04 +0000
Message-ID:
 <SA1PR21MB6683C1A3130951962841B3AECE252@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
In-Reply-To: <20260414111008.307220-2-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a00b5b3-8d38-4a27-b7a9-47523802822b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-14T17:35:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SAWPR21MB6958:EE_
x-ms-office365-filtering-correlation-id: 123cabd7-c849-46c8-2cff-08de9a4dfada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 LWEMkxBtYDzCMvhCtv59PxcCZOcTZtHn+j/pgEBkeNHOfmBKdQZ6XecyEKliRayRope+2/pBFz7BgQulbMYJzjCCJmjrpMeIFnufMxmeznheGiCJWDIbaJIeZCb6YLSEv/2eAzvBKksmHiDnQ2BGPX+6AvPBX4BlF21DdMT6YJswODf0xeR22ysEXl7gjSY0goUIzSXv/KsfGMnqNF5LB+WlDXSw5GSRcjy45n0RMxfvI3udOhUQzPFdsRUPyeMVu2pWLo+GUTZuWujBTrpcThsBhcCXQN1ogNIlU0nGhGyKGuUF/3feCsBl/kSwcvyFXwrG/YhkEdWEGp+icSBOYIMjCOp0/LZLQnkcMj/pg06EfSOUY14OFsCwgCm0aQsH7TbkWAbXF+W9cJjHhcFPkwlj0RY36m3KSR+xrJhglSSb6Tk2IwehFWMqpdhIBqxkvpXX3ZFdackbHNXhxaqs42qURj2etoz94BJvJvCZ6+LcDItxGFlcKT3UdtQX1j73jpwDNzB1MwmViA5tOZrnfXe2LDM/9GSOdG7sPG3LHoWG1eFccyOBCQzDWdmE1H9PQa1UfDKG0Kdr26wIUJPnfq3WG+y9q158neaNTHH4eL85P1V9M6i/Oerq41qhOOMrYIOan4OeEorxMX+XmdhdFWvZzxEeiAPKTMcdJXNdfS2mTNHFrYRLy+hA5A4VBfx9zsqF+xpq4GBEaCTHoh3vvqrRzQc0pLo1yVVwYyTjLVQUxaYjJte93kRm8yJnXyGuKnRwIWqxBa8ZWbEfse0+nTY658D+GV/udoGsKXTa5kY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7orvs8yOORpIaitDNyas/HIQYJ/UC7TNCQdiwSIRhh7blMCGC40v2G4V2KmD?=
 =?us-ascii?Q?nfmWk1c8Tb94aKH4lBfjRVr/MBOdrNYqgDNbWwXyoVPQoAy/8r3JvhgzE1zD?=
 =?us-ascii?Q?gbp4w1wZO/Qs8skUiTnqX7Ib17kgfH2Y8DV/WYXQCSaeXt0IJXl2Vi5iJ7Gx?=
 =?us-ascii?Q?aCyB1g9GHIzJ7EvYo5y/lmtvQj+laexY0mc5BtZPtJQt2irS09KplUS20fcr?=
 =?us-ascii?Q?p1lnmCNrw3VK6HKRsiEkbfzTCTH/fExnVbIMVY7iGqxTGAxSlj7/cUjpn3KE?=
 =?us-ascii?Q?QCN9h10v7b4b9Vs1b745CDAq61Uos2kuo90CFNtJCAeCGv0HMTGgw8zm4DVr?=
 =?us-ascii?Q?Oat1BuKWiGiN9Ka8kZd0hx3f1GS+pIvFjO/NlDUpLM7GLm7s245RRq+xzjsg?=
 =?us-ascii?Q?FItA/1ONzbcm9bGvyy/8IlWeRoT88XtBmITGJ8EXyZfDwbEwPP1kcLayVLGG?=
 =?us-ascii?Q?uX/beXAWHnqbuIxummSgvqBSidHvhFJ3/m9jCLpNoaWSx6ugGrulkmhgwRBw?=
 =?us-ascii?Q?uon3/TJjDBe1PgJXBWi8nel6J3sj3KBv8Iwp1hB2njmnEsQp/4AbF8JJ8T6q?=
 =?us-ascii?Q?qyOU7nFukyUMaOkMuWmYvrp3mZTXX/BSdNgpkRuql1+UobOwXorQwEbhFBPo?=
 =?us-ascii?Q?pDTlhjJpHDYsWGFMhmYAsLrBFd0biwbAKqsGPP15IcNCtPctbIruq3KAVNdl?=
 =?us-ascii?Q?A+cZgDmb0uzGCu7wzTroBNS+b6/aRGyUaeo4AjqXn9rmLo38VW6QDIZmIaWy?=
 =?us-ascii?Q?KJQVIhZVh8mjrZWgZ+iNfwkPU5Auoe7nBoLsQ9MY9tfvDkci0ebn74lIO0dg?=
 =?us-ascii?Q?lk15FR+dlU+GP9bBoQA3by6hzYSXg2Ay2KCXNU7+InLTmjLYnIct3VIGnqQB?=
 =?us-ascii?Q?EChbjTSYV9V19ygwDRj+Psj/MlKSZdpNHzylJidT+GvVCFyPHXYvyOKYSTlm?=
 =?us-ascii?Q?heEn9OOdfRGOQc514i9IGZdVC6lhlKUqeEJ3v/LNO18PLUnKyP10c/LGwDvE?=
 =?us-ascii?Q?LXR2Fyg3T4cOiTAm+hp8wzgnJ1lMnNXFYTthdoEbs7uofiEWjuKu83XHKEzN?=
 =?us-ascii?Q?lGCONdZJYom+llTaDKIGnxiOd8pYk41TKCwOtTvbuQIqkkrMFAcGGTlMzJdv?=
 =?us-ascii?Q?dV9fsIBdaZYxck/gjMYapqlgvNy3EWwFQY3L1VN9FtWSE7kzWwZ5kRVuG362?=
 =?us-ascii?Q?oP3nqX/3igIkUk09J7tsL1zoX1SnGa/jMCFJfT8mxtZQGOoCW+flX7nIZQDd?=
 =?us-ascii?Q?BPrH59oIzpD+KFY0d4TAG8XC8SUM/uelY8sVlh7JVytlic4j+NjhiPdTmMau?=
 =?us-ascii?Q?7+MD7t9+bnvRpmfzoVQiU8WW8/E2zL2sh0NM7Qng4X15tnXjVLfuogEE+yOq?=
 =?us-ascii?Q?1nb3I7X5W3EekztpqDuZBwZ6w/BTNu2Uq99AlfrOMHYmzO/er7ukB95uU/Gc?=
 =?us-ascii?Q?lYdoBlnp7ECKktol09gX3HikZhVdiZsxo9Rp56F3oCEcP2B9XCtyRKXS5g4B?=
 =?us-ascii?Q?cCZl7rtFd1BpG7dSIkb0Jf80hFzKm2UHUot4J4t4cxGzA974pkIUKAbldEzu?=
 =?us-ascii?Q?kMigALr/YtgbZ/Y21Wm5YuFd8ID+WyzhqsMhwgnybI4e3aXZ+vFTEuZPT4OC?=
 =?us-ascii?Q?HtgXa4IBCd0tpqzEkGxEvOSdEwt/HJ7FRg1JLKqusCeJ0lgO99jLePJuv1Xf?=
 =?us-ascii?Q?6esQtEZGu+TlP2vZEwGn7rr1JZ6l9wTNIX0yFIEmEVkIBG6a?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123cabd7-c849-46c8-2cff-08de9a4dfada
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:48:04.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a625EMHmaUxd5P0yKF/xq3JaBZmRtLU4TmZYsEoQvct3QteBG7oYzSYzwGORVivmjThsfujwX0gqTHB3yRD8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR21MB6958
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10166-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 243383FD416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Make kvp_register() return an error code instead of silently ignoring fai=
lures, and
> propagate the error from kvp_handle_handshake() instead of returning succ=
ess.
>=20
> This propagates both kzalloc_obj() and hvutil_transport_send() failures t=
o
> kvp_handle_handshake() and thus to kvp_on_msg().
>=20
> Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by:  Long Li <longli@microsoft.com>


> ---
>  drivers/hv/hv_kvp.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c index
> 0d73daf745a7..6180ebe040ff 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -93,7 +93,7 @@ static void kvp_send_key(struct work_struct *dummy);
> static void kvp_respond_to_host(struct hv_kvp_msg *msg, int error);  stat=
ic void
> kvp_timeout_func(struct work_struct *dummy);  static void
> kvp_host_handshake_func(struct work_struct *dummy); -static void
> kvp_register(int);
> +static int kvp_register(int);
>=20
>  static DECLARE_DELAYED_WORK(kvp_timeout_work, kvp_timeout_func);  static
> DECLARE_DELAYED_WORK(kvp_host_handshake_work,
> kvp_host_handshake_func); @@ -127,24 +127,26 @@ static void
> kvp_register_done(void)
>  	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);  }
>=20
> -static void
> +static int
>  kvp_register(int reg_value)
>  {
>=20
>  	struct hv_kvp_msg *kvp_msg;
>  	char *version;
> +	int ret;
>=20
>  	kvp_msg =3D kzalloc_obj(*kvp_msg);
> +	if (!kvp_msg)
> +		return -ENOMEM;
>=20
> -	if (kvp_msg) {
> -		version =3D kvp_msg->body.kvp_register.version;
> -		kvp_msg->kvp_hdr.operation =3D reg_value;
> -		strcpy(version, HV_DRV_VERSION);
> +	version =3D kvp_msg->body.kvp_register.version;
> +	kvp_msg->kvp_hdr.operation =3D reg_value;
> +	strcpy(version, HV_DRV_VERSION);
>=20
> -		hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
> -				      kvp_register_done);
> -		kfree(kvp_msg);
> -	}
> +	ret =3D hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
> +				    kvp_register_done);
> +	kfree(kvp_msg);
> +	return ret;
>  }
>=20
>  static void kvp_timeout_func(struct work_struct *dummy) @@ -186,9 +188,8
> @@ static int kvp_handle_handshake(struct hv_kvp_msg *msg)
>  	 */
>  	pr_debug("KVP: userspace daemon ver. %d connected\n",
>  		 msg->kvp_hdr.operation);
> -	kvp_register(dm_reg_value);
>=20
> -	return 0;
> +	return kvp_register(dm_reg_value);
>  }
>=20
>=20

