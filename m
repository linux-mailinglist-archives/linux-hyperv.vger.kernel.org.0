Return-Path: <linux-hyperv+bounces-9902-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGDTD0NKzmknmgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9902-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 12:51:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B3387F32
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F789302352B
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD838F657;
	Thu,  2 Apr 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CFJ+T+BT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022139.outbound.protection.outlook.com [52.101.126.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4A38F93D;
	Thu,  2 Apr 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127065; cv=fail; b=UoBcKE7leT6Cd6zfO1WYnnR0Oe68JNAL85Z7DBdewVtcHMzaZ7Db05FubKEFHtlNWSQ2+zpffGBjLWFkPoxXrg4zN/dHkd2kkcPdoT0VAvr1ZdrlIHPpaoT5Ixl+ssVaxCuflR1lkAySlDoeE6DSobWU4mMLOv2HTw13Xh5JEAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127065; c=relaxed/simple;
	bh=4blnxIV+4i0UG9Uh1AXZdp5HNm4s98kbu1FDjh1T94g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jsqKf7nmJ4LiRKhtjkSw0YoSvKsJne9z2YA1iyo+yv/hnLNDJDR+w68399V5uxhoPirbOVyDYIHl7JgAUquo8jWFhYFlQ9p2L2zsXZdRmKnKAukbmP3ZUKIGYEGFTsw1JhcE83TSRSn7Mk0N0Nwr060WVOIkv25wTk9bFwtt99E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CFJ+T+BT; arc=fail smtp.client-ip=52.101.126.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkFixaGDdw+uTFKzwxSY9Kb5aELrFTcs03Wy3+L1SdHtduivZEJYA8bMEvKzK9qd+iL9P6jhIm13DeUKAM1pCArW1pNiUFsYeJx6Kj/wqkmPa+BLK+DpNGNLL5YgZRvWRrdyc5Ht54bXXyGJtdVKBOOU09rAFNcCERD5M9cXO2OrMXQmTDeV9hM1cPwoF4pI2ftIxhNSgjUuWxe48BBXq7I4LHIdf0iuKwxwlafnsuwhh9S+Bf7KK9yPhyGupK+GktIDMnxMyGLVFnHbHjY3HCjsss47mWyzdICP5dTKS2P7dWYXX87ISn6lXco5remSHPjCDh4wd9DHziFPSgNCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI2MSTo9zpN6C28iFiXOn3n95MKHT5Mpuz7NBG5gLPA=;
 b=mxTkHIR6+cI+0veIwg27GEDYlL5PRwYNGHRlt9hEno3+7gOgAthQTVF6JDhMFCMlAxQb7FyBEsVwQ3JogqaF7xk+ZOl15o14WotdmWRJSX0W6zhA6LRnOX15gxH6N526FWvdcPPwdL2IO9U9G2BTocvm4BvTvzItBs3iJP2YoxjMYxzt0fXMvlWXKtd8r8R4M8k06VUjUf3LLCH7znHOGNOWyTObhLFYdg1LaCMIU7Hi6/wuan3c8V8UpMdcBzLJUgX+37IdeRf0V5oSfquYu2VGyuZwL93KROTEtr70LiBNfM/v0SLugL/23U1TnVnw0yDdHusnPDgcIZ4cqlttxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI2MSTo9zpN6C28iFiXOn3n95MKHT5Mpuz7NBG5gLPA=;
 b=CFJ+T+BTM4FykVb9JcpOI5xDujnEFWsvvScrbLjFSqrEILRWAL60CWNxv7HT2NraEnWE5nw+bqfnwLUyKWaDyCQOLByqvITSnu6ARD0wX2LLtuxR5UKvNPfzRc/PJmoFET8RXxEuGva13ZUNyv+ayNMxtxHdA6hjmhc5f1kXm1A=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SEZP153MB0695.APCP153.PROD.OUTLOOK.COM (2603:1096:101:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 10:50:56 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac%5]) with mapi id 15.20.9791.007; Thu, 2 Apr 2026
 10:50:56 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "javierm@redhat.com"
	<javierm@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "ardb@kernel.org"
	<ardb@kernel.org>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Long Li <longli@microsoft.com>, "deller@gmx.de" <deller@gmx.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/8] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
Thread-Topic: [PATCH 1/8] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
Thread-Index: AQHcwo6UUBvHYaEr8EK6Q8BbiI9woQ==
Date: Thu, 2 Apr 2026 10:50:55 +0000
Message-ID:
 <KUZP153MB14449BBE44CBAEEA7621A4A0BE51A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-2-tzimmermann@suse.de>
