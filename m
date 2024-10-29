Return-Path: <linux-hyperv+bounces-3203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE69B42BE
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 08:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D10280FB8
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A39200BB7;
	Tue, 29 Oct 2024 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XCcbHUZI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9381DED6B;
	Tue, 29 Oct 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185369; cv=fail; b=qkARgq4evaXG3oFoGteM6ErRV7wXIMTkF+oQAaGTYrMDkiS8xCyETwhXZUhYhJWl8ywX4ZOZlBCAxXstGBhWO9Ezijcx5lPez6w/6VlOCGTpqS8pil219K5nrkubCbz1M9t1InJ3T0y0KuhyFRDo8BJQRvi/ND3QqZu1CZxhOaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185369; c=relaxed/simple;
	bh=97WDTIFkQ2QzrY5fsPmQyQdsZI7j//2t9JW2EQuZhlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXM8V9LR1ZofxyuvrHwKI4koUMH4LOMf0i3qvQZx3EKBRPBpBT07HGPXD0I8oxST7nxP/+K5Rhu3L1Bq0y3b7tEdRmIlHxbUq4uz1ig8M278niBqrS3jWQu/XdC+60afYX49B8RogHIhO9/nif52uDH5sAL0ppacks1mog+GTSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XCcbHUZI; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNzgloOktFxFS1OQsE8NL9Di/wkscF6VsQxzBXO6gsLDHe40NJJD097uvdvHrTVkqevlJ74SN391Xu3q8rKnwpcZ86MeA9h4CBm2eJkJaIDShM3Idyib0ONmYtudYGrnOFHOVUDdv5ii/4IVSiGYApM06K7548Pxg5LZ0z8xURPXv5BQBWkV3DPRcttZ3GotimbGmBQhSOj/e0Q8WbGgQ7vrhalevSOYqG0ojDe3b+zCvzF5SL5HA5iAEuba/bfVnDlFuS2xW7WWROJFMXQBP8/JaG6/0Tq8lrEqFvvMFotb9FhouiQZQmEO82ljAmUU+dH/G1YWKjI7pGaNXKAr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTYBr0CVaq3Fs96CDx/XAXrfjC3hr3TNYQLp8M+D1U8=;
 b=bRdnlhW1MKWGXCwTMxRRhJFf5/cbGbnzGuwwtAk5e3e3SxNiwf+Qw3TksM1NrGTuyfJl2ZYRVLp+EtDskLhs8/ZZHmqSgQLB0cwUfhlpEj3uRL5NCpahJPYch4p+oP4B+0No31wbfnkGHmoTcga9glBGsgzg/XuW5Dl23DEWYep7BUKcfSZSJuXWpT2njeoNv/CB9iBtrMnz0cFs+lhW1nDvTydmGP0g18uz3iPVn+PpZ2sSjug89Y0yNMWamRfl3rvqGUiRM7XHayAx02i476U0VU2iK0zu796IBpjFo4Tyo9Uqx1/Eowo3x7pCrKiRDsPwlT4iRjUj64PEZXOY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTYBr0CVaq3Fs96CDx/XAXrfjC3hr3TNYQLp8M+D1U8=;
 b=XCcbHUZIS/6nQSftfmNWd1lO+051ALIiFxNiUGoxm91+VNJr9RBkloQ8xggczfzWgVC/tIwDT4vl3IG/ztldislK4Tf7UzO+wcl62ZG8QyPBLRdkSuv9LmJCFVbzrOIHje5CzEdwS/Sz3ChkMTi1hVgcXvxFD6v5JbmmzsXh/3M=
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM (2603:1096:400:28d::11)
 by SEZP153MB1024.APCP153.PROD.OUTLOOK.COM (2603:1096:101:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.3; Tue, 29 Oct
 2024 07:02:43 +0000
Received: from TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f]) by TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
 ([fe80::a481:ba0d:8985:aa6f%4]) with mapi id 15.20.8137.002; Tue, 29 Oct 2024
 07:02:43 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, mhklinux <mhklinux@outlook.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] Drivers: hv: kvp/vss: Avoid accessing a
 ringbuffer not initialized yet
