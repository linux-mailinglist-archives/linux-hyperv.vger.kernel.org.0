Return-Path: <linux-hyperv+bounces-2729-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF39494EF
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8C5286B91
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC93D96D;
	Tue,  6 Aug 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EfZX7ELr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020121.outbound.protection.outlook.com [52.101.51.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926093D966;
	Tue,  6 Aug 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959781; cv=fail; b=As1PHTs98P2KGRbKQYU/qBbr6Tr/RNQYnbZKKh+Zbyh30QPbflMqw55FJGz0qIKxzXbP6aWA70uxqxDCXtutsmKugdG4dWTd0mo1DqDW3Bub5wxSRgemFUsA0nrlGgLnxY1UN1h9yz5qtjiwG3baVf2ZmR9YRJvinwRiY/d201c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959781; c=relaxed/simple;
	bh=6qIPHjOJbT0qAwoWMDx/tJxWUzs3B0anR5YvTfR7V+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKC1nDEB18AOE4FM1xmmDNso8vYElr/qr1spNk8vP5/NJTSb4xW2qvWwLIhahEP3EuzyWL/Y62IBIha0iAOhkufHANhPU+uA+LmL8GZYu7+rgUqe5K8+Qn25kMXeWlL3raIRlHKmHQW/FKsBX9Bv8vfM/YKpY0OEktySKoUm6GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EfZX7ELr; arc=fail smtp.client-ip=52.101.51.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4pYGRvkOJVsHOG2LLBMqYKwa5oVHfkf39CEvCfHpB19RdK7GixpNzz4Ple0yb2Jxp4pqIuJdy6B+BExiRED4LK84rvGiUkRdaVfkSRyut5VqqLLE1kBJApWtWccSSgCvrYpCntu+fGalGg/NkIV9r2KPwpXP8NvwQDlnc6j5A1lwTGHW4YDYYjKIWwFEPoAXgQFLwE+nkfJPgDr4gepgYjSoZZ2KZR7iKioXA13kd0C4WEa/1obamjiPCFxwAnb1+cJGGDAuIX4GJtqr15Xz0zP7HArjFywHJBiu1NnCIpB67FU7I0a9yaNXP9FQ0uwCKc5Jp8XYOJ1Ypn/duThaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qIPHjOJbT0qAwoWMDx/tJxWUzs3B0anR5YvTfR7V+M=;
 b=ahby395PjMhl7tWzkVk34c3pieloOPv5/kk5FR2Fe24XMFXfFt7rBM4P9+hOCLuGuj016prBsRoeBc/pnCQywjjGyJ/0imMZBIZHZ4X+vRXUtBeMXxRygx/ATSA3iIO8/FwjPcJWXnxvPDoo3kk9jF3KIe0qikFHsIOktb5rZP+IAgSOnDkSZK1k+1WyNq6g/KrD8K1C85nvA0UCZwwKTuo1aKdy2cBei84npkSzr4Dqi2uHjpUIRABHQatdcZAe78ZOW1HaCVgl0858x4uB5khDl5za9PmiO+vlMsgeb5v3t4CaUt+8D2vDyjmIYFp1T0/MEcvln+kZsjQUMFGL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qIPHjOJbT0qAwoWMDx/tJxWUzs3B0anR5YvTfR7V+M=;
 b=EfZX7ELrVFje+6Mvuhf50c8qJJvaXJGQmZ48dC2wp7THyzf1gh6WU/4lMPt2QQnVL5RveD1gz4B5QF4tY/wEjf3xHD7qfcQ+O2BcaHHqk5bWKtqDQR0vQPgZuWVg/1N1nqQjVS2b7Cl6FHA7KekvqcDRTYPJVm2mLJuZwu8S5OI=
Received: from PH0PR21MB4363.namprd21.prod.outlook.com (2603:10b6:510:335::13)
 by MW6PR21MB4009.namprd21.prod.outlook.com (2603:10b6:303:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.4; Tue, 6 Aug
 2024 15:56:14 +0000
Received: from PH0PR21MB4363.namprd21.prod.outlook.com
 ([fe80::cd0b:b1df:c50f:68bc]) by PH0PR21MB4363.namprd21.prod.outlook.com
 ([fe80::cd0b:b1df:c50f:68bc%6]) with mapi id 15.20.7875.001; Tue, 6 Aug 2024
 15:56:14 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Index: AQHa55CbOjgIubhFREaQM02LT6ZvcrIaYrgA
Date: Tue, 6 Aug 2024 15:56:14 +0000
Message-ID:
 <PH0PR21MB4363D5A242047944FBAB42B4CABF2@PH0PR21MB4363.namprd21.prod.outlook.com>
References: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=607fb8cd-a02a-4e3f-99b2-6f7636687c9f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-06T15:54:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR21MB4363:EE_|MW6PR21MB4009:EE_
x-ms-office365-filtering-correlation-id: a204fd2e-0526-4a5f-d45b-08dcb6304ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M3u7j8Dbld3igetVDcWMoxazNDbFCYiSiJhMWSC/dxUQiZ7jnVe6Irmz/VJ4?=
 =?us-ascii?Q?XQm1mB4u7Oy/oET2tnaoTqRbqdl5u3w9GMljPDqFNc9Q13mt0mwtlIkYUL3t?=
 =?us-ascii?Q?e5sOgDRGxiJjRnUbgTr+6P5Gtaf5ryvyUWo7ZQAf5bIsOyovdy7rqlcyMZDP?=
 =?us-ascii?Q?HhJXiy1QCGYVdXIuuncJFdpIU45RFxlKdOI69xEnvZa3zDkrNmcs1GqH4kfp?=
 =?us-ascii?Q?xTvFbmU59CjHDhNFOEgcdH24p0JgnhzK4i/TJeGcl4tm7zgfPC4hZfIqefqu?=
 =?us-ascii?Q?dneqZwHMfIQxv78C6O2HU8/MMmhC7rQByWvz0R4DKGgddH7qEpAoqjFc/Dbp?=
 =?us-ascii?Q?XGX+31SDlURpLCo/SV0yGiwkUHmSchFYQmxFEQso3sPwqzvpIKrXeGaknUBU?=
 =?us-ascii?Q?WnF3LOk0+wo8V962OgTfQrmpVad/FevrzPy0SCLotZv+CVrlFwCPCncTH2QY?=
 =?us-ascii?Q?t7+tmwGzzLkwXcPo7Q4ELTqZSgHVeirA3ZvBuMdCM4I07cdx4XTc/z456UrT?=
 =?us-ascii?Q?1glKgEkAoV7yY8nL6f+o1RhJDKLgWrwZFZPcg1fGdVb32IOLpjw6+WoQNQHP?=
 =?us-ascii?Q?zLNemUI4+HqsL9emzy99G2DmqbUWfzL/8FcMpbzJxjx18IGvRSyLOdj+h+fe?=
 =?us-ascii?Q?W7h7DtMo7m17v+4z7ws5xfztVl9zXyRirDh1XPYihZAXFGf4uJ71sJLOKFFl?=
 =?us-ascii?Q?BfmygpodAFSaVD8lcm681JAhPGpgSLWcR2CjDpc6XZmn/RbEJL/Zn3Uu1Gjf?=
 =?us-ascii?Q?AdfwjCzWXvJNNuXgBryPtvy3x4aR8S0baPxVAgoUgIeD4bX5DYxX9CWNbv9V?=
 =?us-ascii?Q?+bQRtE9mUSAiL90DcdijF83BuxnBNLaVv+Ntxr/BEGVdiZtulKw3h2OAlGkE?=
 =?us-ascii?Q?ZOOnTHaVhZpz3kkizwgx2o1rMtKaJQgh8YBBZycFeFGp+XiRVS8IfiDuFOy4?=
 =?us-ascii?Q?VVqC3juCyeCjolyte0pb/mKhmtFTbJZZn4WfvZ1v83QXaBcfpNuXfnZKzaUI?=
 =?us-ascii?Q?gaUp8upsFTwAja+j2Lr/dNAQz23r4Rs+QxU8eWm6o97MLlZG2jF4wbJATc4P?=
 =?us-ascii?Q?lJO1Tkye1X4sveylx70j+dn6xaqeIHlJi4R4XZ2+Any00jm4xqax2eWJCPdH?=
 =?us-ascii?Q?ABLgvSrhLnQYj8dwc85BD+b+eQeYAOtLQBE2v1aDqEu1it67nBHMrv2Do9EO?=
 =?us-ascii?Q?XtrAsj+T478zbQRSG4bg2qNNMtksLB6Ip3/CnCffGPtVIikC9nCdURVgrsjg?=
 =?us-ascii?Q?Cla1aPov5g8dFHzFs5/fqIXghnmODhovchPHsJOcKetqbqKqv1EC3f2hx6+S?=
 =?us-ascii?Q?WPZB0BC0REopFV3Kh7+m50juuHj/7Gvti8eOjj870jcu5uZZW0JG+JNvtoED?=
 =?us-ascii?Q?Kyf9KHueSRYK0uCgZ2TdocrbpZ+rRhieLx0Jt5NXhe8LIeGeS6ikgpX1gEwn?=
 =?us-ascii?Q?R2ZWvQAcaGo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB4363.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hCFrY0l8YushA1dIoYkDz8+tdo7Xslh9FtzqVLnS9u6J97oTK62aDyTCOoXw?=
 =?us-ascii?Q?7M4noEiziur464rGuancV3ND3+egAkUi6DXrB5LHfwSHfxJNcZNig/Hse5JQ?=
 =?us-ascii?Q?V6RsuQCOAqfGM1zb60UVCtLwezOBHB4lQUlAH4Sd4f7ZRkBPlK916eup1iCi?=
 =?us-ascii?Q?7GK2JGVXmklLW6bdHQ1ia/nw1REQKyz6SLWfhJb/CnhUauq14LZtjxdtEKIz?=
 =?us-ascii?Q?IxxAZfAcPq7PG0FfBrbVuaaoJrlaDWLTiORCtwrSi3Gr5J4dbADejWDr871C?=
 =?us-ascii?Q?IHaymQZBPqsck9L3LFfFoAxpA34QWkHgSFMCAshSzOoNcv0SkAHPyjekQSCs?=
 =?us-ascii?Q?mXYBihHqjdwjBpl+WOFy3Div+qm8pX6j1ySsEUhltN/dSxy4oeH8ZHaF4yOg?=
 =?us-ascii?Q?MYtTj5tUk9Pm2kTftuLVPF5U7F3XUVgG/3Pn/1RIPYmQs62G29FACX7Z3o1F?=
 =?us-ascii?Q?XxTw3Is9WG5EbXo/v0g0GkOyna25jkA5V3IKE5KzYZUk8D10ppgXkzoD4X1g?=
 =?us-ascii?Q?gfW7H9/vRbzh0QGWHthb50pOkUcoXE3G8FdJE87vSxggN8ezU1z+aSgR28L0?=
 =?us-ascii?Q?9d29acJ/6CRL6ldOeQrx5IlZk/ZwKgHS7D8HeZywNlDphQCZdXJ2XS+W+qnS?=
 =?us-ascii?Q?LSJIjJAqJycs/kmJPbNkyTNxoKclAVJPQ+nlA6HpzqaWph5GiCTNtzjMPg3O?=
 =?us-ascii?Q?Kxv58wdHzPpf/e/RsGu47NsEcl+qxstYaqoauCt2swMr96T9RWasyvU22+64?=
 =?us-ascii?Q?JCcz7puIkanoCzRvSc0d7IcYVJoBsuCi5Kzk1lZ8pNFlvtZFWP69kgvvEJ3K?=
 =?us-ascii?Q?g/b78//NT5BpTBRXl2P4UP7Rll0211gyQ0orRokTvepQc4p4CsSu7JO5JmpH?=
 =?us-ascii?Q?WvizswPHHqUCOVPhx0bl/HlAKzyab3Qy7jP8N2i8eMUGkb/mj8UvJfpYIGEz?=
 =?us-ascii?Q?92iU2Fe3rIEVLQ66+Fc18TgeWk8Xnwgs9ipSZQukBvLCwossOeJZUGdqrgwZ?=
 =?us-ascii?Q?dIfqdi+DTfrlaSVvwbn8cuvDIj/WxjzutSYYzbeacvz9zXdcNVm20NYbBzBU?=
 =?us-ascii?Q?UhCtDc60icHb6e7R0r/qrWprLvpMpWRsIeUQLLsY5Z4y9IINRmipGHo630/S?=
 =?us-ascii?Q?HNfO8IczbYez5gXJ/MoqVbE80p16t5fkovhRuKOuQOi6IrUOaBf/waTARzWF?=
 =?us-ascii?Q?1bCZoPOWfO4qAo0UaUo/JgZn2PdCd/0zrFzU+4J/nrXmPRweV0x3+mKo55HN?=
 =?us-ascii?Q?eEJlFWKPra+1ThiMTOdgtgWNOyM6GsgS7HAP6sXEuFhOEvbMYAm96i/k0C7P?=
 =?us-ascii?Q?oPmltkmmU8ZHz/PKOAGzYQTtTtPp9sx4V6ik/UfX/j3gem1DHUtbm34o+3jJ?=
 =?us-ascii?Q?NAaAU1vevGbgbLEpI9zp/XfoCkeK+BOBqcDY+PsPK66y/ljSYaEsbMnJJmD4?=
 =?us-ascii?Q?5eZz+ph9SPJjuWZn7qxLk6FepOm8Lr5jAW1+m+4E6saoWTnFZauWHdFtQc7f?=
 =?us-ascii?Q?I0v4BzAG+iThzvyVgxPo/yGdaep+NyRWv0nJ5XRfgppwmwUI5ZCN2wc0+HyX?=
 =?us-ascii?Q?Bll+iKZkR4DjvDCkkDD1fD0oI0wWMnv0ZEV90+uK?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB4363.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a204fd2e-0526-4a5f-d45b-08dcb6304ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 15:56:14.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nATPotxbuPKGphlK2FvYoqu7mSfWyCYFY5h61XxMjcRb/XyfH72MWxfXfmucc8QKZ586qU/XcMhYvUEg4DF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR21MB4009



> -----Original Message-----
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Monday, August 5, 2024 7:38 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric Dumaze=
t
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Shradha Gupta <shradhagupta@linux.microsoft.com>;
> Simon Horman <horms@kernel.org>; Konstantin Taranov
> <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>; stable@vger.kernel.org
> Subject: [PATCH net] net: mana: Fix doorbell out of order violation and
> avoid unnecessary doorbell rings
>=20
> From: Long Li <longli@microsoft.com>
>=20
> After napi_complete_done() is called, another NAPI may be running on
> another CPU and ring the doorbell before the current CPU does. When
> combined with unnecessary rings when there is no need to ARM the CQ, this
> triggers error paths in the hardware.
>=20
> Fix this by always ring the doorbell in sequence and avoid unnecessary
> rings.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you.

