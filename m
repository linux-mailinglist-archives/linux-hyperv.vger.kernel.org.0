Return-Path: <linux-hyperv+bounces-10528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGm3G9fa82k08AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10528-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 00:42:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C921C4A8A04
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 00:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8528F3009CC9
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349843A452E;
	Thu, 30 Apr 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FaHR02Ds"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022075.outbound.protection.outlook.com [40.93.195.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9939F17E;
	Thu, 30 Apr 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588949; cv=fail; b=qZku/IPs8syINyzzAlApvrDPDH0mx/uKxTtyt3YscQcdZe9hE2rEMlwquSm5unNAMsyhTvepAM5w6e/twr1tR3VwVdsOulHQgvNDt96IA6EYq0yAfwc5v/ty2bfOH8ccC4uHbi+hN2AnGYLExOj5SywIv9YySYETI6hUTuICQkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588949; c=relaxed/simple;
	bh=dDAIyBM9NqiANnjMrJ9tR42EPu3HZTZOsp/mM3A6AEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qb8CzZI+CE2P/IQzgCcH8VY8XBG3B6YTVHLNoNKokyiTEXFgGpbNr2hcELhaPxbIzoVqthkQVCiFZfF3AJMAUqWvGjIGgclbiSAXkKJHc13gOMc6vcBqBFaJKZeCa0hnCVqaQsCxTNN1RI16RyR61Y4SsZv7NAC9YJX9HhNapSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FaHR02Ds; arc=fail smtp.client-ip=40.93.195.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi6LgNvdoXTImwgag7BYA+5hbQsfnW8HlSbxGbfKljfbqLaXac1nehAMOPtH3xhqNOb/tABpMFB04qg9DZyyMRb+PIsuyXKRM8qvJShHgO2KAGM1AMAf58NOYs/YvR0+eGPqWzm7hr3JdV77oQ67IN0DkJVmsN5aTmHiMCh7aQ5VI95xPeog1k5o36jU+1BIrm7GI81sGZKFT3w8W2gc8MGh0LvmSpDIPTaCszwMTHMPmT8AuQEBUSsnSQcDaDd3XiZKDk0fFQ3UHWRVFhENSko6znJibtLJkBYoWghhdCFBcaD/mh8Bvlvp/+W5D3A0yC/XyRyywAql6jOJUB5/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Leu+2sjT3yNdlOdOQ4YgnR/5C585LREWU7/QhoF6VLA=;
 b=jd6FQr1AQyJwSAETrchGxfZ0V3aeirCW3czKvAb05laNrpF04Q+vASia5WhgMdjjExdWdSmOCksSateHDHeHGiRwl/gg7Z8rfCAMDXr/BBMZsXC6QFDDu4nf870oYJ721ZSPDEsT2W4uSr5Y/FGhXBJdwSW8y3vLUERe33Lv3Kmhf8C1I9GI2HBHf0/UrvDhUmVNNjYgxG92yRZNUJ1ZV9kwGtIRYaFijfOMFcgP2zfppdlU0+O0HhtOIQLsDIRbchjC4lAm+fmMusiA+k4HwPu8/5bZWAP5N3qWRqXSc93jfGpzmoHN1d/WhDVYkiyhJBeG1x5rE/KPVsL8WNx1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Leu+2sjT3yNdlOdOQ4YgnR/5C585LREWU7/QhoF6VLA=;
 b=FaHR02DsDiS0FaLLa49YMGBqxC6chcRz3p6/DUdk7/8F0nXPSsMWlSzWZk5ovDrS9pwuxzf1fq+sIsFXwh4OpIxpacnBXGvRozx/Jh2jx/cMY6xeJEC2lOMRAjBX5twbjxSqCX0RUE/o7bKUwHp1AT9FCJ9wSgmnPESjG790TbI=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6682.namprd21.prod.outlook.com (2603:10b6:806:4a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.3; Thu, 30 Apr
 2026 22:42:24 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9891.004; Thu, 30 Apr 2026
 22:42:24 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: kernel test robot <lkp@intel.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] Drivers: hv: vmbus: Improve the logc of
 reserving fb_mmio on Gen2 VMs
Thread-Topic: [EXTERNAL] Re: [PATCH] Drivers: hv: vmbus: Improve the logc of
 reserving fb_mmio on Gen2 VMs
Thread-Index: AQHc2L8pk0aH/znCKUGCrK9S0RkDCbX4MjcA
Date: Thu, 30 Apr 2026 22:42:24 +0000
Message-ID:
 <SA1PR21MB6921F17261B7EF19FAF6F9A9BF352@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
 <202605010002.dnnxVZFF-lkp@intel.com>
