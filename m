Return-Path: <linux-hyperv+bounces-10656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP2JLSuV+2nccwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10656-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 21:23:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058D4DFB09
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 21:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B48F0300E16D
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813F30DEBA;
	Wed,  6 May 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YuUeYGyX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020120.outbound.protection.outlook.com [52.101.46.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263A2C0323;
	Wed,  6 May 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095400; cv=fail; b=kFqvSCxqw/0hc8qWVb4vS9yiofQ2LTcgenawGxlIaU+Osly4VJ3WVR6Fb8cE9klR7oa+AIZIXRkjSwYnAB62dIrb6hgvTHWztJutW5DLqRVc167kRFpjHQx++TP6SiqdLMNBJoJHsg7g5UPB/vQnC0tCebKrgsrUZMgevCbfkz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095400; c=relaxed/simple;
	bh=Mr7OP5z+4hW65YLszvja3AVZZ0kUmGVybKKBmhIYMnk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUWody0A0P2CTTV2H8kXLpAHL8snJy6G2PtlmeZAAKuKP+GY6bG/h4KO81a5XH/TwncO84VK79VhHQ80K6g/6wCHm6YoDGF4BXdVRw9vY/n9kpUTiQO0EkS94l8vOC9UiWZVax2kidGqcgNKP8F31iOJl3oBUzVECtpQNyNrt/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YuUeYGyX; arc=fail smtp.client-ip=52.101.46.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TymGjNMiMfBSD66eoiuO9zuU11jECWQbDIKC4cjLGyWWeAjq56L78ZaCnzyrxE1bCrGT0INC6JWBUSqghtNrMhjNe8CkqQhAcdxtPt9HMUPIehv1fFUmeeJMZchVHmcEss2oarU9+3UACshotkPuXFcwDtNIZKZqWHHCFy2fCaYSfrtfm8QxwAOavRWwC6JjIeU4AAZ2bgwXgVi+A3Mbuqv9cVywS0DztVFwXH5tecr5nF/Ck+0MyR2i9Rqg02D4/jWS/2ckuhlVMp30ebO//XqsO97/75cd9bKTOwaoxhIuW9iIB0Lvrc+FmFG0XuCgWfVgfnFfJrP/75aY3J34+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om7Xwbc0ZO4hFHSytZ4ZwfJqqqleFvBv9oscayzcma4=;
 b=lnuQ1wQmLmPFp8mu+tT/G76qD8CMlsSib2ljT1qGiEUvuE8aW32Q5eWIj+Wj6PtWuctjg4uYml4nH/zX16stsItvLvRrhCRIl2Ge/qL25v8Jn7E1IqoofTRKMaSozZNe7K7GG77jO+dtjMVH9EzkdbVDBrSzWAa4Nr5pfTn/8H4IpdeMN0PuXWtUGY0fn4XdGtL8hK4Sd8j1agtYY7+R2gQpF/0r/wfkqWLcDD+QiMyY3DvS+VkYrvwnsIGRClOhozZB3+jFuiExcCT+7MP07Z52M3v5xO3HPAgc/tHirN4UJl84A+l61lm+oydYahlXioabz7CxI6pU+4w4gRsxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om7Xwbc0ZO4hFHSytZ4ZwfJqqqleFvBv9oscayzcma4=;
 b=YuUeYGyXi5ptC/uWiJ7/pH0Qw6uG48dj7DT95SxbtSiLHOXLSRk1ftwOtF/h8mI05CLYBRRQ0Bh7ad6Y03lTjJJMExM7GMd1dFjhwuof5oxjXt/Ae7XmT37n+Gc/0N6ui/sCpeo5hoOoAkwZBjeQd3UJ7l6yVS4kqg4Y9ntrSXU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV0PR21MB5751.namprd21.prod.outlook.com (2603:10b6:408:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Wed, 6 May
 2026 19:23:16 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:23:16 +0000
From: Long Li <longli@microsoft.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>
Subject: RE: [EXTERNAL] [PATCH v2] scsi: storvsc: Replace symbolic permissions
 with octal
Thread-Topic: [EXTERNAL] [PATCH v2] scsi: storvsc: Replace symbolic
 permissions with octal
Thread-Index: AQHc3PJD/4qTX1B3nEuzEL1cWK7Yl7YBYYuQ
Date: Wed, 6 May 2026 19:23:16 +0000
Message-ID:
 <SA1PR21MB6683BB69320F35627E41409ACE3F2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260506004948.2172-1-shofiqtest@gmail.com>
In-Reply-To: <20260506004948.2172-1-shofiqtest@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7ac05d88-260f-4a54-b059-1fe5deb4377c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-06T19:22:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV0PR21MB5751:EE_
x-ms-office365-filtering-correlation-id: af13e9e3-2efc-4650-df94-08deaba4ec98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 mG73GukqikoBvXbUT4D8R+AQHNpeW0nyKSoCaFqFk5ZMTy/BF0CXK/1cc4hj+bN0mpzMHx23OAbmZqg8M7pP8DUb2x9DdovkVUlz4Mn8towR25lAHzGe/0kgDqZeKSDIUGCUJF5c5qAwqym4j+UkIpTzvGCpVX5ErMGZX2VHfbdXDGpCoTqgSO9/BWF3xaGLMCIhygER34+4X81zQ1bqacx7blBAHAFZ+zXg6ngqJNI1V951cUiCFEg5/Gs2IBlhXZ0i2moIDFNoq54gNxMNobIrPuMt/ppl1YvpcaArZYn49Se6AXqC0m/VjQ635x8101QUNssEa51tl2ZIoGfEljnnxMyCgU4tt4ctaddFtL/MoxV2bDgA9lnFpAHomhF62CQVvrUIYsz4vLhtLwTWIQcDuK0ZOW+BrUGUeB7Ih12DUbPIwTX9jmHh35NVVFYNbr97C9rIOiZFnj0gB6kS271XyQRKLRcNEZ0xFNnwdJhPcVU0qmR7K4ooWXQwXQpOmEJJPrDVSxt1LxPmPCjYxZBmD/m5KHWKVUVXgajkxZ+gEmdB/zOae4Ir4er14yb11bqny7efIyG4LHXYSFEb7IYiVEa4Gh8A8bW6z8RvNGU83/3qKdZr9L1gSQ548rDMA46eSDpfXa8zfz5ZCaj36gY5F03btiA9CZDqvwc5IjvSpT9Jrg5FMYGdtg3XzsgIeLq+Vufk4yIBld76DSu3VJoZaJRtUj/mZBNTSgD/lDu7wAvFLZoh19G//wW3U0+Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yv9Dk+6wUvKd3Kevk/KjlIoptIsknASILvHiY2OXNw5KfH9c3PC9oq0N2rwV?=
 =?us-ascii?Q?pNKsT5iDWaJTScRE4yW5ss3mHPBzGAYd2uiALiVkKgCqqGu846PY9/XrS+NE?=
 =?us-ascii?Q?eeeNtV80lgI0O1eBQ/qzUwumSkiaKpnq7uiuXF+SVJw5IDKZ1GwyiA23tjlg?=
 =?us-ascii?Q?yAnQVIIoKQhOLoXm2INq6SNkiY5DP9V29XHr5I6Fmigw3z+JKosVQm9mKHHx?=
 =?us-ascii?Q?P7QcnUj6kxkLLW+SrI3AYqPCOOwQwjEuKZVHTpwGLGC7r4GSNIuCQjYKwdKt?=
 =?us-ascii?Q?jLiZWfHjvdW0BoI187104QTv/dA582JEULxeE8SgpntgUJPxUC9FK9j/tRQI?=
 =?us-ascii?Q?rH6vQ5o5tkog91DKkUVvNddp2Zxii/ihYw9wPVCBN1pxXSzEha0Lk2uK7gq0?=
 =?us-ascii?Q?OrARww3/xx71kghcmenldIYef70IwNoInMfAFwBQYmss6jNbFC1dxrN2P0RT?=
 =?us-ascii?Q?oElonXVAP5LRa/Njsi1L9YuMVTjS9nfFtBkqXaEEyxJWLZQ2qB+D0igWbe8R?=
 =?us-ascii?Q?fe/aauZYoXnAcWrZ0bbOY301zGWfP9iwwSuqyEW8zpIi05S286oyx3Z1Dv7H?=
 =?us-ascii?Q?RF8cwh9rsfjZABKTeRSfKdU3X8FiJPL6OsJdHr6LYVWaik4p9e+iOBKTLfUc?=
 =?us-ascii?Q?0DuCLgbqZktX0S0/CSOhSwE3YZvxatnxUjHemmG8jMnytZ/1Fy1KeXUWpJz3?=
 =?us-ascii?Q?uDT29eAXY9FBJJrJSzmWwZnriJTGh/0rtLt3leppyP0znWCG17CkLZ/9WBre?=
 =?us-ascii?Q?lgOqYL9SvReI5K8TJWzIguA9cQrYtNwjO2ULPj+jopDxL0xPox27/8imQW41?=
 =?us-ascii?Q?1JTJTXtHyJBy//Azc+vXkzuZ5N87WQPMXmgXMF9njxI6jM6MRwZ9DRN2d3fe?=
 =?us-ascii?Q?jTvF5gKg6XCUrXt2GhEbVUpBJd58LR/wJR6/0UT0MhuKK0+KGR6i3hro5S8E?=
 =?us-ascii?Q?S0PRasB6Mll4aFQqCxjxA62wtExfSF7j43WVhFkDK/xykPifBB3o1wwxtJMz?=
 =?us-ascii?Q?kKA2G4dcOjv28e9ENG2C6lHDJ+fDHP6AX1mTgdO2n0nmhTSlli0Xp26WKS8F?=
 =?us-ascii?Q?j3B1nJyJfQfys2qajyjXKFsbf/aw2etEie8O7TNVSDNxYw2sWLuUGw4mnf5k?=
 =?us-ascii?Q?CMSpVXGWwgonVP8F1SV94rJBODSau83UEdXyMN08Es1fl8tfQK7OyJBeVz+x?=
 =?us-ascii?Q?EIy6+bCamun6Rw5fnXUFZR0G8y34YUUjDz0gDQnCLvKw+40hSUpKyhRaYrg7?=
 =?us-ascii?Q?+xyj4/EpME7UoEqIwFNqbMybFLWmHRv44V1KHB9xbvU21I7zJUVFKFVqGdSs?=
 =?us-ascii?Q?RuMFSHdmltmmvt41z1ZViKgAI6qEALqU6hxKB0SVGCaN4PpM8g70Xg8ffjyb?=
 =?us-ascii?Q?UQzemKY0lJ6MoXwhtLNYpA0U4D3TxlHH8rqZzq0gab+vhs6KrrUdxoXBBDmE?=
 =?us-ascii?Q?TgD2wteDveA1BWLfY3ZcJFSh4fvjmzG5lc83B+kE5+wm05WgE7VwE6jwY19X?=
 =?us-ascii?Q?8aDfn7HUne7JB4/n/165y4K+FJEUbNE20PfX+YJuQrNBGyAEIqxqBpXyLEW8?=
 =?us-ascii?Q?gXXsz4p0jFEC7WeFgVdBqy+sk7hm0felAcj7bpYvHip4lbv+KfIINqPe8Qj2?=
 =?us-ascii?Q?/+5lf6jJhbJt9HheByTFC/QYrruthtl5hm4c28/MS8B+77bm0R52qz2tsLzh?=
 =?us-ascii?Q?z38Rt/yOA78cFVpzmrvGfh7BsZDDU1yB/+zhFsujSRFahflf?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af13e9e3-2efc-4650-df94-08deaba4ec98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 19:23:16.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/W49wZEMall8SVF8UcZG4ppjiPYT9CcN/vRzpoAN/ykP+q3ikuqx/A02vZFdneWnIOK+7h3XXuVIdA0V31Kag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB5751
X-Rspamd-Queue-Id: 3058D4DFB09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10656-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

>=20
> Symbolic permissions like S_IRUGO and S_IWUSR are not preferred by
> checkpatch. Replace with their octal equivalents:
>=20
>   - S_IRUGO|S_IWUSR -> 0644
>   - S_IRUGO         -> 0444
>=20
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/scsi/storvsc_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> 6977ca8a0..571ea5491 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -156,7 +156,7 @@ static bool hv_dev_is_fc(struct hv_device *hv_dev);
>  #define STORVSC_LOGGING_WARN   2
>=20
>  static int logging_level =3D STORVSC_LOGGING_ERROR; -
> module_param(logging_level, int, S_IRUGO|S_IWUSR);
> +module_param(logging_level, int, 0644);
>  MODULE_PARM_DESC(logging_level,
>         "Logging level, 0 - None, 1 - Error (default), 2 - Warning.");
>=20
> @@ -345,17 +345,17 @@ static int storvsc_change_queue_depth(struct
> scsi_device *sdev, int queue_depth)  static int storvsc_vcpus_per_sub_cha=
nnel =3D
> 4;  static unsigned int storvsc_max_hw_queues;
>=20
> -module_param(storvsc_ringbuffer_size, int, S_IRUGO);
> +module_param(storvsc_ringbuffer_size, int, 0444);
>  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
>=20
>  module_param(storvsc_max_hw_queues, uint, 0644);
> MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of
> hardware queues");
>=20
> -module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
> +module_param(storvsc_vcpus_per_sub_channel, int, 0444);
>  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to
> subchannels");
>=20
>  static int ring_avail_percent_lowater =3D 10; -
> module_param(ring_avail_percent_lowater, int, S_IRUGO);
> +module_param(ring_avail_percent_lowater, int, 0444);
>  MODULE_PARM_DESC(ring_avail_percent_lowater,
>                 "Select a channel if available ring size > this in percen=
t");
>=20
> --
> 2.54.0.windows.1