Thread-Topic: [EXTERNAL] [PATCH] Drivers: hv: kvp/vss: Avoid accessing a
 ringbuffer not initialized yet
Thread-Index: AQHbBIeCEqrjeeeYokKJGtyVJOMBKbKdlq9g
Date: Tue, 29 Oct 2024 07:02:42 +0000
Message-ID:
 <TYZP153MB079611D53965160ABA3EF836BE4B2@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
References: <20240909164719.41000-1-decui@microsoft.com>
In-Reply-To: <20240909164719.41000-1-decui@microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82089464-7f58-4549-bb32-b1286a28d5cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-29T06:57:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0796:EE_|SEZP153MB1024:EE_
x-ms-office365-filtering-correlation-id: 356c7839-91ef-4541-9527-08dcf7e7af50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ATT/EzzfxJpFSpHb45kX2s08yu9UL/OQaHxj9mgpCLVLv0Wdi7H+GlSiGX18?=
 =?us-ascii?Q?uo/zqn5OzEFlzWPs1OfuHl0oW94wCEqNaq8vEVAZHZqWhMmc8DQaxWQK2pRP?=
 =?us-ascii?Q?7NNxawxf4iRDcXG9Spobr0lWvGv0UO6FSqI4hCQrRDYMGtSsXNEw/gkWKNlm?=
 =?us-ascii?Q?OLaQx1+s1lKWWKH0Bzf8qGsXAT5REzLOWy5JXRi+SNUlsuo61zKbsGZhzf0q?=
 =?us-ascii?Q?6UroJ+Tda76mvh42KZ6AovMQqd/8rd9ZNgY1MI0SGI6yvrn/VaJohTVaYD4C?=
 =?us-ascii?Q?BS1RkaeZSg3nYF3gQOQppdWPqki9DrwoHmVJT86q/f0RdlcTuywnjUVTdxdT?=
 =?us-ascii?Q?7FY2UaBMy6cK971Ukqop3oU5mHR92xRreVTkAKS47WR6hYlGWTxOJcM0GtGJ?=
 =?us-ascii?Q?Oz7EhoP6VzuiHf7CQl7HfdbdvDfw9Mw7OxowVQ1M/7oL49zkqHI3GkmXYapF?=
 =?us-ascii?Q?qf+nfnKZEIJfmTwAsis0W/i4CPQ8SaQi67JO4VxVivpmy7AMoF+1SQCAlGjm?=
 =?us-ascii?Q?zO0TRe41iQIWLk8PyMgM8ZaFyefkdtcleRdpa4l04HJWQndIQPp+NpN9GH2G?=
 =?us-ascii?Q?q5cRjVOLyQW+LZnbd/oDiRyp4kbxvu6dLk5Xnhf5AR0vag4SqHJaTSx3JrQI?=
 =?us-ascii?Q?T7Aq8wbMJr7kNfbemizeZlewMRmcQt/jfbLiAKHlIbhILamlgLtUfXPudxl/?=
 =?us-ascii?Q?PDJqIlboGUvHDujnKufN/Ve75WyU0RKitve10Wgxm0sJO3qHDWeHA1yAb/4+?=
 =?us-ascii?Q?sQIe/SvD1WwBEpJubpXLdLNkH6cvLj9YM4lsnbsINPVYVec9X9pm4vNHWQzP?=
 =?us-ascii?Q?w3bp1ePxC4najx/qfBs++IJLlhfURKFpxo1JGtEZbxv3RPxL5aK6kmTSX0SW?=
 =?us-ascii?Q?JWhtzRPcO5dlYr6iv2fODT3/M9iyilip427ea3n2CJGHLD28DuTEvlrStTZE?=
 =?us-ascii?Q?Got4jHtCsNTwMZbewaIal5Azn0ZMZlTK9qZOmIlsG38O5AGSjFzytK/0H0HX?=
 =?us-ascii?Q?wjwmYiiouBiNiRNyZ8wQ7ZtmJHHGY4gpZ2zyna2bxQ869zzyq6atSioobyjV?=
 =?us-ascii?Q?I74H9L29tFJDkVF6G1JXLSlGzV8xgrlY7UdTZRW1TIMn+mrZZ5nTmOB5lQcs?=
 =?us-ascii?Q?UWxeVeuMKFLkMmE0RkuM91tBM/RikPvdEi5pi9Io7n7Y8p7Z9jwqFuj56MAf?=
 =?us-ascii?Q?E20OaknTMxHXa5cC1dpDK9De7wzm/tjQneTL6bDFNmDpuczFoJKVbmHTEcQW?=
 =?us-ascii?Q?ESBiXhU9yZv74ejftYEk8gCcddkmibC8vlmHB70WR8Ds3RZKNfmXyjHGsVng?=
 =?us-ascii?Q?AZhty9ybAJXPA46b/dmKmxWdJ5m5xwwnJbaiFwjJds4F7Y/CgPM3AIumWPjD?=
 =?us-ascii?Q?fj2eqLFmoGo4NPVjGuLrMaCSyeKV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0796.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?83BgARWuQ9uaq13V1fW3CDgqKzDWfbMQuOA7nwkuUl3t4H0K9I3gv2SuP/nB?=
 =?us-ascii?Q?0cfHapppi6+qHH8ckLEEeXJYd5ilBg634ncgl3B6UVZR4H/b2wbis2uuAT3S?=
 =?us-ascii?Q?IhjBXKc4j+9kwV3sadCPhlMsBlARZ2GpNryRtKbkQsNYTIeausglSwyEFgkn?=
 =?us-ascii?Q?vu5l7d7IRb90sVVU3somp9WUY82A5ZOWTW0gQNXxTGcNgypAtV4p7KNqwx99?=
 =?us-ascii?Q?XyPQb6XvZKXcaM5xwYIqisJh4IIkr4N3UCbDq+Rje9UzCUU2G7KyiCRSuCYv?=
 =?us-ascii?Q?YaDi9+zWASUpnE5h9WN04HrptJyuw/Jr/A+B61y3CsmX7t5TmIQR8WFCGqLb?=
 =?us-ascii?Q?+nqwBrcZbHd3cCRa+UOoItnpAfWdQ86n/ihLNArMKXEsGQeg+ZYo8n+8NR34?=
 =?us-ascii?Q?b4yFrERwPLT9QAEpMRhmepmbNSTksKBI2a0cTElfHKHAFH3a3dXux4AGfebC?=
 =?us-ascii?Q?dAWzkTnCYKfmvFaVLS5OFo/Z/mlxw0O5W4uJYvndpdOsyZgDki5mMazyrTBU?=
 =?us-ascii?Q?keYbkbAND+QQ04r3H86b9B7v8UTriGPsA1blglaOtJRXUGkJn3TtnKr/Yaa+?=
 =?us-ascii?Q?aqW1bfRSO1keTLec7P7VRSPA93XrZUqCZnCzurwXofdnlYku3PsOjdsYMAwH?=
 =?us-ascii?Q?HXGr3T/P7Gv2DYp69Afb1VnmXQNdYTh+QkVvWImFTCrMuHimXf9tYhnV3It1?=
 =?us-ascii?Q?KDA8RU8EP6DYZUrjMRav+567EDPhDtRmdJ+aTskA7wHLhhIzSyu6Pg/SRFdG?=
 =?us-ascii?Q?VC7TFWLf1v3f9/Zb2J5TNPlluIrefwSR1otX19lF56tCIL4wr9jwMDO/Vce8?=
 =?us-ascii?Q?TW7/DKPeUwvFkQJz/9VB1s1mX6nDIyXaPZCWmYH5abCNncKfuvN90d2ZzGSr?=
 =?us-ascii?Q?3qVrg2obmhAYcZZwS6SGwiiP7ZNfZxmL76rN2hfUKqlQoSQTXwMrtfxoYjlb?=
 =?us-ascii?Q?a8ww7da7JRGR9hH6YqubfQK198Lq0pkK8fzXcYSgHWzxfUW5IZ9tM3n8Z+de?=
 =?us-ascii?Q?yDug0JZ6R+J44OdxcW0DotcW3v8eSPf8X7MzyzwLiW/ku5lB6IUKK3I2cjK8?=
 =?us-ascii?Q?+5WXCPw04rcigPE1ijoA6zf8pBGauthtaEI6sOIx7P0wjD/fIh6w+Gmebb0X?=
 =?us-ascii?Q?nu2KGqDtacBAX6giy/nRZ/Rj5kferv3z5JgahiJPgghDMRv8JGTS5ntclIK2?=
 =?us-ascii?Q?Sez8zrbVK7a5BkjjopKbSp6kpMD9UsI8A+WrgJ2c9VfhCnUj0DeKS9trvgDa?=
 =?us-ascii?Q?nf7lhHGCfEHYg0JN7mR2sB/nLdkOpMNFsgaqAWS2cp0E7qjp7ISU0ONklJb3?=
 =?us-ascii?Q?HhOkGNjXJEFZM4klJfqfYNeWvFgDWwJhSseTKbNgwceNN6bxKoeoD/TZAEBF?=
 =?us-ascii?Q?s6qRXmt68pTr2O/FowN0cLB0fLQrVbz+Gz+iJV0t+tu0U6xR3oy+dPC23hEc?=
 =?us-ascii?Q?Av2owC/UsZz4lriVcEsuSmm4oi6hdPea7iuVBC3rI5F41jXejoEGI/mlk2je?=
 =?us-ascii?Q?zAts6CfyDftortxYmEKXKyzTL255y87Hktz5O/4QPYtvzu74/7enEEA3X9dE?=
 =?us-ascii?Q?hjRE7Mog00/tLljJ0EM+Jg44/IbRRoP19hXYDBdp?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0796.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c7839-91ef-4541-9527-08dcf7e7af50
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 07:02:43.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itw92UPaykIBB+CpcPuqb+OBlww/uLKsg3UqJIg2ZQj15cMlVp1b4rDGakDqfNn/2PO9bBWHqHH7nG05SR3/3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB1024

