Return-Path: <linux-hyperv+bounces-10320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IONsFzPB6WkXjQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10320-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 08:50:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0E44DBA5
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07469300399C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC13D16E9;
	Thu, 23 Apr 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A89CmPeI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022103.outbound.protection.outlook.com [40.107.200.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9C3BE647;
	Thu, 23 Apr 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927024; cv=fail; b=WacSEoGuZ82zEXCV0/JLW1kJPi5V8N731FlyTL24lvanTTlm13fKqKCGBo7/tRfkhwvE6KK2XJ3esPOnyCI7+ZQ+DberwVBbfFQGz2sRJZ33+AHzNyQwm17G6AsfO0c2Zpz1DKq62lwA/FjRgATKAyXCfQPyZttMD9yd1w0ATbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927024; c=relaxed/simple;
	bh=4qJMF1nCtTExQVULXrfZ4pe8GEbhSGuk6hAL7m9EA1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FnX/+3ovLiuaTds1G0kNF0TC+YGbc3CccR88YlW8wOSCSFM7T+DxKIoQgtvprN4GFcEW/y5C505QXsUnsOjvll8VfXw7Sodw9cRArSyNRZr+6jZD61JV7UkxuNPg6S7gf9pncEseWKBpf/nbFvU4YzE3fzaYBKVx8AlqdEhpHJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A89CmPeI; arc=fail smtp.client-ip=40.107.200.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdd4ls9+dzJDbiECr0vXG7fPRuLsqwWkFraU5YKMTmtBg6KIOxaUI2qO/1N6pNF7nDQaQ26wo9vdAaiCBCol1YAwOcQSn8rL/3dQ6+paPy7e1mTefU7R0Dzw9pApHUq5hkTyPsjiBRVD8BO+HSNwrrJa6ukkeOLzz6QL7oKGL6eLW2CPdagIpvdmGn8R/vQLSLuws0qfmuhcySBRVECcm/IeIDc0HJwQmlXjKM6fA71ZWGZCs2JWTXMAPspKLTyKlMn+XhUYHhTXRKxQXgpaMHDOhwmfFfFuMv2XWbY4ZTupOOEN6XsXDbAw6RyaPvCdhFYDotm6ZVtbB6CBX3hnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mtb71w7aQUMFtIoxptDfKUaIwHFwrsg6lCAOl59gyE=;
 b=UaaR5eNh08SnE1L0G0MF+swc25VMVZGg+uv2JPfiwrlD5Owi0QoN+d+JCNA9VFxm9rv3sA/WhkwwwD6a6gOQ+LsWhrtlY6UG+aiaEOGDNhejl0Htb4AAi+YNclWYYGIcgR0LK6CBMgCRc/kdqZAX1XII/KlhK16ud1Gk5PUdDlJwrJg4SnV6vG3EFbmlK+cW448VuKkCoyU3ZKaT1y6c3MA5Q5ZDmZ2MJrmwHvrqO4iHGDCP5vJnfEtDaS2Y95iLLq4cPdorJMad5puf5QuemJehtM7pi6VnRR2ut3cRGUZ8Vst7kzvT/qgYhvwnU4nWfxICUpOiYe0yNj7PtVo6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mtb71w7aQUMFtIoxptDfKUaIwHFwrsg6lCAOl59gyE=;
 b=A89CmPeIfzE2ewbFC7MoygSxn8Vxlbc05QmUMRiH2OWjj6GqPEew2DfpB6hpo5lhIPes68SmIxldYEfsocdf6YfX+fQvFYZ3udw3IvIV9YoWXg595/ESkrpDoOat+HPxxqe0c1HE4jflKhc6Iqg95mwrAqjF/Wj/Aw+1Iyzfv0c=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by PH0PR21MB6854.namprd21.prod.outlook.com (2603:10b6:510:37c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 06:50:18 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9846.007; Thu, 23 Apr 2026
 06:50:17 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>
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
Thread-Index: AQHc0jwGNH4NsmEEz0q2k3KJ1A83+LXrYvQwgADTS2A=
Date: Thu, 23 Apr 2026 06:50:17 +0000
Message-ID:
 <SA1PR21MB6921E1084638BD3D25CC910ABF2A2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260421174931.1152238-1-decui@microsoft.com>
 <aeiEsYqcKumplu5P@sgarzare-redhat>
 <SA1PR21MB6921EDE5E6530B09931ABD93BF2D2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB6921EDE5E6530B09931ABD93BF2D2@SA1PR21MB6921.namprd21.prod.outlook.com>
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
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|PH0PR21MB6854:EE_
x-ms-office365-filtering-correlation-id: 4251ec4e-7df5-4072-bdf6-08dea1049489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 1KIEHM9X3QlsULHiXtv5JgHLolA3akWhjQkwVrlZHLQfrSzasno8tKg1uPOQ6NAD5Wl2uY1tLIaFs4svOpfNxrQj9bXnBabXKfQGFLksQgDc4DTiWYWksHodB01+h+07PRywL8G6tbHy/iGkKCht6fduMQ6sBdfPFGOIUm8h90cZsZTjNjLpdRt0r/PsIuUHb6H8ilhVvv+hyd0DG3+Xtu+Toc4HIX7EErCrbyeUrvWVMN3qDloMKyVzV5M3GBReh0XAFX9slKubMHi9OqMKfbf94jLs/nTl6K8blITqzlJ5TiYIzXdjLQ3vKlrjx56iJk5hr9Wwo+tsKDl8M1jmn/l0/3VQ8uOaYnVxLXHLsbukS92htNQQljvXHPrNrvQ7r17p5eVo/pKDi12wmUkj185+OoSE/zGTFJYWkxhGluSHkLErrP7t/IhXS/IvY7XJtGp/8/Qvg+FS6u5zHybPbvA0NL912Cj3hFmAStv6qIq1FRItzAMt3WJtyy2YqcmbEMtqX7kUkZiC5uDhn6oi+fCCbaa/g1GvwhN7uK5XZR36pZk4Mu/0JNLMGddQ/oInrnJ2uUL7iVKaBNRCvo7INt3gs3NlO8y9sWPkJCaoZxS9ZDRer3ih2YGXNtKTqzeAppjkjyUQexVdjXzjUQR6Oq2VqF4xBasK9K2FbZMPswcTn8tyc3gyFVlu8TNQKf62QcY2RTRTRvsGe9BjnBJBdSu43HslIX4dDB8lzHQ78PfICuhjcdwO9r74UWKnQ4YW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IGaHJuw/0A2Q+amtYWq12nRYPD3trdZrB6MVFRj8jH9/mEoI4tSGXSZyTMvW?=
 =?us-ascii?Q?WQtB00gTbcrLmcNOB2OKpg4izQNR0fHiZ0pg4j6vXa2w5QqQ3VEQNA+/tcUw?=
 =?us-ascii?Q?7y/RjbJRfZLEsh/by00z6pVUudA7neXFfiOO/8RxyH2GMJtrynX4pKgq7JNZ?=
 =?us-ascii?Q?SUhWGUZNpkoeepuTIsaxxtV3O5T+Wz3sPMmXtO6aOsHZoBAzIs+r46vhK3r+?=
 =?us-ascii?Q?/4BUJwjFz4BzVbew8iyRc/C1CodMUhjyv9CwQwWUqkMK9Lgpc5iYiHpVUCCI?=
 =?us-ascii?Q?+4I9WPFeWNqVqTVx2eXF0z1lKqqQJWwY7xoMYQjMthNqV+9OirPE8D7z7S8m?=
 =?us-ascii?Q?QOuTL2WY5Y672ICop+OWfwpBjnbelQelFsJU4rM+V9VcSJ9Y9hptmHo2J7qG?=
 =?us-ascii?Q?qMdzK6aNEvBeLP/q9ucqFky7HZCXRPNHSJMv70Myn1D5LW6oDr2s5lo5Nh2Q?=
 =?us-ascii?Q?TsbvhXH00gxuQQmQx/uHKLFDJtZEQUjsPuhes4wWdnujDdVPs5DgoC6wATW2?=
 =?us-ascii?Q?SqRj/DVhb/lGic8rrjkDlOsSsJijO9GeFRLsLCEJIVxRKtxdQDXcDrKbmxb7?=
 =?us-ascii?Q?yPEpktW6FNaiFkCc2WvLurETItLOY0lLfc83rKJdBABgw95ot46bKTz7JMbj?=
 =?us-ascii?Q?XGCrQrxqD454AaQ7xR8SPCV2y3iGl+Ci+SAHl0Hgx3G1fAuQzjhTkWEyEQOa?=
 =?us-ascii?Q?0Eju3ILQL4T0QXxkKvvnNY7SouXn4w4Hu498S+ujZDqewJluX+xTL8VQ9/3/?=
 =?us-ascii?Q?ZJn2TexjwPWnrALRX/CpXJySHKm1dFKvHW7iZsHiloMZDziIMi+6CW8z3NzK?=
 =?us-ascii?Q?PRJ1R3VtbE7viaaKYKuzQSuCXW6rm3W+lgGLtPgtvKNI0sNS28BLuN/RwTgP?=
 =?us-ascii?Q?YowBjPJwVaH02yL84ZnMe4YLcNzutYDHbfZJ3oUoFCT5m7w+5ua3NHLgrkhX?=
 =?us-ascii?Q?25XWcbI1+/z/iyDfw/03jpSSjxQsHhLahK+koiqMLi5Y7C3gfU+MkHh+7GtX?=
 =?us-ascii?Q?7AVsSErKcpAv2M9tejI5Hc1Gv+wwOKLeUf257DYLbHxrPkLW9QS5toFwI50W?=
 =?us-ascii?Q?88YXh92nNKLAD3icUsWxtZyY9NGIP4h4pz7ouuR3rn0s1ozKJl52/99h7HY/?=
 =?us-ascii?Q?UIKuMnpWaYWmWI1I7skAY81F0uKwPblr8c1Rvjegbp9cf2/JwIwnyjP3rpoq?=
 =?us-ascii?Q?aM3PmGJdYHKK4nn+8LoWqUvo7b1UeqkZROoo0SXs/uZaE3YENwzU2eIs56ri?=
 =?us-ascii?Q?T6WKYfSr1M5246mH7mvZh40AjseSfc0IpHozrqosMBTImZNuHbPXrAwzMO4K?=
 =?us-ascii?Q?MJJk+SuiTc9qFlAZaIdd97niX6mYp7m3sEszRDlmnkKcYlL0F2msNhILsgU7?=
 =?us-ascii?Q?7mRrZGjHScGNT07eHAbr6WCJQHlf6oZx+soIMxt1U/r7sNPyOWM5v1RvTnXf?=
 =?us-ascii?Q?xJ8LQywxPJVAzm5AtH/0R3w1on3c8fZT7+1skc/unU+0Tebkn3D8ugox06Y+?=
 =?us-ascii?Q?xlEcmBv7Mxbx09IWypgs4vCwbILElvdcUEDCy7UX+Jrsbe5ZOrd5ZeYE0nZT?=
 =?us-ascii?Q?rHiUftqhVEMO1mjgBrlKCFKYQAsS/LQvqHxlt0jxL+TnOuqDYtdw7sbub96x?=
 =?us-ascii?Q?C0YfVSVuDKRrXIwWKLGnYVTcnA4x23OtdgY12FhbQ1ylYf7kdxhnDNzgRDVd?=
 =?us-ascii?Q?e+y8dZ73u3H5SV593Uu6XSSFJWi8M4X97oUBUMhy/c+FE5Kz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4251ec4e-7df5-4072-bdf6-08dea1049489
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 06:50:17.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxGcSkJZPbVyVM3lKHk9qJzck4UfZ1cC9Z59Isfz6oIub1oFqTUWIjzM7WvaD3kRsOjM2+XRPOEvWuqZM2/7Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB6854
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10320-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: EBB0E44DBA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Dexuan Cui
> Sent: Wednesday, April 22, 2026 11:15 AM
>  ...
> Thank you Stefano! I'll post v2 later today.

Posted v2:
https://lore.kernel.org/linux-hyperv/20260423064811.1371749-1-decui@microso=
ft.com/T/#u

