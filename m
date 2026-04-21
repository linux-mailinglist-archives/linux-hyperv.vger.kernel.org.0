Return-Path: <linux-hyperv+bounces-10257-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FycGn7t5mkD2AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10257-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:22:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BED4360B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2EC300F11C
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 03:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C74368941;
	Tue, 21 Apr 2026 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H2L/WsQ6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023118.outbound.protection.outlook.com [40.93.201.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09F366054;
	Tue, 21 Apr 2026 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741225; cv=fail; b=bMSMLpZ01k8S4lOdFPIKpjC7CI4hffLHQL1HXXPbZmtC8/O7eUsFnUdt+nR4jtUJQnKJoIvnSTYJsOd/LUwCB833sa77J/CC57ZMlmRa3wmL8VGBDiMYNtSi58Av3tKx++FE03QNJdEZSOKnbBeCbzyLY20g1mCB5ublfOh5V4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741225; c=relaxed/simple;
	bh=nSiv0jM+kwhb5uodKT5AZqHH9GFE6o8iMA/2H3AUxUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfUjHmF7Bo3XR40jneKbhVqLYXnnls8EgN+vHD9fo/fZI/70+eJhCTrNbkRNjHKIZ1ol5MVXnfuFcTNhOaABOAuQKTcRN+Suk6PsZsSEeOG6I1PHtvWBh7IHiIF9n8x7+zlH/fttY3icqNIYZkP3F6E1V5XoGJcdMfRcvPSJsnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H2L/WsQ6; arc=fail smtp.client-ip=40.93.201.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp2/lWZon1RHVi6bHwQ9iquGAGedfB2BlmDCY+IJFgj3lbxLaAVA9cjfzK1X7AtMoPPeUDWbcIx8sgkow1d28HIapwTtpAbQelGFANQwvUbzVwriGvNhcGXNFCTg5IihJCCT7lIpiIV3l6k9sC4qOUwZmyADuTSB2Z6H2k1pY1Qkqc0riWK9qTVzMONS+0giVZRfzCM51NCznMcRFpS4+oWUjoWeW91/XvrgoReZeceNTlUakDio+QBm5BxCqLMaMTP25/3afQc+Ujk/uS43UAElWFPG+cslCVsMqCWdr/D+C3SOy82XM9A9aNljObIc+mz6U45Jpmc3XdzyWRE3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdDv5PcpmU/7bqi+uOOrsIu5Uo46Nd2Jo4WYvSA1B3A=;
 b=KLIOWSk45IpLHe3s5f/yxFlFPZtDAHKov7BuxPf4/55XtVqF9gXs67gst74RPJpfAgwSbFv+fL7qCchMm/PQHBNUD51xOSUcXDESa+0C+er9QYJ9gO8Ii7ynsCCb6f4IXRpx5SjdW3nW4kTzeQ/FcosWv5i0r5i13FkprrpmT6QGAxalwuehAgslAvVrIue30S0LqHfyyFS1VWAxApEnQHpp8GZLJBOiDPtyFY+e/cWIhd9iJmWRv84AhEDQb6nMPfzEd6jNZAsm+ME83K5bSraLm7wfZttC6jXPFyX6cjYJAZimyxJhHXq/0xYtX98ajZmIO7Xaz/qT2DFSJ1l5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdDv5PcpmU/7bqi+uOOrsIu5Uo46Nd2Jo4WYvSA1B3A=;
 b=H2L/WsQ64weUBJVmsBk0lt1hY/ZR472KZueN6Xkb2Zip4P6zQqxs8dKGTEjYH/20Fmg4RBF55UX3AT0qhpmYahda/H40R0sLayeVYQYNbaM4ySZ99rwxKG2W4/it7nrw7cYxgJ7Q15vSrNQaKnHL4IBeSlsata3jw+cc8sw22J4=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6080.namprd21.prod.outlook.com (2603:10b6:806:4af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 03:13:41 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9846.007; Tue, 21 Apr 2026
 03:13:41 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
	<niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>,
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
Thread-Topic: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of
 -EIO for FIN
Thread-Index: AQHc0REX4zwzMZcvSE2pP2ozCfc3s7Xo1P2g
Date: Tue, 21 Apr 2026 03:13:40 +0000
Message-ID:
 <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416191433.840637-1-decui@microsoft.com>
 <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
In-Reply-To:
 <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7bf8ba09-6d04-4ec1-85ea-14cce73ebc6f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-21T03:04:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6080:EE_
x-ms-office365-filtering-correlation-id: 00faa88d-66cc-4f81-7d15-08de9f53fd0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|7053199004|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 IyM8UOGwYQe/quevF3++ZsVWZPsKPT1b4w3RZ9x6Z6dKq3BEj7XX0ysBmnkgKCB4Ynyyw0lgvMF0BFi+7wP/ejmSfIh0O0atHlCJy2NPA55oqDu3NUEqnc6jByROmRzBvRmVrTY79nE/Ua3EUBpj4o9YVA2IYf5b4nCPsIuG2Zw6FTqHCVa+HZBYPITXrFWNkgvjiWrv4dEOqJNbZrp2rwcG/w1WQJtuep/gXFYO8+TQTi9PVceaRkakl5C6c17naJuFbvTKeciTUKGkoVvB4izVYMVgXmvfFCKkHr1JXsfocBVz2o84C1YriT6SV0lmFXQ1FHCtafFY2iknlv2gkW+6m1VSQI7YcpjzEMuYDWXVGJlf5Lf/vMSCBWxq5sFkCyqt+ow+Hj+0gWKqYSOAPLKy5LSHaB+6/6T3BYz7d1ajROZM0Dd9Qt9hPBKh8HpA4z9X0GYtyqnaJKkbw3VcJT/YRY09QBHByGdGIyQH29UIlZ4ucY7uWkWMS9F1lvP5fDAChul8qKoGqFFOcR+0oMv9BmB+hay5Zr4CQm3KMDL6sqY2mgjKw6ujtR2+6qrpKyY8bYYDDql899e9jvGPCVJljLSuDA5ksff0lac9wH4AULaGhtmLIQ08hfV5T5esGixgKSZpf3q+yH/cdWwpZN0GGUup6zuEADX+tCIs+Pi2538uzz6MFSCfZ0uZT9MLF8i+DcTxo0gicNLWtSpX9L/hRInYjsaKGiNgiMRF4cc7h8QR5sCw+NP1Uzw5B92X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(7053199004)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?feHzRHv3oNdve+1gEAXbMgjJnkoIcnJXJDhcC4MX+6yPdHuE4SRKot8j2JKH?=
 =?us-ascii?Q?+GtI29Yd/XmQVlOzrA8lNp6u0oqwprrCUAo+tK1oYLAsM+ZVMoo3C2KkAsMU?=
 =?us-ascii?Q?aSPY+D3Qrl4xcEzrkm4iQlQmNGgASbAbt0o0iEZAeo+KtkF31T3nfGKBOFSS?=
 =?us-ascii?Q?nZ12LuNj18qD7JkhOt5+UBtfojlVxWq/X1TNFK29oNrP78ZnTJYtE+Szja05?=
 =?us-ascii?Q?IPzwAM+TRCTRfDDd8xtQTMRSG40Fq0/Eke60tPbYsB6OuolrWdnpuGY2OL5v?=
 =?us-ascii?Q?1w5J+CHeEjwxMzkiWX4szeoSTvhTMZ8xjn8JTQihrRiiCF42DYMzAk+WPA71?=
 =?us-ascii?Q?ASJLeTB302l/AGxFEfE+wjYk/SWRd2XkrzBt03CnvLXenbfvFfDXZDNF+glW?=
 =?us-ascii?Q?sUl/fx6zlIa78RZzveUEaGHnxuIVsZBSbyfSrnx0lAf0BV2WR/OwjcMNL2VK?=
 =?us-ascii?Q?fYG7JTQOZUWJsfoMbAOxGwtb0cmweAahu+shFJEpTwsjklll8m9xXZRCpAGM?=
 =?us-ascii?Q?R0MUNMi3MwA5w6wPz05GXBxO7+RbWLowbn4LUHiu0NBGoBiQCnLYBLvmZqL+?=
 =?us-ascii?Q?DxfMpChseH5TFMFk3sdneeR48dzRdeN/sAbORkwte2vcJ3e0JI0Za8J+j3q+?=
 =?us-ascii?Q?QBCN+rp4QQHlkKDfcILZWYHPzPiFE2KurCds+00pP83VTdS4kGUwh6R3cpj5?=
 =?us-ascii?Q?jminiA/CtC87INAdDSt2tGvJo/QO/TUTr43yaX7tmn/7f10oLAyATriWKcbp?=
 =?us-ascii?Q?fdOks2JWbXCojejvdbFlszHSBCnwUa+uyrlt/AlCi0OH5/Won5OBRYoe//zd?=
 =?us-ascii?Q?0qqtvDnLr+Pn3Bdpev+zCNyc/f1EJU83N5+iXgiWQJ7f0Un4rHGITHsRVL+K?=
 =?us-ascii?Q?jd6AW4gcsJQmMIuZXai3HKJITcRJvueJ6mXoUQ7z1QUixPBVc60s9Jh3wnk3?=
 =?us-ascii?Q?SIYh26OREfFeBXhOFtQIFRVGQL9QbJ7XqI5DxUcChB5Xokxz+Q1QPxT3O8lp?=
 =?us-ascii?Q?GThwmyA/aP5uR088Vd0wmy7lRn/BZCvfrNcsGNCT8J/c0zj5CaLUTExhgFvs?=
 =?us-ascii?Q?0mfkYjE7h9xPQtn0qcG7bJ5LNpbeVCjSHLI6k/O3WLgRqwYIGix1RafDWVe4?=
 =?us-ascii?Q?9kvLqcXsAfiCcOp8kBVzR6OAOT33B+Xi5waaq6jEbXrDUpYwAcyRZNVDkUF9?=
 =?us-ascii?Q?+CY+Y5V+IyM46WCJJaxcijLZVKnmaPx292eEY0Rl7ifX+asqwR2qJ/s/76cD?=
 =?us-ascii?Q?2343mF/jEj00tLTY+MayX3KB2vyoSeyYRLNHYl7bkUhyD61wnZzZxha/zIyf?=
 =?us-ascii?Q?F0ci6QyQ9oiLx2Q41SOL3GupYXWJ5zOxVWKNxYADdbK6eMtB7Xl9uqCmTY2o?=
 =?us-ascii?Q?3tZYIa70g546foc+1QjeXHa9ItieW2lPwUVSX6MyqrXDXkszCBB3rJVglQar?=
 =?us-ascii?Q?rbzfA+f558YCJ+OdYiCY81s7LCcC2QR1Q5gIssaMP28es0Ba/Fnc96AX05HA?=
 =?us-ascii?Q?hJH6vWqEXyLo/zmW6FM2mHtFpiYXjAx3I5PT+nZ/lkzcSroO7kPmz7Rlbvpd?=
 =?us-ascii?Q?UtCrRFbAuBtGMa9AjqIlb7UFooe13VGJlHx8FQaAdIj/vHHhZhI+HzWkBkZL?=
 =?us-ascii?Q?DBK8n96ZcEpRcXAapHE3p5GSfvKb4vl6j1cuwQTTmaGfu/iaLbO0XEAm5VGQ?=
 =?us-ascii?Q?SUmlx04ygPrjEyE2Civww9Epcj1dtSdpVjlcl9vTqYkp5vaH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00faa88d-66cc-4f81-7d15-08de9f53fd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 03:13:40.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RHrzQIuDam+b/kLO/ZIn+gotkX4XkXAXZmuwjH5/hnrRMG8F3/RrRNlyOJKed8+6WyDAXEZf0Tvnz+47O/ozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6080
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10257-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdevbpf];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3BED4360B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: patchwork-bot+netdevbpf@kernel.org <patchwork-
> bot+netdevbpf@kernel.org>
> Sent: Monday, April 20, 2026 3:00 PM
> > [...]
>=20
> Here is the summary with links:
>   - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
>  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?i=
d=3Df63152958994

Hi Jakub, Stefano,
I'm sorry -- I just posted v3=20
    https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@mic=
rosoft.com/T/#u
and then I realized that the v2 had been merged into the main branch :-(

Should I post a new delta patch(with a Fixes tag against the v2) based on t=
he main branch?

Thanks,
Dexuan

