Return-Path: <linux-hyperv+bounces-10185-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKHlCXvF32kmYwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10185-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 19:06:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23D14069E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFC532E7308
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F93EDAD5;
	Wed, 15 Apr 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bw+FSK0w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021081.outbound.protection.outlook.com [52.101.52.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE913ED128;
	Wed, 15 Apr 2026 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272162; cv=fail; b=refU+iwstJ45zjTBEHj/FyfbVmns1I9Po+yLw1/bcUvI7Y3WDkETIZZFaLeENZvJ7yeNGwLpfb9VbZFychqMPIJGwWrycUPfWHg4wZs05q7b5JlCbgA6Mh9z5YfTlMDVWUIEgNyWsSlwMLwD/BN9A7tgE9dIf0NIEROrnlpCpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272162; c=relaxed/simple;
	bh=VhLzU8SunLGIMO7M9jxcD9saUnGszxGEynI7TzG1uB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cF+yqQqHg60Qk0TT6FPUNWXEi43v6FNvsjPvS0UwtZBIsROSArS82Is1D/MCFT9Ou/7/zuL2IXplaJ/30YQEbBnwG3wmMip5zzMlHE1lyEg5MJUmtoV3M1kIbkoabifmrlm8OAcqU7ZylaaeqY/td1UHislYLIRFyqE2GuuaFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Bw+FSK0w; arc=fail smtp.client-ip=52.101.52.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrPtAhbowArKQ+pVdYHbBJqiMvYswRO0SindaoGV98qrDKAcn27qvn/5/JM0EylwrQqJcK9i4IVYogt5/lchQigKpxgWzCGcLHL35rwg07wph7qs6uXnmozySWCbzMP4KR/9r7SiJ1MhR4n+Hgdq4CnhH+VYVU3bidmDAiTBLcjAjXyBM3P/t78Hcn+B/zPqx9PrET5/TuZqITZMTXdSnDHMOZCTpvYz2IilB9LzmEyRkV4KtQfo1LnXZ3Q9b878/YQqXwTrl76Jw7Bn+8bLl7nwp5QWknkOv3bJo3Yyy2EhCzSokLIyyfdeKZoCRMEp5xyk5T90lzQvVulsP49QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2OwXonR0wYHGINyJt+yBCFgSke2QeodSD/ITsmd3B0=;
 b=BnfrKGbLlY4RPs9eJ3lysfnUIgIFVlKczEP+V6PdXjgwSwfBOMklHLbVR+8yjhm0/YCzuz1aoNDKmePzUIx1S4b26JDtKemyyyKCdBG4HMFKPtjPv1eQ1cHnDGYqeZSEIx4OEGkLvXMj1/xQ/ZYC0ndMBimKo3GlzJW1szq/e+5WL7QXYaJqxT+1VZCw5PDRY3XtnKzVVA6NW43wkekaOJx2qAaT2ZzP33j5yF4MiwGlJ/HL/WdVAJUiepWMB65EQqCLwMYBHJrdxrl/Rrw7ScEmZBzA5PtRNjsqtA2JevziYumNTJGRLwv2yXQ6Wr2G3Fghk8oW3mnO5PF+s4hwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2OwXonR0wYHGINyJt+yBCFgSke2QeodSD/ITsmd3B0=;
 b=Bw+FSK0wTsDa7CN+UIPXvN1EPQR0TDDIDMVkbnBWaDRmi54zJCfzlc47ebGDcYu1Z9nOt5XQWl5HhxljL7ge6KcIC9xWSHZiI2z+/gMlfUI6tUWjcU6bC9fqn+7IHs/rx3yhjPCLJrWzQAueONOpy/DdiBqNNwuo+aHhz0naRX8=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6560.namprd21.prod.outlook.com (2603:10b6:806:4a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:55:57 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:55:57 +0000
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
	<stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>, Mitchell
 Levy <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH net] hv_sock: Report EOF instead of -EIO
 for FIN
Thread-Topic: [EXTERNAL] Re: [PATCH net] hv_sock: Report EOF instead of -EIO
 for FIN
Thread-Index: AQHczMP62DSp8tUfXUqykY0mY+sLYLXgVi9Q
Date: Wed, 15 Apr 2026 16:55:57 +0000
Message-ID:
 <SA1PR21MB6921C57E27E17305E56BC0F9BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260414234316.711578-1-decui@microsoft.com>
 <ad9pPrji1uYSgNir@sgarzare-redhat>
In-Reply-To: <ad9pPrji1uYSgNir@sgarzare-redhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1dca6e96-832a-40da-9150-e0ccdd9e8c43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-15T16:49:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6560:EE_
x-ms-office365-filtering-correlation-id: aff118d6-52ca-4036-1860-08de9b0fdd2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 84xNx29pX24oOEG38GQGFMPkPbRSFhjr7mlWpGyjGH5bzr8kTbr6dnIQWWvJoEhd41HWL6ClL5zgJ1eBQk3tuJ/sgVujQ06OiIknlQKnRhOBO7Spfk12Xz4lGEs2UTK0TtJYXB8hnzVw9vAJRXUVyIR7Ff8ZEew6u7583iVV4+gNgXKYuRLdhJjAmOZvx8DmYToxIWoSb7mf/qshO9jLzpW4QQJeS5KrqeGNPIMz6hcyIe/8JyuzW5iKs3tAO6VS8yM/WGrNMgWU8efhm2m8UpC2IEMjF74m/LvFrThHRmm7YUpOj1oa7ymf6xr3CSMN+cey8X7D0n3qUb89gn04VbDyEJTKplsKQmPLxXwFKAfjcLirXceXhL++mWy3O7wGtrkuGjz8uLKRDUvw3J/DD7n62sjBVmlp55SS6extKEla5a9Bfh03GFLnfK6gBh0kiLRb764UsZzmO6WDgIzkv++NAR1V3PtzLmaGQlP94S0MYFRYIf5qXWY+AWqZgCU3m+lERFRZ3X1+5SfEtNma13nNahC9VXoprpn8bFewK2AfyIp52Zmog13qXNsL6hcUy9U+bRNThBLG5Nzg/J65bzZF+WekTRlmaEmIHmaZpDD8JpR6ni5VtNWZT2O1o0cKNjt4lpxh3iRjrn/Zk5M2wh190c/L8IgSPilsHjyFuofE+ZHeK9exIJTBfjT4cJlEwSWyArJ8ANcvc4X5hWpSaRZpgI11GecnOPOIz9N0zYK1WmaQbpcismKU7DBZzRCqYmMaraDXQZ57vvGrjILI3+xuUb5ouq0BhC3jo7wnSj8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Li2w9Qlzlwk817z5BYveuLind//778M8r9Y+1aeWwtQ85Z/02SKq7nLWM7Q+?=
 =?us-ascii?Q?/+2pZviOUU/WNCGT3MvrAjVRbk4Aen+39sZ/LSkOrsxVDYgCbsHHEbPhfNK7?=
 =?us-ascii?Q?74q3Af1QUN19IXLI/sy0oo9XDq24MilnqEI4iCOPsQ+DKD/6Tb7HYLrCzIF9?=
 =?us-ascii?Q?8iLeb/EiCoQM6qE+IKhGyhR7L6KV8uoSBxXixpgJR5QVhQJdvlsgINguSfk5?=
 =?us-ascii?Q?7OCFvkHZde1xB/Xrdfqfosbsaf5V2eHEJE5lhYlZj0cHXyF+4pf4d+u32Zjs?=
 =?us-ascii?Q?CWai+xa8/BgUE82QPoqNsB0MERT5mHVwTYuj4sNeOhKwz4E7a4kqibUdUhj9?=
 =?us-ascii?Q?xVGOe+PeIK/gaOc/73gXJGz1SucqUiwpVxpur8PvDxdKO/yvf6X1MwZ0tSST?=
 =?us-ascii?Q?RddAeQmtGiILfPgIdvuTwd19om74LDQ815FeZ4VDH7yKiW+2a4CQfyAOqMCm?=
 =?us-ascii?Q?ywQ9+b6jNGiBSncBOl5Vd/FJxMukFpLV9+gshS/sPHbfsWxItIHtJoEVMtGi?=
 =?us-ascii?Q?JUComfetGv7nsVBVzr2YQLah3DBVPG6x07KPDGtypwYKTmOqS0MpePYeUWTB?=
 =?us-ascii?Q?I3ILYhhSoLeOHmJPxdqQGXjIniusGHV29Mw1qGGT1JSabUaEzCaZ7Sfkfn0l?=
 =?us-ascii?Q?RE0i1ERBH4IWnIweiSF2HoGN+0fdB0cBA37A/Qe+mKnR+nXv81wzLFEpvmb/?=
 =?us-ascii?Q?/9i+nHaEOkGF2kTRInv5s6MMKr2oZ7ojnSUYb2GOB8EvgKnKO9Nx2Ntwcje+?=
 =?us-ascii?Q?9Kb32m73pIAoyrFsQW7qecgHgwV1MaNJgNcPp76IkM5M4xXXj1rIT70upDFn?=
 =?us-ascii?Q?pRQ3WYiPbDhIsQRRLb7dOLkDlbE8O2Ygd5rNeI3pjxvDVIctLiEsNaLYa8mT?=
 =?us-ascii?Q?G6O0CYArbPYZ35ieSv5eK9tfDwuQWyXAvRRDAObJtnbls6i15hKLfS3bSd8U?=
 =?us-ascii?Q?djYkoIDMzuLbLO8EKJPhoesjFX2kTnydbaAXElKGTRMv8z4j7FWESQ7oxUW9?=
 =?us-ascii?Q?a/5cHzAI/rXuL6C/TM+bbnydjos4hcOYNj0HN53rO+sIdwr/ndZDMpn/Giqj?=
 =?us-ascii?Q?Yc0q3eKGNsjtjPz9OUSt/A6Bs8EXGCkcTc6IF89TdPfjpD7Y1rFeqFJ7WuTu?=
 =?us-ascii?Q?u/SRTJWNjnq9TWR7mdHdu/9BElCEnJ5Hsqo6hmlxKvCaVkwxQWLSzOnw2mn8?=
 =?us-ascii?Q?bNYQ4EjQ9mYcreRBP2DcaQBmBiBiLCitvV+o0rGaK1xhdCZcp/JV/gkt4Abf?=
 =?us-ascii?Q?Jw+OUS8KJ0XwIC5ksWWCU53r1CBOBnO7Unhq1+j0yl2D3K+un48oWF+vXnBc?=
 =?us-ascii?Q?AuvzgEqzNwGwWDSutK9gbs1CHUU/kXbsM96XnrZdVwIPGRc9uJ+/j8vX+lDP?=
 =?us-ascii?Q?0t+85/cd2jn7uzu7AG8F1bsQIyhefwP5ADpgOXLMKBhGP5/IhhFTvOJHAHMj?=
 =?us-ascii?Q?cDep0LF4Zfhvc1xcXc4VKbuTrMkfnwDJkQU+LHbvU95dYmfwoZ8yCJmJXok3?=
 =?us-ascii?Q?uUPM5Q+fFK6/czM6d7cRt/9iNkDL0UPYOhoySJezeqPzElAchM/7rfm6dVwa?=
 =?us-ascii?Q?rSvsOhcHMhRFLPPIe1KUc3bJsWq++XisYRVzYAHv7cnImfDinHfhZgUxwwby?=
 =?us-ascii?Q?ru8xzF5TESfDS8MCGxP4YKxJyBiR8BG+NGb39euLPpq5wrf2+eG2Oit+MWb4?=
 =?us-ascii?Q?g18FRjfCfktpFLeDXrkd0U1ONdz0A6GrdJUrWV9XpSJliMct?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aff118d6-52ca-4036-1860-08de9b0fdd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:55:57.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0w+XY+/ujA2yGtM+tH0ozRO9I1KAfT5apza83B6DQHPEGR3FRak9thCbTrYWhKeA8wbNr3YSEAcUXNHbmudZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6560
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-10185-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A23D14069E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Wednesday, April 15, 2026 3:38 AM
> >@@ -703,8 +703,22 @@ static s64 hvs_stream_has_data(struct vsock_sock
> *vsk)
> > 	switch (hvs_channel_readable_payload(hvs->chan)) {
> > 	case 1:
> > 		need_refill =3D !hvs->recv_desc;
> >-		if (!need_refill)
> >-			return -EIO;
> >+		if (!need_refill) {
>=20
> Can we drop `need_refill` entirly and just check `hvs->recv_desc` here?

OK. Will post v2 later today.

> Mainly because now the comment we are adding is confusing me about what
> `need_refill` means.
>=20
> The rest LGTM.
>=20
> Thanks,
> Stefano

Thanks for the review!


