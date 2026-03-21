Return-Path: <linux-hyperv+bounces-9680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ke1Ds3svWkwDwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9680-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:56:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918522E2B3B
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 01:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED5B30917BE
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8543290A1;
	Sat, 21 Mar 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="caOeBPlR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021105.outbound.protection.outlook.com [52.101.62.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E579225417;
	Sat, 21 Mar 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054472; cv=fail; b=sep6Np8MCw75h4dv/QoPMrR0HHig5ruWy4H9F7vdLT16qkF8qJxJwOWagmuN5BzHwnW9p3A3TstuJ7N15C+DpfXrHejPYHE0Avjo5HilY1KNjDeq4SZQdE4cS0C7z7AM9/MBwlkxt9/9XNXxyaqrJpAoL3BW3dhcYjvYTfZW4LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054472; c=relaxed/simple;
	bh=yiv5qvNdVO9dCEiCYW0rc4IghVga1AYKOKUkVR2/cHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pvz1sJWFLSmZnxsQ8WOk95WN/6OF3nbRiHObW6QxODYQHza16CvaFbpo9FAvNVwmHIiC7AQR2YSwpmDOLUbxrPk/eGjNfylreU0F1C01YojZ6/ofrGgKzwD/oNkhFIL/jyq4nF+4wHH5h+u3++lfaSf98u9duohC6q0AwHr9c8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=caOeBPlR; arc=fail smtp.client-ip=52.101.62.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHcaR0efCQ6LtJs6P3wwCiQxINx+a79xOL3p5hGC/DNZ1qSd89jDEyhI4y2GMWJE2KsGieKihH59w+PNpCiif2L4woOWYbAkUsjw5+zHb8bN/m/4xMxKC8jg16sJT+FOD6SbK5p4PGCTRFGvhvaENfqhs668am0jmYf4I1TUkznTgIAlOB5W02UOSCIBZ69KYjj97eYnDp9T09p4sjnMPzwI8xMDGsVY3bcs3ky1A5MYgO1800Ag4yxEwQE/1sefkNjJRX8PAtKCXgRVvWznW0MfwuOPVD5L96yE/hOrWR5jWSD60289NO25Zmk9e4/NQst+71Vg51U3lpsZHRW7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml6SNnS9CW8VQBe6vWmxB38DvcAZFc5oz8aVjwcl5T0=;
 b=mxS8LVeHKlfLy6Va3P8oskwd1Dv/V5ZdIFWSAeDbLg+xwiAtD1oueL3emaCscyzKb3a/v7x5jBumzh7D2RJWQPyxPxom2tAqfqLx2PkMmg6Ao0J4GH6kEx5EUuM/EIuAx7JkYOLzVLCClsRdNFz7YiZIr+1pht/1B+PhVpcXcnKAE/JQzLap2Cn8wjJhoyLVWi2vKGQ3HobKn3LRpIlDEeNtQFyD+PxevYViDVnpABctjKx15rSTSJvTxO0FUFQL7os2ZuA8XEjlqE90GqqYu8/dSALB4JRWAiSimGOhHXM/SzmlVksfZxS0pNkrTYW1NEQr8sXf1JJlZwBZ16xVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml6SNnS9CW8VQBe6vWmxB38DvcAZFc5oz8aVjwcl5T0=;
 b=caOeBPlRcfe71MFWv9upo+krETUU5NtNEyccYjgvv/Ryk/IlvXXZ7rXHIPtXjCuyN8SFEeewTghakChSN2jpzmv82xqy/qp/L2QlVvWYZUTxSleqbz/6HqjyK3aUieeL7zrl3LXMwSvosxM8pJDbHywrE7xGPJ05Q7tNAmDuKxY=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS2PR21MB5636.namprd21.prod.outlook.com (2603:10b6:8:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 00:54:27 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 00:54:27 +0000
From: Long Li <longli@microsoft.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>, Aditya Garg
	<gargaditya@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] net: mana: fix use-after-free in add_adev()
 error path
Thread-Topic: [EXTERNAL] [PATCH] net: mana: fix use-after-free in add_adev()
 error path
Thread-Index: AQHctu2ebd0c04Rfq0yN3Ad81LZjAbW4K+JQ
Date: Sat, 21 Mar 2026 00:54:27 +0000
Message-ID:
 <SA1PR21MB668307100E236BDFD42DE3F7CE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260318154041.638747-1-lgs201920130244@gmail.com>
