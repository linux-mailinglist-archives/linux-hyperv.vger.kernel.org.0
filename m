Return-Path: <linux-hyperv+bounces-11667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i5/SLiRaPWrL1ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11667-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:41:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEB6C7841
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:41:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=FEm+E43k;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11667-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11667-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3323300A768
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1543E1CFF;
	Thu, 25 Jun 2026 16:41:06 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072E260580;
	Thu, 25 Jun 2026 16:41:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405666; cv=fail; b=rHm07Spygzk0Y63yctfBH/MT8OH3WO3s2b6t0GYEAine3VmdZCuBCtN6ks/eBbIwk64qPcQoM3qGzFQzfvtyrI7ZNKAlUDWm2/y85lCR6ISESiyIdPB7wxQuugxpj3bLak3b52wqj+Pu6FDVJFQotHFvKYNw4zXh7E3Rw2BvtAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405666; c=relaxed/simple;
	bh=RcHa/H8nRPG7MX8v1eYXXP+0xiAMZELtdrw88UD3iZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2KL46bAmZ9MQbal9uQsMCrLjFld4xHOFjoyBivTLwqFsOFHb9jO098M79SpJoLErU0dKP8fUZWdYURUxPJvnljA0GJn+e7ObsZUznzfD+s8wNY3067nd/IUf5PqAJEwTYNj+d4Abs4k+p0T5994/nP4O45NUR2B4tBfA9a37jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FEm+E43k; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj+gKpA4v2LoqBnVClOaZIsZLU2eIXvSr9WXhO/0+yN4GL3mc/D2hKGSvFxpwFcOpx1bx/py6BMnfLJQsrh0jrwkyTKkjzDxqc8lq+9nbCO9bCIrDFrU08SzULlqNBatgSJ898i816uW4RNf80IV++fRQmmOQIIOtL9hClh9xQAtUtopi3rqiw/6U51Ro1TE312IRayCHsJZDGvQT0lX2TWXyK7hWeLm59ibuus8HdubAI2W/mEgP6sWIztLN698eDfKW997YExWk/L/if517dwpcOB59K1+cD3PUFefprmCqhLDeyfkY8ae+1lIO7oLEKaSIeNbh7DBqOI22gzZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTBTNyiiDX9T0W8F/rv7uPVQedi1cWBv9X1tfVTQKwA=;
 b=lDZtEuRjCwC2Th5iIdFmv3aLvFXxr6IBXPk9/1RlsQVBqD7EQQ8mH/AGPdSdxJzaoHwsk9CtLWpVXXlgvtVPyXbyHxIPlf596xsCA34cuVYVY2K96oikTYAgmJIU2Dh7zIGuNPUcd3VrqSkCha/iRabNp6DD1VeKzT43+uXb4/krHTtizPp10ex3NH9CRKVYngfvA+M0DEEitkbau4qATMy+YJnJOJ5mRZD6nyEb3NOWVTdcPCls01GszFFLAw/oml/lYmlFTu3rTk2mwaqyF3x9kJ1p6vua/1cDyVgQKb0RTbxlDqSokPV14jfmG1hfbp32hr/+Za2liV1D19HbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTBTNyiiDX9T0W8F/rv7uPVQedi1cWBv9X1tfVTQKwA=;
 b=FEm+E43kATeKjK9IqfqtJgrQSu75NoG12rn1mnO2vEKP9BZ3IGNqSIqmh0fDCmAnl8Gt44B2fT+TGUrDmX3+u5UX2A6UIkjjIWOvPfT5LEcqBjiLTpW3JgkjZuMemXC8KDfFQGKL/p5cXCWVtlF4NALfZmRwq3dj6wiOZDWoYheBdPtmtmZCrcf4S5mlSs89qRsXKNHcQj660LJnMCWSUFhZ3hIlDTcUQcFf0eL85Fnv2bMZa063431AEFD8ynLP4uCMvhxwJmU6dSAl4NRdcxV8N5N5zyYS1VZEKfZ9/aUnzh4+3YYD5hy2CWQONuDToD5a5qiOeD7i1afXU71y3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8629.namprd02.prod.outlook.com (2603:10b6:510:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:41:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:41:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: mshv: zero VTL hypercall output page
Thread-Topic: [PATCH] hyperv: mshv: zero VTL hypercall output page
Thread-Index: AQJxN3/GtoThpT6vx4oOhrhNZNlvpbUnCY7g
Date: Thu, 25 Jun 2026 16:41:02 +0000
Message-ID:
 <SN6PR02MB4157CD65CE361AE9E5BB846AD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260624172157.2790-1-alhouseenyousef@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8629:EE_
x-ms-office365-filtering-correlation-id: 32e88a61-660f-45d0-0933-08ded2d88b27
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mCYd7/icPJlj+s+m08RC6kCFynQbuIZnR8R/j1WuBpp6e7Yze6kqQrU9ZEFwB4z107GUDxQ09V/oRXwjrwG4g0iRtDiUGmXPuWgL3VxIjSjI2DKme6g3qyfvNsd06skOXTrojwDCtsEtil2hae4I4Ae8+9bN/fpSnqYFb3pWVpidRPSx4/l/w9VfYwvYfrxNAObb38cnLL+6Y4z9u5bSxRyRr6DSElS83bt3nuBBfjKdTuMnI52eRhZtJ9wRL11m/SI8TO5H4WRR4c37WKzVg7okMyiGDx7A3CFFzhiRyahMQAjV8lxI8oJSDeHw/XtCnYs1tNO+qKPbvyeEg7rzpnNycwoj4lGyBE+KCheMcaE2jOuxtCQSW9625z88OIQLKK5DzWhEbIBW3Nev9w16L5CeDixBAkyACSfp+czfAYwuE3sU53pBigeCmEPquWPauOizmwgDzi1BCf5zp5u0amJPWhlT3ltiVjSDjj9wnLw6U9pFA7Pimg5XyP0VQoOFUGo0y/F0rzhDVXkjG83UKo3tV14yUWx4GeoIo+fO708XBZADHo7m4DwCrMbZsiXEfwGMdvOPfcEPe1CNPJ1DlWD+nJ7bs4zrJ8GNvi35UDmFhfhFu5IK/DcL3Rs+QAFdGQc7pYqqS74dVPVI9Zd7+ukbKlYiE6novMoUorfiDLxB93sDtC/rZCbgvF3rsQynfyp4BzefU2kdfmLv5gqxEewmqFODmOhHJ6mZNhLvCgXYqmzl8fA3l9Zn0xpZN9/etTbL+drdDTfojKijGeKZ5c
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19101099003|13091999003|31061999003|19110799012|8062599012|8060799015|41001999006|15080799012|12121999013|37011999003|4140399003|25010399006|10035399007|40105399003|1602099012|12091999003|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XQWA/I3dpEu/Vjz/qWp95kuoNCIyLI7lq9q2+ZqwZGfPYnfqBb99iZZUIffp?=
 =?us-ascii?Q?VpoT3gU8NyutvmNtzlBKkjx5HGckv7fA6xNos1gxvC/489cS7MbhCqbiaCMQ?=
 =?us-ascii?Q?PinzOXoMvDFWGi4RQNd23RBp0zCn165mQjTg3zhSJDvPWgndWaBUY/DBzm0r?=
 =?us-ascii?Q?cHISbcsE6itNRWhLIaWyguw2LdjERx4L/yEZJiC5RLrGq2ThZx0s4Rb1a11+?=
 =?us-ascii?Q?NXRXyxqPzsrKuH5JYVqd+IG+bV1eFMvn7R7mQ34oaCdqY8kQxT3irAq9RqoP?=
 =?us-ascii?Q?O1R/5AGOSoowxrOCp71CsMfcsMGZTjjqGNTxeyjtLe7lDVacjs13yXE1XDza?=
 =?us-ascii?Q?0PhGt8k1Jdh2OWsEk1iDh9wwxT0CxEsEcc0IM+UL58IEu9eytibsFrz2jPLF?=
 =?us-ascii?Q?ymGQzWaJHMyD5QyLZMRT1BKZinLpge5h8cy8BTrKsnOfK5sc4FSxZ+7YtwXR?=
 =?us-ascii?Q?0pXmTInRKWQcMYQEaqvmvnWDg8uVx02LfbqvzHd7B75htT34B7PHFX6rFAGo?=
 =?us-ascii?Q?P5YcIER2fcbSvID7wa6U6Dz3wE73RydqCJ3aRqv/KK/CU0rtT65PzdHgzWep?=
 =?us-ascii?Q?9Zf7iAWGQXg11bfdoAQXTyomjtXluraiKe+xzxnIcHMARP/Fwij0xJz9tadb?=
 =?us-ascii?Q?arnHfR92i8bkr5nIoR4p8Aa+rFjqD8i9DLcR3CSfzH7AxATPlPwtd0FfZG55?=
 =?us-ascii?Q?eAnkIX+k72GyXwE3gP/Qogk1JKba9+nYE5Y/GL+uWhkJzVFkVcHpWuwgd7ZL?=
 =?us-ascii?Q?AlFSXJkje5YltpZ8SsI56jJuk/rfx2baZhysIoxPcQ6we9ySIGoLRqLu/kOz?=
 =?us-ascii?Q?EtkH/CRtMtchZJrbn/0KnGO6cv24vhN7Q2QHiA268lolXmL++RRJBsRqCSJG?=
 =?us-ascii?Q?9MWbhIfjGJn6BVrwfMwzzkPeEs08FQP69bz7uUJd4U7cYw+H4XjKbMBg259m?=
 =?us-ascii?Q?Lz7TudCs5aOAq9+uYv/5/JJZxosEPN4KOq2P/Ypio26jSYtqM2YVBXeIa+b9?=
 =?us-ascii?Q?9kGiHW/F8lKyDt+hVQ0cejuzeBhFMhanthfIupjmNl6e3vOv5vBuWGbTICUX?=
 =?us-ascii?Q?WbplnBlDhGOOW1z41Qibh90GTuukR1tcMYWLdlnSX1MJofy/7hOp76b69Qn8?=
 =?us-ascii?Q?OT83W8IeLUIl6yAjfWJmRVVVA9czHGnavT/OdpCBFa8r4hzl8vfw8IqGe7CL?=
 =?us-ascii?Q?WFnXLwUSYLJZ7r9n?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?esfZ9Dsf6nr4+GOpCrno5oFdeUobhxjJWQXcBy2x9djdq97ICz/+OgPBljCt?=
 =?us-ascii?Q?r20gwlqJTYDVdr4ScRrSPZ+/xbHtPYswj+Tfim0f9YIZml2KVv8a/Jqo0iMG?=
 =?us-ascii?Q?A4JAIvvY+vwLX1witKrdqmWOdFZhuOCoJf+Bd0WsleXH409u/ig0XWNQiy7u?=
 =?us-ascii?Q?6J2vq/PNBGpJsoh729h7v/+geCqCIsCTfOiJ18T1f4OAOMPm5EVya97Iwuoh?=
 =?us-ascii?Q?gkTeAtSv3erDnsU5yAdSzTgGoku5Hgx3AkG2Nc89UzXVkO7ZKlfzxctPYagN?=
 =?us-ascii?Q?pDUWkSyl9zdWYyC8vDerGp3Bu+KSDAkpnViz3UU/j0shztbWy7FsYYnFtH+9?=
 =?us-ascii?Q?Cxkv/KXj5B8+qugbG/YKkWjmDaDf/5MfhjfolAei5lKZbk6z47XXXnT5DTrT?=
 =?us-ascii?Q?WUqjgKmJ7nXd852jc7dHWC2aZPNbvBB1Lkd2I4cVr/JXkOJUeiViCsTjgzIk?=
 =?us-ascii?Q?TeH/fro2WZ8qTsEMJ3s6JXtSpkLD1+/gZDcQE6PqM4dBHIOQTBMStIw6jD3x?=
 =?us-ascii?Q?hdSh0lhadUMdwoP2ApuWXouBmrNjkeotHpO8kNLUUOrDcnkiCmJwBBZ9nBQV?=
 =?us-ascii?Q?zfhM0O6PuRkC4xoS4sR4ASoMxb5mFn/73n/JbimrP9zA0msNAyqj/pbs/d3E?=
 =?us-ascii?Q?pGckkc+9obBYVwDAwgY8Zb/2MZWBVbZ2dkAABXc0tUgxVdOh37q0sj7qlPux?=
 =?us-ascii?Q?7UFtRIBeGmR3CmhqCUtx2xzrLHPtDZEaSLdO2b5E9Y1Ko3TefSMHrP/W/wGc?=
 =?us-ascii?Q?bx3wXMCea5MqGYM7bALt9JoswluCsNIC5bs2liJqwZCRsXF/uXvdCeMzwlle?=
 =?us-ascii?Q?R6e0NRNX4mdZgEBO3gAAcHS5BX1cPx0qsEu6Wpv3IQLzxLSwLzxWaZCys+3o?=
 =?us-ascii?Q?XGeNH+QfqetiCBlgxHvFbUyP+9aPKGwxrjQLgBFRSjBkH/kKicPNqntrFptd?=
 =?us-ascii?Q?B04RPg+jJkZ2O+C04rj5+J3YVmvmzjF4DNHvh8LgYevnc1/bA/uDDVXh/s43?=
 =?us-ascii?Q?TviflktJEi8auv/YaWWBom3qmQUT9ZBxo83wBavYsyM2cp+SQ32VYEXYkBNf?=
 =?us-ascii?Q?t1Wx5tzbFnY1ylyUvsxTkejFPivnt7XHkp0N6rsiZu88p0jYK+ZYJQiCi92S?=
 =?us-ascii?Q?QQY7Z6tWLwirU1HWLuNM9rWt91fpzobXwkh3Gva6RARe5tpIwR1CzMzJ37ZX?=
 =?us-ascii?Q?0NZIqpCtvvVDIJkKBEMJDvVB9z8tZirWNtw9ZB37eDmUnxHzYxZQhRhSyW7g?=
 =?us-ascii?Q?0htr/wMLD9lJlIG1YkXT50OWqTfYpaoUWadSauZgAI7DMDr92AmRQfNkQD3V?=
 =?us-ascii?Q?hr88cimPfR43i+pKYqRoBoevASwJFZazi3JQ5B11KJtpxqZp6y0PMdnEgUU4?=
 =?us-ascii?Q?NGhk+YQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e88a61-660f-45d0-0933-08ded2d88b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 16:41:02.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8629
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11667-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13EEB6C7841

From: Yousef Alhouseen <alhouseenyousef@gmail.com> Sent: Wednesday, June 24=
, 2026 10:22 AM

> Subject: [PATCH] hyperv: mshv: zero VTL hypercall output page

There was a recent discussion about what prefix to use in the patch
"Subject:" field for changes to MSHV VTL code. The agreement was to
use just "mshv_vtl:". See [1].

[1] https://lore.kernel.org/linux-hyperv/a0d271e3-ece8-45cf-9dbb-ced773d6f3=
f8@linux.microsoft.com/

>=20
> mshv_vtl_hvcall_call() copies output_size bytes from a freshly allocated
> hypercall output page back to userspace. The page is currently allocated
> without __GFP_ZERO, so any bytes not written by the hypervisor are copied
> from stale page contents.

This is a good find! Even though the VTL user space code is somewhat truste=
d,
there should not be any circumstances where the kernel could copy random
garbage to user space.

>=20
> Allocate the output page zeroed before issuing the hypercall.

Hypercall output is usually no more than a few tens of bytes. Zeroing
the entire page is a bit expensive. It would be sufficient to just zero
output_size bytes.

Standard practice is to *not* zero to the hypercall output area, since
the hypercall invoker knows exactly how many bytes Hyper-V will
return for a particular hypercall, and Hyper-V is responsible for not
leaving any garbage. So it would be good to leave a code comment
here about why the output area is being zero'ed contrary to that
standard practice.

I would note that many hypercalls don't return any output other
than the hypercall status. If output_size is zero, allocating the
output page could be skipped. But that's a further
optimization for another patch.

> Also check
> both bounce-page allocations before using them so memory pressure cannot
> turn the copy paths into NULL pointer dereferences.
>=20
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d41619..0365d207c 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -1147,7 +1147,11 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hv=
call_fd *fd,
>  	 * TODO: Take care of this when CVM support is added.
>  	 */
>  	in =3D (void *)__get_free_page(GFP_KERNEL);
> -	out =3D (void *)__get_free_page(GFP_KERNEL);
> +	out =3D (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!in || !out) {
> +		ret =3D -ENOMEM;
> +		goto free_pages;
> +	}
>=20
>  	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_si=
ze)) {
>  		ret =3D -EFAULT;
> @@ -1162,8 +1166,10 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hv=
call_fd *fd,
>  	}
>  	ret =3D put_user(hvcall.status, &hvcall_user->status);
>  free_pages:
> -	free_page((unsigned long)in);
> -	free_page((unsigned long)out);
> +	if (in)
> +		free_page((unsigned long)in);
> +	if (out)
> +		free_page((unsigned long)out);

Testing "in" and "out" here isn't necessary. free_page()
already has code to do nothing if its argument is zero.

Michael=20

>=20
>  	return ret;
>  }
> --
> 2.54.0
>=20


