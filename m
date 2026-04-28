Return-Path: <linux-hyperv+bounces-10447-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLG2Drgl8Wn4dwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10447-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:25:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495F48C4A6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 548A7300622E
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78333B895D;
	Tue, 28 Apr 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e9lH51TV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020078.outbound.protection.outlook.com [52.101.46.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A637F8DB;
	Tue, 28 Apr 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411506; cv=fail; b=p43X6CtequFn/XcQ1xiQZ/FfhQ+xINCQ2b7XLNZucw8LUayQixs19IruynIUg4hX7ecHDnzEkGu+Hn2cQfWxq9ou6o50tUNiTv+ARBXJY7e6Sy7MZnZzdswoOCU1BFFPn9vDX0EQtmSwkPBTL8PkC6jwuklC70ONGeJgjyRGEnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411506; c=relaxed/simple;
	bh=wTQqV1cKlFSGaBtUj7EpjXCDCIT/6OzAwV/1n8q1BAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jeQuAND4qy8EShutXwu88/y7gqedbGo7ybazOLj6O/iOOn5EwoUiPR5LEHhBl4djqqv+xGDTsaHbrlUam3sGoxtrM9aM5sBiSxhwj0N1Z0EkYyYv8lw2yBsNoRPd3ZDm++W7h5dMwQXt+inwrNTwClVHyqXB7YoiVjosQAJHCYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=e9lH51TV; arc=fail smtp.client-ip=52.101.46.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc2iVxNCMoxVieDu9sAnklh2ykH/XfeUu6DsJ/z/zpiYEKHfVxHW3rp7JUwZlRfGon3ARXwZr0NkeF/w6NtjuONvJOjubtj22Be8hHhMOevh13CJyhF8x12UapAeD9EtvuBVSFN0PaXQqOG6LE+QanC18kVyI4ZC8igu9cbX5EYty64PXJcYkZB76Mmd9ICo+1Segsffts2xMZ9K/RAYtZ91n6Bx3Yi5HNHMlZCXsOpfvNhHUcTzRkJg31Cv4134GV2jsJdX2KQW84UIWVTovVL1vrXuXYGiPNrYsuH/Ie0B1r7+p+OCPDFsxATdyJSXgYjh/dUnHHKtuvKnK8Un2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTQqV1cKlFSGaBtUj7EpjXCDCIT/6OzAwV/1n8q1BAM=;
 b=kMlsZvPR/zhD7WgDvw+3P4qoUpTUKPQMz4I4PQamIxg6HiaPn0owu2YaFlRYOWYOtxm7fbJo331IP3Slqg4O/YiuXg3HqYtgpRdX+cMa6mv43tM7Gyg0b5ShtUGDMrcqZ0GWkyR3LeHvCNchl0HSIWReT98JTF1cMSkQ8KwkFMI/ugfg8PYkCFVjVk20KojuzHl3w36+0oVLL1cRA1GKv5UafNpKRZpEvR/iEBfCshZCpBPD6AqWdbe3Nxfep+M7nbgU9bNNJ7pdfP4QQ3QCixcT7076ocfJiA+ywNxe38ttPU7vxWVSLsQD5hRbYGpDesD9dc0P1ze9GDVhLC3Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTQqV1cKlFSGaBtUj7EpjXCDCIT/6OzAwV/1n8q1BAM=;
 b=e9lH51TVGRC6AVfIXPKmKURBDY9MPZpMx1h1JSoUdF0PV3/wG44BWeTcOArD8TWoRbkNbFUnhTYydsnX6z9TXgHGLzi2LqTP4JMnlzmLOV8KD8cOv31GNEZ0FMpbyoi8D7kfj+2EipovFQQqsk6070XTWuZMsIRb2REnsWWwGAU=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6608.namprd21.prod.outlook.com (2603:10b6:806:4aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Tue, 28 Apr
 2026 21:24:59 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 21:24:59 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv_sock: fix ARM64 support
Thread-Topic: [PATCH] hv_sock: fix ARM64 support
Thread-Index: AQHc1w4VcMw9r4DcdUu19JrBvAZyHbX0+55A
Date: Tue, 28 Apr 2026 21:24:59 +0000
Message-ID:
 <SA1PR21MB69211500C7F60FC29F1BAA79BF372@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2abdef9e-2f78-4b65-bb68-708d7e661849;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-28T21:20:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6608:EE_
x-ms-office365-filtering-correlation-id: 97d55ced-21dc-4318-9150-08dea56c9a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 QFWKgXgqzCOVwTCttl+WlPI71Iuxq3uz8XZ2P6/GbB0YRGLwqLMdVQDXT49Mqo3nl1/SJCpgrmWdmGTir/OBLcJoU79yIvXFyuQqTGumKZ6cJUbMVxA9zNNGM9ShfATOBNf2Hl+VZoWtsUcDyd6BrWZ7X2KoX0K+Cyz1XogQ85+eU9ZBR0YN1Iku+09Z6oWbcYPJZPyQ2Q+Yw7dNhrQlmBFVSAV4P6sw9mVwnd17hwMk3919BYfZgSN13maF2zd9/NG2nWlAIAKas1pEGlK8BfAphDwHap6JihfwC2tpXdWPtPWHJoG2tU2pDmOz3vuBXRFQnDk+xKZh6niF5kQsY9Dn2UeV6o3xXEBKjOMZJj8TZlxrTkMBGNClZBUJBTR3o9ySf3HFQVr+xkE/GwiaMmAFaQX02HAUlAclknfWAnSL3NIDUYGayLRUPWjGmucfcf+f/d2wR9GZnWor2lsgxoUxIaPLpSiZ/Y5PUPOmYUN+52LEZtI3JONbm0/ekZWU+WktMutUcYbxCwlRnrUhZSoQ7UUGBja5s/HuvjYakbSrHhrmqAaDmyt1NpwyKtWOmFEYVzi47CMVHnSy7Oc9wxoSEhw+JkbJMTfRSb1Ebs/ZvmZ9oYzbjApHLwImKKhf4jE2WYVC3xxa9Gzti6VeADeTuhb8oj9OuEs5SRvtJDGXZU0Q+6oVAOxkmNNxGhAzlOdiYjcu89cIVFEoA8kKZpsJrzs2DhuZgk4OsD4VounCPftElI4JyaEXUAxkEmg5guO+R3oPdwNuuORMHb5hcrOKW3UAZBj4Zv0Xlc47mjA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6A+3TQcjNF5IXb+gI0eiO0BqS7t1z5RXyyRkhajwbiahVqLYFo0peegboER8?=
 =?us-ascii?Q?c27j98HSxZRos2hUWh8Fj3YCrAONCeQ6T99tO9VT9L3C0r8/fB5117PPJxX/?=
 =?us-ascii?Q?8hT1JPOIa/R6pxBSPK4rZFm+O3jSL+DNFdI8CNaU91McZ0xsr1PiIEuCbkxz?=
 =?us-ascii?Q?jmXeQPJkc2X+y/xNX0mI9m6aDsWx2nnE+sos3+kXhP0kTeR2AFczQKoPEfLj?=
 =?us-ascii?Q?TKUr094OtZO4SpLqlt+Mee/8Ow646NS+6/dMBRJE2G8ghz55J7KL0LdFU5SF?=
 =?us-ascii?Q?amYH3RmR+0tkQLIndn7PpkZfCE/uVP65HV09lK3y7YS61xInn6chzeYFR/lU?=
 =?us-ascii?Q?1LrrLnFtX44ukJGz0tXYSCDJxtMfGs1wCfitKQ/4NvPCIkfO97ZoAyxYJUb0?=
 =?us-ascii?Q?JdinXT1tvcQ4ks0k/j8Fs7mKVQAUxRvgHXHtlC0SWtmN+u2vaDKFQ7TFFFtt?=
 =?us-ascii?Q?zVHxxGowGZkao6fieoFEAO+QXtlAEJmGj8yHY7H+XBuWupJifly+REmikcRv?=
 =?us-ascii?Q?LbceSRWhzzlMjosMWr/eUI3/vfbgBeo79cTp+YT4pvQ+ZnWRvwFDitP7sm99?=
 =?us-ascii?Q?h5Sfr2zxLuuWVMupbPVpZaVtI5gux68IMfWT4bp0nj3anx3aw2KsS4FAlwxi?=
 =?us-ascii?Q?yW3lYGAU1oKG6jlJGFmywMGmQH0OBKFQimfCqEWm4dCZmnJex2g5uPlkcxeC?=
 =?us-ascii?Q?WMapleLPF4rToQc43wmc9AVjDRy0fY9EwStTyk09aua16PIBQMld31bNriFx?=
 =?us-ascii?Q?cNArl1NBJshjQl4bhHAlYCmaLlKKyhM1YkHZC9aTtq75vAcsxni43B56E787?=
 =?us-ascii?Q?P9H1aynOprrjg/Dc+BVtl+88EKyyWaq94NybsdbZkgKyXzoulNg07rzNen/A?=
 =?us-ascii?Q?rAZ9eW/ge9pcTn+qahbuScDMwqcxnsz7A6bQ40WNS7dth5MgqqQrlgeppog9?=
 =?us-ascii?Q?h4fyt2Qkz8l326upT2pfdaMBOwML6ykMaFI4J91pwSMeGfMZ7X/s5SkHH6qM?=
 =?us-ascii?Q?snMUzZbOi08qL/Est84b3R1g2UwJTlpHuD5k+t4/O+y39WaJSLAZZZlvL4bf?=
 =?us-ascii?Q?W4Jj3RWY0FIElg9VUmgqNmkSgniphbUUz/j9hLPkfOUVZZQeIoesgJajTqLl?=
 =?us-ascii?Q?hcQDc6KDfUplUhrymweq2ROXY2AS/jUdXjbre381EmsU7lrAdZuDSalsXYpb?=
 =?us-ascii?Q?KFHp1EWHHIL5zEvt0X4/HMu3KGHZGa/V1gjDZESuvnQm9bNhTI26jbtw21sS?=
 =?us-ascii?Q?/HrnZ451a2IXDHGmI/iSOt1ub7IPEekLYZ7sdTeXN2Lia+5U0H2hQps9Aedg?=
 =?us-ascii?Q?+lZErZ9kYnU9ogyUGclBGquLsHvRoVMxMpd6iMcI2cvdhKhziPeClO7boGsx?=
 =?us-ascii?Q?2g6ubFzC7JbxYP7QidlrERg8irOIjpDkWWkPyV1svPfRV+XyHDNtVovO5IcG?=
 =?us-ascii?Q?7K2mBP0SC57cztwL0QaVE2PNpDxoS8RBFGBf+jIJKWr00KLHPjhuSPWjGRut?=
 =?us-ascii?Q?GRwgq0lJgcsR5+FGLNUUVWyfi8ROJfLFToJ/wT/DGU4k/0z1ODMcg7IVcy4g?=
 =?us-ascii?Q?pmqhqll866tn6Vzgat0wKBBs4/6J+2sEno0i5cSpel2G1+7cw65YEB8HBUlA?=
 =?us-ascii?Q?3J7imX2f2aW8POXEdCNmKzP7NllsHLwOXyBA5fZaPSYgPjzrEem6Fh3lzcqO?=
 =?us-ascii?Q?D8oguNM9M7MUFIrmTiqGZNME34w+6OxT5cYjS9JbVZcoGpRR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d55ced-21dc-4318-9150-08dea56c9a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 21:24:59.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYvdvOBMHdpnz7xnzAd2CimSipR7gjqZ7lExdT51MX4aIhz8fjUUiAAAvQUgzzVa0P7Oe0sZbWkYKsUwpM97qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6608
X-Rspamd-Queue-Id: 4495F48C4A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10447-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,outlook.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Sent: Tuesday, April 28, 2026 5:54 AM
> Subject: [PATCH] hv_sock: fix ARM64 support

Typically, for a change to net/, you'd want to add a "net" or "net-next"
after the "PATCH", i.e.

[PATCH net]=20
or=20
[PATCH net v2]

See "Documentation/process/maintainer-netdev.rst"

