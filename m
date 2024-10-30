Return-Path: <linux-hyperv+bounces-3219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353339B6CC0
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E3E1C2168D
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE431CEEA3;
	Wed, 30 Oct 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SHsL1Unv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E11BD9DB;
	Wed, 30 Oct 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730315016; cv=fail; b=tvqoOE2aY78iB/YirqYul3APcESP7c3SYkjpZx5lOgiCoyxrKd54he4Wh6PbRtK+wA9GyWGdCOy5YXXmQHFnYMGS+vFFENWjmncKLMNSCIuWn2lfDUAnxq5j98GEr6yIiGh6aWbLdfBiHQlliLGb3xFi9GyjSupkqK/L7CjX/1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730315016; c=relaxed/simple;
	bh=WIuqEaVxG2BY74on+bIDMLScfIfpZFQY0LxGrKMy8R8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T3o437IVsilm49su8TnUkWRC2Nw8MqS92SbBwPqHmOeO382n0ZQXnE7ceUvhoQNxhJYykt5yNSS2NwQeualpm0C0XbL0hdqUGw5lO1Pmj5AAfNYiBzfTyN1V27Mk+yXObZenS660ob+iaGNTn7m4XGn4yzeCwFUQfygFebnGR+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SHsL1Unv; arc=fail smtp.client-ip=52.101.62.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+H4ccrL+Z3NMaHRg3qz+8EAutp1phwaK/TfKnm/J0A7K9AeWQrVak/j+8F1GauwPsu7GP7+NGldLYQEl3qSCH6FQMUpAdvBYWc3xzy4p4fG2QuR6+8rApZLlY4xohYch/beJ7i4uHuUhAyBZqjAyy+FtSk1zeJquiCgmgY6qccm9GLqJscVQVg0bEbbvxd8acx2/cH1+x10CW7UnUsOWEfB9hu+OOuDaijbqi2srm9nKXrAjzsdg9QZXkk4tHyju3NFsWulHafSF53PorLr5H7BNt+aX50B3dXKfUEqlBw6hRrIPuWeckTZXTzJpJ979QAvkjFgR9LwGBYsHJKBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIuqEaVxG2BY74on+bIDMLScfIfpZFQY0LxGrKMy8R8=;
 b=Qp9eP9ZKfSpkzZuOYhx4XHsW4LYmKDQf2Trl5W1k5ZH8bBT2ne/49+tQfPPnz5GnM5kZ2ydLnEdHzAYo+yNhXaGVa9IuMA0/Hml1xS2ORgyYT9sTNPfOLsJj0q8hng6AFAnm0DkzetQnM9NMsC1uiKT59g0vUG7tMgsXra44ZYU/RXhUqLPtWiUuCTbKKf0X6KCwGpr/P4yfm1X3B4JNWnAjK91nvV2E/sRNQc4nk6pthQLIDEIvcEXnFMUtn6j1gU/xph5iqgQieGW45GTiXEaLLlg4i9M2XSFJYQ2DDUHtUwtB8Ti55os308A8HMHynaMB2OVM7WS0nm9DmXhRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIuqEaVxG2BY74on+bIDMLScfIfpZFQY0LxGrKMy8R8=;
 b=SHsL1Unv2rlbHJJHd+pFrslE29jwF+DV1bISkoavDm/k6aEDdAeVkpEKLlm3lfxvfiWo/xd1LqSDFzwLCvVVro/wJddgyNmbHLmkkdGOLCuR0tobTFjRlZQFsQ14nXysACJoWrnJWqDp7l6tfAArFFZqMrgAQXSL+L5J7iUa1ak=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by SN3PEPF00013D79.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.3; Wed, 30 Oct
 2024 19:03:32 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%4]) with mapi id 15.20.8137.002; Wed, 30 Oct 2024
 19:03:31 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index: AQHbKlyHss5KWmFug0aMZtYQWKCj3bKfoGAQ
Date: Wed, 30 Oct 2024 19:03:31 +0000
Message-ID:
 <SA1PR21MB131794D6AF620CB201958EFCBF542@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2ddb8d8-b0cc-4ed7-8c4d-806213566d4b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-30T18:35:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|SN3PEPF00013D79:EE_
