Return-Path: <linux-hyperv+bounces-2858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2E95E0C1
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 04:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2019628226C
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935D4A2C;
	Sun, 25 Aug 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZSMZ1gx8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010005.outbound.protection.outlook.com [52.103.7.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A163;
	Sun, 25 Aug 2024 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724554304; cv=fail; b=kc0XTeKnurmXRItW5UAfSTwDKSDxOzDpUDZGzZesxu9jqTWL/QoG5YyZ6NTflWjWbl7zB17EgwbDVNVrZrq2uqIu1WJntJ2qsu/xMzpuK08eS/sYnt02VHtTgsItopdnFlObfq0FdhPkWpnnrgGktkqxuZbDHrnlSGtFxPY+8wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724554304; c=relaxed/simple;
	bh=WAuPa0eQawebJhTQJGo11yiigw5SZtDJfUuPK4hZ6ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7E0GQPqYHJgz/ORA3cdD4EcxXb5oO2nlpW4Kym++cghpVJWYIsItpNL35ecAISDi56P/t+zMpbfPiaeU6CI1/zXSkQY8irrCSFV8gplNpZuGYzg8kIGMsEEl0ZVCr/jOzr1lNq5IVhABtOI2TbZpjtCLAt9gEHUZ1XlzVwmdSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZSMZ1gx8; arc=fail smtp.client-ip=52.103.7.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpE46sWmmXrJNJTD0ZdH6ivcCe4EIsjJvgmCO76AjNJfeD9IoXQJv9aJTyJurmzUyBYDVwlc959SJyGMYUBjglAb1+Vh3fKrYOyeslquR5xMBYM5pBZHHSbPVM/U9HKnQsCLAopnxM2S6J32LlTHTPbGmnlSHd0URddmQoL4rHECJ6zumwU6kn1pDerlvwfGooK4gJkvn3N4Gl2V94k5SPTQnCQkU0hBotSJ1KmF1iQ3cboYtSb7gJQiGAmzocG87Se+6yVVV25sQSZRgEYMb+0csaZ0KK6DUmucz0ONDUYpiOi5FNUiSfG0w+bqNTU0Z6P8mjF2bOQNm6zAo2RANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmHuF7CEjoCp4EAFDFFlY31q3ET8WePuMQkoU/xy/Zg=;
 b=CtT0GjC+8+znPNCE2BSNoxFsvK0QtuoyCjFzVnCc81Ijzb4QiXEZhcVHZTPys3aBvvTiEWEB+RuT8wDpAaf7uqNdG9c8x2w3svqO08l4+pF5zMyJtsdKICIeiR9rtakEbnaCj8Ml6QcAbj5iBnZj7B/bUWTvkrOU927F/geQMN9coxfbbriqJoMCLUh+uJdOV1cefTeeDbdMaK8swQNyGLBbQ1dIybJ3MlaWiL4FrH9HB7EH7n8BQGNmeprYDh7x1lBspVVWADzVZTUFKDqYjn/ka7tWIFcspS1DSyQdlAQNwqTQsLJQtdGKtZkcXG+TfTF5tvDvmf2lNdcXkxK94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmHuF7CEjoCp4EAFDFFlY31q3ET8WePuMQkoU/xy/Zg=;
 b=ZSMZ1gx8YWFJqe4Iio4GXaIaSRGMNi1puVl/Kby4nj2RUpVF4zTNl7YOVEae3KFC5QpbZ4uzf3sf/wBnwnZil0/3+mb8wZOt0Zg6/YjvVyEHzMmmFbD2OZTO6oKwOk82Zgauk7zmn1qdi2xWG6AbI9OUpopyFr22zqyd3eFm0GOevTDqw6Eaieh/1Dre/BslBV1+/aPQLtTwUh5LPP+krBxelS+mheQ0+sPBjoUUClrbAKCQUymfxp0qpX4MTmdXMVyEtD08k5rO/vzq1J2vOcyjA4B7S1siAvlyfNFHn4wi9uiRbtCow+fcz8xMVDadmdEx3jX1yTCkJQma4nMfyQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8805.namprd02.prod.outlook.com (2603:10b6:806:200::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 25 Aug
 2024 02:51:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Sun, 25 Aug 2024
 02:51:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH 1/2] uio_hv_generic: Fix kernel NULL pointer dereference
 in hv_uio_rescind
Thread-Topic: [PATCH 1/2] uio_hv_generic: Fix kernel NULL pointer dereference
 in hv_uio_rescind
Thread-Index: AQHa9IPaKeKLgv3auEyyAVvZzl/4nrI3SF/A
Date: Sun, 25 Aug 2024 02:51:40 +0000
Message-ID:
 <SN6PR02MB4157FDCAE52019E13DB97229D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-2-namjain@linux.microsoft.com>
In-Reply-To: <20240822110912.13735-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [m2fKHLKBAU7coh+WDfHPaGM1KTUopvto]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8805:EE_
x-ms-office365-filtering-correlation-id: d8f8a8d3-8242-4b17-5ec6-08dcc4b0d8bf
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 XZnBB0yTkjR4TheZp1lTHliUFMkYZPLlFzh4UmXOzlfNSFGyg4lahjV9SeQLNZF5JBNedqB3mxZT9bj3nzZ+aHyGxHmey2LkGBAo3G4RZ969kWd5EnJHKUpjHlksW0gOCNq29gm6PSZftCbVsCk5jduKKZBWM921JtUOo/qlSIzd4fvGWilYhuCHqwnBHNL5LUZgh5A+uLzkRrtl5mbNayYCyFyWVhlLjwH/c81YaAI1kZ98wL0icYTBW37+jW23ct7ihA2jk2fWurhSMcuKrTX2l62ZRmWvBlxuhNCG60cLYYHlHLJ9k/cImiCFNfxENcIQVrtLRHofKDdaXrtND04SgjPpeBSN3evqI46P/IjcF0agHZ5gHmHFQ6eDwanizJ8tPm65mdbN7PZ5TS1ZSGgBarkwSbMiYhNjJC+Xzzz0y+WnD4/sb3ZWYsByvLwQbjssNONO5KIcVoorDK+Wp9Q5PK25Tir7FqvbDSvCFnV1PPgStieHhjS4PMlSMq9vaFGULm4jdSk7tFynz6W22GQebGtm9qKFyG07CRI9Miq5vqRtlCLvMhAanZPP/RgTfXrHN6X93goY0XoUGbLvpoDOMmVYNdmXvBOo4mjLtggN3B0cfDFz/l+EHoA5yaUUibL/vvXEjRenPvSCk75Yat2ST8Ld0SwnG/NzzkXn4M0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yyX3dCnD4dguSFrMOPWeppZSKi6ld6kulKX51Ohezw/widiKTaDqCof5kV6M?=
 =?us-ascii?Q?iQVJXi/pLuM7j8BGoQ480qmJ3xm6psu0/UX0c5PbVuZG4OCo1MgpEoLhqzUG?=
 =?us-ascii?Q?tv1Y3kC5MdJmSjDE2346DVlSulNk/vjlwAjUx5q7XZ1dLzoEk3wl15FR5V8Z?=
 =?us-ascii?Q?0WOua4yfjTdeg92wFPA4QSzQn97zzARxpWzwDHsJwpvpojqAhMq/3TePSZ/k?=
 =?us-ascii?Q?2mhifoinPiVKaxTNiJoLG6EJ1qaiDo+zOzGVaLtaD13sqCCtQ7Pc5NBz8KBr?=
 =?us-ascii?Q?eV2kthiv7JGQNAGbZmDCkCp0aTSnQum08QV6eVQd17RGhfVoDvvJ7SC9KmFh?=
 =?us-ascii?Q?uW81qn8dR/FGJOUTjRMi2672gW+8KyfLtPPlA4rXXcMzAMOH+zKrIoiZEpiZ?=
 =?us-ascii?Q?ZsN3aCqUs5NiicEaS4sTaLuzr3seyekBMfVU0ZSx6aFyZKa7vamp4l/q0KXW?=
 =?us-ascii?Q?Eb6SWD68Vs/w2GyA9mVO211MfIXfbQ1AQQoWA9EgkUfrnk48uADRh78V41zu?=
 =?us-ascii?Q?s5w464ATzlh5DeIdW3k90C3K3FZHe+8yss9WyqCzrE7v/t3ZOAyrIj6O+5i5?=
 =?us-ascii?Q?parzRdEVKfcvr5TiCJ8vcoculpJhDjA5q/yDaOwlC95ha/xFMLNyQcencqNv?=
 =?us-ascii?Q?PEXWmAvYLsRNs++nHsSD/5qIaW7nRyy3XB+aP/7hPVw75ppLWxj9ZaKl5NPo?=
 =?us-ascii?Q?JISVHEXlYzL9qzzVxBsUS6fd9UkvBYcMGtKMch0VGUl39hCqMzHL42/EB5mi?=
 =?us-ascii?Q?tfpFZSQP8nXvObVLezXfm77tFAoCOOk47KfyAx2okWR82wJW0HEWglcvG/z6?=
 =?us-ascii?Q?BB70WEUpTTGC/GBTnGsoiou2kGQK6gC9iJ47maduTlBmPQGcS+qfZlouGW3w?=
 =?us-ascii?Q?7Cz0qYp0ZUiTRDztYPIbQgufc9RlUO75A7c7tVTi2sBJfhKejwVgbyLw6oWY?=
 =?us-ascii?Q?kZ5Yq0jMI++VfjaP0poBpGIGDoWg3zlWTMVUzUDQdKkNGBz24XD31u24L2yw?=
 =?us-ascii?Q?HVki8XA7kY9nBldkpA3Mi8wXNBX9cmhdqEgxlVTbUP/+rOwfi1SPYiG60uxz?=
 =?us-ascii?Q?1SD7dmTSuXeN/4sFhAWcsw02tPBRONO1qCKmlp8E6F6s6+dZmIrS0vXpMwYU?=
 =?us-ascii?Q?fTVuwCxmHJtVa5JwHb+VEUJWINJbCvth8ylOvbZoyh1rc9pAzRaWcdRnKJzd?=
 =?us-ascii?Q?92yd9XT7PMdy2K5zLkxC656S9I9UtT/L6KmX86bYLYyW+VwiCp4uC90H0HY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f8a8d3-8242-4b17-5ec6-08dcc4b0d8bf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 02:51:40.9450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8805

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 22, 2=
024 4:09 AM
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> For primary VMBus channels primary_channel pointer is always NULL. This
> pointer is valid only for the secondry channels.
>=20
> Fix NULL pointer dereference by retrieving the device_obj from the parent
> in the absence of a valid primary_channel pointer.
>=20
> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index b45653752301..c99890c16d29 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -109,7 +109,8 @@ static void hv_uio_channel_cb(void *context)
>   */
>  static void hv_uio_rescind(struct vmbus_channel *channel)
>  {
> -	struct hv_device *hv_dev =3D channel->primary_channel->device_obj;
> +	struct hv_device *hv_dev =3D channel->primary_channel ?
> +				   channel->primary_channel->device_obj : channel->device_obj;

It looks to me like hv_uio_rescind() is called only for the primary
channel. That makes sense, because waking up the reader should
presumably be done once for the device, not once for each channel.

Rather than generalizing the function so it works for both primary
and secondary channels, I'd suggest checking if the channel is a
secondary channel. If so, output a warning message or do WARN(),
and then return immediately, as some there's some kind of
programming error.

Looking at the history of the code, it appears that rescinding a UIO
device could never have worked. Is that your conclusion as well,
or am I missing something?

Michael

