Return-Path: <linux-hyperv+bounces-4918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A7A8A3A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ED4443A8D
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AB218851;
	Tue, 15 Apr 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LfG2f08y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2011.outbound.protection.outlook.com [40.92.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00E20ADE6;
	Tue, 15 Apr 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733299; cv=fail; b=ZXv4rBt5WsM0FGxcNqO/ftaTLr4UNpb0G76ipHXXzK44pVixttwso7RjOKn/MpWmQMls7M8IYrDOedph8Yow7m4CX3s3e3FeKWpRkjwicSinO9jCHFkuqwjDjDKerO5j+WIg6bnikmcy8n3G23q3tilXptVRCALWxkbR1+l0Fcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733299; c=relaxed/simple;
	bh=oIiuv1X0SlXVKp5n9dL6E1iKdVOtJ2AEElmcag1thSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8DGF6RLvf+EDoTRTA72iAO/sktnnHkCtpY/bKfr3qja19gnKJfZoCTgYlygAON8PJNCxwtO9eeIidTZEn3aPlL1ttw4+I5ALBNvPRiWzOjS0XJ8DfD3eFkH8OUptBt19GywQOiuvMRU/wsl305eamu0quHpKGuJBIFH3Ujnmtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LfG2f08y; arc=fail smtp.client-ip=40.92.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3gfX8JEnBPxk2o2+WRAoS+trx0U7fivRShh9uEjiYt6dL4S6j3MXaSTxPqGX+ApuqgSysitFHquOAFkvX2w4yCHOPhKlQiwAUsjIy7juRzz/5V64DQQ3hXFK9fdC6JSLWsE+UDehgkS4Hc77ZlDf0pR0PHLXdbTutEXCsBnRNqIZTVYaOi9D9R3rrYtYe5TxV9BTvMDFWAXP+wfLYXNMilLArb90HllUxLqMH0GQ4JY2mCTdnQ6RFKUldK2/aym3oXdkOn2CLWDeBTxsZuX7HEAmw+DLW+bJpSi6xtfabiYCSkvh606oq9jsAbdNeShQYLOKRLt0GDH6VJnhK/DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjK0cWEVd73mcKmo4P53snGLw/JM7ANIV32gBED/Hpw=;
 b=bNL534SjYT2hTlzrvtydnYfQQ2zhjXDhVRkU8J4dxUyHUziyp2JZzIPugheejAmIEEXbqUtOrdbzklCV/c/H8E0ueHsZPPVBSpKVWpPuCmtGGMWDyQSIv5K/G6LJzp7uNHpWZXgtkoWqgyIkLk+Kv3Xu+HGfcaaiK7NP0sHEMqHKMa8SWqhBE2D6/jggCw0FRgS1JbizOzlOexd9JMNwS68Vpv1906pC8CbdU1MJwnU8n+I628W8bTHWKDH9VWeErWk0zAJ+bJbeRNgeTq6/cTa/Ap6jLwqAd+QO/sjLgWCeO1KE1xO2gdiMQUz9efi4NawPzL2WSrEtldj2szFuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjK0cWEVd73mcKmo4P53snGLw/JM7ANIV32gBED/Hpw=;
 b=LfG2f08yQJwQwwMbGACsMN8LBRP2TCM8K2zgIo1YFBwg8O5oJgjb7us8EPOF3Jdf1tUzAsIM0vBDcSEzBZDhdf/YAGwFzS4Fy5zRDKaAKvy2O0Ka3m7v8lh0v/O+ZxUk4gOnifsZC9oqJ+cXj8bl621ALHIpQryyjZuOtFBAQA488mpqajxHpOJ4Jgrm3NENesfjEynt4sPFPOxAILJMNbkCdvECfbbd+PFu7phq69BNSD/Y33kzRX1IHZaaSWJV+cYNSxI3YWAAFbRQowhEktnRGJQm6kudNE/ugrAmloccfiRwaFuh/nsAy0IIU3UFHmyk7VSuhyZJJb7+JFX8Vw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9359.namprd02.prod.outlook.com (2603:10b6:510:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 16:08:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 16:08:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v4 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Thread-Topic: [PATCH v4 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Thread-Index: AQHbqd8LFlOL2OBO1k6aNRsiIlqmsLOk6ZHw
Date: Tue, 15 Apr 2025 16:08:15 +0000
Message-ID:
 <SN6PR02MB4157D5A900435AD1663BC720D4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
In-Reply-To: <20250410060847.82407-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9359:EE_
x-ms-office365-filtering-correlation-id: 682921aa-f10c-4101-f19a-08dd7c37ba95
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15080799006|8062599003|19110799003|1602099012|10035399004|3412199025|4302099013|440099028|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GEgmI3kXnomkhwJChmd52gWgG5nDYfKra+sgkDFPW/vQd6WLKe12X5UnzMLF?=
 =?us-ascii?Q?LeW5FOK7tZYHIEViromRJ3S1uCqYo+TeRlGXeVQH15wCnzAbcGvy9j4EUPG4?=
 =?us-ascii?Q?mg42nAG+Eepp+VY2lZA8z6CbY65MEGkGRtbQawNv84TZLtPX+sVSjmqvPSz6?=
 =?us-ascii?Q?bRMV78nmWe4Y6+h0FKqn8ZcCxOoGJG/ONxhU4khh03HGxwCNxKe8ktXPdhQ4?=
 =?us-ascii?Q?JuJtRaWXqjKSVQfJRYe0UvXJNVAOAGFmbI+9iCeBsUMZ5OpxicHbAOthmpmb?=
 =?us-ascii?Q?vS09Pv4CzTQazG87rXv+yaXB5WHR68EYGJlZsv+C/BvpTU/kKIOCHCt+DOFt?=
 =?us-ascii?Q?lIizK8Uq0OELOsHUaS0KgVIJITTYH+ygUUFZBxNixO9L5UuDXq/67QMBuT5z?=
 =?us-ascii?Q?6CjaJKa0UWLBL2w6gZQ6IwWIQkmkregD78XpHsMRtmhHUZIxnmKLm0uP8WPq?=
 =?us-ascii?Q?sjRV4W3wS7kq/Sac7ofIeSDMFm65EQK1CWX4NJ8XhxTsduUQgDqMYcDUhveG?=
 =?us-ascii?Q?7L6GOcjNoXTN00y6WMZ5HGljtw6hH9mfROMfX5wgAe9RxDwvixvUnV2xBAj7?=
 =?us-ascii?Q?QWYponZq9seWkyR9EpID6EVtPYXmwpRog38mk0QBVD1PuzVrSBeDCF5ZWu6V?=
 =?us-ascii?Q?RRNFXSuZGL7xkmHIWK1eXg2RxlR8wcxUXAZ1UzYuVDoPPj7tPDPLM4+/L/Wj?=
 =?us-ascii?Q?Z7K14C7UhsItK5Yx7RGWQn592qDQByY4XrubFT+JHMT9WwHRtTwZ3BlU0TLH?=
 =?us-ascii?Q?Qn9QTsDt41LF6QjfPZq5zsa6m9/TF9MqJVn0iMCxRV+PlMFTZKIUw95/182O?=
 =?us-ascii?Q?vyXIj8e3/b2s86CeEcsxICN1+7NgLE4bg5QGVOtNSZPuIe1Wq6XQRRINKYGJ?=
 =?us-ascii?Q?4TU70USVE8E0Yox4Kr3tsmD8An09S779NrWrEPrl1WQj+ACccBZRDXu6NaDa?=
 =?us-ascii?Q?o7DYqvy4XuWBl+HdO9xe/fp8nzcuvKOGTJb400x7l6y2wiTjK8J/64lucmg+?=
 =?us-ascii?Q?Xr8kKgp/WEbca+umn+ZTS2jRkYhcL7WQVupqBPHTAUcBuGJza/1OdMSQ4br6?=
 =?us-ascii?Q?Aj1R+S1O5BQQH8ycDSWbBsXJwPscaFEbPUbIqPh1OrIyrEK5VubbrWJvTdyg?=
 =?us-ascii?Q?6Bw3Aol+2wlWNiq9h7r44n8FUAk0lInM70kYvepbJ5iy+5yb6h3FUOvwLmJ6?=
 =?us-ascii?Q?QN3YZVJNYdQwlSOgzq3ivPamFvBqNUof81QSWOzUjT3shInMjku5MRGAGR+k?=
 =?us-ascii?Q?7SDfu87Vn+fslh6MwshE3SmH0q+NpIffDQMB2X9tMCCpT5quKhaUASyB2s7P?=
 =?us-ascii?Q?90k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LdsofyySo22FiDTLcbBAr2okWpbN6In/oacyVsbmb3/ZNjsaXVFAA4dIGZJZ?=
 =?us-ascii?Q?WfUQsv8X+df43YzptNGIiuHx63Ox45ppPrqtnaOMrtt5E2BtY3/np4QBGF/Z?=
 =?us-ascii?Q?99y6ncpbaOPnzLL81MscdWrZEkSGKJH9gXTrGtAXtAALTc4lnC2YB0hSL3Mt?=
 =?us-ascii?Q?YI5o8VESMKxtiHvwdTXbGimxGBEBZO4NjovfeNexBboEP5yJWOhEt4luEGkR?=
 =?us-ascii?Q?oe63e5kVvdXFQ2sh6zISlCoRFxtcac3x41RyefQ/Sd7zo60bS/sNYk90L2Ci?=
 =?us-ascii?Q?8sSE9WXvxa2Zq+A+m4dLOYDDSxEknTiqDqDHKSpXVVwUHrrthPP51QB3ThQf?=
 =?us-ascii?Q?yqvR9yO3GcdBQPowsQXNvs+WIgzkJalG2JZ/T2yEcCXh0LrOFcWDd4Rd31V2?=
 =?us-ascii?Q?LMSeDGEnb+IompLl3LuNdqdiWvR6ecbedkmKLmdxQ35PRdMyNuOLnJyqiM7R?=
 =?us-ascii?Q?0N+/6pK0Jb68Z/SgcwzbcmXVOXGe4tAY9coMj8TYUo7IMcSAInTwbxEJFQ6h?=
 =?us-ascii?Q?57n4al5QmTA04jxHBdx+IN3uXIC1Hzym98oXn2Oh2H2nRwhZKXs/nEOLa7lK?=
 =?us-ascii?Q?RJ1mjKyvgVjLj9TfaXZTsP6aSKpSt3AANZt0MsFsXg/jQpmHpbJLhwdBb2GW?=
 =?us-ascii?Q?jemD9zk3M3Ma7wIeYsGUCtRRTgHmAkkYs7hgUy3jwS3aRzuK0fsgnjzyPXXW?=
 =?us-ascii?Q?fSH71xJJpmQCyVo8+3WCXjRXDwoE6NTeATTHsYM+C+/Zt+JMxZpTwJQ2FnvQ?=
 =?us-ascii?Q?qq5IaaNFGQvcWeCZw9g+0UsJCMki3nYrcwmOTt+1CSGnsZCHEJ49UwdyUpEe?=
 =?us-ascii?Q?D2V0w35MPZ6qJLNZgGCFiJG7BwTBFu3vIB5UKTBsblGGKPg1xF7evJwqwoxq?=
 =?us-ascii?Q?JsMrOduSZ8mA9d48qPJ5HFPRAXr9qhUK8P95HsPLqjUEvaPGHqz2XopDQlhQ?=
 =?us-ascii?Q?I027aoZsg5XraGDN56s5ceb8P/mS5+wutXO1GM9ZIC8ji/tQQY4CYDzFp+79?=
 =?us-ascii?Q?FPXmGW6v6SJ05Du1YAk2+RkQU9UvyppTmSusctbF6IjeDhh0OmDwFnkcOfNN?=
 =?us-ascii?Q?y4wvOZ3HWy0l8k2HGznmLnLWlXezguv8xufdWfaBd9dG8auH/thE+w7FubPK?=
 =?us-ascii?Q?1MQj4R/ddTVE6afIhU7y4a4auNznbgw9BwODDKTXntMvfa1jx1fWI8Hlt7pi?=
 =?us-ascii?Q?5aTOECCSA3qTfQy3UWj9AtRdqHMwUnyr0B6+osvqNSeVZA0SXqJCcBWXsjc?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 682921aa-f10c-4101-f19a-08dd7c37ba95
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 16:08:15.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9359

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 9, 20=
25 11:09 PM
>=20
> Hi,
> This patch series aims to address the sysfs creation issue for the ring
> buffer by reorganizing the code. Additionally, it updates the ring sysfs
> size to accurately reflect the actual ring buffer size, rather than a
> fixed static value.
>=20
> PFB change logs:
>=20
> Changes since v3:
> https://lore.kernel.org/all/20250328052745.1417-1-namjain@linux.microsoft=
.com/
> * Addressed Michael's comments regarding handling of return value of
> sysfs_update_group in uio_hv_generic.
>=20
> Changes since v2:
> https://lore.kernel.org/all/20250318061558.3294-1-namjain@linux.microsoft=
.com/
> Addressed Greg's comments:
> * Split the original patch into two.
> * Updated the commit message to explain the problem scenario.
> * Added comments for new APIs in the kerneldoc format.
> * Highlighted potential race conditions and explained why sysfs should no=
t be created in
> the
>   driver probe.
>=20
> * Made minor changes to how the sysfs_update_group return value is handle=
d.
>=20
> Changes since v1:
> https://lore.kernel.org/all/20250225052001.2225-1-namjain@linux.microsoft=
.com/
> * Fixed race condition in setting channel->mmap_ring_buffer by
>   introducing a new variable for visibility of sysfs (addressed Greg's
>   comments)
> * Used binary attribute fields instead of regular ones for initializing a=
ttribute_group.
> * Make size of ring sysfs dynamic based on actual ring buffer's size.
> * Preferred to keep mmap function in uio_hv_generic to give more control =
over ring's
>   mmap functionality, since this is specific to uio_hv_generic driver.
> * Remove spurious warning during sysfs creation in uio_hv_generic probe.
> * Added comments in a couple of places.
>=20
> Changes since RFC patch:
> https://lore.kernel.org/all/20250214064351.8994-1-namjain@linux.microsoft=
.com/
> * Different approach to solve the problem is proposed (credits to
>   Michael Kelley).
> * Core logic for sysfs creation moved out of uio_hv_generic, to VMBus
>   drivers where rest of the sysfs attributes for a VMBus channel
>   are defined. (addressed Greg's comments)
> * Used attribute groups instead of sysfs_create* functions, and bundled
>   ring attribute with other attributes for the channel sysfs.
>=20
> Error logs:
>=20
> [   35.574120] ------------[ cut here ]------------
> [   35.574122] WARNING: CPU: 0 PID: 10 at fs/sysfs/file.c:591 sysfs_creat=
e_bin_file+0x81/0x90
> [   35.574168] Workqueue: hv_pri_chan vmbus_add_channel_work
> [   35.574172] RIP: 0010:sysfs_create_bin_file+0x81/0x90
> [   35.574197] Call Trace:
> [   35.574199]  <TASK>
> [   35.574200]  ? show_regs+0x69/0x80
> [   35.574217]  ? __warn+0x8d/0x130
> [   35.574220]  ? sysfs_create_bin_file+0x81/0x90
> [   35.574222]  ? report_bug+0x182/0x190
> [   35.574225]  ? handle_bug+0x5b/0x90
> [   35.574244]  ? exc_invalid_op+0x19/0x70
> [   35.574247]  ? asm_exc_invalid_op+0x1b/0x20
> [   35.574252]  ? sysfs_create_bin_file+0x81/0x90
> [   35.574255]  hv_uio_probe+0x1e7/0x410 [uio_hv_generic]
> [   35.574271]  vmbus_probe+0x3b/0x90
> [   35.574275]  really_probe+0xf4/0x3b0
> [   35.574279]  __driver_probe_device+0x8a/0x170
> [   35.574282]  driver_probe_device+0x23/0xc0
> [   35.574285]  __device_attach_driver+0xb5/0x140
> [   35.574288]  ? __pfx___device_attach_driver+0x10/0x10
> [   35.574291]  bus_for_each_drv+0x86/0xe0
> [   35.574294]  __device_attach+0xc1/0x200
> [   35.574297]  device_initial_probe+0x13/0x20
> [   35.574315]  bus_probe_device+0x99/0xa0
> [   35.574318]  device_add+0x647/0x870
> [   35.574320]  ? hrtimer_init+0x28/0x70
> [   35.574323]  device_register+0x1b/0x30
> [   35.574326]  vmbus_device_register+0x83/0x130
> [   35.574328]  vmbus_add_channel_work+0x135/0x1a0
> [   35.574331]  process_one_work+0x177/0x340
> [   35.574348]  worker_thread+0x2b2/0x3c0
> [   35.574350]  kthread+0xe3/0x1f0
> [   35.574353]  ? __pfx_worker_thread+0x10/0x10
> [   35.574356]  ? __pfx_kthread+0x10/0x10
>=20
> Regards,
> Naman
>=20
> Naman Jain (2):
>   uio_hv_generic: Fix sysfs creation path for ring buffer
>   Drivers: hv: Make the sysfs node size for the ring buffer dynamic
>=20
>  drivers/hv/hyperv_vmbus.h    |   6 ++
>  drivers/hv/vmbus_drv.c       | 119 ++++++++++++++++++++++++++++++++++-
>  drivers/uio/uio_hv_generic.c |  39 +++++-------
>  include/linux/hyperv.h       |   6 ++
>  4 files changed, 147 insertions(+), 23 deletions(-)
>=20

I've tested this series with linux-next20250411. Did the basics of binding =
the
uio_hv_generic driver to the FCOPY device. The "ring" sysfs attribute shows=
 up
correctly, and with the expected size of 32 KiB. Did the same with a synthe=
tic
networking device, and the "ring" attribute has the expected size of 4 MiB.=
 In both
cases opened and mmap'ed the "ring" attribute, then read from the ring to
verify accessibility.  Did not do any ring operations or create any subchan=
nels.

Did some test hackery to create the conditions where hv_create_ring_sysfs()
could fail because the subdirectory under "channels" had not yet been creat=
ed.
hv_uio_probe() correctly ignores the error. When the subdirectory under
"channels" is created later in vmbus_device_register(), the "ring" attribut=
e
appears with the correct size.

Just saw Greg KH's comment about running checkpatch.pl.  I did not see any
errors from checkpatch.pl.  Maybe that comment should have been directed
to a different patch?

For the series:

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

