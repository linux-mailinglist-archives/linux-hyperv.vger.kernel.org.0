Return-Path: <linux-hyperv+bounces-10316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMwqOCAQ6WmiTwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10316-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 20:14:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C44499F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 20:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F5CB30197D0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7183CB2E7;
	Wed, 22 Apr 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gcx9Fn+n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022104.outbound.protection.outlook.com [52.101.43.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C438AC72;
	Wed, 22 Apr 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881691; cv=fail; b=CYEGNjeEaG+x0GK7Nng2X0k/2eT5gFVteucWcpHhp+Pt3q2BrsP5Qa7IopNYIJAYEBtJYiNpf2U48yi6fTHhpnyUc/JaaTB9JWlKNRlGhFpkGESTXbVWG51c1xiWFG8f694RS1n1UXpWxk9kYz16hjSD7I0mDSA79fnhu9JTg1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881691; c=relaxed/simple;
	bh=ALBLZ6TVCwdcBGfEcGmLM3netiTxXf2xYRmzrYzFa4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDROTh1kPfvTZ/jNJ92Id19q1YTLRyEwbf4QMBtMLbMeWM79wXpbl7cUNwD+Q8/xLrKfk9O/B0WHDwpVaZQG7gcByXNAfdiBOIVsqZDV41G9DNtyLM9OO6lAHiVmbNB9rQc5c3lThFbTJPgUMqsufWfnxvJAVCrMRNgtoRZ3yKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Gcx9Fn+n; arc=fail smtp.client-ip=52.101.43.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mny8Vnp9/Z2TeIc0yIEJFvdb36bRUubroNnVpvsToixyc2VLGQv24RjqUfxcy59NYcwFeiinmaAsMJtGkUMhDJ3viQfFj7XtzcXiCGyONZQI4lNW5NQqdsWLMojYNS2BOlwnvlUCuvWDY7U0fc12+X2ayPbxHLzCyfueYAN9dGfwwN4rlEYJurJ+QcyPNZt51aYFaeTgG52gVOuLBcfQa0do9EjpkexKS37yjRi4B9H3ONtlFM8VX1xPleiPL1HyUcBVnCqxzeINITje541SGwIZCREiy3eAeeYvAm8ubTeXfIrfvjVt68S2Wf0gao4pbcQy7CZJLKwKFp5ucH+x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJUqkQ7NXPozWbSjNRI1Aq9KQS8uyGbRykxZOD1Sh7s=;
 b=Dl4Mb6XzfbXLsAdW8/DP2YSXWTO+Wx6OkjP30Ip0wBa8Xkd3BZuMWobbV6fiQstsyFwx8+WLZ8ebrMnVpH90Cgv065CJTwtBGsoGKTg88hb6tHgvcA62/eFSCUZTHBuwoFsNrwWdpaavY6YjdPWDzbvKNIaoR/IPzJRSo5v8LRgn1pZO+vjf0QDsx7a5hlsV3G7NGJzxv4O7/evD2xNrfnpl99OIUInnFyjqOWZI17xmCPDBE+EJ8XG0KJPmOcNMsq5PzX5ueLeUH8KzF7SwND+vd1pEMudYvsMg6QluMJLILttQD6LG9vVfEJcXeTIBrNZ8XQTid4kWYOXFB2kOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJUqkQ7NXPozWbSjNRI1Aq9KQS8uyGbRykxZOD1Sh7s=;
 b=Gcx9Fn+nGq0CR0jb2ULKPY4rK8rfeN6q02n+kRVWRDctrPBasaFfa963LVa8GBaL8aWFCInq1rSH8mhwOKxxXgyCxMRfqEON9PQMLpibVp6DoiuVFMglgYBSFvcCdxbni9cERoSonPkYR77KI/CSSSQyL9hxzT761kcyyWAcaBo=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6730.namprd21.prod.outlook.com (2603:10b6:806:4aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.7; Wed, 22 Apr
 2026 18:14:46 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9846.007; Wed, 22 Apr 2026
 18:14:45 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
	<niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] hv_sock: Return -EIO for
 malformed/short packets
Thread-Topic: [EXTERNAL] Re: [PATCH net] hv_sock: Return -EIO for
 malformed/short packets
Thread-Index: AQHc0jwGNH4NsmEEz0q2k3KJ1A83+LXrYvQw
Date: Wed, 22 Apr 2026 18:14:45 +0000
Message-ID:
 <SA1PR21MB6921EDE5E6530B09931ABD93BF2D2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260421174931.1152238-1-decui@microsoft.com>
 <aeiEsYqcKumplu5P@sgarzare-redhat>
In-Reply-To: <aeiEsYqcKumplu5P@sgarzare-redhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d044eaa9-a0c8-485b-9461-169de02fe75b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-22T18:13:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6730:EE_
x-ms-office365-filtering-correlation-id: 3497533c-5140-4468-477d-08dea09b0884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 S3jruAxbWWfCAZvPITWsjOSzvsqftF/ctvYqscoVvAiNJ0Kp7Fo6fSA7HynEuoZSz192yrvHb9IDy6SNDafpz55p/2IK69DFAx3fEXcIxlpMtuXbtzXgvSn5h7eY3DOibS1m48BjeWwZUqP9uZXPxa6iJZ4qFE0KMOQCjbGIEQEbATOLFWWCumq8wgdYUxoo1EmEPUONMy7HGs9bqRDRpWUjqUGpQ1IjuacxnO4uxZwEcjFZmXZmsJUoQCmUb4cZJjBo7rH/4LeG0yRVcEmQR4oKT9ET9bTg28N82JAz1p05kN7ez9+cokPgYz/C1I8/IMKORfc5VTPEdp+tDhMHUu3vDbT6if+Irx9HP90aiMqFS/ZyXMaPRhv2007sSHFwxyEozum9Zs+f9FVZ8Y4ezXDIvqVqmGIpKEjnatbCVpymL4Hzc8/cJ8pzvxYDPdfFh1VCusu0Keq3LsVZg+3AvRCv8e4gEndTJUy9GEgNCh83JM7z9QkUc9t6iMC62CL7jsj3gHnT3StSbzBg+0v/58lWlWsb4ePut3XHh519ykKRBfk5m75YHWHErJO1VRVsea7w0Wcr88yT6H/C7geGO9bgsm7kvB3pSIzURWnXVWB6xfJs2+wFFAEtxuEFyL5gsVK8t99Nbl+05hjRGmM5dgKjNhY/0s5vfFJPoZ8MrTPOGBBkbRi9GjiJL4TCVZei/GxSm0fQCd8HIpez/U7Chjm7OTVTCil7bmDB5mHMHEG9TVnkg53lp0Lct85RoftRFO5f83KkspQcMlB3MizOFUjTthk1SKycAS+wv/eaYgo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fj3wxjfBpkw/Am0jX7Evp/EdcdVQC6tDI5MQxIHkdxYKKptygfggvzM02ibt?=
 =?us-ascii?Q?8ZhlxotvCgIgunI1WgpjWCkzRmkxvcGdrP+8rKDqNEeNThAqxbFsZOgqwHhh?=
 =?us-ascii?Q?DCt60uQhPR35w4nVATcAbsAmXeXUaCLdZF1E01pFtyW82U3EkpB5l4cqxr7o?=
 =?us-ascii?Q?nFBZRYv2B1ytAi8w+M9vPoLfvcv0o80UcF7yZ+QagOIc7bnt4MdBvMxFs0mj?=
 =?us-ascii?Q?pC6ZznE4OebnwmT3LuJJdPciF6T2BkdcG4FPfFvKgCP700b3F6eqgifqjjzc?=
 =?us-ascii?Q?RpNbv5fzyMPD1ypB9N2mXvmfddDHlRLhWXzilSYSJLdzI2H6Z2GA8guzZCCG?=
 =?us-ascii?Q?aKDGfLR01jXTSghgjcm7/R3eTxzYB9ctZ6NPyTcoccz05O878xtlk7BZsg1z?=
 =?us-ascii?Q?gCMYiAQIuEEvqfS3mh7WT208BMp3OgCjwLBpljio466S6c2wXKWFuVdkChEl?=
 =?us-ascii?Q?VWyEMLYDb+mY5q7JD3ENAzBbaSJTMRApaYIg0VoTczZ74i1P6npjXt55+l/4?=
 =?us-ascii?Q?YwZg+i/nrC0gWaJHu8JazbKRKG26jqFKEiABepsFVh4LttmYJN/4VxjyjOCo?=
 =?us-ascii?Q?4I1H92KXMYZUX5q8GAGbtYFSqNaUC3rR7XnSsnNMbsJvUgfV9NzXgbZjr3sm?=
 =?us-ascii?Q?R0Dg/n6gELStyZllcnwKTt/NhZVgsta80u6t6pIlyRfGXuI/baJ+x3Hy7JRF?=
 =?us-ascii?Q?WjPCUzSQLjpsVwkIc8MPfgZfyNyCZsa9U/1GaHOj51MejV9yroVExjfG2j3m?=
 =?us-ascii?Q?HiDJxgzFFbWEs1eiUWtMgmfzJs6LYPzEjtPlK4yL2T96mwj4zJX5w0BYRFBr?=
 =?us-ascii?Q?ZnTk1yicZsXbDltBl7/l8gCrcYe6RLqGuf3Ei7UGgC4smKEqknBadBCL5J8A?=
 =?us-ascii?Q?9uGS7TIsg9nXNTQ7ZBvTr07pfxcUZ8r3B98rh88xOP3I+HUcLZKPa+13JcKC?=
 =?us-ascii?Q?K9Xs0psNsBbJMrfO5w6jvdMzhL/zz/mkJYMY48rO31SiNjhlTD4eaEDHGnY6?=
 =?us-ascii?Q?Do9pTgqFYOoeD7DzDzO9+4W84Q1tO/ktXb01tO0yaUgJjXpE27Dg24jJdoeq?=
 =?us-ascii?Q?UEaody624P4JhGPl476y9Bw1ZQIHn5DQf0QI+nUnpJhG3SyT27lC+GD1oSNt?=
 =?us-ascii?Q?VUsm+AaM5y4tgUT0jfeHQFYWC/u1nQCNKPBLDZNyFZtgXK/ZBlzjcXj0b2UP?=
 =?us-ascii?Q?RLhqmZ3yTKKeK98rXmZKlsCqEBJsd9WVaUwrKfBEuk8rO5GyKSZVe4FsxRqJ?=
 =?us-ascii?Q?ReKqgyXUR+cY/eWk7w5HAI0iH0TAmp9kQvmLuXGDK/b4wOlxhGASRNzig8rN?=
 =?us-ascii?Q?Rdj39Kll1H9E8MDEMgGvV2eFI3G1UB9sTzd862HOSDrzXmjzGMp1sPkmOmza?=
 =?us-ascii?Q?11CC32o7xrvI2CkTy3/MS+2tGGBVszItzunov30ZErEf37xzTvs7g7WXxJvd?=
 =?us-ascii?Q?phoCXr6dCI3i/Vt2yTujllI4/etLgkNt28VM7Sbr4IPaWdbpvwQ72Poy34tl?=
 =?us-ascii?Q?k4roaTGfJUsrzvdwDOcBoUiFEDamPc9NnGAZy83ZOzkzk2RfC8M/KRa15hj5?=
 =?us-ascii?Q?3/riIVH7yI4xciSv02ivhRCxxjcVBjTGDQqUoyyZ/rgMUZtrg1ejz54COa18?=
 =?us-ascii?Q?AoAgB63KFQ0S2UYmqj7rYKoRWduesL+BN4fUgt/L1O6EcBN3bbElzmXHjQ6E?=
 =?us-ascii?Q?KdA8nNJsfYbCgY3iT5bIzaSbNEjEXN/GnZMdjtDpN0rGqQSm?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3497533c-5140-4468-477d-08dea09b0884
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 18:14:45.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXrx9O1qoajJ/1VmF4E6vQQJRY7VfVZJErUj113d75ctP/9Jqf1+BsnSdRiNQ/VcMPAoCzZwFwskNMZ0947bUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6730
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10316-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C7C44499F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Wednesday, April 22, 2026 2:40 AM
> ...
> >+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)
>=20
> We can access `vsk` directly, I mean `vsk->peer_shutdown`.
>=20
> >+				return 0;
> >+			else
>=20
> nit: we usually avoid the `else` if the other branch returns early, and
> maybe have the error returned first, so it's more clear when reading the
> comment on top.  I mean something like this:
>=20
> 			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
> 				return -EIO;
>=20
> 			return 0;
>=20
> BTW, not a strong opinion on that.
>=20
> The rest, LGTM!
>=20
> Thanks,
> Stefano

Thank you Stefano! I'll post v2 later today.