x-ms-office365-filtering-correlation-id: 23664f89-f1dc-4f6f-c1c2-08dcf9158c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KK9Dg6maNEBEr7EMEoiIbazNNVtA18S7jMb76tPw0Il4Nux3OqJE6I9bhztp?=
 =?us-ascii?Q?zkceu8eyb3BNPBoWKHYvMtMDC6rUi6weolXzw43o+PLDG51TZpZ5hYqtjUtF?=
 =?us-ascii?Q?jk3aL6btgtMyFgcwkvIkvs+bPUxEPoVbkcAmZ0Av1z9XkmXQpYCrfG73iIdN?=
 =?us-ascii?Q?+wwucNXb6ugdyXo5p0cAyb4CG4p57/5epv/UOlTu3wAHGPWMk7arHVnDVPLq?=
 =?us-ascii?Q?7pkacaw4jAflAkOfoSMt6Pvs4NPAPNNTBe+9j6b9EQjfpCdoCxpFxh8gQh/C?=
 =?us-ascii?Q?SCsysCtClIklIfkEfDMVIOn1oxb4eTNz+fH9prFpOG0AXbcjlkWpaYICSteA?=
 =?us-ascii?Q?GdnF26I4Raxly7bMjFR5XeVzxnhmGSMgMKOOaLFQuLm73F22VboRlvBsrv00?=
 =?us-ascii?Q?OnRDVnDDKDIVX/8dJkT1b/qnu5LzOVF+zXH/Dgq5Nf9hhg0VxrH+tix2+jPX?=
 =?us-ascii?Q?iwXffjV3vzbQCIBo380iHloKMqNL+e9aZflBohNkIOhk8dV2jJrj0YZFB2FJ?=
 =?us-ascii?Q?4PzMIodDlWheHoXQQlkiziIcqN7TDxBbAIduTg3DHjU55T1lT3oLTw9YE477?=
 =?us-ascii?Q?b2qPgGUi8j9KH7QYrYLWtXZCA5GjmdXoRYweUqWx5wdVaVt/mSACy/INTrZ8?=
 =?us-ascii?Q?gAbnETTmsxD0Lmfr24DuAgrxN7MUFPAX6f0KoLj4OAWjmvRc/Cnn/CGK73LZ?=
 =?us-ascii?Q?nuHcU4LLxdALOdwfXW9SMO8A5GCPYgWd+JnjEWCw9tb01024Cw/mBPFzc4K4?=
 =?us-ascii?Q?RQwJH53deO964KoDyywiDVjzBQiv3V6PTGcDmLmetvP+H4f+/nlkoAjwPA/k?=
 =?us-ascii?Q?d8jixI4aE1ppEjLqwdbQ49nuwwQyMHesVni55SptqK3darNJB/BVRLsiYWKV?=
 =?us-ascii?Q?kC+o63sc+fZN1P3OGZfQCxAhSHsBKEAm0jGSnC8AdZ521GNrr6bgfDmB9V+x?=
 =?us-ascii?Q?QH1hHFwnn+SdKwUBeTeZd+7hC5SZHgVSLT8RjojO0z2ig4nzM1dRQZfqYqY3?=
 =?us-ascii?Q?qxlzn4sDsk8Rpg5F5tkRf/GjC041WvvwwXsI9ys+DqO9ecUbUQ5Oj+hr8DFJ?=
 =?us-ascii?Q?ahLYIrDaDLUWsNtQDaPbo8a8YjzC3/y8Lirdase8MLEyuyXITas7wUFYBEDp?=
 =?us-ascii?Q?moT/VNOhV3lDPxJdqNB2JKlvk4S+l1HjkCAhnce7Vh+cmS9Q8BEuhA9Jdmac?=
 =?us-ascii?Q?Smo5u4mcXJT1WUiM5uGJFiWat5DbLzY6hfuhOLNw6XdVfyvdVNHxx4NE+nvG?=
 =?us-ascii?Q?YTzGaOPhSp4Xsk/LfltVItnGLG47GHk6ZghVwt970j6Rsd/3mf7xB6kC2Rw3?=
 =?us-ascii?Q?NHR8BiH7trmSEdGk98CmFuGKBKMispnMERRctacV+INCrqM6IZp1KfDlGSqq?=
 =?us-ascii?Q?KwxoSfk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N1Vle94V7bWU61jUQhoEu0rp1ckBocDX3uvlJGJICeZqo8Q1P47xv+mgjhyY?=
 =?us-ascii?Q?quT9fFWL4F2ksMfK/CD2DWmNVPa1SZJ+Wii+UoYRluG7ssUtvJ6S02QMYH1A?=
 =?us-ascii?Q?L0PyxC2JpIqOaKOlIWdUqzrIwqHwENxtQnXKm2SFD7O/32sA5Yo/BlRvEH1s?=
 =?us-ascii?Q?TsBsiAQZLsWdlx78ehMK1l8yw/ynT/+ZgI4D2VozWkEmCyZRcAOssSGzctuq?=
 =?us-ascii?Q?PebpkRsXeZEUSBGM4MMIaU1CpcXUnvemyAkngBCIbZz+/3HELzwTqXcfscME?=
 =?us-ascii?Q?TCTkxME48p9CcNXH/jtb7frDB9QwJ83f99mGiwMd6sLL2NMqQ/Z6Juem3195?=
 =?us-ascii?Q?tzccWALSgPVVqwYewIgH/K7gOeySjbSnGttvSDt0PBAtNGuShqRzgdiN9m/P?=
 =?us-ascii?Q?MCcnY8B41pA9t22N1tvOUlwFsfRS4kDr6ztUtbmsnksZSObjZLQ5t67LV4rt?=
 =?us-ascii?Q?p7Udz8VWgjDX99sW10P9M/mmifUPk5NTo8dwLwyJF1peflcPe1Bpobl30U59?=
 =?us-ascii?Q?xbbCRSWAf3u/Xf2o+0Q0JERT/VWMXPoeASO4R/Q3B/+yKzLWOnmW3rZfaD5J?=
 =?us-ascii?Q?OJy8LZvCTh72OKjBrxHxDNtiuzNfwJeTA/tojqMUf6yNUMh967EBoqn8L2Ey?=
 =?us-ascii?Q?muNEU61jLYM8nXdSNnBgv4fAMQKXag+g80lQieBmNuqro2iagjbQv/ZbThjm?=
 =?us-ascii?Q?00DiqFchMSbuB7AylLsklWoLqHQO0N9JMhckkAlLQPhNP5w+MthN8B+xTrPQ?=
 =?us-ascii?Q?ZTqq4Z1Z1r8bogZnLZ0PDG3CG4w+ZAk52tkQYEEXbSXvbfDQkjcUNOp/p3jD?=
 =?us-ascii?Q?l7Of7xoKe3VNXdKHVNMAoBNL6+5fC0GAdab9BYcdKkilIYQRT7A/Ef/IeKaZ?=
 =?us-ascii?Q?O6gm29l5u2n5rtudV3CbofwBhuLEJL4zuS6DF79WJe2TwGS57KHEWHxMZlNU?=
 =?us-ascii?Q?Q2L19YdW4I4tQ7oUUW8vv83EhNacGa5JY9YTkXb4Nj5AcYLfDgzWJOcxqUL9?=
 =?us-ascii?Q?nWu5/JLNx73NbMCicXpCf+5hACMCckuHB18BS1SAn6IPdwo6kczdSGT/NqOV?=
 =?us-ascii?Q?B0rhJb8YhwN4Vq92J4YVHgzHu0bELPMoLSqR8LzD0qD6O1jFSzAIZQO7aKZ2?=
 =?us-ascii?Q?torl3drwjBhmiVBhmWe3Sih5b987alkvh6retEjHNacmpyzxj18z8OTa3lDS?=
 =?us-ascii?Q?CNPJp5zRxOpTiJcGn2Q5zbZSXqXtPIEX6iXNB6PR/qNo78quEmTeex6jC5ND?=
 =?us-ascii?Q?fQbjGpQREq8s789gi3tMx0drqRsrMfDusF/XZqOj7V3HzNtj6wqi888SN283?=
 =?us-ascii?Q?umyOWGaMADgB05qHbnOwOqhIjTH4BRgKt1bqria2UNaPizvThKUsta7zarkn?=
 =?us-ascii?Q?jHPkDzO1tOXKkF5GrZsCI7V7c+ZAS4qK+0q4L6sRzYNKpVdBbvb+WFIPxNWp?=
 =?us-ascii?Q?SQuJVAtkSbrZIgnU/m4FQ/krzEz1Kw1mctJk2UzuA9ALQjs0yb7WTR9l9+2+?=
 =?us-ascii?Q?vL1Bd6i+ZHj3U0Wg8y9Bxmg3QXn/mdCcp/Y2BYH5OZZ+2u++HqYSFQrLec3p?=
 =?us-ascii?Q?1mddfJDw30XQ8Apsklqr/hP200CvU2VNT0KLbYzboCLQFdAvmm5NB7Vmh4ch?=
 =?us-ascii?Q?bbvouDpRZG8JgepchENlyASfyb1CssmXTpokIy/Op6BG?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23664f89-f1dc-4f6f-c1c2-08dcf9158c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 19:03:31.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwafogYfzocMy4odoqsGECF0/0I+0L3g1++86F2/e5Enb/egGVUR/6GYWHHkI7EaHn3A9SwiC+kBDiTOD04Mxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013D79

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Tuesday, October 29, 2024 4:45 PM
> [...]
> An alternate approach occurs to me. util_probe() does these three
> things in order:
>=20
> 1) Allocates the receive buffer
> 2) Calls the util_init() function, which for KVP and VSS creates the char=
 dev
> 3) Sets up the VMBus channel, including calling vmbus_open()
>=20
> What if the order of #2 and #3 were swapped in util_probe()? I
> don't immediately see any interdependency between #2 and #3
> for KVP and VSS, nor for Shutdown and Timesync. With the swap,
> the VMBus channel would be fully open by the time the /dev entry
> appears and the user space daemon can do anything.
>=20
> I haven't though too deeply about this, so maybe there's a problem
> somewhere. But if not, it seems a lot cleaner.
>=20
> Michael

I think #3 depends on #2, e.g. hv_kvp_init() sets the channel's
preferred max_pkt_size, which is tested later in __vmbus_open().

Another example of dependency is: hv_timesync_init() initializes
host_ts.lock and adj_time_work, which are used by
timesync_onchannelcallback() -> adj_guesttime().
Note: the channel callback can be already running before
vmbus_open() returns.

Thanks,
Dexuan