> Subject: [EXTERNAL] [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringb=
uffer
> not initialized yet
>=20
> If the KVP (or VSS) daemon starts before the VMBus channel's ringbuffer i=
s
> fully initialized, we can hit the panic below:
>=20
> hv_utils: Registering HyperV Utility Driver
> hv_vmbus: registering driver hv_utils
> ...
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> CPU: 44 UID: 0 PID: 2552 Comm: hv_kvp_daemon Tainted: G E 6.11.0-rc3+ #1
> RIP: 0010:hv_pkt_iter_first+0x12/0xd0
> Call Trace:
> ...
>  vmbus_recvpacket
>  hv_kvp_onchannelcallback
>  vmbus_on_event
>  tasklet_action_common
>  tasklet_action
>  handle_softirqs
>  irq_exit_rcu
>  sysvec_hyperv_stimer0
>  </IRQ>
>  <TASK>
>  asm_sysvec_hyperv_stimer0
> ...
>  kvp_register_done
>  hvt_op_read
>  vfs_read
>  ksys_read
>  __x64_sys_read
>=20
> This can happen because the KVP/VSS channel callback can be invoked even
> before the channel is fully opened:
> 1) as soon as hv_kvp_init() -> hvutil_transport_init() creates
> /dev/vmbus/hv_kvp, the kvp daemon can open the device file immediately
> and register itself to the driver by writing a message KVP_OP_REGISTER1 t=
o
> the file (which is handled by kvp_on_msg() ->kvp_handle_handshake()) and
> reading the file for the driver's response, which is handled by hvt_op_re=
ad(),
> which calls hvt->on_read(), i.e. kvp_register_done().
>=20
> 2) the problem with kvp_register_done() is that it can cause the channel
> callback to be called even before the channel is fully opened, and when t=
he
> channel callback is starting to run, util_probe()->
> vmbus_open() may have not initialized the ringbuffer yet, so the callback=
 can
