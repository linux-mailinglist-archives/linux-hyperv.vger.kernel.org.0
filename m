Return-Path: <linux-hyperv+bounces-10377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GpKiKwWc7WmPlgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10377-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 07:00:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0638468BBD
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 07:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A73230038F7
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Apr 2026 05:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E932224B05;
	Sun, 26 Apr 2026 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nsdbmlfu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023102.outbound.protection.outlook.com [52.101.127.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447523B2AA;
	Sun, 26 Apr 2026 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777179650; cv=fail; b=Sj0qzmKScMtT9Zd9aftVnOPuYbxQ4RvrWkTWp8UWZ7hgsvpsvF4fGw7ERdThN4zzCZesFnEyn+Nq/ViM6/BARpajPNxtZXdUcWBqDR1HtwZ09AWcA1KiaJmH1/np2OrvrGdTyHIba5BXs0OWG8/Lxx4SKHPi/gqbEWdX/M7GMI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777179650; c=relaxed/simple;
	bh=eVtvanaa01dFbB/2soJ7dSbWcbsQQAlbYy3mXZt+foQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPRPt/Kkn/kCy87nrVy0nGN6F9dJpOPssXanKWZKbxpNFFsLn/VzCBkVknr2+S4ZUwr2HYExfXC0B8FL17qa/nQXUjr+OYs/Eaj2vRoN3wl4ZvG3XFw0waq0F9V73xnxPZWM/aSJxzrj01419Ga2mCMePrNiWwmzGL4RNH3MQXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Nsdbmlfu; arc=fail smtp.client-ip=52.101.127.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUjRY1tCXTYVgPEGoYpaNkyGDnwK8Kk6kDcn2ZO4yJ4cdKHutDXXYICx4tex2gROuHJ3bO6lL2ZAzGPgjCPr8qv04QO18XXNhnCOlV5OhytI65HZEI6Tsa/OitxRGrgVj9REDyv3vdlTqfceI5SKVZJGnA3G76W0VZ41LtZSHbIoQMQu956QWk5Mg4WEHo6hGLtUzDiYW3xM3aIQ+C5/xHj0MU1kXQaq7jJlxDCi+LwvVnD9Vdh2GXVt1rtBAMaHn3MBK7gfOLbZNnT6iARJedqIQTbitC19rOVmSQbebTSbwgA6RjkzLLK4AJm43G7Yv5AUE/IJsZBwfI1/sRgdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCaoCwt9OnpWu4KDy9p09/PzVQUztpkf870emYvMKyw=;
 b=SXd14ZFb0TTtW9v9t9vmA/h8Xi/yOed1jLrYRl3GRtYACcv576qRwxD0wXGlo/dpyaSviiZP7EbZfy7Ul0Vvp8YhFBcedCHxeu6xQzYnZcRvkg8TBM+hCVukznGFBrH3fjlBEKrR+3BbDuQ/bRaVul7KhWB3cu12EKR0FYE4/7lUDd0hcOhzjInqEMHTUUU0NTmjZMh7bYx77wVshyfr8cLEa5XVP+7elJ+4QZbZh+rI/JhOZXry69bsjEhWCK/BHBOj+UQ4ZORNPEDVD12+oEPOEdONvFffZkmcfrmUORPrzY9LpPBOE92gLbPkyzfNHsTGnms62zODLjJIHnzBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCaoCwt9OnpWu4KDy9p09/PzVQUztpkf870emYvMKyw=;
 b=NsdbmlfusZMhsqR9QfpvtR38hsIO9yTfw+mrwigex7KKOrKAkpUOiREX8JyQZsmCITNV8wleT/pqQw/mPC4KZGNLNje/TRaIegzI8E9cTPu8gS/Ierk1HVaMVr1xfl0TQNjlYZ4AjvOW/hEzRhYHVid42awDBl6O9jSyXgop0j4=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SE3P153MB2015.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 05:00:26 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac%5]) with mapi id 15.20.9870.012; Sun, 26 Apr 2026
 05:00:25 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Himadri Pandya <himadrispandya@gmail.com>, Michael Kelley
	<mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
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
Thread-Index: AQHc1N/SUNnjTDdEJ0aXGX//Fa53IbXwyMIg
Date: Sun, 26 Apr 2026 05:00:24 +0000
Message-ID:
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=895fcc43-acab-44d8-b176-25a159887d25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-26T04:57:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SE3P153MB2015:EE_
x-ms-office365-filtering-correlation-id: b1137af0-4759-416d-56ba-08dea350ba3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 NY2+znp5p4TI4/zSAOfH3x5UFAjl2XDp/KERrZhh86/gEuVRGuQ//HdFcv1ijC8zGiSwAmGVlG48xamGaRg2fWWHvqdo0H3lj83CN7ah4LUC1MjVy36X+53zS2ayV1rjNESVEUhsCcazVQKxSZdApfjaosrFEpKGXhAkj0b15aruRtl2UwQI2hUVSpJ6135zUp32O0IMY9uI6wEPzA48eriIO24Z0saJDqJYkWPEFLvwOKrXEpKI5KdC0O2t9rXPzWcwZ6BQE+RehmCcAYS8SQ3S9UxMWFc1fidqEdgujug6vSgiLfW+1UbMf29jHM/gtKKpPyM5NWdWhS4YUDOc/9EBiBJ3GUVAqKV+763uJEBbQBH0/Sosr4tLrmPP06ibswXYipa5EvAdrf7rGxrXsmLxCw2Mxn+eChTyJtJi2ZI0TWAk5ySoG0JsZ12tIW8HtrMjqlL8scLXrcmGPdEV8pTooQ2+wrbv+ZPoK+6WVjQzhD6dj5kD66ssgk/45AM6hM7NJXNJ62gXvGSiUQoF8lrQIm/cm0tyo8sgB6cLmZ2joa9IuG+LiEb05RyVHQ3oG1gRMODpp0JSH/neNVKhJXBCkmcWDNOIq2a07cDIsJb5fi2GvhgULueZe2tpE2UgDn1SE1aTNFsagF0/zr0Uqmk25uURiEbXqivN5AWG5kclxkoW4vto6aJ7uu1bhfoGe71W5wFgtszUKbbNSCQaTe+Ex9pD3XYecXVREW5+dT3ui2P8JHMEhz6DaRbdZwnjUdVVCigB5VR9NSTpnwUi3kNC9TbZ17N3zTwk7jU2kFo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CxC3Up22GSg5BtNW28sPAuo3Re850mPWgHfZ5/OOf/NlFEMeyyO1qlPeabor?=
 =?us-ascii?Q?+i84wR9puWiqe6RK6RPa0BT7qFYhslZFMbML4AiHPjBghKK5Jo5+5pz8s8ID?=
 =?us-ascii?Q?i88lrcFYmhI0Wx4fbOuC3tDXRwjQsJh6A2pVID+GAnf9/YZjPCaN7ZQdTi2c?=
 =?us-ascii?Q?/2iluU7YNQCfEEkVBEXwoTucCG0bGA4R49vmFRbcQxi6nhtoAfwPu+ZCyqI0?=
 =?us-ascii?Q?q/xqwdF9r2EyvrP5UJhU8F36r8/x2MV8Lcgl0Dqu+lGLaYcYnsde6FWHHxGZ?=
 =?us-ascii?Q?VJVO/KFA4CSTL7bytxJg4132Jz/PaO3oTQDg8N7NKe/5JGjmSeHEAdkwl0ty?=
 =?us-ascii?Q?baXoadZQZTE23CyDmqrVSP7xl4Ru1yG6zTidq8J7QoLNcnlRgwhbhxPlyTTM?=
 =?us-ascii?Q?/nkpwg21Id1PDmhidVDu9Egnms3PE4juYeAiprPm5OvK1LMyAGJqvJNGO8mE?=
 =?us-ascii?Q?yEprSUBiflD5JEcZtW/vE1+h7NpoXIG5AiOlQvYLUaYfkQn5s79iQNEIa50l?=
 =?us-ascii?Q?OpVU9ydA7mi/lZz1CBKKqg9mhVl3cxVwQsN5buv16sABacEcMGaqQAwfRxNy?=
 =?us-ascii?Q?K6ZvS//3kb8WZUg3SG2m47x9RamW69QfWu68wO9ZCZThWJL7FAckFgazacbJ?=
 =?us-ascii?Q?H5RvxhIMkG1bj89KuonxaXRvksWKQ52ljQ7KKyiHmbn/AkIO2UYBmVn5Vb8v?=
 =?us-ascii?Q?+Jgk9ndHTnHauBXSGXdQVG46ewwCy5SM53O9kk2gdIt3bGnxIiszO6hcVwOw?=
 =?us-ascii?Q?lGyPYhh7CBI+FWV6FsK/2TQVnzmbJhcf9p219LYrBVLMRrZl9O09K/tnd5qk?=
 =?us-ascii?Q?oxHPQTA4k5U309VGki6eveSgWoPM9fbNBOZFwYNsL1GjPSFnYSxVsS4rxK+4?=
 =?us-ascii?Q?eLmdhLufAQRKSnzIBtZ9nA9Bd3NO5DutrHzHQhoLrXOcwXrLECjF7tdlBYaD?=
 =?us-ascii?Q?5xnpjWXbmnFWnrCQl8N7Q1I1DthzuYER2+eNLNWqRsX3LHVsUFUSdWPbSoGr?=
 =?us-ascii?Q?t8xnWgeJ3uS3Yb6nETfogDP31ZybsXyBf4fxfEwUw7bAXGXRG59DIFGCOvaF?=
 =?us-ascii?Q?TEAQrCNiAIllCt0fenlIF+UPON2NyqecqQSiei3L6+AgWnHYyF6Y8HQd/PHn?=
 =?us-ascii?Q?OG1MvuF8qOOrR+Q6wmxU/n0zhUvKLg/PioPys5LLLb3YIqllKNsRMyL3OR0u?=
 =?us-ascii?Q?UNGdeD9i2y61O5JYYCM6vqWseo+jUwv5cjaW5GTp23CzXKanThC78ifmmxB9?=
 =?us-ascii?Q?y1HJvus5AWKvcFnUJi7PykM9xdm67PUtvJ4Ic7Zs0rTyVVT3lU9g4QDKFL1h?=
 =?us-ascii?Q?2MRgUSL+YBpfGlNNOZD5pXpgZwQfCqLMg3Hm2EcVsXpl61tkRUm2xZW2nO5x?=
 =?us-ascii?Q?hiJOOlbGzJ20b/PrtOLrYaSF3a6eE8Dk0tEclaTTtOH+Ccb6rd+4whyDM+YI?=
 =?us-ascii?Q?F7UhSBw8SGh5YUdLH2MSMIOOLhUuMkKJ3dspimpiT9ZKgAGCIlZ8DCPFEnl5?=
 =?us-ascii?Q?WIHBmf6wZe5CIMhi11uttbkiYoqNaahJ8/6ySpw7hlYACjJI9ZRwBwSyRWQp?=
 =?us-ascii?Q?p1iU0PqYbSXPx7ni9COTItEwE6YlFxtbXnHt6PXYHqiTPtdUYfadBkzg9ubw?=
 =?us-ascii?Q?fBqIQXE3Na6nRJIaIeFoIE83M76nqGmxQjKOrAcLQOT6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1137af0-4759-416d-56ba-08dea350ba3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2026 05:00:24.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8jWOY/UEHeWzYVXz26eGwh4d+vGjQ4BVp4DM0gdd+AE9zFfwVrqJzCoSfkarSG6eGEaPrwt7BXHq8ZsADtpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3P153MB2015
X-Rspamd-Queue-Id: F0638468BBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10377-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,outlook.com,vger.kernel.org,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
>=20
> VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
> ensure they are always aligned and large enough to hold all of the releva=
nt
> data.
>=20
> Cc: stable@kernel.vger.org
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo
> device")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 051ecc526832..753d97bff76f 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -10,7 +10,7 @@
>=20
>  #include "hyperv_drm.h"
>=20
> -#define VMBUS_RING_BUFSIZE (256 * 1024)
> +#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
>  #define VMBUS_VSP_TIMEOUT (10 * HZ)
>=20
>  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
> --
> 2.54.0

Although this lgtm, but this may change the behaviour on ARM64 systems with=
 page size > 4K ?
Have we tested it ?

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>



