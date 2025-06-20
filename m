Return-Path: <linux-hyperv+bounces-5976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E0AE1123
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568F33A23E1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74161AED5C;
	Fri, 20 Jun 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H8y0kd/i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2106.outbound.protection.outlook.com [40.92.23.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25511A8419;
	Fri, 20 Jun 2025 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387004; cv=fail; b=Hs3eJ/Eu9zuWlCMsIhbcoZlTkUVM5N1J0N71q7o8DVh0ywY0ESpugknuMxA7eVo5RUVSH1prxhc2REIZuaQQUhSVLVCPMKD7uX2PDlNQ7S0zYoOaGQsUObaU7/kZ/K8AFf9NuFTKv9Nuzp45msrCbXpl2d1vZPSIxZjyJaHMG6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387004; c=relaxed/simple;
	bh=Z9e+BREy2PxGJv4ZFlCQo5CExzXEfu9uzXiL67R8nSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tlTpdnz0fifNC2iE5IyBVtBfFKyrg3uxGOgiz5JLj6yPGMZr7M+34z/EayUkGRrRYlqQFsoBPdj2Sz4r2W7HNLHlJ5uM9v9sBt/23+VjmTvisdxCncHVXz0GosRNkpk0wjC1slO7my4mmaI18juNqTt9mPiOil57wQyhoclXU+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H8y0kd/i; arc=fail smtp.client-ip=40.92.23.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRa1Y/y9jzFXeCCpT8UUM7rmZUPHaTY6ytKr3A09POsARs9WwRt51mgjE8AasT5I9QpfIIlDzXqfcixgLVTtbfCw4J67J9arrw5mivEhhURe56J67PeZEY24i5k4n4GQ/rso37aV+mWt1f0x+XkX22XeyCME6543mS2PWbx3QINEJ5KPWGc4BVnOA64jrRoy0VeZjJ/fjbhT1m+HFA4eZ0e5T8kfcfIcwoM0mcBYya/ZIi2XrWGyT6pSw7oEyBvc74kc+CtqMaeLsFU/2dsSd3n7e7jMPD9EUHVx6iiYVxaG3KHxH4yCaVsf+i8Oi3bqQc5QGXFIU7jeXOSm5N2FBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCXeDUH95sRQZJOHcprUKblfdx/ko0IMvb5iIxOV1G4=;
 b=Qjqt5htszhu9yvv4d1UH5hhHMiUT5pwuEAVo8DzxOxCiC/4p060VRTs5g9aqCmnqsS8m3UKvVR2EsqHpDB6l3QSoOqQyubHbnBDvRSWcjgC2yuF+Az+ZE+rrobjhlF7J3+sQ7N4iY2MLq8JjdQHB7W5z8zTwRXhN5K/r5+SAFRyW2ycFCLmQMF5iTBOKQjzTkfgVRyHw7hFUYC1/LHBfMdu1nfv9ktCw1MfaRGeCwaboskM9LMy1xtUjQKLBp/t3J6cVhgiIdV3pPE89e9QWMJPF9IeT0Bxkb50u7YK+KLmB3rPe7AK1Ugr29TqeiX3Elwnlmlo9kw4hPuJQBL45ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCXeDUH95sRQZJOHcprUKblfdx/ko0IMvb5iIxOV1G4=;
 b=H8y0kd/i2fALpmgeHxVo/wAGkorBRWjE4XNYgX8aQ1XewzIQQ6qSjQYis8gBkHTjRUMeHp156p6Fa6JTzDjwl3k8K8E8fVQDhF3TQR0IwOqsUNyduhBQBmyxcLdyGEKa2JhAQiBnhGzUdsxuo5S6CTup2nHFr5pTiTS3J3vAfORLf+6pFljzJF7AOJ77mfSRQvlrVYrt7Wzv8pGuyn/KSXMRtXb3ZM6vTnf6/m/y3iQo5o7dY3tbtNsR4r/LMcj0+8+9w1lJVFqZ1daHzW42QiqaPWM2s/9BPewgLNaTOcspO5Ooei7VsDbwcEVZNyvOdnty4MtGhPIQ4rZEgywRyA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6802.namprd02.prod.outlook.com (2603:10b6:a03:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 02:36:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:36:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hardik Garg <hargar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"hargar@microsoft.com" <hargar@microsoft.com>, "apais@microsoft.com"
	<apais@microsoft.com>
Subject: RE: [PATCH v4 2/2] vmbus: retrieve connection-id from DeviceTree
Thread-Topic: [PATCH v4 2/2] vmbus: retrieve connection-id from DeviceTree
Thread-Index: AQHb4W76TCYPtIrHMUi6VpAB7R0jC7QLUMVA
Date: Fri, 20 Jun 2025 02:36:39 +0000
Message-ID:
 <SN6PR02MB4157F2C0674B85C7206E6047D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
 <1750374395-14615-3-git-send-email-hargar@linux.microsoft.com>
In-Reply-To: <1750374395-14615-3-git-send-email-hargar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6802:EE_
x-ms-office365-filtering-correlation-id: cf17c686-cbfd-42af-812d-08ddafa34921
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|19110799006|15080799009|8062599006|8060799009|102099032|1602099012|440099028|52005399003|40105399003|3412199025|4302099013|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CgX5xAWfpwTZJZpRb1bQsRcluj2JIaQqpWfgFceCe8GZ5NuvvnC6o6xWuDW6?=
 =?us-ascii?Q?QfOA/ksaxIab9RH0toIZn+7T0t2FgLP++A7GazwYCFxehYT92pEFiK7Bu6XS?=
 =?us-ascii?Q?SoarxsO5ewgthwXc1ulU2NfEgprs66paR0F63lKxz/rSL+I6VvB6HE6E8vAe?=
 =?us-ascii?Q?6YseWR4H/55KiJn2o8L32HmDIO6gBei8Y9oRrkZwA/IZyDQHS1GCMunELB/A?=
 =?us-ascii?Q?Ezt0GtTD0OlnNpqyPImslkgJfj119iXD2sP+0CmqIymmKaP3VKq4PcNTvhHl?=
 =?us-ascii?Q?qf7xCBBpkHwyxtOVVRCcIlnFfm5VnADyX+MFp6uMj1oDAAOmrAEVgrKlLaxP?=
 =?us-ascii?Q?34zDgnyHKhDnHbt6CDLGOvGftDyXItMNwvF/pksBGH0CJcD9nz0bGv/CzPrw?=
 =?us-ascii?Q?afGTJ1x56RBx6JAQwu2AEIbLDf3O8xgaKZACARSKgYnbpITYtqONh6Q1tURy?=
 =?us-ascii?Q?CIuZGqNHmAshxDsA//VM2ELxZpyDrlWQAgf8A7B/oXv5C8zVc5A3akq3RWlZ?=
 =?us-ascii?Q?pMzD8moFkntSOJgwaf6UAO9Dssbt7XC7klV+7uCcyBDJqfalouJlwBX7a917?=
 =?us-ascii?Q?E9ZszP1eq+GqMjEsaBT6qzFYtEjxd4Ufhu/yNVWgZfbMHFFuoeHgRT3J4X+3?=
 =?us-ascii?Q?+5UNj+LNJ5R+I6y9BxsOJikSjaAc2ypqqVdMTV5h/BD1BF56A3ckZNLQgZhr?=
 =?us-ascii?Q?dH7o5pE2srOxEXYcszT22pYOTreggezRYjDHcAgxcjOXQeP7OJeFZi6nucuB?=
 =?us-ascii?Q?rb7avwshnAcFbemQkVBZA9bVG708U9y2YcCvV3SNMqumVa1sAaeM8Z80Yqos?=
 =?us-ascii?Q?FxMB2yDq7ls3Z/acTZFHcaSGdW2XtBY1M08kZsVW9mESlh2m1z1U800ZidA1?=
 =?us-ascii?Q?2YFVVqh+gPd1ergMxfvAJKIg4S6vw8hDMVQdZ6qkhgt1NTzcONHJpUddbiOB?=
 =?us-ascii?Q?bYplevpjbgzXrX5AKJ5juTEfI1AojjKjt0QKeyJSXBPfL/jAY7aE7uicvyBl?=
 =?us-ascii?Q?Lgziqh8t4GzXYliddlH3TDXOWRHAIiKerDjqNeOd8mnISrQoKXygMxDzHjpZ?=
 =?us-ascii?Q?cx/lZx1QRu6bYVO4QQsb3S/0qp2fFU6Mv8nl75Np6vF5W8UkrznzOGHpLfDI?=
 =?us-ascii?Q?OypYVWOjFygm8vfFo1ieflx1iwoIgttlhwZEH7saOHOme4GIaCQppXD53peA?=
 =?us-ascii?Q?TPD2o2g+to5CpiP49ajy3H68spE2hh3Fwmmgak7oXWXwWv7QECKsFpVPnwU8?=
 =?us-ascii?Q?O6IUAzbcfYSqSgppqCV7mi1cdEa5V56nAp0FpvKsvJXUtitvtdKJRZpgjgDm?=
 =?us-ascii?Q?EQU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+OwUlZnJb9y+fBfiU6COdzJpiwDGw3QD9+t8eSfOZZNXbk7G5XUGWebNwV5/?=
 =?us-ascii?Q?89q5iQOu1clmckKjOJzuQYBYvn34XnSldCZ9u0zGeJqxwI1hsQFg2Slv1NBw?=
 =?us-ascii?Q?4ZKxwZ4vKOC5Z9FsCPDCHWXqKMh/TGDOAq5oUxxkgqVe5kUjccNuRQhKsjuB?=
 =?us-ascii?Q?amu/P41OmXW1YCXw+4Dz4VTw8CXKtIo5e8fXc0AqPaK3Qm6WgLtiCZLUDaB1?=
 =?us-ascii?Q?4j6li+5C3jZna+4eVQalF6dAtqgBR9a15F6YCgZi1mSZJggi037zUbbeTxoy?=
 =?us-ascii?Q?XZER4DvXwXNd8oGfI9QMaeE5cvf9fRmw7JfiqUZVaU764WQ3mxa/DLSMPANC?=
 =?us-ascii?Q?i6AvH4+pKCZW+QPaPzO3rm6euVW7Eoe2z785yIYI4zBmkH47+GtKNq76X6g7?=
 =?us-ascii?Q?G2WQ6ccAr5ORbLCmvgsCuQyV1On8c4ce6avOAmJ43gath5o4yTJYkGAM3QsS?=
 =?us-ascii?Q?7iCMKGHfnE36D+ot3FT/p1qq1X4BqNGz3TE1rPMOgXCSsU2U9I8ldEnQ7eDZ?=
 =?us-ascii?Q?XugyoCN9DnTKYPzmn07MwALdPsAXP4EJi5goCzxkrOn0GMQ1Nr/oUj5pSzG7?=
 =?us-ascii?Q?eoVFGxHBQnfTJ0EmkzW5PrfWeXNviga/kSoEoaaZqHXLpJDwOjdUv3RN5Z3Q?=
 =?us-ascii?Q?s08bZlnjGzifdmXyNGyfOssKwSWu2HxfYK++e2hOaF6spctYQDc//z/nmNMm?=
 =?us-ascii?Q?57+IcMeLp5pCsG6eT3uFCqfVbz7gNfO6hNLE2iEv+bZ1lgABG9Hxc1masDNQ?=
 =?us-ascii?Q?MspOSKX4yH5ai774L32IsWWxF2vpg5MfWo/14paissQAQKT+FQ5mQhjXMT7Q?=
 =?us-ascii?Q?Rekz8H21p6kiCf+7tnRVBitH+cbQT/XkJWng/8f/6B3RxlOb43eux2rWcV/h?=
 =?us-ascii?Q?mhFeHQATWbsrqQf2QjzJpVsy4Kaove0W6Y+7qy8AbT3ICzHFhKnJ345JNQCC?=
 =?us-ascii?Q?SHs9XJXLbAsIdMD3VTtLrM/gWEv9H9WADNI9dGSMXJS/SMgPYah1gsDtHB9t?=
 =?us-ascii?Q?sjhiXXIWtyhMNpMt9lcy7JcSeXR4FNjNK/ZU81t7AJ+KX6KI+MLtY3JrRrNp?=
 =?us-ascii?Q?e1Y48Z7q9JrUQB6cVYIVkUOWqF3Rc7xKUFyJd9AV3T3DvaJXCxFV3hF2CecB?=
 =?us-ascii?Q?g+1F7RdTmZpSEgNNlQqbLPZCnh4HLEnF19V0OKsOFfRWkNqQ7RLYvhunVxyh?=
 =?us-ascii?Q?fdclFruzgsWymqdQf1TjisixodIxpQoHktchaDLtJzhmhS0/4pMQYI2FLoY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf17c686-cbfd-42af-812d-08ddafa34921
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:36:39.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6802

From: Hardik Garg <hargar@linux.microsoft.com> Sent: Thursday, June 19, 202=
5 4:07 PM
>=20

For the patch "Subject:" line, prefer prefix "Drivers: hv: vmbus:" to be co=
nsistent
historical precedent. We haven't always been consistent with that precedent=
,
but I try to call it out when I have the opportunity. :-)  If you look at t=
he commit
log for drivers/hv, you'll see that prefix fairly often, though sometimes
shortened to just "Drivers: hv:" when the change is more generically for
Hyper-V and not specifically VMBus.

> The connection-id determines which hypervisor communication channel the
> guest should use to talk to the VMBus host. This patch adds support to
> read this value from the DeviceTree where it exists as a property under
> the vmbus node with the compatible ID "microsoft,message-connection-id".

Avoid wording like "this patch" in commit messages. Commit messages should
be in imperative mood.  So something like:

The connection-id determines which hypervisor communication channel the
guest should use to talk to the VMBus host. Add steps to read this value fr=
om
the DeviceTree where it exists as a property under the vmbus node with the
compatible ID "microsoft,message-connection-id".

> The property name follows the format <vendor>,<field> where
> "vendor": "microsoft" and "field": "message-connection-id"
>=20
> Reading from DeviceTree allows platforms to specify their preferred
> communication channel, making it more flexible. If the property is
> not found in the DeviceTree, use the default connection ID
> (VMBUS_MESSAGE_CONNECTION_ID or VMBUS_MESSAGE_CONNECTION_ID_4
> based on protocol version).
>=20
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
> v3: https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linu=
x.microsoft.com/
> v2: https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linu=
x.microsoft.com/
> v1: https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linu=
x.microsoft.com/
> ---
>  drivers/hv/connection.c |  6 ++++--
>  drivers/hv/vmbus_drv.c  | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..15d2b652783d 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -99,11 +99,13 @@ int vmbus_negotiate_version(struct vmbus_channel_msgi=
nfo *msginfo, u32 version)
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
>  		msg->msg_vtl =3D ms_hyperv.vtl;
> -		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> -		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
>  	}
> +	/* Set default connection ID if not provided via DeviceTree */
> +	if (!vmbus_connection.msg_conn_id)
> +		vmbus_connection.msg_conn_id =3D (version >=3D VERSION_WIN10_V5) ?
> +			VMBUS_MESSAGE_CONNECTION_ID_4 : VMBUS_MESSAGE_CONNECTION_ID;
>=20
>  	/*
>  	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c236081d0a87..b78d5499e4bc 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2541,10 +2541,23 @@ static int vmbus_device_add(struct platform_devic=
e *pdev)
>  	struct of_range range;
>  	struct of_range_parser parser;
>  	struct device_node *np =3D pdev->dev.of_node;
> +	unsigned int conn_id;
>  	int ret;
>=20
>  	vmbus_root_device =3D &pdev->dev;
>=20
> +	/*
> +	 * Read connection ID from DeviceTree. The property name follows the
> +	 * format <vendor>,<field> where:
> +	 * - vendor: "microsoft"
> +	 * - field: "message-connection-id"
> +	 */
> +	ret =3D of_property_read_u32(np, "microsoft,message-connection-id", &co=
nn_id);
> +	if (!ret) {
> +		pr_info("VMBus message connection ID: %u\n", conn_id);
> +	    vmbus_connection.msg_conn_id =3D conn_id;

Indentation problem here. Should be a full tab, not 4 spaces.

> +	}
> +
>  	ret =3D of_range_parser_init(&parser, np);
>  	if (ret)
>  		return ret;
> --
> 2.40.4
>=20