In-Reply-To: <202605010002.dnnxVZFF-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f55ba25e-b4ac-4f7f-ba75-f5d94fa5ef09;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-30T22:36:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6682:EE_
x-ms-office365-filtering-correlation-id: a8529951-be3b-4153-5bec-08dea709bf72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 9OQ++GLPbXzXQGzMD7tSfhJvHOi8ehBM52ezPW3Mp0Qeg73l0zEgX1e4LThDj84BxiiDMfFWqmG8nUbbEmZvJhf9tofUvXmOa5E1iJzYwF/WX2+3/qitCt4jt9oMy/ROgHs4yaCnQRZ98k5URHnypeiklgfNs4na2gPpXWGmgWc8BA53chI4qYfl6MKaEjtCvXIi5RO6JnIVLnFPj9Ql0o0O+VtpQQChD6yW4NWpst7DsBYvuD9wUl2/wyk0A7Hp6ipx5+fsTIoVHXz2PaWuly6LYEwFEon+akooBRJBhnPWVRfe3CZLwJPb0s9QIHNeR2/OyPESo7cYy2cy2Rx8XYrHMqeN9AaXUOvwLKx9+e5iyC1bDEoTkzDYYCqGXP5wet5X2F4frODJnl/UuqD91QQ3HWwdstD/qjZCD7pLhDDpVmZgaBPiS/5ILX+xxkW8uipY6GADTEod+CLPCRL5oyZJpCkIzUg2GtrHSvaE2IFH3h5hG0SpjmQtBLpyl99vRPNYvF4TcrnCEkA8EkQlkd4oNKfug9rLxcb6m4m5RUr1DGg29o/R6+j0HWvz5PUmKm9yAk4B8NSTh5EZ8LCsrj8DGGX+QQpOQr7j33eja7gorHk0zjel3snXddBwsZ4WHFF8LQWGyTM7YZ3sos3XCYpEAj55kN0/Z02SjqMKExzQc8thCnaUHSngvbb6QmdLagOoBNdxzfOk24BjX46/wVMsWCCxEO+f92Ys6RGJZdRv/F5TM74zhVnw8rZbMSOU8RiT30XB0oGLB1ZwIS794g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6vDo+73c1c2TC5hwlEyVThD4BiOME3tig0sxHmaIUe474UqUvEKH2PI9EFFr?=
 =?us-ascii?Q?gFqEOT7NY+F+0eOz3QzeLNIvMYmVpsqAo+QGZLGid4RQmC3va0W/iXYdOJs1?=
 =?us-ascii?Q?MD3d7DJFpNjlHyPBGceXc38JEGOWmOR7vsjKn8Nra3K5NwN7RHmjCJXXNja6?=
 =?us-ascii?Q?M4FyLH8JbFoNv8CHbubVG1k+all3xfLhBk891OaIF5SEzGBz8fUmbXgOmr+x?=
 =?us-ascii?Q?TTbGtKwVKkIuKOBJGlHTEb2ykrvwDVylS4mrOokM63DbL8TIrJBFHnTSuYWk?=
 =?us-ascii?Q?UtxRAx/RdZshMmGqsmpFXAKn6ZmGirt2KqG0bKXc87hBmSOBbSYrKKrGGpE+?=
 =?us-ascii?Q?+szZpdhtsSxUjZ4ty7OlF33LzIsEpbn08Vxt2cSct7Dy8MK8r0cgpeSTbztA?=
 =?us-ascii?Q?r7jtM12sf35JxJqPVQUbWA/FkNSh613gLAb3UXpVAQvVUq1tftdAusw7IUTa?=
 =?us-ascii?Q?oFCQ4z0QZzatrIV7w+geDTB3l9XmaQkFXzWMCWAJSc8sy2TsuaTmeLp9ZkLa?=
 =?us-ascii?Q?ZTTUUIut/8sTGlxsREc0bFZlqk7MLxiPJo4j7MDeGKRubPQc6nn4E/bf8Q0J?=
 =?us-ascii?Q?iBD+kHj7MnWHcE6ER+eKj1un009Z/Ck19ljzpse9RrEPIIkxX+om8nnudVaD?=
 =?us-ascii?Q?mJockr9YpyAcNJo3G7UGn/taYiIao0BGcIXXmpNw/3bp9oPvWCj6lId6Scy6?=
 =?us-ascii?Q?pcGAmYdpdjbxkzu/wiqd/LxqpYSVJF10pBVkfGXWVq85u12imIZxH6OeLN+o?=
 =?us-ascii?Q?hxTm56FDGWGsB9THQ5Eh1BA+gDdhcL4Yn/yNse5wmOwpc6sbYoYI8nnpzdl9?=
 =?us-ascii?Q?RVP8caUJ8G/6SsBCxd4wxPdSuEnhaC1g2QlYkXJj15CWIu5uUXMCACA66iSp?=
 =?us-ascii?Q?F4RTsBpWzMD/Qx7PMkx9tuYkXfE2fI2XobQRs71Ouqrq4eakeIUMMrldyd7B?=
 =?us-ascii?Q?9h+7AZ9iT6tyuIkdBXsKhtWkUKCcfDQ0uZbo+5ua702XsOVmPLv5Vzz3B6Rw?=
 =?us-ascii?Q?chodzlpl+wLXtL9A2785nSNUOuFf+lsPV+US9T33ByT2DJ0gFUjuZsPO/733?=
 =?us-ascii?Q?j952GUhG2ulkJy8vvI2CLxde7X2as7PorkBiqUHkjQeZnVbvzQqWOjkxLHky?=
 =?us-ascii?Q?7WRXkuG2JF3KEAMV7e6jds7BllGpNUJqYF8RzW0tBdFc3u9SH/4PHTbI39SW?=
 =?us-ascii?Q?slFfb7i8hV9rlndqly+peKACRNsDB377uXk86yKo0wlN7RyZXwLAdloXNcUo?=
 =?us-ascii?Q?EJ+pCohIMq97HmEe6wYDZjkpt3roNewmht1tN9Nm6lkWZ14CZmUwR6jzCnd/?=
 =?us-ascii?Q?FYF79OCsfmy5j6DdAdmQe9W5TTaWr86XvZxhy3llQrt1jq0NL8c+BEiu5dNJ?=
 =?us-ascii?Q?y/tD5TtaTRaMnXeCANumaK+8PZ772+otcAgiAkK4FwoXAZrHsysYxB+22WqF?=
 =?us-ascii?Q?oPnEzBnqev5K/BeG38ex7cK56r4u+cKrKQnWCCumMLgRv2N37NoLzd9qyltb?=
 =?us-ascii?Q?XhzpwvG7o+ZzJHOLb85+WHoprdcUSepvHJ/6TIKXuNgAXcstkWfmSmf6oksr?=
 =?us-ascii?Q?9tQvrkxmDg+CrWvucCOIODF63ALYMTY0sCzkk+nOBqdUyucKx/8IFfyXaYyE?=
 =?us-ascii?Q?nKhhqd3t4RUNdRCgmgwV0oS2IqpPraPcf7GOJgIUS4zancgCwes71PkYFwuR?=
 =?us-ascii?Q?oJzmE2oDxkRtv+ypzVGWPnxmWA8S5x3EhjwMcwDmQp0452uo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8529951-be3b-4153-5bec-08dea709bf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 22:42:24.1450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOVCJaBby3aEb2WP6qfVbPXyw9OjvxoSIJDwT/OZR1Bj3R+hiNtHX5j5rgBRmJbV4/i0wMIxGwTzhB38BOcvDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6682
X-Rspamd-Queue-Id: C921C4A8A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10528-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6921.namprd21.prod.outlook.com:mid,intel.com:email]

> From: kernel test robot <lkp@intel.com>
> Sent: Thursday, April 30, 2026 9:33 AM
> ...
> config: i386-buildonly-randconfig-002-20260430
>  ...
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/hv/vmbus_drv.c:2403:40: warning: result of comparison of const=
ant
> 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int')=
 is
> always false [-Wtautological-constant-out-of-range-compare]
>     2403 |                         if (!low_mmio_base || low_mmio_base >=
=3D SZ_4G ||
>          |                                               ~~~~~~~~~~~~~ ^ =
 ~~~~~
>    1 warning generated.

Thanks for reporting the warning with the i386 kernel config.
I don't know if there is any x86-32 users nowadays, but this warning can be
fixed by:

-	if (!low_mmio_base || low_mmio_base >=3D SZ_4G ||
+	if (!low_mmio_base || upper_32_bits(low_mmio_base) ||
 	    (start && start < low_mmio_base)) {
 		pr_warn("Unexpected low mmio base 0x%pa\n", &low_mmio_base);
 	}