> hit the panic of NULL pointer dereference.
>=20
> To reproduce the panic consistently, we can add a "ssleep(10)" for KVP in
> __vmbus_open(), just before the first hv_ringbuffer_init(), and then we
> unload and reload the driver hv_utils, and run the daemon manually within
> the 10 seconds.
>=20
> Fix the panic by checking the channel state in the channel callback.
> To avoid the race condition with __vmbus_open(), we disable and enable th=
e
> channel callback temporarily in __vmbus_open().
>=20
> The channel callbacks of the other VMBus devices don't need to check the
> channel state since they can't run before the channels are fully initiali=
zed.
>=20
> Note: we would also need to fix the fcopy driver code, but that has been
> removed in commit ec314f61e4fc ("Drivers: hv: Remove fcopy driver") in th=
e
> mainline kernel since v6.10. For old 6.x LTS kernels, and the 5.x and 4.x=
 LTS
> kernels, the fcopy driver needs to be fixed when the fix is backported to=
 the
> stable kernel branches.
>=20
> Fixes: e0fa3e5e7df6 ("Drivers: hv: utils: fix a race on userspace daemons
> registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel.c     | 11 +++++++++++
>  drivers/hv/hv_kvp.c      |  3 +++
>  drivers/hv/hv_snapshot.c |  3 +++
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c index
> fb8cd8469328..685e407a3fdf 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -657,6 +657,14 @@ static int __vmbus_open(struct vmbus_channel
> *newchannel,
>  			return -ENOMEM;
>  	}
>=20
> +	/*
> +	 * The channel callbacks of KVP/VSS may run before __vmbus_open()
> +	 * finishes (see kvp_register_done() -> ... -> kvp_poll_wrapper()), so
> +	 * they check newchannel->state to tell the ringbuffer has been fully
> +	 * initialized or not. Disable and enable the tasklet to avoid the race=
.
> +	 */
> +	tasklet_disable(&newchannel->callback_event);
> +
>  	newchannel->state =3D CHANNEL_OPENING_STATE;
>  	newchannel->onchannel_callback =3D onchannelcallback;
>  	newchannel->channel_callback_context =3D context; @@ -750,6 +758,8
> @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	}
>=20
>  	newchannel->state =3D CHANNEL_OPENED_STATE;
> +	tasklet_enable(&newchannel->callback_event);
> +
>  	kfree(open_info);
>  	return 0;
>=20
> @@ -766,6 +776,7 @@ static int __vmbus_open(struct vmbus_channel
> *newchannel,
>  	hv_ringbuffer_cleanup(&newchannel->inbound);
>  	vmbus_free_requestor(&newchannel->requestor);
>  	newchannel->state =3D CHANNEL_OPEN_STATE;
> +	tasklet_enable(&newchannel->callback_event);
>  	return err;
>  }
>=20
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c index
> d35b60c06114..ec098067e579 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -662,6 +662,9 @@ void hv_kvp_onchannelcallback(void *context)
>  	if (kvp_transaction.state > HVUTIL_READY)
>  		return;
>=20
> +	if (channel->state !=3D CHANNEL_OPENED_STATE)
> +		return;
> +
>  	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4,
> &recvlen, &requestid)) {
>  		pr_err_ratelimited("KVP request received. Could not read into
> recv buf\n");
>  		return;
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c index
> 0d2184be1691..f7924c2fc62e 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -301,6 +301,9 @@ void hv_vss_onchannelcallback(void *context)
>  	if (vss_transaction.state > HVUTIL_READY)
>  		return;
>=20
> +	if (channel->state !=3D CHANNEL_OPENED_STATE)
> +		return;
> +
>  	if (vmbus_recvpacket(channel, recv_buffer, VSS_MAX_PKT_SIZE,
> &recvlen, &requestid)) {
>  		pr_err_ratelimited("VSS request received. Could not read into
> recv buf\n");
>  		return;
> --
> 2.25.1
>=20

Thanks for the fix.
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

