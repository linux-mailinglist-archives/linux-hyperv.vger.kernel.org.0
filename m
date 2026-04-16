Return-Path: <linux-hyperv+bounces-10195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJUfKjA84WmaqgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10195-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 21:44:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEA041444F
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 21:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F2C32150E2
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67838396B8D;
	Thu, 16 Apr 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TXLwNyTX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020100.outbound.protection.outlook.com [52.101.56.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91521393DE8;
	Thu, 16 Apr 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367856; cv=fail; b=atlIF+ISNnbyGYX3CADq49Cga+RFRlQbSGdQjg/i8eaKWbOSgzOe+/1LjWIcfauiD2qQcYJLXSbxps4PvvV28AE/cwfeFtCL58Q79P20EzwbXwWNTGUGvelsbCsSPt5ZUe/fRQtEJv7VtwgwjhgPZKRRR6KwfueEc0cmzoCdbhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367856; c=relaxed/simple;
	bh=DgnweWmWkG42ACSORvhaHn+vgYaEAN1R71KcZBqbGic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h60z2lufv3EYKkXWMgqEkm2SoG76rcQncP8O1k2F2vNcQZFC+HeS/PpGC2fCwvoGw1b6PpQ7GR+cis6NX7TqQl8noOfqX6wFFxGH1b4czgZp2ej2vfRTYIU/HD33CGiHbFdGJsZ3HfYJncfno6nNcespP2y/72xrftXfHpK75pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=TXLwNyTX; arc=fail smtp.client-ip=52.101.56.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkozeYpfba5zIGcG50wb9SL3gdfRDdujkZANzVciErE3nqS5Ecl0lxS7IwGItnAYLH37QxbtM4A93vhVFoyU5ubIIp7Smh5W2KJnq4bH7dXO2fslIeNy2ImWaEGkElryCbVhFUA2k5zCZapeyGjFmAGRbaYFiXIPjmTDAOIbcDPbfBdGZGLn3ochBkX8aAeShfGbr5TSJwzq58BZdD/0qXunLy5o/GIFSYvwg7235nlAxsvFxdHwhUbvoxmQmGbpvf/EkSddMF9nBEJGm+ySCKTjCgUWf149IGlLD+hs5Oht138T/PPWc2ECqt7rvS03JySWjyaLt5CXhF8jVH/SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgnweWmWkG42ACSORvhaHn+vgYaEAN1R71KcZBqbGic=;
 b=Y7nTRnKT0JRg0aPjlvUvWVWs2fOR/6PXJ/Wpko7d6ul7XU9NmTb9ttl7rdH8sIftiMevTX759JdOPcV5zfuClbu+pLDUbKFsfVPOzFIJV9vSgeK1LMIwELM3T0KTPant7eBfZsfMXaQPLzNwhik7uqZ9p+xaOsYgUspHySUYlkJ/FtZ2jaeJGuRgBnCsyaDcjBEDdHWWhwa+EfVSjhvdKIiIureDJeac+rZoctfgNS9KqYKEbRzSPmbtujJa0dP2s/Zy9Ng3ylspgghOYb9y2ukvtg9GHep+4DYdKNLrvk/njt0x0G1HOqOdbP9X6mwpX/4W5/QpgLocgAV0e4XgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgnweWmWkG42ACSORvhaHn+vgYaEAN1R71KcZBqbGic=;
 b=TXLwNyTXbQdxknOS8M//fUP8ZO5kFbJik9V5bIfxg9870CB7O3MGsefbLybMpk1xrPR1ncCyRH+34nOU7KCodA+07/08LQMCvREs+UBG1t4oEL7zjPWikwWszNzD7qhZ+qRBCRCxf9W6uyoOIwtkm/C3bPIapioi86FlAWahlQs=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6682.namprd21.prod.outlook.com (2603:10b6:806:4a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 19:30:50 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 19:30:50 +0000
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
Thread-Index: AQHczMP62DSp8tUfXUqykY0mY+sLYLXgVi9QgAG/H6A=
Date: Thu, 16 Apr 2026 19:30:50 +0000
Message-ID:
 <SA1PR21MB6921F3052FBE78A408F59697BF232@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260414234316.711578-1-decui@microsoft.com>
 <ad9pPrji1uYSgNir@sgarzare-redhat>
 <SA1PR21MB6921C57E27E17305E56BC0F9BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB6921C57E27E17305E56BC0F9BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
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
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6682:EE_
x-ms-office365-filtering-correlation-id: dc64996a-231a-48c0-7ced-08de9beeaaaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 AIp+C7UL58Kf8p7tfz01A6XpbZH4sUQjz6qQ6RUKOZXc8PdH4LCuwXLdfXcZEtxP9/BtDbm7FwJmjrAnfuZLxzqUJ6ORnp1OTu+qOfKLHGVGQ6MqekK30GLJ/zQ+wnJVtJoAbt1r8pJRXXXgtoCY12YKAVYmdDYf7xGsl/n17uRa3l9rVG/kKrW4owiQr86hKwtcUb8ZXORmEf/EuUPbYVYso0+ES/iYok0Df5T5QW8z8l95HpkfvIWz0Zrc2CBrf0rp0kH2x/jMiS9xiox2RZKAgOjuGmjknosRjbLvomETEDGAwiKDBJlI8An+YktiUGg81SoTeQM0c/O7oCSipaGdsr/48diLMZxlPFhJKm0xIT3/B0nrXnRbmh/F9Sh3OeUIaRIdgap423wOz/S+ntvUuNtH9IKa79l9f5fOXVSowadQTZ3cSfErhB8tnUhg9zns7t7fRrO5aJl2WvEiII38E47BM0bCHZ7HPHBLtFg/d6p3EPguej98y3gadqeWH3Mdcjr3IvVRU5HPBkp4xqCr+B1I60j+NO6OzIV8bh99OM90NvfD5HCvXng9jAcJV6OpOqSyflt9H/6HZ9dGMz1vVnh3TkQGahGUk8U88Hggre7J+a7F5pHr1mR62/yMSup2aZpvnLRzFo0QEYm7o384Ia0/4C3RLdOep6SnXCwzRU+jpkmHp3vdgJZrmGimRtNPXTBrrEhinqZIpXr/43G8VFAwKggrVj6h9+qBNhqRlKZ2/no/GA8udddhM82h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fth+qfDnrmxN9wfgb+si3nEammDX63FgYzMff6dhFKl2KcGMqPSf4hKDyhPk?=
 =?us-ascii?Q?9MpYaJW0/iA+/fGFZ/y2Kibpq5VurJ+bFID5faFoKzNt0sp0wr0G7JKOssw2?=
 =?us-ascii?Q?2EJBD0jju+iY8qyto1a8gp2lGzmhcmqEBQFYsUxThoZxIwyMEXTDvSjEWGfB?=
 =?us-ascii?Q?G2ebtRG7Wg9N1zugQN5DTYnTfDHS1VH408cQ3Z8PR1YjY/miqWhRTODmx024?=
 =?us-ascii?Q?gX5mfNiN2yYMZR+WAmf4nzdXMidHtu87ai4gY60c6nqflCTR5ByIxbEZHPB1?=
 =?us-ascii?Q?1y2dU0zjaDGx/XEhqxTpxXChZe/fh8naRwb+lu+Jd1kfXXM08jSGTaeFXKqB?=
 =?us-ascii?Q?CXVqlT5QaY64JchdV3VAgV0svgSkI4ygwEJyOL0FdyqRQTfwhXvYVA5P7+/7?=
 =?us-ascii?Q?9bYasAkQUZOGCmVLDoucTiXGgmO52SF+jVEiRW+7Cz3g5PD6+ea+H9KG7FcZ?=
 =?us-ascii?Q?/OMZnRHzjDcTdArNqh2j7ZUNjmirHkoKm5zakxJyvG+IkaaP/YGNk2Lf+eBm?=
 =?us-ascii?Q?Io6cLPJpMWOm3+eIYCsHAQ+fv34nUXgawrwH7zetr0+Xl7M0xlgQXF9nP8GA?=
 =?us-ascii?Q?KyeuUANOrLCeVmkPWKkAhgf0sh4GYZJPbv3vg3/zCBCRe0lvLwCihsIorcP8?=
 =?us-ascii?Q?FPHOsGKOYqmguJkmuoAPtS2Q72hzlen/ALN7TEL0NVJRK+YSkqjeNscSPEqc?=
 =?us-ascii?Q?zVL5yh5dsZoHrNOg+FWTmrVp94wq1XOaq6NND+5J0ravkYlORINyrkI8QWzY?=
 =?us-ascii?Q?IJI1x+G+2ryUt0br6ygbK0iWuNwC+PgQowEyAg0RqSZXfXNvZsrRvjcLfqfU?=
 =?us-ascii?Q?ISyEXQrH7tcIdbQm1bOK3KeexQdqz7snMMeF2t2/2qiKiKYIjklHh3dtQQfS?=
 =?us-ascii?Q?eVb8WDiUEbONip5dRMlojoirAFV+UedbEskLSUc30SZLl/fTalZb1++fxe0i?=
 =?us-ascii?Q?Y8Ek7FaZ/oAFZtI4hoLQAEo5QV2Jk26jkrij0yRGkFdNShUWGukygZycyfDJ?=
 =?us-ascii?Q?vhhS0aXKqvtEMuOu7ciFlXroJAw7apk4ZDCxTIu2FuEItjMwrfF1KxI/br8l?=
 =?us-ascii?Q?yoKwHEuh4O+gtb20XGU04OudU+QuYpQCyhbGWtp35jUb7obhM6JDDzKw3USc?=
 =?us-ascii?Q?v7v6Cns1D8ga1kswqSPaPUa/biSWkPqXMZfG1s+j6CyzfaMKUf1DJOuYY2Fd?=
 =?us-ascii?Q?Fpai+JVXqgSB813gtfEALGbiQ7dttAqbZUHX3OrQJRcExB9OYAEMWHfFib6o?=
 =?us-ascii?Q?q83LQNNix1WHDWDtgK9lfqrKcWmD383TDGhgEe9PNQzLGP0GYAcsMh3XL7Wn?=
 =?us-ascii?Q?jFgeMrSmo1O93Zyxr8lKj+/M9ARYXDIbYsT3nXlgJugtRxYIoQ21QsAB883f?=
 =?us-ascii?Q?94rLm7iRvbEy0Pq7opCOcnI0CMzxYzM/ZI3meacR0dexpW/ipgAGfx6m4jj7?=
 =?us-ascii?Q?SfMeSGGXbj+q41ZTtSMTFNs2LzxET5g2D2kWUFWmWzKddfcAvWnZXGqeT0UY?=
 =?us-ascii?Q?K/tUwIqJ0/xvLqdEXI4ojjfSuBNPACO0GW+px7gtoBxr+oCEaH6xnmw1QfBK?=
 =?us-ascii?Q?8upFLy4AniQ5811j/3Ua5CWp4mdHm52MFnE8NRYMTxIkclCS+J7Ye5iSzhjl?=
 =?us-ascii?Q?vPKkcAJSLJpFhEuKm84vSHmFGDzvASMqmW9/MZcAH5h8sLjuJG8Va1+/LF74?=
 =?us-ascii?Q?TBuMm6d6H3vTwgzBIvyumhe/IdYeEyNcPt/9AZBOcuo9kw7p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc64996a-231a-48c0-7ced-08de9beeaaaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 19:30:50.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heAs/KXzOaMi5XJMuCqegpTGl7M6v/3aCs8Ve/9Z+hcVvaWRNW8QUaBfm20j4KI7TW73ExKTSW70yzYwX5BMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6682
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-10195-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2DEA041444F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Dexuan Cui
> Sent: Wednesday, April 15, 2026 9:56 AM
> To: 'Stefano Garzarella' <sgarzare@redhat.com>
> > ...
> > Can we drop `need_refill` entirly and just check `hvs->recv_desc` here?
>=20
> OK. Will post v2 later today.
>=20
> > Mainly because now the comment we are adding is confusing me about what
> > `need_refill` means.
> >
> > The rest LGTM.
> >
> > Thanks,
> > Stefano

Hi Stefano, I just posted v2 here:
https://lore.kernel.org/linux-hyperv/20260416191433.840637-1-decui@microsof=
t.com/T/#u