In-Reply-To: <20260318154041.638747-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e4dd799e-96ed-460b-b437-8214e60bdb73;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-21T00:51:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS2PR21MB5636:EE_
x-ms-office365-filtering-correlation-id: b9a57772-f890-450a-7e87-08de86e46712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 CGdLN00rfhUEd/14XWP77E523P9InF+K3pnIj7SeZfFrDmKcsQ4Ay1EyH/eGYkgIL6ToiK2ux9tAKCXaMujnCy6XKmMrpOtixRYPmnJ3GBRb68Q4+0GbSFQVzNxVbYvVvMBI1c9e5Mwe8U2mF55THFZGpewJurcNXC72cYZnlVN+P9vchJd7oPaWnMBeCaNoRdQK++RzVLPBKBjDmefwilwTzS8eRxnxFy2c9uoThkwkuvSCtLRKRmtcjRoFBgFrfbYc80ibfYMrBuXCPW9o1CgohExNE5ispsb3aawGAcGm+SgD+Fvfuwz5o6ip2hYvrbZ9QrUkCxRr1LkjSFwOQ32xhFI++p9F1jTCm79cUVshhoYOOu5psv4Jvg37vRNEuRzI1znmdPl6I4KrECskuvZxsM8TQnPRlQx7CKnr2YsZrGeVGBm8p3k3B9sMhbMdMAPHqgHdtNa2pFK9BYfFS7uJodd9sYh17Sz29xEiRzXnmHxOWKDwO5xBjbu/eELvOEFAeVx/mth3wX4OXD+5dsRGXZ3rZyRekqBgKqtfOH6X5hTMNrPYtGeochvpkrOcXi+FMsTh+UkyUEzO6kwffhIXHdi7cGMFd3Jeny8Xp3AhYIApH73F6BFhdBYpEnF4cYy8I7sazggAB0fn6IKOaeEUGgY//uXApauFm/AXRN2lcPlyhvJL1iSf5wxAsEC4W8pr19kxX9cykz5qM5mNnKQnwhcqMCg1hR+5QngtRl0L6VVDljW+hsMRJ16jvQsPTUyhvL6su/HunXNTURHqyyxeIArrBk4GpMwKtuxEll4i2WX3kDucM4CaCEtmhjU7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UNljpOXQcd/m/APCMzwZ/Q1tHlSpQlgO7yBgwpjuOQMgMDfVJOo4HUL9DrlI?=
 =?us-ascii?Q?PCRgsqD/uIhxTm6IK6dFT88IVdfp3Jt/o1VBTVF+TmSWzP9p/NUn3qMLgurA?=
 =?us-ascii?Q?x2WL2Eybk2N1plkyjsvyz4M2UJbLg53FeGUzPnuIRlATtVGd/BHIChX34P97?=
 =?us-ascii?Q?pGXitE/MCadO20t5fWyq7yEJpAcMxY6Vot68/Z+NcrTC5jkBUeio5BVS+o+7?=
 =?us-ascii?Q?9WMYIpe7FhBRBDJvjdH14SHZd3G+aYIQE2mFg75MIZ46gYK5ljKkr1VvCCE9?=
 =?us-ascii?Q?bLql6/3RBwAOftjutk2r3y3XJUL1241abLIO+Xxfo4iGSAA4fmseeWhRea5L?=
 =?us-ascii?Q?awIxeRCwtE7p04z6JlAh/8ZQl7sqiUPATgEpH3VR/DwCrblmfAO3jaf3nXUd?=
 =?us-ascii?Q?B+5Oliym+VlIPGN6KNQ7lgDC4qSzs/DhAOY/ofmPWAYDjHS7w/Y55U3cqUur?=
 =?us-ascii?Q?Sw5SBQeu+9h5lUVw4Z3Vp1hMpJL1tfprrQKJIZ6FkYrGTH16rOCsz3+HtJ1l?=
 =?us-ascii?Q?8ZAfF6+tkQ+gNxQGtFtSvBKvd211RQTg1sEvKAogKmF7gjuUyEhajmL/unKy?=
 =?us-ascii?Q?AmDnqxLlfmc61biu9r04fTMt7ZjTgMBntFBVHZlP40llHTUM8uEpHFPaytEj?=
 =?us-ascii?Q?tmyvh0zbQrp0xxclOehz3aAPQTpSzGfgpCJ6JMi50rRkBeC0SjSWpIKn0sHD?=
 =?us-ascii?Q?zWLcBV2HDj3rLYmZjTecUL+zL0ntG+vgL7TaktSN3jDsAvcQaueno7PtW5GO?=
 =?us-ascii?Q?xhEPmtIL5mSr2FPxoyoTBl9oZV7HbdKYqpIamEJuh6CzzvKaGrJYimCv4Mpr?=
 =?us-ascii?Q?aVIfm9BvElW7dSfzFjmtEE+17uE1Bg8QJ+tlJW3L40kvDjsexb+yP8vRkxpt?=
 =?us-ascii?Q?+b/jK89Q3gsDWOoPA6w3z9AET4YlxumQaDAw3PVEdYe6cPIEIsyO5R9gPG10?=
 =?us-ascii?Q?TdhkfXB1shEGXkwM2EDZ8LEUZ9BBdCN9DoiTK06c7o4oCldP6fBBdn2PQPhR?=
 =?us-ascii?Q?WI3ytzbkPSzybqFu8NSzXzVxZIcqoeT3CVtiTEwRaV85zJtpVVk6FPgZEof/?=
 =?us-ascii?Q?n0BWAI4Ud8VwMCFiOS/m+tBBCQgcyQzp+YKpdXzjVVG3F9lgwkWXCzvmvuLc?=
 =?us-ascii?Q?algk1qTcsJXqha++kTZ4K8G7Ae8wYi8hnwIex9FDIyYhps9xHzChTqz19YPb?=
 =?us-ascii?Q?MhrCrL668ka43IyxccVS1q2URiyV4F4ItzF5Nc/S+Exy4xrRKHI1Owr/A3mr?=
 =?us-ascii?Q?+FZTu96wATY4iQMEpVqpvJRL5agevC6R88udW1A3GsWk814aicA5JD1Faolh?=
 =?us-ascii?Q?tKyxq9q9Mx6m7k3HHHKWYYAoQOYJipPE5hgXLv6WGK2jwhZDspYnkgq9c8Bj?=
 =?us-ascii?Q?3InFWzuUL51e6pwulm6k8arh1IT3XaXYAHK28mz9GZMlLajxTXrtzl0OB8RW?=
 =?us-ascii?Q?TcVl31IAZcdblauYwiIspYJk/9xluNbIDgGFixjnITp4/T4+81qxbBRjbSB3?=
 =?us-ascii?Q?8Kxn4Sa8fGqk9FvbJ36wqOCORbm0vFhV5i/Q2K5ZL17k2Ad/q1wtWtv0Oa+a?=
 =?us-ascii?Q?6pKFwNTEMmGSc9siAUOVcTm3Q5yBSyuNTEYk4e0IB2w72rm9f2helTzudgxA?=
 =?us-ascii?Q?zcVp1aMLCBlSReRzsBApQC3K77OSFYFflbpHgh7F7HVGJt/xvSmzQabwmREM?=
 =?us-ascii?Q?/C+LTZ/e77QWQQTE5Z74WWc8FnlpqxwTZa1Flaqm06CGIfEa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a57772-f890-450a-7e87-08de86e46712
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2026 00:54:27.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izuapNT9wUmSudcyMGU/xP27O7cOku9l4/rez5Sd19tnyQD9aBGS/c2Ip1YxQsvL+fJAsvafw4zomaLepfGigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5636
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9680-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 918522E2B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> If auxiliary_device_add() fails, add_adev() calls auxiliary_device_uninit=
(adev),
> whose release callback adev_release() frees the containing struct mana_ad=
ev.
>=20
> The current error path then falls through to init_fail and accesses
> adev->id. Since adev is embedded in struct mana_adev, this may lead
> to a use-after-free.
>=20
> Fix it by storing the allocated auxiliary device id in a local variable a=
nd using that
> saved id in the cleanup path after auxiliary_device_uninit().
>=20
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Long Li <longli@microsoft.com>

Thank you.

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 1ad154f9db1a..70d71594c599 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char
> *name)  {
>         struct auxiliary_device *adev;
>         struct mana_adev *madev;
> +       int id;
>         int ret;
>=20
>         madev =3D kzalloc(sizeof(*madev), GFP_KERNEL); @@ -3372,7 +3373,8=
 @@
> static int add_adev(struct gdma_dev *gd, const char *name)
>         ret =3D mana_adev_idx_alloc();
>         if (ret < 0)
>                 goto idx_fail;
> -       adev->id =3D ret;
> +       id =3D ret;
> +       adev->id =3D id;
>=20
>         adev->name =3D name;
>         adev->dev.parent =3D gd->gdma_context->dev; @@ -3398,7 +3400,7 @@
> static int add_adev(struct gdma_dev *gd, const char *name)
>         auxiliary_device_uninit(adev);
>=20
>  init_fail:
> -       mana_adev_idx_free(adev->id);
> +       mana_adev_idx_free(id);
>=20
>  idx_fail:
>         kfree(madev);
> --
> 2.43.0


