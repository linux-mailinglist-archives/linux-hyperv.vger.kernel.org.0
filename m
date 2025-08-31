Return-Path: <linux-hyperv+bounces-6677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A336B3D44B
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1153B88D6
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F95248F72;
	Sun, 31 Aug 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z1o7Z0q1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2016.outbound.protection.outlook.com [40.92.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94685464E;
	Sun, 31 Aug 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756656783; cv=fail; b=Z3neMkcH/rEOyenjwglxzLOYxRmyu8+a1HE7riscwrKeIAobYcFNoENU9HdV9YVU1og8NP3QJZVL6gePWgswG6cHULfPKURhPqmvecimekQdlfmABKDkNgVm5Wqlery9uAPqQ9Wfi/nQJFicuJpX+/SkA8006lifRRqxP4bIdkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756656783; c=relaxed/simple;
	bh=m4gmrVQ3a+yKEKA03u1tfHj6+Hfj8X+XnEss/vJev4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DWQxl3yi6r6IIy7B1WpW7WBAuqysZkt88iMt8gjPePf154J3N2pQmAfxwXwY2Bt3f4CiTOFodzrRanVYIvWi2/xPdluqZQMiwGy8zTHWSBBlG7U8fMX+zCIzdQ1K9v5J6G9et7bOLaN08NdZoEx52ZJ1JAviYF5Cmo0qOkHLzzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z1o7Z0q1; arc=fail smtp.client-ip=40.92.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMRRo079JQoOYeWejkxraEZEnt8e1q9Tcbm3qoQmxYh9slcRLss1WNVjadMF+R2JI5vuV6ESa0PgNZR9CgqYVDwvV3ke7Mu/P5ASjHktkaYXPsgt+7iQL7lf8pbSiXYfY+pTOe1EgsnOk3OyoEh+tCmIlSQbgg8Ug+pjm31KSz1J8NTJk8EHK9DgIFhCRyKRMql0C2II5fNGK39DnmD9FPesq/a3vcS8weZoxGQW066ZbuoyEGkUGrcqnYgP/kqsBVDelGMgEpz61tfyGi34JbvFKNm7xFjFWYdqnahg41PZ7WWzzwEkO6K3fuyaarieljpiqn5vYIG09F19W87ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgEMJ81LK4KpGj+/sfhJQUhnq8cRN0iwa01dK8gFsTc=;
 b=avdQpAMU6SN6lYC3auM+RpRRS0Sjc/oxt01sDCzdVLTgT/3W/smLPaOUFgGOJePs697ziQAfuGBToA4YxyIf0Hj0F5oOeM5tktq2FLdwHgix8EawupdOC2wfmfkJpO3g3sFZvoJR8O57SYOnvUTckPwoYj+AtXMpV0WKrDy9yOHFiVpHqOQdOC3drEMgHWnkQZZXKnARHK387mqx3RzXiN/q5C0EYeQokDZrTjkiExKsdRC4vQlPucV10oSnDSk9BDOlOfGjdV4an2RKf+kLMt5tqoZT0msgNwXe/1EzRXAgZ/VK6oci2n5zuUNFtTryoeZBq0RFYRNDIpxwhb7hsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgEMJ81LK4KpGj+/sfhJQUhnq8cRN0iwa01dK8gFsTc=;
 b=Z1o7Z0q1ryrFi7mEN7oZfolIdBwD/c80QATnhUiNlnudnO43/T/4Aigly5xT0Pn0+RsCr1506rFhJQujkOoeuAowhP39F+ZRDVrOAsi0VK3xwOQh6xp1WzdK0mlmWmx5qobgzwU/pDhHla2uEORJPKP+TgcvOhRtWumaSHHYa5FFTOabuoN76++uASyDUJ+T9byUsPZPVhBnztbqS8oo4KSexoBF6zaszMrW9A0xWfyVyi1Tmun80w0b2e49L/SzR/HvGyTdigmhI2jDCjRZa5nAFg4UfVc8YyL3KXoe6Qu7th1jA4vwVMia/R2YzG0fBslnRpzMXMK9PpdxJTO8KQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS2PR02MB10846.namprd02.prod.outlook.com (2603:10b6:8:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.27; Sun, 31 Aug
 2025 16:12:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 16:12:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Long Li
	<longli@microsoft.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
Thread-Topic: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
Thread-Index: AQHcF9YgahfJQA7jr0mWtTQfM8y95bR887vg
Date: Sun, 31 Aug 2025 16:12:59 +0000
Message-ID:
 <SN6PR02MB4157BE838354759E7B301F69D404A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828044200.492030-1-namjain@linux.microsoft.com>
In-Reply-To: <20250828044200.492030-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS2PR02MB10846:EE_
x-ms-office365-filtering-correlation-id: fbdd74b1-7d38-4648-b25b-08dde8a9412f
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|13091999003|19110799012|8062599012|8060799015|461199028|31061999003|15080799012|440099028|51005399003|40105399003|4302099013|3412199025|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WooOQhW/Mkwc5y7TQFGad8qrN7NECB8iRcIH84iiQ6Xw6wLftmWQMARQVe?=
 =?iso-8859-1?Q?M7/4e6hQWCPgps+iip33Xy/Y6pAr9OryM1Nu05zl0RjX7aTZ+l0rhaWgxh?=
 =?iso-8859-1?Q?A2fNnyMV7gi+chjWTMMvhnfTj2ZqK3o2tiGLQoKuFu6RLeCSTewwk4dNE+?=
 =?iso-8859-1?Q?1K/73mkqfT7BCy61cIEIXDDGWpciKdo1FtE53NlAIjROJecaWfHB7bOD0F?=
 =?iso-8859-1?Q?r8Hbgl87ZYSgz/LZKbdnI/wZu8R5d46f9OQgbquHQhaEMrmhyBREddZHuD?=
 =?iso-8859-1?Q?JGJpPCnrKoWhflMKKtxmGSFrXlaIQwlxO3qbSKHHyZAp7PaMpJ8f6Sl/o/?=
 =?iso-8859-1?Q?Fdtwu/Dp+1F11xiBzZ4il364LJf9W3y9C8NG6NdBhWHlKKXMZGNKzI/BTY?=
 =?iso-8859-1?Q?c1arx16Qf7YLZXyDTNuwU0vncZU9zHb9ZlzKTovWOniK7ch9zYPfnPK6+C?=
 =?iso-8859-1?Q?7qPuA7c9jQrLdtkkCv+thxUN9mEll52YmS/Sm88/KKwN9vNB826AnYl+A8?=
 =?iso-8859-1?Q?aNu5stWr+UADHQF2oO/Hk1q72qrDuOmMTBlQMYDscP+p4G4NpMY65+aFO0?=
 =?iso-8859-1?Q?gJe1CiZgGvVSOGLHbvXGWKG2WeiXBiqzsEdomX0rUGOxp3Ef9SLF1M1+3P?=
 =?iso-8859-1?Q?JKYiKVBPBMpLqepk8EN6Qah7v/HUUdi7b5olNEtnWtUmbzID9T1qNJORfL?=
 =?iso-8859-1?Q?Wi1mv0zGO1DCDxb5gohh8ZyOBFtFoPiFjiLtG+IiOxrmTT0tUfdJyuPaIW?=
 =?iso-8859-1?Q?ELt5PhxqpAeqppaBNGfHVxFrXSjVyQToNBkrdAnNpvOM+pDEs+kJE78H8e?=
 =?iso-8859-1?Q?RMYtVYLHeX0aLBMI1WnlI30gqmWyxHF5h3H0zUJ81ejCFM1GkZuwxBAWW6?=
 =?iso-8859-1?Q?nU1LrkMQ5M15b+2g6CcPFyD/040UGAbMc0uKzWsVwidMYk/WMPxQ+f+nfs?=
 =?iso-8859-1?Q?zMrNBsA+maMD0aVJgV6tJWVWsYcWg14cLnLC0I9fYbyxg+oSV5XvacJT0k?=
 =?iso-8859-1?Q?CxfjdXTRdK++STMi0Tcze9EXEsMNL/Qhg5BDqrvimzKjX8BjxplfXKIRbS?=
 =?iso-8859-1?Q?p7VFVEW5VOc0hg5zlQy1Dmz5tw6OQwdw2qA8VoUs2sNNnIcYO4xdTLDChS?=
 =?iso-8859-1?Q?a4cDmizOJnUwtUyoBqh+bF/g3S+lyhC/SMPDn67G4W7SAUPoU8fIlGUPsU?=
 =?iso-8859-1?Q?H3hjOGis0lELbeFFebza/tCBr5m1lQ8b9bwxebIPGAhrENSgklfteOvA3v?=
 =?iso-8859-1?Q?OE/TXmUlmLKcAieSxKz6rBFSgb+Pcn3y5RSlNtXdpJgmlXtI1ftd34Ramx?=
 =?iso-8859-1?Q?Il4SebLniPnctJFy1DRbrXMQR5Bpedn7W6LkMZbp1cPEWh8r2IQo2amLwP?=
 =?iso-8859-1?Q?lsXDkezPSdd38kC6y8gKlc4DNMIKrS8OUMEKSuiLQAritEgSNB/Pejrc0S?=
 =?iso-8859-1?Q?qSprg0mXzWCO6jzc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PrsXI1wGprxqkMZqvlu/nvW5xwzxE35chT6bNSG2D1IxE6eBXbPSHTLfoy?=
 =?iso-8859-1?Q?2UGXI6uB7eVnFYzUD0SM1IwrFEnOQFC6t/RbdVWUyK+4GgHMF2Q2BS+S7r?=
 =?iso-8859-1?Q?idB+ongnLU9EhuelRshDF9F522LS1HV82lKpz/QlVK7ztFly+70o3BMNpA?=
 =?iso-8859-1?Q?2Tx84hARAAbqE/WMQVkqWrSB1EP6nD1/xNsEx+Z3IL0uIzMtW95k17XoL4?=
 =?iso-8859-1?Q?bkxrkppW/pzZSxzfZIuVoN0oQnxovfDAV/KOeH60ZZ0egH6He9F02fxgmY?=
 =?iso-8859-1?Q?tZegj1knHYCrf62X9dp5DRIr1G26oLtJxlRncI+vqaNAUhgWSX+V/sVkOj?=
 =?iso-8859-1?Q?l4/f4Sa9QZKY7Mge/OhNiXg8+BXkVa4+ikO5bgd1Nb65uNWOxJ96ARE8Vn?=
 =?iso-8859-1?Q?WmJJsKSSga9oe75LumpQruNUn3rHL86FxXya0s6yVtUqArZ0YQTnfCBT3c?=
 =?iso-8859-1?Q?Vj568uZv4bOHv8kS5Hv539X6QKic+nTcl/KMFXjHaSUs7atonMjbPqn3/u?=
 =?iso-8859-1?Q?X/Af8CEBmyNKbpUVvJjqDEe3deI8013WA2KVUbmXTnFt/gmCJRee/rjphD?=
 =?iso-8859-1?Q?gR2QwXBhAvWaqC/cU/WN1bawRN1TGLPLu+yWum4iN7HduO5Mfc7Vc94Zl7?=
 =?iso-8859-1?Q?LQATGO6xWi5qAd9aJVYWG7xCYSATt118UIrTZ6PFgB7tqBu0rgpq7YhTpB?=
 =?iso-8859-1?Q?PcLFz2Dx3A7NezWw9/5Z+6z7azJN/siUYtBRSW6mRfrJBunWKtSHI9kTAa?=
 =?iso-8859-1?Q?++kNjxB88UsMNzM/mvTvgnvBNzSejt/xanUEDLaroEIBrkoCf71cIC0QTK?=
 =?iso-8859-1?Q?Kv1WdXuKbPrODjnDz3VOBBEcwwK6kgre9YQHdwzmj1oKrk55Xh0DPtUllR?=
 =?iso-8859-1?Q?OcCFeWdzc1LVtvBG1wYFXES4+R6M4d/cyhzDQQVv6FCqZxcZmvIuqw72rZ?=
 =?iso-8859-1?Q?DyMp/GO8XU07YCLDWo1oYXetbEOOX+hWSv4MLvmBleAXdNM1o45/wvHw3r?=
 =?iso-8859-1?Q?TZ/ZTaBwv3NdFpZdmaHGrgHLE7Ntdo76l5z2TY8273kSXYpSgFYYuywCFM?=
 =?iso-8859-1?Q?/zhBk4H1nL6qXOmayUlQrRxHxZeqr+Z6D5+zM6IJPSDJb6vGL8q3MVNFqK?=
 =?iso-8859-1?Q?ybzyEl2L0GS/amyTtnXyojnxRRKnX+qUQtjakDDgytBZ4gqJPKJfAyof6V?=
 =?iso-8859-1?Q?Hibfx5bGHcvQXWvCI4CcqtPoFwnEXHlNzqWhxtK4OVMLO/tDkPCzO0K2Rq?=
 =?iso-8859-1?Q?V1gxFGeKRAWriK2U3e/Yq2zvETA+5p5Js0RQcJVAU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdd74b1-7d38-4648-b25b-08dde8a9412f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 16:12:59.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB10846

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 9:42 PM
>=20
> Remove the logic to set interrupt mask by default in uio_hv_generic
> driver as the interrupt mask value is supposed to be controlled
> completely by the user space. If the mask bit gets changed
> by the driver, concurrently with user mode operating on the ring,
> the mask bit may be set when it is supposed to be clear, and the
> user-mode driver will miss an interrupt which will cause a hang.
>=20
> For eg- when the driver sets inbound ring buffer interrupt mask to 1,
> the host does not interrupt the guest on the UIO VMBus channel.
> However, setting the mask does not prevent the host from putting a
> message in the inbound ring buffer.=A0So let's assume that happens,
> the host puts a message into the ring buffer but does not interrupt.
>=20
> Subsequently, the user space code in the guest sets the inbound ring
> buffer interrupt mask to 0, saying "Hey, I'm ready for interrupts".
> User space code then calls pread() to wait for an interrupt.
> Then one of two things happens:
>=20
> * The host never sends another message. So the pread() waits forever.
> * The host does send another message. But because there's already a
>   message in the ring buffer, it doesn't generate an interrupt.
>   This is the correct behavior, because the host should only send an
>   interrupt when the inbound ring buffer transitions from empty to
>   not-empty. Adding an additional message to a ring buffer that is not
>   empty is not supposed to generate an interrupt on the guest.
>   Since the guest is waiting in pread() and not removing messages from
>   the ring buffer, the pread() waits forever.
>=20
> This could be easily reproduced in hv_fcopy_uio_daemon if we delay
> setting interrupt mask to 0.
>=20
> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
> there's a race condition. Once user space empties the inbound ring
> buffer, but before user space sets interrupt_mask to 0, the host could
> put another message in the ring buffer but it wouldn't interrupt.
> Then the next pread() would hang.
>=20
> Fix these by removing all instances where interrupt_mask is changed,
> while keeping the one in set_event() unchanged to enable userspace
> control the interrupt mask by writing 0/1 to /dev/uioX.
>=20
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Suggested-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Changes since v1:
> https://lore.kernel.org/all/20250818064846.271294-1-namjain@linux.microso=
ft.com/
> * Added Fixes and Cc stable tags.
> ---
>  drivers/uio/uio_hv_generic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index f19efad4d6f8..3f8e2e27697f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -111,7 +111,6 @@ static void hv_uio_channel_cb(void *context)
>  	struct hv_device *hv_dev;
>  	struct hv_uio_private_data *pdata;
>=20
> -	chan->inbound.ring_buffer->interrupt_mask =3D 1;
>  	virt_mb();
>=20
>  	/*
> @@ -183,8 +182,6 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
>  		return;
>  	}
>=20
> -	/* Disable interrupts on sub channel */
> -	new_sc->inbound.ring_buffer->interrupt_mask =3D 1;
>  	set_channel_read_mode(new_sc, HV_CALL_ISR);
>  	ret =3D hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
>  	if (ret) {
> @@ -227,9 +224,7 @@ hv_uio_open(struct uio_info *info, struct inode *inod=
e)
>=20
>  	ret =3D vmbus_connect_ring(dev->channel,
>  				 hv_uio_channel_cb, dev->channel);
> -	if (ret =3D=3D 0)
> -		dev->channel->inbound.ring_buffer->interrupt_mask =3D 1;
> -	else
> +	if (ret)
>  		atomic_dec(&pdata->refcnt);
>=20
>  	return ret;
> --
> 2.34.1