In-Reply-To: <20260402092305.208728-2-tzimmermann@suse.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=18bb24b4-8011-4e12-840f-c00cb01f033d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-02T10:50:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SEZP153MB0695:EE_
x-ms-office365-filtering-correlation-id: e877716d-0112-41b9-009e-08de90a5b777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 SdvUNrGWjKzVIi0jcfhE88EgvkVPpvZjp5M7KULTg6vT9b35NBZ8AEqaVT0Tkk9vdyBpCxmtOkwcKfVkbWXdN0PUsAMIQOp640wFoCk+Og76/j5cs7ZPp2v2w7ZtiLMhXYKek4MDOVpMHs7ua+YHuDZxbfPyjxDwnipZIj+ViN+owrZF6iP5IlqmV9DrfOdW9LDK+lW1yaE3w5TkN6HbFBW8XdMoHU39a+ayo7Bojgl2kY2sRXZGOFSTr6cCMbaWhxDmUKUnhYhIvfF1Wnw74jGG52tnYxibb6x1jc3PFli1lS0tTOkRgDWg7cQfX3cKhHnDORsARR7xsc4cVAeBpk6WfqVtpU6pQOPr5G72mNnRr5IbaSYX4pXnkfdvUuT6+bkDE9+eQqadNQ5/SC/AsJ5nbr1eTyD/iYNzDNb55B3a4kKrEMOFbKiQIh1xFSYmwKJX2uBhMFacJJ3Zk3/ReUegHjUEX54zd+YEIO46Yh7NEP6HJ9FbVpPT5zmgrs84FCqs9iuuYaxHCEdano71Z5sTZofNhusZHi0SQXz4HgKfR+eK06Pq1NGOXO6iz6B3jl6X64jDqszQBtGWLj0xikzq57buLHyioV0rjB4KNj9/rNqptMQHWIbLit57pAGhm1ibyYBM+KsXSdIcutrAmSFXAUIxTVmsqG8SghYp+CT5Gjyj3FCZMye1gQX36+OsQwQHIP0xO9qdjmMR4aWKbh+K16NgPy/XGIuiJjnN5Eh54yE7MWsX8f12uyCujmwNXj8ZDk5kCJ+LxH9nEBdmn59YJ/dyrYEKhLYTOhSd/iqy9g+4Pxv57b7o6tQIVPhh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iSJG7Ki3w/6dKAPOpBCKrVR/kp2H/0uLYC04t5WwHmON41CSLhBEJjwbX7yc?=
 =?us-ascii?Q?AgzW9ZOP4ZJuKXfWVwmLd5ypp2jYq90uWNGza+TbZ7d8BnP9lnJqYW7KfLXF?=
 =?us-ascii?Q?meDgY/tMXVEG9kwG5vHWqSWwSUU40BJUjsxFdKz7dlQq/raMld3rxijHFUiN?=
 =?us-ascii?Q?OoyniSC+OyPvmXU7sHkqp6PNnOFzusH25mIzlMh54x0hAE5b3KKAVg5Euv7/?=
 =?us-ascii?Q?uaBpStNA8Ma2KwxN8e4sy2b44NzZz+RR4wXU33LiyHmiP3zjAwznw044MgdA?=
 =?us-ascii?Q?aYFst3K1AA2vtZffdDzFqJQ4qcF+WslTiOffOS4/e8cUtjIx9YdWKjBpWPw5?=
 =?us-ascii?Q?lcZz3J1cA9c3+HAyRCueoO2BOvVVN4n1bk2jq644hA7ZDOfRkJZ1lun59JkD?=
 =?us-ascii?Q?90rbaJGH7yoeV2N15LYFJLPIFgb/bI4tjfSFbJfe/5DCaNhYnDDXcA1nsu5w?=
 =?us-ascii?Q?4Q7o9f2LxdLjfEyKGpfOCmuyU3KnAmU5Di413oMjdZEZFju77tnpfgO29MSE?=
 =?us-ascii?Q?09+L0M4HWrX5NgzFKxlN8gOaUX2ShqhHj66fz9R4y64+Cs0KJ5nDzy8rNn/8?=
 =?us-ascii?Q?y0erizoNJ7DjX+YbU9kJyyu1K0mHx+zzmxAYxeVTL34uWn2B7lxma3prBgOy?=
 =?us-ascii?Q?yLUV1krIAalsVm7Z58q21aYrNYR6ORwhScAzEDkuE/L3En3wz8leHMq5luiK?=
 =?us-ascii?Q?xKfcrv0RVxGHq4+xfDkS+j18SV2z242itwOfJTuxehsTktAjKKd/nsa5TMSB?=
 =?us-ascii?Q?SfpgQyL/j46qm8DXgyismp84cqn5QXSt04d82FvcOdOIyEBNz8ZwuuoIl1kD?=
 =?us-ascii?Q?Eca/8YgO81o4mo9lrmAOlLONhPTyrpkcJQfqZHzcoxwKfr//tHnFWz8FLmMb?=
 =?us-ascii?Q?wyzrus7RIwpaa5+l4d7P0oopfUyI+l0JlyTC3aUPSt9GWxRi3YJ5oAHrfWoB?=
 =?us-ascii?Q?ncy7f2ruU3K6EJFdaS8Zxn12FnIahFlHZtLZDowRxgm1pBJjivKeWUaJHY1b?=
 =?us-ascii?Q?biEk6vKep1X2Gw6Nia22TpfuRJKRvCi2ZlFnUBM1PZ3qEJi9emB4if3Xw49/?=
 =?us-ascii?Q?vhDX2yj9YvtdvTSpQG9nQD4WZLkdTcCkF2Q1qLLmW+Fl7gqjmAcdumGcFVjn?=
 =?us-ascii?Q?L/6kdohQWqUe5/uihCnl3kaejbZZ/WgiW6smK13ETt5KQiGl+RWLFoRsUhji?=
 =?us-ascii?Q?DiMnVR5ZdmLYMtEYAKJGOBoCL8V+cjzzOe/ytyLHxsd/tUvogGqQlSSNR2Ma?=
 =?us-ascii?Q?0R9kEVP1Ajy0vEkwYyEjiLKPjm+kZibnmxm30Gyrh8StJ14VncvMaE49FuYE?=
 =?us-ascii?Q?G+Ff6z5b0INzFNBNpktu1ST2Je3UYL7Vkzl4rIt52cklVc18IgSyI8omSRZr?=
 =?us-ascii?Q?9JUwTCeDmXx2KkeKB2BimaMA+XJGDhrLVjHhuVDEEEQhiG7DsYSxodL3TrBm?=
 =?us-ascii?Q?WOLxye8t9fyh7B1nCHg3/+2B3zvJv3Lb7+JzhbWyWfUaeBUwtSzybGz9QCor?=
 =?us-ascii?Q?KSaJskktcf/eWSe2hKA+RPndW4NZNPJj/GQrMpHnRwBZOl+WivaVNbCo/XZ9?=
 =?us-ascii?Q?oK+y/EkdnJM0yE0/2ZmV9c7iZu0sL/9oWBzEcCmp+8w1NV/QZX3ziKtUAFOC?=
 =?us-ascii?Q?rL5hAV0Fhn+ObMf+C1I9nzWxozBclwuSH+c876KnyuDP?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e877716d-0112-41b9-009e-08de90a5b777
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 10:50:55.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIiXXMppZYPpOHdRHZ+nRFdZXYEpZs5V01ntxE7smqq1+dJGbx3NWf0fQz1aklgukmKcm3EdTfP6h0Aoox3ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0695
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9902-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,outlook.com,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,suse.de:email,KUZP153MB1444.APCP153.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 8E1B3387F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hyperv's sysfb access only exists in the VMBUS support. Therefore only se=
lect
> CONFIG_SYSFB for CONFIG_HYPERV_VMBUS. Avoids sysfb code on systems
> that don't need it.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
> guests")
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
>  drivers/hv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> 7937ac0cbd0f..2d0b3fcb0ff8 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,7 +9,6 @@ config HYPERV
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> -	select SYSFB if EFI && !HYPERV_VTL_MODE
>  	select IRQ_MSI_LIB if X86
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating @@ -62,=
6
> +61,7 @@ config HYPERV_VMBUS
>  	tristate "Microsoft Hyper-V VMBus driver"
>  	depends on HYPERV
>  	default HYPERV
> +	select SYSFB if EFI && !HYPERV_VTL_MODE
>  	help
>  	  Select this option to enable Hyper-V Vmbus driver.
>=20
> --
> 2.53.0

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>


