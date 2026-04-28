Return-Path: <linux-hyperv+bounces-10445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGyBJpsh8WkhdwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10445-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:07:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BC48C375
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C15301C591
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0C3115AF;
	Tue, 28 Apr 2026 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PUWBq055"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020126.outbound.protection.outlook.com [40.93.198.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A12DF701;
	Tue, 28 Apr 2026 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410354; cv=fail; b=JU2TqP2QWjUardBzteLvoO/Won7Ti0kKVtpStqSolku91EV2dqmR/ZF+h16lNGnbE+xaIHJHYCMBTQLD4n95ojBE86mtTk6KFibRbXAwzlRuYcAdURDII7sXBIBAG6FS/p2pHovHb2E7olTe4FC/VGPxbrbUf4smwFe8JrOliVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410354; c=relaxed/simple;
	bh=qFebeEiLlmls+mcA9zzR1j01vsjl1qN8MBoWiRUy/M0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8i2YweJW8O/22t+CSsjvmMevTLoo1PXSANVNZ9SVUnrHJFIZCBl6nbt3+bPL8CxKjFnNQlpNmkRN1y47HTkh+2zkU+enRmxX+XpZUWiS308OTjAbEexQF1M65jj7uKcwTjHhxNpg3cMVq3o47tgMrS/99FQ/jYkY7vbzArOLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PUWBq055; arc=fail smtp.client-ip=40.93.198.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUZ1GCSgnfJXohScMxfpDqqex1u+GE6cuJ+vGqn/dWYYnk4Bv3jyWQbp2oduGMZ+OHf1GX8bBz96QhQ3t8dWT08aGpAW0x+m2FRQCuNfKJAm78uzUMaYrS4UiJ02CVIrdjqzDqVnQ276pZzoE6n85ZSdjTsXVd1TvT23dbAPQxa/wSBUtjxHi666t7yKL1pQJDIFYZZhRig7kLBG3jIvtjYmnbUS2BR+THBRhKZVY9ikJsA9Op6430CC6D3HTB1xxwFAHBaoPkEn1KmbCPIvUYG84ifA7yVEiDOJgLDfM2DC47gw0YkXbPx815lE8q7ms/xz7gRbol1G7+LRgu616Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVEt/gVh2ZQCFjl+WCZI3ScYTDfHdOHmjSki4Vocg7k=;
 b=cc83NCrK9HddIlK5RzLVi+JSB4nL4X64frtLDtcuWb5S21IZND2oeK/ft+MmR7VziQNwtpMFpeF7vZFbc/bxqZ5gAJYaFsOkTnlEVJj8+hEcHJ2pZgmWJJa60MIyItZRORUg7iMgufahRtyrQjpMwn9isgT7l6yHakW9miKWbJ9bgCAH2QaGULGUv+XfF3wmJNxStZ4GCEGfCSMmKdgbyQPS7eePU2Ft2YMr9KmMMbXtT3H1EeJQkEjXdEmZQwHtlmcOINbG9Zm8Ri8GiXlxtIriWKxvqhdnCMQAqd1FYfLGHIu7zUjBotbB7wFgLq4Sz9Avs6jat5YmcI5sVRNOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVEt/gVh2ZQCFjl+WCZI3ScYTDfHdOHmjSki4Vocg7k=;
 b=PUWBq055rUeV6JJv4hR2ud2+Lulot+sZKeOeQjtqMvRfcTbzvXT1u+ipuTURPcaH91mDWLYk+NpzDZndgT8eiNX883fr7M8dphiYZtuj8bRAgBmFwOuijzC2bDBTHihjCEZFvqucbNOThfXFT8/Ss9AjeqFCcA6ZhUbO9NWJ2pQ=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6417.namprd21.prod.outlook.com (2603:10b6:806:4b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.2; Tue, 28 Apr
 2026 21:05:48 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 21:05:47 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Hamza Mahfooz
	<hamzamahfooz@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano Garzarella
	<sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Himadri Pandya
	<himadrispandya@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Deepak Rawat
	<drawat.floss@gmail.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "stable@kernel.vger.org"
	<stable@kernel.vger.org>
Subject: RE: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Topic: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Thread-Index: AQHc1jw02yJrERFkmkeSl7gccH8LxLXzPWxQgAAHyACAAa+UEA==
Date: Tue, 28 Apr 2026 21:05:47 +0000
Message-ID:
 <SA1PR21MB6921427C29C760AEB14D98F2BF372@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB6921B5A2441DB3E9A1312AC0BF362@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB41571A5B77A5FDDFE17AEF19D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41571A5B77A5FDDFE17AEF19D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=866de344-17d1-4da0-ae37-df720ba729ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-27T18:37:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6417:EE_
x-ms-office365-filtering-correlation-id: 67b39463-7336-44cf-3b3c-08dea569ebcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 jqHJRWR6XTaE+kgp9u8TOzPSP1u5MT3zZXWR9zHPq7z3bOd8ogBiQwNwZVQ4BQILBygIJ3/gchbymYvhga18+AwJND/di6hZEjDlqm17UfQAe0EnVBZOgMxkFiuWfgzWsCdXdtrXMYjgll1+urvkvFajr7w3BOMo52ecddmquSK1L6AvJlBaJTddLfINPPIYNLByoVpqGWY7MjsQtChJhkj+5ZOjb67q2prluiqHKq3GgrfMw+oHOYbsdBOifhMOElvkCdJSq8ueEVWbjJw9ebxrM+TFQDzYhV5fuqspdSn0Mhn01pUO1pL5jDXnnqZcresolIfKxMhKTHLlvCnGOS2u07v1QzGL1SS5K15d49w6ZabzLgdgVtL9dtpspRcMXqffD8fuOWT7U9/1jToLAJ+N50bk+Ao4QEAx7lv+UbwND5SLbcD3wOE64Xs4ziNNcEqYLS5VbPlmVFRoPOG7JjeUDXSVS8NaTNrgzOK2nWbRE0Sec6jNWPp9KhxgHjpk0G+nUdIovvP0eCPIrKEJUzlp7vsc0o4Fc+q1SmZ9Ia4iYtOIfyBW+j6Z0ZN//hW8+L0dVROgcfUkhJgXOr1ldgPGIxRbNddj+4/X+YByw5gFe9ImUooiFDV/zJSLAf+pP+5nAm2hhy2QrxlzdQlxGldrCfCLvYtfEaXV0BSETu3bViA3IJNr4/GV8/eR0QTd2hhb+3MggTaP88rm2x4yEGzvjMAV10DVt3K5GbSkGSioqAHsXlpYrsznmm/hK53PMOEeBBI9zjXF/R8tGYxTvfddZna3pR+F5JJLBMhpxsc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GDSzZiX8geTn8USva/GENDdgXCSqGb++SUVjvLrDu4hZDmx6ZaWD/PVJyDXw?=
 =?us-ascii?Q?lKmeIrcie97ui/gqbVfA4K9JnFL/Eu1zJofk1CoW+Uv3oBp56Lhsl0y9Yeyu?=
 =?us-ascii?Q?jePcVfQaaSpXcdfCACnGq8qKOHgfkPXkTMT+dDgotoyqIol5Rdo40AIUbdNI?=
 =?us-ascii?Q?qbppby2VDorEcCM7mCWcqXo++XPoSe20JKRtame98Y8pQj9GPoRetMa1Md5J?=
 =?us-ascii?Q?gGp35T26KEsBFUIdOFTt1sIC+Bbj625Zav3/pkwD3mU3YjpQRmBWlAPa3cU9?=
 =?us-ascii?Q?3T8l4++aD2ubw+Dm13gSL+lof1dRZ1qQtoxvenrDn2oATbU4fwDaMDXu0qcf?=
 =?us-ascii?Q?xX2dN6zH5lCnC9izbgvdRSLfZ1ls38u2zpz1081xsHAF97qtyyV/xfCI9lz9?=
 =?us-ascii?Q?iRV+Q5w43BGim+uyCRiGuD9dejTrCIXzbjlvAdC5p/yV5TDWxNcl4MRARI44?=
 =?us-ascii?Q?miHagcMcJEV76pqWsCVfphb7Qp+n8tmTHYcbCMaGmHU6Hop0D2HeobFnGTFh?=
 =?us-ascii?Q?OF3f5UM3a9OyxdGNvpX0mF5hqq/EdEpCz5TMRm9wgxl1cz6/0Fa8PS43qNxt?=
 =?us-ascii?Q?+UJUOCZfOXcpuplgQqfIoG3JOgo30rmcf9pqn97nWkK0E1YeCONq1qDYBDcA?=
 =?us-ascii?Q?Ycjp5xtsfquwp9XqxiajGecgbj6ZF2HpiYhtU9qKl/Tpe3UhxVQjvU7TCc7l?=
 =?us-ascii?Q?aqCvZOXOPq3NrfEFrbaBOvahh96//tG4fObAepp8CqvmI4P9xkKUvrbrPTZQ?=
 =?us-ascii?Q?jr/cvIhXEsKm8LQnwDNbDBTKIM0Sy4+6pxAfPjc8GnBj6bVjzJyQC7rf029g?=
 =?us-ascii?Q?72qZY9OqXgPWqy4rTkwnXFlAexx1iTtsKgzYEL2L4YSmOG8DTuvDKjtugyF+?=
 =?us-ascii?Q?HVF/HGuA3YgDlR0KcySwa4moQJcRVHZyLq0971DherYsCf8aJxlGaKhNhCK5?=
 =?us-ascii?Q?gyrofLh8GclO/3KTSyVq8nMrlEydfoNGD1WeaH7JP8Zx0m0uWjbPyzSiuS0r?=
 =?us-ascii?Q?bl4UZnlNNK7iMQjvRZiLaUa25WVUiPqD3um08/2AQZ4OIAD6N+8/L62xL84K?=
 =?us-ascii?Q?MHySQ6Yq2/qxMZtf/Tpv2WnWEeRZs1diV0kMDfrrJqIs3KOxYssroHZTgDPM?=
 =?us-ascii?Q?N32u3QvZxsrz1jBhzknPx553pUbjMxan9F+RoZDotHZfQgUSTW0BiuanvqkG?=
 =?us-ascii?Q?Mz6Z17WRpWKxinrV+pERKjbCmPyy0UZv8Q4OMhHaY97WZIwzT9feGxy45xFT?=
 =?us-ascii?Q?VbLdNTk2oGrX19wZmSjDgWWDlFVsm6jDkzVaMazeKBYjMEKkXLNTDDqHVdEg?=
 =?us-ascii?Q?fxDqqd6SffJxfGX7Zdc6QPortKiWXLXvbrLs4wlVreI4HZMBFc8cd6BPYBkP?=
 =?us-ascii?Q?3IFEAYxC3rrq77y+/zDQ+h7VRq+SzDEu2KZDmTDo1dOyxToudUac2NOL1H1f?=
 =?us-ascii?Q?FU4bU2nrjWuWshVtUL7gbc7w5sZa54lL1X0hxzjuYL9FWe3qfRXW5ewLPa/f?=
 =?us-ascii?Q?0GK/QM+4aegaBJU7MkPuQ5sbttAor5A0jcPOdtY7p+31ZwkwKJDISaiSg4XE?=
 =?us-ascii?Q?Ae5vsVzlIoI6uQmeGKUe/dx+e0mTYLFYZeVZAuAAEvsF28zMusyoC+6duKLq?=
 =?us-ascii?Q?7KNQWOQP4BNV2LnUt1Xb7Hdqzb+w+tuo7FNnYl2R8f9Q4aF1nPqpDVBnWew6?=
 =?us-ascii?Q?UM5N3YZmL3yJ5/Kzbnlrm03RWbyDK6DU1ighn0LcVV/ru/Dt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b39463-7336-44cf-3b3c-08dea569ebcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 21:05:47.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W6tOQF8u35ggMMJf3sKDYM6n0Df1ECZhLGh4i1jdn9Vf/iy4k1663E8KyKjjJAEqwj2zbEd3C3zXGBvdIuJiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6417
X-Rspamd-Queue-Id: EF9BC48C375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10445-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com,microsoft.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Monday, April 27, 2026 12:06 PM
> > IMO the Fixes tag is unnecessary because the existing
> > VMBUS_RING_BUFSIZE
> > is 256KB, which is already aligned to 4KB, 16KB and 64KB.
> >
> > VMBUS_RING_SIZE(256 * 1024) is still 256KB.
>=20
> Not always. If PAGE_SIZE is 64KiB, VMBUS_RING_SIZE(256 * 1024) is
> 320KiB. If PAGE_SIZE is 16KiB or 4KiB, then VMBUS_RING_SIZE(256 * 1024)
> is indeed 256 KiB. See the explanation in the comment for
> VMBUS_RING_SIZE.
>=20
> Michael

Thanks for correcting me!

I didn't realize that sizeof(struct hv_ring_buffer) is based on
PAGE_SIZE, not on HV_HYP_PAGE_SIZE.

However,  it looks like the Fixes tag is still not needed:

without the patch, we always pass two arguments of 256KB to
vmbus_open().

with the patch, we still pass 256KB to vmbus_open() in the case of
PAGE_SIZE=3D4KB or 16KB, and we pass 320KB in the case of
PAGE_SIZE=3D64KB.

Both 320K and 256KB are multiples of PAGE_SIZE, so
vmbus_open() -> vmbus_alloc_ring() doesn't return -EINVAL.

In the case of PAGE_SIZE=3D64KB, it's OK to pass 256KB to vmbus_open()
here since the hyperv-drm driver doesn't really have to use a slightly
bigger VMBus ringbuffer size.

Thanks,
Dexuan


