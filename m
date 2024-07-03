Return-Path: <linux-hyperv+bounces-2534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB392664F
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE41F24D0D
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F01822FF;
	Wed,  3 Jul 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oOFDmAyZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2012.outbound.protection.outlook.com [40.92.19.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D72183099
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jul 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025050; cv=fail; b=eSwms+64RFF2BEaCRTUS1oYMiTlT2A26vBhwoGt5dTLfYuS0aJOd6PBEZa9XMRmrAntAL1jzD0BANo/4+R6fy+3vQZADhnx7CQqi6OinSnPiwhF7BSNdBgxpbCXmF9Vpzfx8D2PWqWN4tx6ybX79uD8nyISJ+uVIeNkhrf8SazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025050; c=relaxed/simple;
	bh=bLySIAkyqUc16lFoEJhBV4/wYh3gw830YNNRTcG/B0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NaaGk3yWX7FRy8EIJZGQgBEs4R0gKEU7Y0WKM9UEwyK4u4YTO39f4rlWBA7CsUtqisZUzd4iJIOVp3Whrx7RchuTHtJYJBMNctMWtW5Q1QYzJma4em+GVkCJAvLsJMP9lKfEzXzgBhxpO/dSZuST5+Bj55YsBeUG+aDN7Obn5ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oOFDmAyZ; arc=fail smtp.client-ip=40.92.19.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypvg/r2/qDsOWFVsrCJb58uDqHmTJYbG9pph/PbHcl7QrouWXQkdXtnUlU1X2c6f1ltLJknknHrt+Qujz15jUpZRsS2TdFizjejEKqAEta9R1cVfgFlfb0klDwUCkH+/EGZm6Ijj0LNt5s4IIlp3SVndo8dqrTnyp5YcfRDy143dlAbZ8u+4BPO9lVXjNl4d4/O55hN1KcGNtwhKiN7AfHgO9ApES9ZkAHOOAFuC6eJzqSLGrPE3/D7MzehXQ1XX6YCsf8C7QI/iRG5vONlS9crx+xnQddgFIX6pbaK1lEXCaFoC5G0rcSg8vOi/BvQEHwEh9DyDbg8r3nJ/Id71Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9a91M9af5vpaTnu6mGpg/hQJMMeExDGg4MFZU9rlxg=;
 b=gdmmwnz6jJT6/QKTn0L9b1l+0F6fyRYELiyfTY88/q7mT2rbqcntUf2VRUsYN0PC/zp2E85wWapb9FjbdAaDXtD7jOqRgC9BTWRhNB8YP61xY3ofeEaisIW+nzxGULjfLTAk45ckpdQvaW4WDKfxImDNaAS+fpy0p6+s2kqBckulvqfNVNlMh/QaajCHos5stkR9m0zDnzyR4gdIMNjqOVN3a2qbmzB6ttTLnV1hhNtK+VjZGzpZ3N22+F0qAacXHgTsXC0ZULAr/aVrEJBDy36EXxnkhdyjgRV55/ykEkDILsxu+SevFrheZ89Uojnp04ho9jHzVrgF5LmON4sdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9a91M9af5vpaTnu6mGpg/hQJMMeExDGg4MFZU9rlxg=;
 b=oOFDmAyZlOHoxHqOypduz3ZihfwLQ1N1RkHZnJp8UurE0pYqhwvYm3e0Dxlhcma74BMAkcYGlVmRmzx5gsz4SbJ1IyfaxxcQ1qAjXpBx3AqQ/0AKmB/EmXVd1hRfvHqLJpqERbuNLCJ9jqOhdaohquikP4Iyz4h6936QvhX8jYKIJCO99qrUSGE7qthav+/z0mGSOVZ7RKU/uBc187zfq+GEIDMP5djzYYYcABVYJuU+tWcaKibiVNOiAo8v94HvUfQUBLkRv+WyoMztbA3EflXdYmnGMhiJQYiOkqGBumJGBT4SpvHBO+tpwKsn0/S+wi6LLS6L4muCjxQkpp3pCQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10787.namprd02.prod.outlook.com (2603:10b6:408:285::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 16:44:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 16:44:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anthony Nandaa <profnandaa@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>
Subject: RE: [PATCH v2] tools: hv: lsvmbus: change shebang to use python3
Thread-Topic: [PATCH v2] tools: hv: lsvmbus: change shebang to use python3
Thread-Index: AQHazGnTrihdwP+Fo0KaqE8YkwNQurHlNzpg
Date: Wed, 3 Jul 2024 16:44:05 +0000
Message-ID:
 <SN6PR02MB4157AFC98992A53FC05EC312D4DD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240702102250.13935-1-profnandaa@gmail.com>
In-Reply-To: <20240702102250.13935-1-profnandaa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [QPA4BjKzarKDEIJPOpcKpNCeP3qJ/xO5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10787:EE_
x-ms-office365-filtering-correlation-id: 9a9c2cf8-0f7c-40c3-a160-08dc9b7f5a74
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 2fRyQ6QqNv1xwRqNniRT6N0CZYDXmAUxN5zOKRzdu/dBJw1hxhB/0/brLRDCt52buS8deQctls4Y9VQaHzLDMTfG8X843e84CRkP/NPjTHju3mCq+M+uNwyy4sOIULNYgKfH8ZznPpaXjwSe6IGseG+lPsfZ0iwlSnw2HA8MSbUZZMVAMfglcx/i6Hhjl73GwB/zoz/XzQuL+WP0YfZOw9lvefr4cRK8Uv1lvO3j4sj7pPCJ6KJivElvNWBBOBAX2oKqdimAoCjchNeLRw0TdwJUSUxY6ZBdT/gttDxNdHAFoFP0F9Zd6nq66NfzHgaeMuPt1bXi+VztfAdiq4duw2nXaZXZsD3Id8NtkETzxrH4Wpp+jpkbPRDUIyqpJwx5g16J/ff6FW7eLt0EnoyrCrb0Kwfhs33bhME5kjD4rc3S1QWeCr6vqn87GAdCxeQA3UfxTMUXeFtIhWARfVEGhf+HhWUHXiwV81uSP0rgNxiga6tKHp33IVr0yDRjy+8eray9nd/fqinT2Tm6BFlQw/Oe2+V7uWQ8+sypPyOABB4LgCvjPzwRWqNl74tZWA7WNkaJKCCFnGnBP1f72XZEeLvXkk0WR4GbY87KnTxQIO/oSnKAzmCtji3StDl6YmY870TkTpBE5YJcJDGBxfC5m1Jv1xJaQfCIhMEMQlG2DVo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?24+9dF9tu2B+mYnZI+4l2TMXTKfPR53AdNoX5HLRD0P7vPTMbAImE7WyJVjX?=
 =?us-ascii?Q?k0db6ORkgXpEVtTLt1oTY7tjHKP8u+VOJnJHjS2ISlFiXXWdjs+Ng/54RFJo?=
 =?us-ascii?Q?wXL7GDGLAkCIPEOWSzDG5jhmPJf1CyKaHXsLwaMgYf7dLiOwsQJC1uJo5R6K?=
 =?us-ascii?Q?RuGHxpJj77KQPFcQr27zcSjCzjSKRWH4Jw8NtSHRT85xonjX55ZNEbrfgokD?=
 =?us-ascii?Q?yflrZvha7AY99bKHMxOGd7mlZwOzW5HxJWMBZj17zTJ34hJ56elqRHcx6eSl?=
 =?us-ascii?Q?kdrNbm1Dioqt+U03GGPzKK3Am9OD/ZeXIbSAOwYq4UX/Uptf3AFJID34yxHV?=
 =?us-ascii?Q?w4g4PY0TAbSQU3BwoaBzVYpq8xEPED8tNaVswwdyz5B45hy04+Afx79Z+WV0?=
 =?us-ascii?Q?M/s/6kU6NFb9B5tLIj58S1u0T44wMycsNEGlsrZeBG0wYJfT4/t0U2lIl6qw?=
 =?us-ascii?Q?RoYynb5FrMXxAb75RA3gWaLrY+UJJoAk3wcYtl8CVLPjhW5ZOEDGcLQFRonv?=
 =?us-ascii?Q?kumbbXg+fem5yOGEysAT5quW6XIkPcvTqhcF7AzcXr0lpMUTGWWSvIRRaeJm?=
 =?us-ascii?Q?AZ57PaplWhH3kXB5n+hGXG594hV4zH5hIsDVhfbhKzApZmX/6eTNLSv9MKRa?=
 =?us-ascii?Q?J+cnrlDkNlB0cmQFWc/84Fq0pU3hwAK5qUAz+13m/+SBpOtzibDlmdHe/Hi6?=
 =?us-ascii?Q?WMdLRLNXM+G/8e1jqrQFozwdGNqt67ycipWNoEXjgMnj6HD9e72vKhrEECkT?=
 =?us-ascii?Q?e/1kCY0LjaxY/COPSMGUdJWyTgoSsyzM2pliYfocPzyDISspzO8rrr3ML7Iv?=
 =?us-ascii?Q?W/OThhF/3I9fAgPUQPadmop8rRAITojHYP2HmG+UnLLHZcyqgzv3BOSLKUfJ?=
 =?us-ascii?Q?JLAixRN3DehmzUDfA+R++Zvn4lnq99Ul3MGHybljRkOXLP6B5HFjdhll4Ccq?=
 =?us-ascii?Q?Sqc7bnMINsT/qtWxILxdcuUU3uv0zCKcKEFhRNhzrfaTqG1ea0FErc9SygEP?=
 =?us-ascii?Q?c1drJ9tSMWjPgR8VDRiqY1raCcFfPwFiy++NbTyeaJSOYwfX4tJWnSjBuCLf?=
 =?us-ascii?Q?xuz5jh9klxRPX1Y/jFm70/JpcnsS5IzcTPOp0UgIMy2ZNgqv2O/GcibBYtZN?=
 =?us-ascii?Q?vjDDDob8c3hwa8fTrMuYDDGbNOcjoj6sNCOqHRpgLOTeV7qow7otAhFi/hnW?=
 =?us-ascii?Q?Whjo5pt7J0mL2XKnf11zQYvY50rnKmUJUbHYNM41flBe0VW3dF6G2m5YoF4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c2cf8-0f7c-40c3-a160-08dc9b7f5a74
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 16:44:05.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10787

From: Anthony Nandaa <profnandaa@gmail.com> Sent: Tuesday, July 2, 2024 3:2=
3 AM
>=20
> In many modern Linux distros, running `lsvmbus` returns the error:
> ```
> /usr/bin/env: 'python': No such file or directory
> ```
> because 'python' doesn't point anywhere.
>=20
> Now that python2 has reached EOL as of January 1, 2020 and is no longer
> maintained[1], these distros have python3 instead.
>=20
> Also, the script isn't executable by default because the permissions are
> set to mode 644.
>=20
> Fix this by updating the shebang in the `lsvmbus` to use python3 instead
> of python. Also fix the permissions to be 755 so that is executable by
> default, which matches other similar scripts in `tools/hv`.
>=20
> The script is also tested and verified that is compatible with
> python3.
>=20
> [1] https://www.python.org/doc/sunset-python-2/
>=20
> Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
> v2:
> * change the commit message body to conform to guidelines.
> ---
>  tools/hv/lsvmbus | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 tools/hv/lsvmbus
>=20
> diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
> old mode 100644
> new mode 100755
> index 55e7374bade0..23dcd8e705be
> --- a/tools/hv/lsvmbus
> +++ b/tools/hv/lsvmbus
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>=20
>  import os
> --

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

